function populateSkuBox
{
    $items = @()

    $items += $global:skuTracking | sort-object SkuID -Unique

    $skuBox.items.addRange($items.SkuCommonName)
    $SkuBox.add_SelectedIndexChanged($SkuBox_SelectedIndexChanged)
    $skuBox.selectedIndex = 0
}

function populatePossibleAttributes
{
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


$LicenseAssignmentReport_Load = {

    $global:isFormLoad = $true

    out-logfile -string "Populate the SKU Box."

    PopulateSkuBox
    
    out-logfile -string "Populate the possible attributes box."

    populatePossibleAttributes
}


function LicenseAssignmentReport
{
    out-logfile -string "Entering license assignment report."

    out-logfile -string "Establishing global properties for getting users."

    $global:possibleAttributes = "AboutMe","AccountEnabled","AgeGroup","AssignedLicenses","AssignedPlans","Birthday","BusinessPhone","City","CompanyName","ConsentProvidedForMinor","Country","CreatedDateTime","CreationType","DeletedDateTime","Department","DisplayName","EmployeeHireDate","EmployeeLeaveDateTime","EmployeeID","EmployeeOrgData","EmployeeType","ExternalUserState","ExternalUserStateChangeDateTime","FaxNumber","GivenName","HireDate","ID","Identities","IMAddress","Interests","JobTitle","LastPasswordChangeDateTime","LegalAgeGroupClassification","LicenseAssignmentStates","Mail","MailNickName","MobilePhone","MySite","OfficeLocation","onPremisesDistinguishedName","onPremisesDomainName","onPremisesImmutableId","onPremisesLastSyncDateTime","onPremisesProvisioningErrors","onPremisesSamAccountName","onPremisesSecurityIdentifier","onPremisesSyncEnabled","onPremisesUserPrincipalName","otherMails","passwordPolicies","pastProjects","postalCode","preferredDataLocation","preferredLanguage","provisionedPlans","proxyAddresses","refreshTokensValidFromDateTime","responsibilities","serviceProvisioningErrors","schools","securityIdentifier","signInSessionsValidFromDateTime","skills","state","streetAddress","surname","usageLocation","userPrincipalName","userType"
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