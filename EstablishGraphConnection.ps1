<#
$items = "Global", "USGov", "USGovDOD" , "China"
$EnvironmentBox.Items.AddRange($items)

$directoryItems = "Organization.Read.All","Directory.Read.All","Directory.ReadWrite.All"
$DirectoryPermissiosnBox.Items.AddRange($directoryItems)

$groupItems = "LicenseAssignment.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All"
$GroupPermissiosnBox.Items.AddRange($groupItems)
#>
Function EstablishGraphConnection
{
    $global:GraphEnvironment = "Global"
    $global:groupPermissions = "LicenseAssignment.ReadWrite.All"
    $global:directoryPermissions = "Organization.Read.All"
    $global:combinedPermissions = ""

    $EnvironmentBox_SelectedIndexChanged = {
        out-logfile -string $environmentBox.selectedItem
        $global:GraphEnvironment = $environmentBox.selectedItem
        $LoginStatusLabel.text = ("Environment Changed: "+$global:GraphEnvironment)
    }

    $GroupPermissionsBox_SelectedIndexChanged = {
        out-logfile -string $groupPermissionsBox.selectedItem
        $global:groupPermissions = $groupPermissionbox.selectedItem
        $LoginStatusLabel.text = ("Group Permissions ChangeD: "+$groupPermissionbox.selectedItem)
    }

    $directoryPermissionsBox_SelectedIndexChanged = {
        out-logfile -string $directoryPermissionsBox.selectedItem
        $global:DirectoryPermissions = $directoryPermissionsBox.selectedItem
        $loginStatusLabel.text = ("Directory Permissions Change: "+$directoryPermissionsBox.selectedItem)
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
        $groupPermissions.hide()
        $directoryPermission.hide()
        $groupPermissions.hide()
        $directoryPermissions.hide()
    }
    
    $RadioButton2_CheckedChanged = {
        out-logfile -string "Interactive credentials radio button selected..."
        $textBox2.Enabled = $false
        $textBox3.enabled = $false 
        $LoginStatusLabel.text = ("Interactive Authentication Selected")
        $groupPermissions.show()
        $directoryPermission.show()
        $groupPermissions.show()
        $directoryPermissions.show()
    }

    $Button1_Click = {
        $global:combinedPermissions = $global:groupPermissions+","+$global:directoryPermissions

        out-logfile -string ("Combined scopes based on user input: "+$global:combinedPermissions)

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

            try {
                Connect-MgGraph -tenantID $tenantID -scopes $global:combinedPermissions -environment $global:GraphEnvironment -errorAction Stop
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
    }

    out-logfile -string "Showing the authentication form to begin user interation..."

    out-logfile -string "Add items ot the combo box."




    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    [void]$Form1.ShowDialog()
}