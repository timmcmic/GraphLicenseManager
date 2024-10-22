$GroupMembersName_Click = {
}

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
            $GroupMembersView.show()

            $groupMembersView.columnCount = 2
            $groupMembersView.columnHeadersVisible = $TRUE
            $groupMembersView.columns[0].name = "ID"
            $groupMembersView.columns[1].name = "DisplayName"

            foreach ($object in $groupMembers)
            {
                $groupMembersView.rows.add($object.id,$object.AdditionalProperties.displayName)
            }
        }

        if ($getGroupFailure -eq $FALSE)
        {
            try {
                $skus = Get-MgSubscribedSku -errorAction Stop
                $getGroupFailure=$false
            }
            catch {
                $getGroupFailure=$true
                $errorText=$_
                [System.Windows.Forms.MessageBox]::Show("Unable to obtain the skus within the tenant.."+$errorText, 'Warning')
            }

            $licenseLabel.show()
            $LicenseList.show()

            foreach ($sku in $skus)
            {
                $item = New-Object System.Windows.Forms.ListViewItem($sku.SkuId)

                foreach ($servicePlan in $sku.servicePlans)
                {
                    $item.Subitems.add($servicePlan)
                }

                $listView.Items.Add($item)
            }
        }
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}