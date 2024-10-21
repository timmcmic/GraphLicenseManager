
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

        $displayName.show() 
        $expirationDateTime.Show()
        $mail.show()
        $groupTypes.show()
        $membershipRule.show()
        $displayNameText.show()
        $expirationDateTimeText.show()
        $mailText.show()
        $groupTypeText.show()
        $membershipRuleText.show()

        $displayNameText.text($graphGroup.displayName)
        $mailText.text($graphGroup.mail)
        $membershipRuleText.text($graphGroup.membershipRule)
        $groupTypeText.text($graphGroup.GroupTypes)
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}