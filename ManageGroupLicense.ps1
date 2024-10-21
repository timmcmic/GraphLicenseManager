
function ManageGroupLicense
{
    $Button1_Click = {
        $groupID = $groupObjectIDText.Text
        write-host "GroupID"
    }

    . (Join-Path $PSScriptRoot 'establishgraphconnection.designer.ps1')
    $Form2.ShowDialog()
}