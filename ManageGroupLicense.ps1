
function ManageGroupLicense
{
    $Button1_Click = {

        $groupID = $groupObjectIDText.Text
        $getGroupFailure = $FALSE

        try
        {
            $graphGroup = get-MGGroup -groupID $groupID -errorAction STOP
        }
        catch
        {
            $getGroupFailure=$true
            $errorText=$_
            [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
        }

        $displayNameText.clear()
        $expirationDateTimeText.clear()
        $mailText.clear()
        $groupTypeText.clear()
        $membershipRuleText.clear()

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

        $displayNameText.appendtext($graphGroup.displayName)
        $mailText.appendtext($graphGroup.mail)
        $membershipRuleText.appendtext($graphGroup.membershipRule)
        $groupTypeText.appendtext($graphGroup.GroupTypes)

        if ($getGroupFailure -eq $false)
        {
            try
            {
                $groupMembers = get-mgGroupMember -groupID $groupID -errorAction STOP
                $getGroupFailure=$false
            }
            catch
            {
                $getGroupFailure=$true
                $errorText=$_
                [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
            }

            $GroupMembersName.Show()
            $groupMembersView.show()

            $groupMembersView.columns.add("UserID")
            $groupMembers.id | foreach-Object {[void]$groupMembersView.items.add("UserID").subItems($_)}

            foreach ($member in $groupMembers)
            {

            }
        }
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}