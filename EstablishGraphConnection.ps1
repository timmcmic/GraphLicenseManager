Function EstablishGraphConnection
{
    $ExitButton_Click = {
        [void]$Form1.close()
    }
    
    out-logfile -string "Entered establish graph connection..."

    $RadioButton1_CheckedChanged = {
        out-logfile -string "Certifcate radio button selected..."
        $textBox2.enabled = $true
        $textBox3.enabled = $TRUE
    }
    
    $RadioButton2_CheckedChanged = {
        out-logfile -string "Interactive credentials radio button selected..."
        $textBox2.Enabled = $false
        $textBox3.enabled = $false 
    }

    $Button1_Click = {
        <#
        out-logfile -string "Establish graph button clicked..."

        if ($GlobalButton.checked -eq $True)
        {
            out-logfile -string "Global graph envirnoment in use."
            $graphEnvironment = "Global"
        }
        elseif ($USGovButton.checked -eq $TRUE)
        {
            out-logfile -string "USGov graph environment in use."
            $graphEnvironment = "USGov"
        }
        elseif ($USDoDButton.checked -eq $TRUE)
        {
            out-logfile -string "USGovDOD graph environment in use."
            $graphEnvironment = "USGovDOD"
        }
        elseif ($ChinaButton.checked -eq $TRUE)
        {
            out-logfile -string "China graph environment in use."
            $graphEnvironment = "China"
        }
        #>

        if ($textBox1.text -eq "")
        {
            [System.Windows.Forms.MessageBox]::Show("TenantID is required to connnect to Microsoft Graph...", 'Warning')
            out-logfile -string "TenantID is required to connnect to Microsoft Graph..."
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
            }
            elseif($textBox2.text -eq "")
            {
                [System.Windows.Forms.MessageBox]::Show("Certificate Thumbprint is required...", 'Warning')
                out-logfile -string "Certificate Thumbprint is required..."
            }
            elseif($textBox3.text -eq "")
            {
                [System.Windows.Forms.MessageBox]::Show("Application ID is require...", 'Warning')
                out-logfile -string "Application ID is require..."
            }
        }
        elseif ($radioButton2.checked)
        {
            out-logfile -string "Interactive authentication radio box selected..."

            try {
                Connect-MgGraph -tenantID $tenantID -scopes "Directory.ReadWrite.All,Group.ReadWrite.All" -environment $graphEnvironment -errorAction Stop
                out-logfile -string "Graph connection started successfully - close authentication form."
                [void]$Form1.close()
            }
            catch {
                $errorText=$_
                out-logfile -string $errorText
                out-logfile -string "Unable to connect to Microsoft Graph.."
                [System.Windows.Forms.MessageBox]::Show("Unable to connect to Microsoft Graph.."+$errorText, 'Warning')
            }
        }
    }

    
    out-logfile -string "Exiting establish graph connection..."

    $EnvironmentBox.Items.Add("Global")
    $EnvironmentBox.Items.Add("USGov")
    $EnvironmentBox.Items.Add("USGovDOD")
    $EnvironmentBox.Items.Add("China")

    out-logfile -string "Showing the authentication form to begin user interation..."

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    [void]$Form1.ShowDialog()
}