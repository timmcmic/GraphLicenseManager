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
        $parent = New-Object System.Windows.Forms.TreeNode($skuID.SkuId)
        $treeView.Nodes.Add($parent)
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}