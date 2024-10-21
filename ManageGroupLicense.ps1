
function ManageGroupLicense
{
    $Button1_Click = {

        $groupID = $groupObjectIDText.Text

        try
        {
            $graphGroup = get-MGGroup -groupID $groupID -errorAction STOP
        }
        catch
        {
            $errorText=$_
            [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
        }
        
        write-host $groupID
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}