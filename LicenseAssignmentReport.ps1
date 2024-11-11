$LicenseAssignmentReport_Load = {

    $global:isFormLoad = $true
    $global:possibleAttributes = "AboutMe","AccountEnabled","AgeGroup","AssignedLicenses","AssignedPlans","Birthday","BusinessPhone","City","CompanyName","ConsentProvidedForMinor","Country","CreatedDateTime","CreationType","DeletedDateTime","Department","DisplayName","EmployeeHireDate","EmployeeLeaveDateTime","EmployeeID","EmployeeOrgData","EmployeeType","ExternalUserState","ExternalUserStateChangeDateTime","FaxNumber","GivenName","HireDate","ID","Identities","IMAddress","Interests","JobTitle","LastPasswordChangeDateTime","LegalAgeGroupClassification","LicenseAssignmentStates","Mail","MailNickName","MobilePhone","MySite","OfficeLocation","onPremisesDistinguishedName","onPremisesDomainName","onPremisesImmutableId","onPremisesLastSyncDateTime","onPremisesProvisioningErrors","onPremisesSamAccountName","onPremisesSecurityIdentifier","onPremisesSyncEnabled","onPremisesUserPrincipalName","otherMails","passwordPolicies","pastProjects","postalCode","preferredDataLocation","preferredLanguage","provisionedPlans","proxyAddresses","refreshTokensValidFromDateTime","responsibilities","serviceProvisioningErrors","schools","securityIdentifier","signInSessionsValidFromDateTime","skills","state","streetAddress","surname","usageLocation","userPrincipalName","userType"
    $global:defaultAttributes = "AccountEnabled","ID","DisplayName","UserPrincipalName","UserType"
    $global:selectedAttribtes = $global:defaultAttributes


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

    $UserLicenseView.columnCount = 10

    $UserLicenseViewColumns = @()
    $UserLicenseViewColumns = @("ID","UserPrincipalName","Blocked","FirstName","LastName","DisplayName","City","Country","Department","LicenseAssignmentStates")

    for ($i = 0 ; $i -lt $UserLicenseViewColumns.count ; $i++)
    {
        $UserLicenseView.columns[$i].name = $UserLicenseViewColumns[$i]
    }

    $userLicenseView.Columns | Foreach-Object{
        $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
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

    $sku = $global:skuTracking | where {$_.skucommonName -eq $itemSelected}

    $skuString = "assignedLicenses/any(u:u/skuId eq " + $sku.skuID + ")"

    try {
        $skuUsers = get-mgUser -all -filter $skuString -properties $global:possibleAttributes -errorAction STOP
        $proceedWithList = $true
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
}
function LicenseAssignmentReport
{
    . (Join-Path $PSScriptRoot 'licenseassignmentreport.designer.ps1')
$LicenseAssignmentreport.ShowDialog()
}

