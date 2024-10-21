$TreeView1_AfterSelect = {
}
$ComboBox1_SelectedIndexChanged = {
}
$Label1_Click = {
}
function ManageGroupLicense
{
    $skus = Get-MgSubscribedSku

    foreach ($skuID in $skus)
    {
        write-host $skuID
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}