function EstablishGraphConnection
{
    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    $Form1.ShowDialog()
}