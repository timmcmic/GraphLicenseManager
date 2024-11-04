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

$directoryItems = "Organization.Read.All","Directory.Read.All","Directory.ReadWrite.All"
$DirectoryPermissionsBox.Items.AddRange($directoryItems)
$DirectoryPermissionsBox.selectedIndex = 0
$DirectoryPermissionsBox.add_SelectedIndexChanged($DirectoryPermissionsBox_SelectedIndexChanged)


$groupItems = "LicenseAssignment.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All"
$GroupPermissionsBox.Items.AddRange($groupItems)
$GroupPermissionsBox.selectedIndex = 0
$GroupPermissionsBox.add_SelectedIndexChanged($GroupPermissionsBox_SelectedIndexChanged)

$items2 = "None" , "User.Read" , "User.ReadWrite","User.ReadBasic.All","User.Read.All","User.ReadWrite.All","Directory.Read.All","Directory.ReadWrite.All"
$userPermissionsBox.items.AddRange($items2)
$userPermissionsBox.selectedIndex = 0
$userPermissionsbox.add_SelectedIndexChanged($userPermissionsbox_SelectedIndexChanged)

#>

Function EstablishGraphConnection
{
    $global:GraphEnvironment = "Global"
    $global:interactiveAuth = $true
    $global:directoryPermissions = "Organization.Read.All"
    $global:groupPermissions = "LicenseAssignment.ReadWrite.All"
    $global:calculatedScopes = $global:directoryPermissions+","+$global:groupPermissions
    
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

    $ExitButton_Click = {
        $global:exitSelected = $true
        [void]$Form1.close()
    }
    
    out-logfile -string "Entered establish graph connection..."

    $RadioButton1_CheckedChanged = {
        out-logfile -string "Certifcate radio button selected..."
        $textBox2.enabled = $true
        $textBox3.enabled = $TRUE
        $LoginStatusLabel.text = ("Certificate Authentication Selected")

        if ($global:interactiveAuth -eq $false)
        {
            out-logfile -string $global:interactiveAuth 
            $global:interactiveAuth = $TRUE
            out-logfile -string $global:interactiveAuth
            $groupPermissions.hide()
            $directoryPermissions.hide()
            $directoryPermissionsBox.hide()
            $groupPermissionsBox.hide()
        }
        else
        {
            out-logfile -string $global:interactiveAuth
            $global:interactiveAuth = $TRUE
            out-logfile -string $global:interactiveAuth
        }
    }
    
    $RadioButton2_CheckedChanged = {
        out-logfile -string "Interactive credentials radio button selected..."
        $textBox2.Enabled = $false
        $textBox3.enabled = $false 
        $LoginStatusLabel.text = ("Interactive Authentication Selected")

        if ($global:interactiveAuth -eq $TRUE)
        {
            $groupPermissions.show()
            $directoryPermissions.show()
            $directoryPermissionsBox.show()
            $groupPermissionsBox.show()
            out-logfile -string $global:interactiveAuth
            $global:interactiveAuth = $FALSE
            out-logfile -string $global:interactiveAuth
        }
        else
        {
            out-logfile -string $global:interactiveAuth
            $global:interactiveAuth = $false
            out-logfile -string $global:interactiveAuth
        }
    }

    $Button1_Click = {
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

        if (($RadioButton1.checked) -and ($tenantIDError -eq $FALSE))
        {
            out-logfile -string "Certificate authentication radio box selected..."

            if (($textBox2.text -eq "") -and ($textBox3.text -eq ""))
            {
                [System.Windows.Forms.MessageBox]::Show("Certificate Thumbprint and Application ID Required...", 'Warning')
                out-logfile -string "Certificate Thumbprint and Application ID Required..."
                $LoginStatusLabel.text = ("ERROR:  Certificate Thumbprint and Application ID Required")

            }
            elseif($textBox2.text -eq "")
            {
                [System.Windows.Forms.MessageBox]::Show("Certificate Thumbprint is required...", 'Warning')
                out-logfile -string "Certificate Thumbprint is required..."
                $LoginStatusLabel.text = ("ERROR:  Certificate Thumbprint Required")

            }
            elseif($textBox3.text -eq "")
            {
                [System.Windows.Forms.MessageBox]::Show("Application ID is require...", 'Warning')
                out-logfile -string "Application ID is require..."
                $LoginStatusLabel.text = ("ERROR:  Applicatio ID Required")

            }
            else
            {
                $msGraphCertificateThumbPrint = $textBox2.Text
                $msGraphApplicationID = $textBox3.Text
                out-logfile -string $msGraphCertificateThumbPrint
                out-logfile -string $msGraphApplicationID
                out-logfile -string "We are ready to establish the certificate authentication graph request."

                try
                {
                    Connect-MgGraph -tenantID $tenantID -environment $global:GraphEnvironment -certificateThumbprint $msGraphCertificateThumbPrint -ClientId $msGraphApplicationID  -errorAction Stop
                    [void]$Form1.close()
                }
                catch
                {
                    $errorText=$_
                    out-logfile -string $errorText
                    $errorText = ($errorText -split 'Status: 400')[0]
                    $global:errorMessages+=$errorText
                    out-logfile -string "Unable to connect to Microsoft Graph.."
                    [System.Windows.Forms.MessageBox]::Show("Unable to connect to Microsoft Graph.."+$errorText, 'Warning')
                }
            }
        }
        elseif ($radioButton2.checked)
        {
            out-logfile -string "Interactive authentication radio box selected..."

            if ($global:userPermissions -ne "None")
            {
                out-logfile -string "User permissions are requested."

                $global:CalculatedScopesArray = @()
                $global:CalculatedScopesArray += $global:userPermissions
                $global:CalculatedScopesArray += $global:directoryPermissions
                $global:CalculatedScopesArray += $global:groupPermissions

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
                [void]$Form1.close()
            }
            catch {
                $errorText=$_
                out-logfile -string $errorText
                $errorText = ($errorText -split 'Status: 400')[0]
                $global:errorMessages+=$errorText
                out-logfile -string "Unable to connect to Microsoft Graph.."
                $LoginStatusLabel.text = ("ERROR:  Unable to connect to Microsoft Graph")
                [System.Windows.Forms.MessageBox]::Show("Unable to connect to Microsoft Graph.."+$errorText, 'Warning')
            }
        }

        $Details = Get-MgContext
        $Scopes = $Details | Select -ExpandProperty Scopes
        $Scopes = $Scopes -Join ", "
        $OrgName = (Get-MgOrganization).DisplayName

        out-logfile "+-------------------------------------------------------------------------------------------------------------------+"
        out-logfile "Microsoft Graph Connection Information"
        out-logfile "--------------------------------------"
        out-logfile ""
        out-logfile ("Connected to Tenant " + $Details.TenantId + " " +  $OrgName + " as account " + $Details.Account + "in environment " + $details.Environment)
        out-logfile "--------------------------------------"
        out-logfile ("The following permission scope is defined: " + $Scopes)
        out-logfile ""
        out-logfile "+-------------------------------------------------------------------------------------------------------------------+"
    }

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    [void]$Form1.ShowDialog()
}