function ManageGroupLicense
{
    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    $Form2.ShowDialog()
}