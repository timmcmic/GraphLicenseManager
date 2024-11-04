$CloseDisplay_Click = {
    $GroupInfo.exit()
}

function DisplayGroupInfo
{
    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'displaygroupinfo.designer.ps1')
    $GroupInfo.ShowDialog()
}