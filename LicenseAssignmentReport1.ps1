$RefreshButton_Click = {
}


$LicenseAssignmentReport_Load = {

    $global:isFormLoad = $true

    try {
        #$skus = Get-MgSubscribedSku -errorAction Stop
        $skus = getMGSku -errorAction STOP
        out-logfile -string "SKUs successfully obtained..."
    }
    catch {
        $errorText=$_
        out-logfile -string "Unable to obtain the skus within the tenant.."
        out-logfile -string $errorText
        $errorText = CalculateError $errorText
        $global:errorMessages+=$errorText
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain the skus within the tenant.."+$errorText, 'Warning')
        $global:telemetrySearcheErrors++
    }

    out-logfile -string "Removing all non-user SKUs"

    $skus = GetMGUserSku -skus $skus

    out-logfile -string "Build the custom powershell object for each of the sku / plan combinations that could be enabled."

    CalculateSkuTracking -skus $skus

    out-logfile -string "Populate the SKUBox with all of the USER skus in the tenant."

    $items = @()

    $items += $global:skuTracking | sort-object SkuID -Unique

    $skuBox.items.addRange($items.SkuCommonName)
    $SkuBox.add_SelectedIndexChanged($SkuBox_SelectedIndexChanged)
    $skuBox.selectedIndex = 0

    $planBox.add_SelectedIndexChanged($PlanBox_SelectedIndexChanged)    
    
    out-logfile -string "Populate the combo box with the attributes returned by get-mgUser."

    $global:possibleAttributes = "AboutMe","AccountEnabled","AgeGroup","AssignedLicenses","AssignedPlans","Birthday","BusinessPhone","City","CompanyName","ConsentProvidedForMinor","Country","CreatedDateTime","CreationType","DeletedDateTime","Department","DisplayName","EmployeeHireDate","EmployeeLeaveDateTime","EmployeeID","EmployeeOrgData","EmployeeType","ExternalUserState","ExternalUserStateChangeDateTime","FaxNumber","GivenName","HireDate","ID","Identities","IMAddress","Interests","JobTitle","LastPasswordChangeDateTime","LegalAgeGroupClassification","LicenseAssignmentStates","Mail","MailNickName","MobilePhone","MySite","OfficeLocation","onPremisesDistinguishedName","onPremisesDomainName","onPremisesImmutableId","onPremisesLastSyncDateTime","onPremisesProvisioningErrors","onPremisesSamAccountName","onPremisesSecurityIdentifier","onPremisesSyncEnabled","onPremisesUserPrincipalName","otherMails","passwordPolicies","pastProjects","postalCode","preferredDataLocation","preferredLanguage","provisionedPlans","proxyAddresses","refreshTokensValidFromDateTime","responsibilities","serviceProvisioningErrors","schools","securityIdentifier","signInSessionsValidFromDateTime","skills","state","streetAddress","surname","usageLocation","userPrincipalName","userType"
    $global:defaultAttributes = "AccountEnabled","DisplayName","ID","Mail","UserPrincipalName","UserType"  
    $global:selectedAttributes = $global:defaultAttributes
    
    foreach ($member in $global:possibleAttributes)
    {
        if ($global:defaultAttributes.contains($member))
        {
            $propertyBox.items.add($member,$true)
        }
        else 
        {
            $propertyBox.items.add($member,$false)
        }
    }
}

$SkuBox_SelectedIndexChanged = {
    out-logfile -string "License selection changed."
    $itemSelected = $skuBox.selectedItem
    out-logfile -string $itemSelected

    $plans = @()
    $plans += "All"
    $plans += ($global:skuTracking | where {$_.skucommonName -eq $itemSelected}).ServicePlanCommonName

    $planBox.items.addrange($plans)
    $planBox.selectedIndex = 0

    if ($global:isFormLoad -eq $FALSE)
    {
        $ToolStripStatusLabel1.Text = ("SKU Selection: "+$itemSelected+" Plan Selected: "+$planBox.selectedItem)
    }
    
    $global:isFormLoad = $false

    out-logfile -string "Pull the users associated with the sku selected."

    $sku = ($global:skuTracking | where {$_.skucommonName -eq $itemSelected}).skuID
    $sku = $sku | Select-Object -Unique

    out-logfile -string $sku

    $skuString = "assignedLicenses/any(u:u/skuId eq "+$sku+")"

    out-logfile -string ("Filtering for: "+$skuString)

    try {
        $propertiesList = $global:selectedAttributes -join (",")
        $skuUsers = get-mgUser -all -filter $skuString -Property $propertiesList
        out-logfile -string $skuUsers.Count.tostring()
        $proceedWithList = $TRUE
    }
    catch {
        out-logfile -string "Error obtaining members with the license."
        $errorText = $_
        out-logfile -string $errorText
        $errorText = CalculateError $errorText
        $global:errorMessages+=$errorText
        $ToolStripStatusLabel1.Text = "ERROR:  Unable to obtain users with the license...."
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain users with the license: "+$errorText, 'Warning')
        $global:telemetryCommitErrors++
        $proceedWithList = $false        
    }

    if ($proceedWithList -eq $TRUE)
    {
        $UserLicenseView.columnCount = $global:selectedAttributes.count

        for ($i = 0 ; $i -lt $global:selectedAttributes.count ; $i++)
        {
            out-logfile -string $global:selectedAttributes[$i]
            $UserLicenseView.columns[$i].name = $global:selectedAttributes[$i]
        }

        $userLicenseView.Columns | Foreach-Object{
            $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
        }

        foreach ($member in $skuUsers)
        {
            $userLicenseView.rows.add($member.AccountEnabled,$member.DisplayName,$member.ID,$member.UserPrincipalName,$member.UserType)
        }
    }
}
function LicenseAssignmentReport
{
    . (Join-Path $PSScriptRoot 'licenseassignmentreport.designer.ps1')
$LicenseAssignmentreport.ShowDialog()
}

