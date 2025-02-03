$TextBox3_TextChanged = {
}
$Label2_Click = {
}
$TextBox2_TextChanged = {
}
$Label1_Click = {
}
<#
$items = "Global", "USGov", "USGovDOD" , "China"
$EnvironmentBox.Items.AddRange($items)
$EnvironmentBox.selectedIndex=0

$directoryItems = "LicenseAssignment.Read.All","Directory.Read.All","Directory.ReadWrite.All","Organization.Read.All","Organization.ReadWrite.All"
$DirectoryPermissionsBox.Items.AddRange($directoryItems)
$DirectoryPermissionsBox.selectedIndex = 1
$DirectoryPermissionsBox.add_SelectedIndexChanged($DirectoryPermissionsBox_SelectedIndexChanged)

$groupItems = "GroupMember.Read.All","Directory.Read.All","Group.Read.All","Group.ReadWrite.All","GroupMember.ReadWrite.All"
$GroupPermissionsBox.Items.AddRange($groupItems)
$GroupPermissionsBox.selectedIndex = 0
$GroupPermissionsBox.add_SelectedIndexChanged($GroupPermissionsBox_SelectedIndexChanged)

$items2 = "User.Read" , "User.ReadWrite","User.ReadBasic.All","User.Read.All","Directory.Read.All","User.ReadWrite.All","Directory.ReadWrite.All","None"
$userPermissionsBox.items.AddRange($items2)
$userPermissionsBox.selectedIndex = 7
$userPermissionsbox.add_SelectedIndexChanged($userPermissionsbox_SelectedIndexChanged)

$licenseItems = "LicenseAssignment.ReadWrite.All","Directory.ReadWrite.All","Group.ReadWrite.All"
$licensePermissionsBox.items.addRange($licenseItems)
$licensePermissionsBox.selectedIndex = 0
$licensePermissionsBox.add_SelectedIndexChanged($licensepermissionsbox_selectedIndexChanged)

$operations = "Group License Manager","License Assignment Report","Group Assignment Report"
$selectedOperationBox.items.addRange($operations)
$selectedOperationBox.selectedIndex = 0
$selectedOperationBox.add_SelectedIndexChanged($SelectedOperationsBox_SelectedIndexChanged)

#>

$Form1_Load = {
    out-logfile -string "Testing to see if administrator provided connection information in calling command."

    if ($global:EntraTenantID -ne "")
    {
        out-logfile -string $global:EntraTenantID
        $textBox1.appendText($global:EntraTenantID)
    }

    if ($global:CertificateThumbprint -ne "")
    {
        out-logfile -string $global:CertificateThumbprint
        $textBox2.appendText($global:CertificateThumbprint)
    }

    if ($global:AppID -ne "")
    {
        out-logfile -string $global:AppID
        $textBox3.appendText($global:AppID)
    }

    <#

    if (($global:EntraTenantID -ne "") -and ($global:appID -ne "") -and ($global:CertificateThumbprint -ne ""))
    {
        out-logfile -string "Invoking button click."
        $Button1.performClick()
    }

    #>
}

Function EstablishGraphConnection
{
    $global:referredObjectID = ""
    $global:GraphEnvironment = "Global"
    $global:interactiveAuth = $false
    $global:directoryPermissions = "Directory.Read.All"
    $global:groupPermissions = "GroupMember.Read.All"
    $global:userPermissions = "None"
    $global:licensePermissions = "LicenseAssignment.ReadWrite.All"
    $global:selectedOperation = "Group License Manager"

    $userPermissionsArray = "User.Read" , "User.ReadWrite","User.ReadBasic.All","User.Read.All","Directory.Read.All","User.ReadWrite.All","Directory.ReadWrite.All"
    $directoryPermissionsArray = "LicenseAssignment.ReadWrite.All","LicenseAssignment.Read.All","Organization.Read.All","Directory.Read.All","Directory.ReadWrite.All"
    $groupPermissionsArray = "GroupMember.Read.All","Directory.Read.All","Group.Read.All","Group.ReadWrite.All","GroupMember.ReadWrite.All"
    $licensePermissionsArray = "LicenseAssignment.ReadWrite.All","Directory.ReadWrite.All","Group.ReadWrite.All"
    $groupPermissionOK = $false
    $directoryPermissionOK = $false
    $licensePermissionsOk = $false

    $SelectedOperationsBox_SelectedIndexChanged = {
        out-logfile -string $selectedOperationBox.selectedItem
        $global:selectedOperation = $selectedOperationBox.selectedItem
        $LoginStatusLabel.text = ("Operation Changed: "+$selectedOperationBox.selectedItem)

        if ($global:interactiveAuth -eq $TRUE)
        {
            out-logfile -string "Interactive authentication is enabled -> adjust permissions dialog."

            if ($selectedOperationBox.selectedItem -eq "License Assignment Report")
            {
                out-logfile -string "Group permissions are not required."
                $groupPermissions.hide()
                $groupPermissionsBox.hide()
                $userPermissionsBox.selectedIndex = 0
                $global:userPermissions = $userPermissionsBox.selectedItem
                $global:groupPermissions = $global:userPermissions
                out-logfile -string "User permissions are required."
                $userPermissions.text = "User Permissions"
                $userPermissionsBox.items.remove("None")
            }
            elseif ($selectedOperationBox.selectedItem -eq "Group License Manager")
            {
                out-logfile -string "Group permissions are required."
                $groupPermissions.show()
                $groupPermissionsBox.show()
                $label7.show()
                $licensePermissionsBox.show()
                $global:GroupPermissions = $groupPermissionsbox.selectedItem
                $global:LicensePermissions = $licensePermissionsBox.selectedItem
                $userPermissions.text = "User Permissions (Optional)"
                $userPermissionsBox.items.remove("None")
                $userPermissionsBox.items.Add("None")
                $userPermissionsBox.selectedIndex = 7
                $global:userPermissions = $userPermissionsBox.selectedItem
            }
            elseif ($selectedOperationBox.selectedItem -eq "Group Assignment Report")
            {
                out-logfile -string "Group permissions are required."
                $groupPermissions.show()
                $groupPermissionsBox.show()
                $global:GroupPermissions = $groupPermissionsbox.selectedItem
                $userPermissions.text = "User Permissions (Optional)"
                $userPermissionsBox.items.remove("None")
                $userPermissionsBox.items.Add("None")
                $userPermissionsBox.selectedIndex = 7
                $global:userPermissions = $userPermissionsBox.selectedItem
            }
        }
        else 
        {
            out-logfile -string "Interactive authentication disabled -> no adjustment dialogs necessary."
        }
    }
    
    $EnvironmentBox_SelectedIndexChanged = {
        out-logfile -string $environmentBox.selectedItem
        $global:GraphEnvironment = $environmentBox.selectedItem
        $LoginStatusLabel.text = ("Environment Changed: "+$global:GraphEnvironment)
    }

    $groupPermissionsBox_SelectedIndexChanged = {
        out-logfile -string $groupPermissionsBox.selectedItem
        $global:GroupPermissions = $groupPermissionsBox.selectedItem
        $loginStatusLabel.text = ("Group Permissions Changed: "+$global:GroupPermissions)
    }

    $directoryPermissionsBox_SelectedIndexChanged = {
        out-logfile -string $directoryPermissionsBox.selectedItem
        $global:directoryPermissions = $directoryPermissionsBox.selectedItem
        $loginStatusLabel.text = ("Directory Permissions Changed: "+$global:DirectoryPermissions)
    }

    $userPermissionsBox_SelectedIndexChanged = {
        out-logfile -string $userPermissionsBox.selectedItem
        $global:userPermissions = $userPermissionsbox.selectedItem
        $loginStatusLabel.text = ("User Permissions Changed: "+$global:userPermissions)
    }

    $licensepermissionsbox_selectedIndexChanged = {
        out-logfile -string $licensePermissionsBox.selectedItem
        $global:licensePermissions = $licensePermissionsBox.selectedItem
        $loginStatusLabel.text = ("License Permissions Changed: "+$global:licensePermissions)
    }

    $ExitButton_Click = {
        $global:exitSelected = $true
        [void]$Form1.close()
    }
    
    out-logfile -string "Entered establish graph connection..."

    $RadioButton1_CheckedChanged = {
        out-logfile -string "Certifcate radio button selected..."
        $textBox2.enabled = $true
        $textBox3.enabled = $TRUE
        $clientSecret.enabled = $true
        $LoginStatusLabel.text = ("Certificate Authentication Selected")

        out-logfile -string $global:interactiveAuth 
        $global:interactiveAuth = $false
        out-logfile -string $global:interactiveAuth
        $groupPermissions.hide()
        $directoryPermissions.hide()
        $directoryPermissionsBox.hide()
        $groupPermissionsBox.hide()
        $userPermissions.hide()
        $userPermissionsBox.hide()
        $label7.hide()
        $licensePermissionsBox.hide()
    }
    
    $RadioButton2_CheckedChanged = {
        out-logfile -string "Interactive credentials radio button selected..."
        $textBox2.Enabled = $false
        $textBox3.enabled = $false 
        $clientSecret.enabled = $FALSE
        $LoginStatusLabel.text = ("Interactive Authentication Selected")

        if ($global:selectedOperation -eq "Group License Manager")
        {
            $groupPermissions.show()
            $groupPermissionsBox.show()
        }

        $directoryPermissions.show()
        $directoryPermissionsBox.show()
        $label7.show()
        $licensePermissionsBox.show()
        $userPermissions.show()
        $userPermissionsbox.show()
        out-logfile -string $global:interactiveAuth
        $global:interactiveAuth = $true
        out-logfile -string $global:interactiveAuth
    }

    $Button1_Click = {
        out-logfile -string "A directory permission is always required - add this to required scopes."
        $global:CalculatedScopesArray = @()
        $global:CalculatedScopesArray += $global:directoryPermissions

        out-logfile -string "Validate that mandatory tenant ID is specified."

        if ($textBox1.text -eq "")
        {
            [System.Windows.Forms.MessageBox]::Show("TenantID is required to connnect to Microsoft Graph...", 'Warning')
            out-logfile -string "TenantID is required to connnect to Microsoft Graph..."
            $LoginStatusLabel.text = ("ERROR:  TenantID is required to connect to Microsoft Graph")
            $tenantIDError=$TRUE
        }
        else
        {
            $tenantIDError=$FALSE
            $tenantID = $textBox1.text
            out-logfile -string "TenantID provided in dialog..."
            out-logfile -string $tenantID
        }

        out-logfile -string "Access token is not specified - proceed with allowing access token connection."

        if (($RadioButton1.checked) -and ($tenantIDError -eq $FALSE))
        {
            out-logfile -string "Certificate / Client Secret authentication radio box selected..."

            if ((($textBox2.text -eq "") -and ($textBox3.text -eq "")) -or (($clientSecret.text -eq "") -and ($textBox3.text -eq "")))
            {
                [System.Windows.Forms.MessageBox]::Show("Certifcate Thumbprint or Client Screct with an ApplicationID are required!", 'Warning')
                out-logfile -string "Certifcate Thumbprint or Client Screct with an ApplicationID are required!"
                $LoginStatusLabel.text = ("ERROR:  Certifcate Thumbprint or Client Screct with an ApplicationID are required!")

            }
            else
            {
                $msGraphCertificateThumbPrint = $textBox2.Text
                $msGraphClientSecret = $clientSecret.text
                $msGraphApplicationID = $textBox3.Text
                out-logfile -string $msGraphCertificateThumbPrint
                out-logfile -string $msGraphApplicationID
                out-logfile -string "We are ready to establish the certificate authentication graph request."

                if ($msGraphCertificateThumbPrint -ne "" -and $msGraphTenandID -ne "")
                {
                    out-logfile -string "Certificate authentication..."
                    try
                    {
                        Connect-MgGraph -tenantID $tenantID -environment $global:GraphEnvironment -certificateThumbprint $msGraphCertificateThumbPrint -ClientId $msGraphApplicationID  -errorAction Stop
                        $connectionSuccessful = $true
                    }
                    catch
                    {
                        $errorText=$_
                        out-logfile -string $errorText
                        $errorText = CalculateError $errorText
                        $global:errorMessages+=$errorText
                        out-logfile -string "Unable to connect to Microsoft Graph.."
                        [System.Windows.Forms.MessageBox]::Show("Unable to connect to Microsoft Graph.."+$errorText, 'Warning')
                        $connectionSuccessful = $false
                    }
                }
                else 
                {
                    out-logfile -string "ClientSecret authentication..."
                    try
                    {
                        $securedPasswordPassword = convertTo-SecureString -string $msGraphClientSecret -AsPlainText -Force

                        $clientSecretCredential = new-object -typeName System.Management.Automation.PSCredential -argumentList $msGraphApplicationID,$securedPasswordPassword

                        Connect-MgGraph -tenantID $tenantID -environment $global:GraphEnvironment -ClientSecretCredential $clientSecretCredential -errorAction Stop
                        $connectionSuccessful = $true
                    }
                    catch
                    {
                        $errorText=$_
                        out-logfile -string $errorText
                        $errorText = CalculateError $errorText
                        $global:errorMessages+=$errorText
                        out-logfile -string "Unable to connect to Microsoft Graph.."
                        [System.Windows.Forms.MessageBox]::Show("Unable to connect to Microsoft Graph.."+$errorText, 'Warning')
                        $connectionSuccessful = $false
                    }
                }
            }
        }
        elseif (($RadioButton2.checked) -and ($tenantIDError -eq $FALSE))
        {
            out-logfile -string "Interactive authentication radio box selected..."

            out-logfile -string "Validate that the minimum scopes for required functions are selected."

            if ($global:userPermissions -ne "None")
            {
                out-logfile -string "User permissions are requested."

                $global:CalculatedScopesArray += $global:userPermissions
                $global:CalculatedScopesArray += $global:groupPermissions
                $global:CalculatedScopesArray += $global:licensePermissions

                foreach ($member in $global:CalculatedScopesArray)
                {
                    out-logfile -string $member
                }

                $global:CalculatedScopesArray = $global:CalculatedScopesArray | Select-Object -Unique

                out-logfile -string "Unique scopes in case there is an overlap"

                foreach ($member in $global:CalculatedScopesArray)
                {
                    out-logfile -string $member
                }

                out-logfile -string "Calculate Scopes Array."

                $global:calculatedScopes = $global:CalculatedScopesArray -join ","

                out-logfile -string $global:calculatedScopes
            }
            elseif
            {
                out-logfile -string "User permissions are not requested."

                $global:CalculatedScopesArray += $global:groupPermissions
                $global:CalculatedScopesArray += $global:licensePermissions

                foreach ($member in $global:CalculatedScopesArray)
                {
                    out-logfile -string $member
                }

                $global:CalculatedScopesArray = $global:CalculatedScopesArray | Select-Object -Unique

                out-logfile -string "Unique scopes in case there is an overlap"

                foreach ($member in $global:CalculatedScopesArray)
                {
                    out-logfile -string $member
                }

                out-logfile -string "Calculate Scopes Array."

                $global:calculatedScopes = $global:CalculatedScopesArray -join ","

                out-logfile -string $global:calculatedScopes
            }

            try {
                Connect-MgGraph -tenantID $tenantID -scopes $global:calculatedScopes -environment $global:GraphEnvironment -errorAction Stop
                out-logfile -string "Graph connection started successfully - close authentication form."
                $connectionSuccessful = $true
            }
            catch {
                $errorText=$_
                out-logfile -string $errorText
                $errorText = CalculateError $errorText
                $global:errorMessages+=$errorText
                out-logfile -string "Unable to connect to Microsoft Graph.."
                $LoginStatusLabel.text = ("ERROR:  Unable to connect to Microsoft Graph")
                [System.Windows.Forms.MessageBox]::Show("Unable to connect to Microsoft Graph.."+$errorText, 'Warning')
                $connectionSuccessful = $FALSE
            }
        }
        
        if ($connectionSuccessful -eq $TRUE)
        {
            $Details = Get-MgContext
            $Scopes = $Details | Select -ExpandProperty Scopes
            $Scopes = $Scopes -Join ", "
            if ($global:directoryPermissions -ne "LicenseAssignment.Read.All")
            {
                $OrgName = (Get-MgOrganization).DisplayName
            }
            
            out-logfile -string "Validate that the scopes provided to the application meet a minimum requirements."

            if ($global:selectedOperation -eq "Group License Manager")
            {
                if (($scopes.contains("User.ReadWrite.All")) -or ($scopes.contains("Directory.ReadWrite.All")))
                {
                    $global:allowReprocessing = $true
                }
                else 
                {
                    $global:allowReprocessing = $false                
                }

                foreach ($permission in $groupPermissionsArray)
                {
                    if ($scopes.contains($permission))
                    {
                        out-logfile -string "Group Permission Found"
                        $groupPermissionOK = $true
                        break
                    }
                    else 
                    {
                        out-logfile -string "Group Permission NOT Found"  
                        $groupPermissionOK = $false                  
                    }
                }
        
                foreach ($permission in $directoryPermissionsArray)
                {
                    out-logfile -string $permission
        
                    if ($scopes.contains($permission))
                    {
                        out-logfile -string "Directory Permission Found"
                        $directoryPermissionOK = $true
                        break
                    }
                    else 
                    {
                        out-logfile -string "Directory Permission NOT Found"
                        $directoryPermissionOK = $false
                    }
                }

                foreach ($permission in $licensePermissionsArray)
                {
                    out-logfile -string $permission

                    if ($scopes.contains($permission))
                    {
                        out-logfile -string "License permission found"
                        $licensePermissionsOk = $true
                        break
                    }
                    else 
                    {
                        out-logfile -string "License permission found"
                        $licensePermissionsOK = $false
                    }
                }
        
                foreach ($permission in $userPermissionsArray)
                {
                    out-logfile -string $permission

                    if(($scopes.contains($permission)) -and ($global:userPermissions -eq "None"))
                    {
                        out-logfile -string "User Permission Found and was none - resetting."
                        $global:userPermissions = $permission
                        $userPermissionOK = $TRUE
                        break
                    }
                    elseif ($scopes.contains($permission)) 
                    {
                        out-logfile -string "User permission was specified and was found in scopes."
                        $userPermissionOK = $TRUE
                        break
                    }
                    else 
                    {
                        out-logfile -string "User Permission NOT Found"
                        $userPermissionOK = $false
                    }
                }

                <#

                if (($global:userPermissions -eq "None") -and ($userPermissionOK -eq $FALSE))
                {
                    out-logfile -string "A user permission was not specified - see if it overlaps with another permission."

                    foreach ($permission in $userPermissionsArray)
                    {
                        if ($scopes.contains($permission))
                        {
                            out-logfile -string "Permission Found - setting random user permission to show all options."
                            $global:userPermissions = $permission
                            $userPermissionOK = $true
                        }
                    }
                }

                #>
            }
            elseif ($global:selectedOperation -eq "Group Assignment Report")
            {
                if (($scopes.contains("User.ReadWrite.All")) -or ($scopes.contains("Directory.ReadWrite.All")))
                {
                    $global:allowReprocessing = $true
                }
                else 
                {
                    $global:allowReprocessing = $false                
                }

                foreach ($permission in $groupPermissionsArray)
                {
                    if ($scopes.contains($permission))
                    {
                        out-logfile -string "Group Permission Found"
                        $groupPermissionOK = $true
                        break
                    }
                    else 
                    {
                        out-logfile -string "Group Permission NOT Found"  
                        $groupPermissionOK = $false                  
                    }
                }
        
                foreach ($permission in $directoryPermissionsArray)
                {
                    out-logfile -string $permission
        
                    if ($scopes.contains($permission))
                    {
                        out-logfile -string "Directory Permission Found"
                        $directoryPermissionOK = $true
                        break
                    }
                    else 
                    {
                        out-logfile -string "Directory Permission NOT Found"
                        $directoryPermissionOK = $false
                    }
                }
        
                foreach ($permission in $userPermissionsArray)
                {
                    out-logfile -string $permission

                    if(($scopes.contains($permission)) -and ($global:userPermissions -eq "None"))
                    {
                        out-logfile -string "User Permission Found and was none - resetting."
                        $global:userPermissions = $permission
                        $userPermissionOK = $TRUE
                        break
                    }
                    elseif ($scopes.contains($permission)) 
                    {
                        out-logfile -string "User permission was specified and was found in scopes."
                        $userPermissionOK = $TRUE
                        break
                    }
                    else 
                    {
                        out-logfile -string "User Permission NOT Found"
                        $userPermissionOK = $false
                    }
                }

                <#

                if (($global:userPermissions -eq "None") -and ($userPermissionOK -eq $FALSE))
                {
                    out-logfile -string "A user permission was not specified - see if it overlaps with another permission."

                    foreach ($permission in $userPermissionsArray)
                    {
                        if ($scopes.contains($permission))
                        {
                            out-logfile -string "Permission Found - setting random user permission to show all options."
                            $global:userPermissions = $permission
                            $userPermissionOK = $true
                        }
                    }
                }

                #>
            }
            elseif ($global:selectedOperation -eq "License Assignment Report")
            {    
                $groupPermissionOK = $true

                foreach ($permission in $directoryPermissionsArray)
                {
                    out-logfile -string $permission
        
                    if ($scopes.contains($permission))
                    {
                        out-logfile -string "Directory Permission Found"
                        $directoryPermissionOK = $true
                        break
                    }
                    else
                    {
                        out-logfile -string "Directory Permission NOT Found"
                        $directoryPermissionOK = $false
                    }
                }
        
                foreach ($permission in $userPermissionsArray)
                {
                    out-logfile -string $permission
        
                    if ($scopes.contains($permission))
                    {
                        out-logfile -string "User Permission Found"
                        $global:userPermissions = $permission
                        $userPermissionOK = $true
                        break
                    }
                    else 
                    {
                        out-logfile -string "User Permission NOT Found"
                        $userPermissionOK = $FALSE
                    }
                }
            }
            else 
            {
                out-logfile -string "Something went wrong...you should not have ended up here."
            }           
    
            out-logfile "+-------------------------------------------------------------------------------------------------------------------+"
            out-logfile "Microsoft Graph Connection Information"
            out-logfile "--------------------------------------"
            out-logfile ""
            out-logfile ("Connected to Tenant " + $Details.TenantId + " " +  $OrgName + " as account " + $Details.Account + "in environment " + $details.Environment)
            out-logfile "--------------------------------------"
            out-logfile ("The following permission scope is defined: " + $Scopes)
            out-logfile ""
            out-logfile "+-------------------------------------------------------------------------------------------------------------------+"
    
            if (($directoryPermissionOK -ne $true) -or ($groupPermissionOK -ne $TRUE) -or ($userPermissionOK -ne $true) -or ($licensePermissionsOk -ne $true))
            {
                [System.Windows.Forms.MessageBox]::Show("The graph scopes required are not present in the request.  Suspect that the application ID does not have correct permissions consented.")
                $global:exitSelected = $true
                [void]$Form1.close()
            }
            else 
            {
                [void]$form1.close()
            }
        }
    }

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    [void]$Form1.ShowDialog()
}