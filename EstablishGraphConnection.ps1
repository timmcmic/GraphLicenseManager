$textBox2.Enabled = $false
$textBox3.enabled = $false 
}

$TextBox3_TextChanged = {
}
$TextBox2_TextChanged = {
}


$RadioButton1_CheckedChanged = {
    $textBox2.enabled = $true
    $textBox3.enabled = $TRUE
}

$RadioButton2_CheckedChanged = {
    $textBox2.Enabled = $false
    $textBox3.enabled = $false 
}

function EstablishGraphConnection
{
    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    $Form1.ShowDialog()
}