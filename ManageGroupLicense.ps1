function CheckAllChildNodes($treeNode, $nodeChecked){
    foreach($node in $treeNode.Nodes){
        $node.Checked = $nodeChecked
        if($node.Nodes.Count -gt 0){
            CheckAllChildNodes $node $nodeChecked
        }
    }
}

function ManageGroupLicense
{
    out-logfile -string "Entered manage group license..."

    $commit_Click = {
    }
    $exit_Click = {
        $form2.close()
    }

    $Button1_Click = {

        out-logfile -string "Search button selected..."
        $groupID = $groupObjectIDText.Text
        out-logfile -string $groupID
        $getGroupFailure = $FALSE

        try
        {
            out-logfile -string "Attempt to locate the group via groupID..."
            $graphGroup = get-MGGroup -groupID $groupID -errorAction STOP
            out-logfile -string "Group was successfully located..."
            out-logfile -string $graphGroup
            $getGroupFailure=$false
        }
        catch
        {
            $getGroupFailure=$true
            $errorText=$_
            out-logfile -string "The group was not located by group object id.."
            out-logfile -string $errorText
            [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
        }

        try
        {
            out-logfile -string "Attempt to obtain assigned licenses on the group by groupID..."
            $graphGroupLicenses = get-MGGroup -groupID $groupID -property "AssignedLicense" -errorAction STOP
            out-logfile -string "Group and licenses were successfully located..."
        }
        catch
        {
            $getGroupFailure=$true
            $errorText=$_
            out-logfile -string "The group was not located by group object id.."
            out-logfile -string $errorText
            [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
        }

        out-logfile -string "Clearing all form controls..."

        $displayNameText.clear()
        $expirationDateTimeText.clear()
        $mailText.clear()
        $groupTypeText.clear()
        $membershipRuleText.clear()

        if ($getGroupFailure -eq $false)
        {
            out-logfile -string "Displaying all relevant form controls..."

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
            out-logfile -string $graphGroup.displayName
            $mailText.appendtext($graphGroup.mail)
            out-logfile -string $graphGroup.mail
            $membershipRuleText.appendtext($graphGroup.membershipRule)
            out-logfile -string $graphGroup.membershipRule
            $groupTypeText.appendtext($graphGroup.GroupTypes)
            out-logfile -string $graphGroup.GroupTypes
        }
        else
        {
            out-logfile -string "Relevant form controls not displayed due to previous failure."
        }

        if ($getGroupFailure -eq $false)
        {
            out-logfile -string "Previous operation was successful proceed with locating membership."
            try
            {
                $groupMembers = get-mgGroupMember -groupID $groupID -errorAction STOP

                $getGroupFailure=$false
            }
            catch
            {
                $getGroupFailure=$true
                $errorText=$_
                out-logfile -string "The group was not located by group object id.."
                out-logfile -string $errorText
                [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
            }

            out-logfile -string "Showing relelvant group member controls..."

            $GroupMembersName.Show()
            $GroupMembersView.show()

            out-logfile -string "Showing relevant group member information..."

            $groupMembersView.columnCount = 2
            $groupMembersView.columnHeadersVisible = $TRUE
            $groupMembersView.columns[0].name = "ID"
            $groupMembersView.columns[1].name = "DisplayName"

            out-logfile -string "Generate the membership view and log membership for preservation..."

            foreach ($object in $groupMembers)
            {
                $groupMembersView.rows.add($object.id,$object.AdditionalProperties.displayName)
                out-logfile -string ("Group Member ID: "+$object.id+" Group Member DisplayName: "+$object.AdditionalProperties.displayNam)
            }
        }

        if ($getGroupFailure -eq $FALSE)
        {
            out-logfile -string "Previous operations were successfuly - determine all skus within the tenant..."

            try {
                $skus = Get-MgSubscribedSku -errorAction Stop
                out-logfile -string "SKUs successfully obtained..."
                $getGroupFailure=$false
            }
            catch {
                $getGroupFailure=$true
                $errorText=$_
                out-logfile -string "Unable to obtain the skus within the tenant.."
                out-logfile -string $errorText
                [System.Windows.Forms.MessageBox]::Show("Unable to obtain the skus within the tenant.."+$errorText, 'Warning')
            }

            out-logfile -string "Showing license display controls..."

            $licenseLabel.show()
            $LicenseList.show()

            foreach ($sku in $skus)
            {
                $rootNode = New-Object System.Windows.Forms.TreeNode
                $rootNode.text = $sku.SkuPartNumber
                $rootNode.name = $sku.SkuPartNumber

                [void]$licenseList.nodes.add($rootNode)

                foreach ($servicePlan in $skus.servicePlans)
                {
                    $subnode = New-Object System.Windows.Forms.TreeNode
                    $subnode.text = $servicePlan.ServicePlanName
                    [void]$rootnode.Nodes.Add($subnode)
                }
            }

            $licenseList.add_AfterCheck{
            #Event Argument: $_ = [System.Windows.Forms.TreeViewEventArgs]
                if($_.Action -ne 'Unknown'){
                    if($_.Node.Nodes.Count -gt 0){
                        CheckAllChildNodes $_.Node $_.Node.Checked
                    }
                    else 
                    {
                        $parent = $_.node.parent
                        $needsChecked = $FALSE

                        foreach ($n in $parent.nodes)
                        {
                            if ($n.checked)
                            {
                                $needsChecked = $true
                                break
                            }
                            else 
                            {
                                $needsChecked=$false
                            }
                        }

                        if ($needsChecked -eq $TRUE)
                        {
                            $parent.checked = $TRUE
                        }
                        else 
                        {
                            $parent.Checked = $false
                        }
                    }
                }
            }
        }
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}