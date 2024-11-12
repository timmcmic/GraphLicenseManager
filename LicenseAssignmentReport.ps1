$PropertyBox_SelectedIndexChanged = {
}
$ReportExitButton_Click = {

    [void]$LicenseAssignmentReport.close()

}

$ExportCSV_Click = {
    $global:telemetryCSVExport++

    $ToolStripStatusLabel1.Text = "Attempting export to csv."

    out-logfile -string "Export to CSV Selected."

    $selectedID = $skuBox.selectedItem

    out-logfile -string $selectedID
    
    $sku = getSkuInfo -returnType "SkuPartNumber" -commonName $selectedID

    out-logfile -string $sku

    $licenseExport = $global:logFile.replace(".log","_"+$sku+".csv")

    out-logfile -string $licenseExport

    $output = $global:licensedUsers | select-object $global:selectedAttributes

    try {
        $output | export-csv $licenseExport -errorAction STOP
        [System.Windows.Forms.MessageBox]::Show("Data exported to CSV", 'Success')
        $ToolStripStatusLabel1.Text = "Export to CSV was successful."
    }
    catch {
        $errorText = $_
        $global:ErrorMessages += $errorText
        out-logfile -string $_
        [System.Windows.Forms.MessageBox]::Show("Unable to create CSV file"+$_, 'Warning')
    }
}

$RefreshButton_Click = {
    $global:telemetryRefresh++

    $ToolStripStatusLabel1.Text = "Attempting to refresh the users license view with new fields."

    out-logfile -string "The administrator has selected the refresh button."

    out-logfile -string "Clearing all columns and rows."

    CleanDataView

    out-logfile -string "Capture the selections made for attributes."

    if ($propertyBox.checkedItems.count -gt 0)
    {
        $global:selectedAttributes = $propertyBox.checkedItems
        $global:telemetryattributesSelected += $global:selectedAttributes
        $global:telemetryattributesSelected = $global:telemetryattributesSelected | Select-Object -Unique

        out-logfile -string $global:selectedAttributes.count

        foreach ($item in $global:selectedAttributes)
        {
            out-logfile -string $item
        }

        out-logfile -string "Perform an update to the display table using the new options specified."

        buildDataView -skuUsers $global:licensedUsers
    }
    else 
    {
        [System.Windows.Forms.MessageBox]::Show("A property option is required in order to refresh", 'Warning')
    }

    $ToolStripStatusLabel1.Text = "User license view refreshed with new fields."

}

#=====================================================================================================
function populateSkuBox
{
    $items = @()

    $items += $global:skuTracking | sort-object SkuID -Unique

    $skuBox.items.addRange($items.SkuCommonName)
    $SkuBox.add_SelectedIndexChanged($SkuBox_SelectedIndexChanged)
    $skuBox.selectedIndex = 0
}

#=====================================================================================================
function populatePossibleAttributes
{
    foreach ($member in $global:possibleAttributes)
    {
        out-logfile -string ("Processing property: "+$member)
        if ($global:defaultAttributes.contains($member))
        {
            out-logfile -string "Member in default attribute set."
            $propertyBox.items.add($member,$true)
        }
        else 
        {
            out-logfile -string "Member is not in default attribute set."
            $propertyBox.items.add($member,$false)
        }
    }
}

#=====================================================================================================

$LicenseAssignmentReport_Load = {

    $global:isFormLoad = $true

    out-logfile -string "Populate the SKU Box."

    PopulateSkuBox
    
    out-logfile -string "Populate the possible attributes box."

    populatePossibleAttributes
}

#=====================================================================================================

function getSkuInfo
{
    param(
        [Parameter(Mandatory = $false)]
        $returnType,
        [Parameter(Mandatory = $false)]
        $commonName
    )

    if ($returnType -eq "SkuID")
    {
        $sku = ($global:skuTracking | where {$_.skucommonName -eq $commonName}).skuID
        $sku = $sku | Select-Object -Unique
    }
    elseif($returnType -eq "SkuPartNumber")
    {
        $sku = ($global:skuTracking | where {$_.skucommonName -eq $commonName}).skuPartNumber
        $sku = $sku | Select-Object -Unique
    }

    return $sku
}

#=====================================================================================================

function getUserBySku
{
    param(
        [Parameter(Mandatory = $false)]
        $skuSelected
    )
    
    out-logfile -string ("Attempting to locate users with the sku: "+$skuSelected)

    $sku = getSkuInfo -returnType "SkuID" -commonName $skuSelected
    
    out-logfile -string ("Unique SKU ID found: "+$sku)

    out-logfile -string "Build the SKU Filter string..."

    $skuString = "assignedLicenses/any(u:u/skuId eq "+"$sku"+")"

    out-logfile -string $skuString

    $propertiesList = $global:possibleAttributes -join (",")

    out-logfile -string ("Pulling the selected properties: "+$propertiesList)

    try {
        $skuUsers = get-mgUser -all -filter $skuString -Property $propertiesList -errorAction STOP
        out-logfile -string $skuUsers.Count.tostring()
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
    }
    
    return $skuUsers
}

#=====================================================================================================
function buildDataView
{
    param(
        [Parameter(Mandatory = $false)]
        $skuUsers
    )
    
    out-logfile -string "Bulding the users view for the administrator."

    $UserLicenseView.columnCount = $global:selectedAttributes.count

    out-logfile -string ("Column Count: "+$UserLicenseView.columnCount.count)

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
        $attributesToDisplay = @()

        foreach ($attribute in $global:selectedAttributes)
        {
            $attributesToDisplay += $member."$attribute"
        }

        $userLicenseView.rows.add($attributesToDisplay)
    }
}

#=====================================================================================================
function CleanDataView
{
    $userLicenseView.rows.clear()
    $userLicenseView.columns.Clear()
}

#=====================================================================================================

$SkuBox_SelectedIndexChanged = {

    $global:telemetryLicensesViewed++

    out-logfile -string "SKU Selection has changed."

    out-logfile -string "Clearing all columns and rows."

    CleanDataView

    $itemSelected = $skuBox.selectedItem
    out-logfile -string $itemSelected

    if ($global:isFormLoad -eq $FALSE)
    {
        $ToolStripStatusLabel1.Text = ("SKU Selection: "+$itemSelected)
    }
    
    $global:isFormLoad = $false

    out-logfile -string "Pull the users associated with the sku selected."

    $global:licensedUsers = getUserBySku -skuSelected $itemSelected

    out-logfile -string "Build the users output table for review."

    BuildDataView -skuUsers $global:licensedUsers
}


function LicenseAssignmentReport
{
    $global:telemetryOperationName = "License Assignment Report"

    out-logfile -string "Entering license assignment report."

    out-logfile -string "Establishing global properties for getting users."

    #$global:possibleAttributes = "AboutMe","AccountEnabled","AgeGroup","AssignedLicenses","AssignedPlans","Birthday","BusinessPhone","City","CompanyName","ConsentProvidedForMinor","Country","CreatedDateTime","CreationType","DeletedDateTime","Department","DisplayName","EmployeeHireDate","EmployeeLeaveDateTime","EmployeeID","EmployeeOrgData","EmployeeType","ExternalUserState","ExternalUserStateChangeDateTime","FaxNumber","GivenName","HireDate","ID","Identities","IMAddress","Interests","JobTitle","LastPasswordChangeDateTime","LegalAgeGroupClassification","LicenseAssignmentStates","Mail","MailNickName","MobilePhone","MySite","OfficeLocation","onPremisesDistinguishedName","onPremisesDomainName","onPremisesImmutableId","onPremisesLastSyncDateTime","onPremisesProvisioningErrors","onPremisesSamAccountName","onPremisesSecurityIdentifier","onPremisesSyncEnabled","onPremisesUserPrincipalName","OtherMails","PasswordPolicies","PastProjects","PostalCode","PreferredDataLocation","PreferredLanguage","ProvisionedPlans","ProxyAddresses","RefreshTokensValidFromDateTime","Responsibilities","ServiceProvisioningErrors","Schools","SecurityIdentifier","SignInSessionsValidFromDateTime","Skills","State","StreetAddress","Surname","UsageLocation","UserPrincipalName","UserType"
    #$global:possibleAttributes = "AccountEnabled","AssignedLicenses","AssignedPlans","BusinessPhone","City","CompanyName","Country","CreatedDateTime","CreationType","DeletedDateTime","Department","DisplayName","ExternalUserState","ExternalUserStateChangeDateTime","FaxNumber","GivenName","ID","IMAddress","JobTitle","LastPasswordChangeDateTime","LicenseAssignmentStates","Mail","MailNickName","MobilePhone","OfficeLocation","onPremisesDistinguishedName","onPremisesDomainName","onPremisesImmutableId","onPremisesLastSyncDateTime","onPremisesProvisioningErrors","onPremisesSamAccountName","onPremisesSecurityIdentifier","onPremisesSyncEnabled","onPremisesUserPrincipalName","OtherMails","PasswordPolicies","PostalCode","PreferredDataLocation","PreferredLanguage","ProvisionedPlans","ProxyAddresses","RefreshTokensValidFromDateTime","ServiceProvisioningErrors","SecurityIdentifier","SignInSessionsValidFromDateTime","State","StreetAddress","Surname","UsageLocation","UserPrincipalName","UserType"
    $global:possibleAttributes = "AccountEnabled","BusinessPhone","City","CompanyName","Country","CreatedDateTime","CreationType","DeletedDateTime","Department","DisplayName","ExternalUserState","ExternalUserStateChangeDateTime","FaxNumber","GivenName","ID","IMAddress","JobTitle","LastPasswordChangeDateTime","LicenseAssignmentStates","Mail","MailNickName","MobilePhone","OfficeLocation","onPremisesDistinguishedName","onPremisesDomainName","onPremisesImmutableId","onPremisesLastSyncDateTime","onPremisesSamAccountName","onPremisesSecurityIdentifier","onPremisesSyncEnabled","onPremisesUserPrincipalName","OtherMails","PasswordPolicies","PostalCode","PreferredDataLocation","PreferredLanguage","RefreshTokensValidFromDateTime","SecurityIdentifier","SignInSessionsValidFromDateTime","State","StreetAddress","Surname","UsageLocation","UserPrincipalName","UserType"
    $global:defaultAttributes = "AccountEnabled","DisplayName","ID","Mail","UserPrincipalName","UserType"  
    $global:selectedAttributes = $global:defaultAttributes

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

    . (Join-Path $PSScriptRoot 'licenseassignmentreport.designer.ps1')
    $LicenseAssignmentreport.ShowDialog()
}