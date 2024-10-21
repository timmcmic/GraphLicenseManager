$TreeView1_AfterSelect = {
}
$ComboBox1_SelectedIndexChanged = {
}
$Label1_Click = {
}
function ManageGroupLicense
{
    $skus = Get-MgSubscribedSku
    $skuID = @()
    
    foreach ($sku in $skus)
    {
        $skuID +=$sku.SkuId
    }

    foreach ($id in $skuID)
    {
        $parent = New-Object System.Windows.Forms.TreeNode($id)
        $treeView1.Nodes.Add($parent)
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}