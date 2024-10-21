function EstablishGraphConnection
{
    $RadioButton1_CheckedChanged = {
        $textBox2.enabled = $true
        $textBox3.enabled = $TRUE
    }
    
    $RadioButton2_CheckedChanged = {
        $textBox2.Enabled = $false
        $textBox3.enabled = $false 
    }

    $Button1_Click = {
        if ($textBox1.text -eq "")
        {
            [System.Windows.Forms.MessageBox]::Show("TenantID is required to connnect to Microsoft Graph...", 'Warning')
            $tenantIDError=$TRUE
        }
        else
        {
            $tenantIDError=$FALSE
            $tenantID = $textBox1.text
        }

        if (($RadioButton1.checked) -and ($tenantIDError -eq $FALSE))
        {
            if (($textBox2.text -eq "") -and ($textBox3.text -eq ""))
            {
                [System.Windows.Forms.MessageBox]::Show("Certificate Thumbprint and Application ID Required...", 'Warning')
            }
            elseif($textBox2.text -eq "")
            {
                [System.Windows.Forms.MessageBox]::Show("Certificate Thumbprint is required...", 'Warning')
            }
            elseif($textBox3.text -eq "")
            {
                [System.Windows.Forms.MessageBox]::Show("Application ID is require...", 'Warning')
            }
        }
        elseif ($radioButton2.checked)
        {
            try {
                Connect-MgGraph -tenantID $tenantID -scopes "Directory.ReadWrite.All,Group.ReadWrite.All" -errorAction Stop
                #$Form1.close()
                #ManageGroupLicense
            }
            catch {
                $errorText=$_
                [System.Windows.Forms.MessageBox]::Show("Unable to connect to Microsoft Graph.."+$errorText, 'Warning')
            }
        }
    }

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    $Form1.ShowDialog()
}