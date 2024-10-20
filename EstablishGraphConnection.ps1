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

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    $Form1.ShowDialog()
}