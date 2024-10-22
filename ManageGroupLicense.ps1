$GroupMembersName_Click = {
}
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

        $skuTracking = @()

        out-logfile -string "Search button selected..."

        out-logfile -string "Clearing all form controls..."

        $displayNameText.clear()
        $expirationDateTimeText.clear()
        $mailText.clear()
        $groupTypeText.clear()
        $membershipRuleText.clear()
        $GroupMembersView.rows.clear()
        $licenseList.Nodes.Clear()

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
            $graphGroupLicenses = get-MGGroup -groupID $groupID -property "AssignedLicenses" -errorAction STOP
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

            out-logfile -string "Build the custom powershell object for each of the sku / plan combinations that could be enabled."

            foreach ($sku in $skus)
            {
                out-logfile -string ("Evaluating Sku: "+$sku.skuPartNumber)

                foreach ($servicePlan in $sku.ServicePlans)
                {
                    out-logfile -string ("Evaluating Service Plan: "+$servicePlan.ServicePlanName)

                    if ($servicePlan.AppliesTo -eq "User")
                    {
                        out-logfile -string "Service plan is per user - creating object."

                        $functionObject = New-Object PSObject -Property @{
                            SkuID = $sku.SkuId
                            SkuPartNumber = $sku.SkuPartNumber
                            ServicePlanID = $servicePlan.ServicePlanId
                            SerivicePlanName = $servicePlan.ServicePlanName
                            EnabledOnGroup = $false
                            EnabledNew = $false
                        }

                        $skuTracking += $functionObject
                    }
                }
            }

            out-logfile -string "Evaluating the skus in the tenant against the group provided."

            if ($graphGroupLicenses.assignedLicenses.count -gt 0)
            {
                out-logfile -string "The group specified has licenses - being the evaluation."

                foreach ($skuObject in $skuTracking)
                {
                    out-logfile -string "Checking to see if the group has the SKU id..."

                    if ($graphGroupLicenses.AssignedLicenses.SkuID.contains($skuObject.skuID))
                    {
                        out-logfile -string "The group licenses the sku id - check disabled plans..."

                        $workingLicense = $graphGroupLicenses.assignedLicenses | where {$_.skuID -eq $skuObject.skuID}

                        out-logfile -string ("Evaluating the following sku ID on the group: "+$workingLicense.skuID)

                        if ($workingLicense.disabledPlans.contains($skuObject.ServicePlanID))
                        {
                            out-logfile -string "The plan is disabled - no work."
                        }
                        else
                        {
                            out-logfile -string "The sku is not disabled - set the SKU to enabled."
                            $skuObject.EnabledOnGroup = $TRUE
                        }
                    }
                }
            }

            foreach ($entry in $skuTracking)
            {
                out-logfile -string $entry
            }
        }

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
            $expirationDateTimeText.appendTExt($graphGroup.ExpirationDateTime)
            $mailText.appendtext($graphGroup.mail)
            $membershipRuleText.appendtext($graphGroup.membershipRule)
            $groupTypeText.appendtext($graphGroup.GroupTypes)

            if ($graphGroup.displayName.Length -gt 0)
            {
                out-logfile -string $graphGroup.displayName
            }

            if ($graphGroup.ExpirationDateTime.Length -gt 0)
            {
                out-logfile -string $graphGroup.ExpirationDateTime
            }

            if ($graphGroup.mail.Length -gt 0)
            {
                out-logfile -string $graphGroup.mail
            }

            if ($graphGroup.membershipRule.Length -gt 0)
            {
                out-logfile -string $graphGroup.membershipRule
            }

            if ($graphGroup.GroupTypes.Length -gt 0)
            {
                out-logfile -string $graphGroup.GroupTypes
            }
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
            }
        }

        if ($getGroupFailure -eq $FALSE)
        {
            out-logfile -string "Showing license display controls..."

            $licenseLabel.show()
            $LicenseList.show()

            foreach ($sku in $skus)
            {
                $rootNode = New-Object System.Windows.Forms.TreeNode
                $rootNode.text = $sku.SkuPartNumber
                $rootNode.name = $sku.SkuPartNumber

                out-logfile -string "Testing all licenses on the group to determine if any portion of the sku is available..."

                $test = @()
                $test += $skuTracking | where {($_.skuPartNumber -eq $sku.skuPartNumber) -and ($_.EnabledOnGroup -eq $TRUE)}

                if ($test.count -gt 0)
                {
                    out-logfile -string "A plan within the sku is enabled -> set the main sku to checked..."
                    $rootNode.checked=$true
                }
                else
                {
                    out-logfile -string "No plans within the sku are enabled -> set the main sku to unchecked."
                }

                [void]$licenseList.nodes.add($rootNode)

                foreach ($servicePlan in $sku.servicePlans)
                {
                    $subnode = New-Object System.Windows.Forms.TreeNode
                    $subnode.text = $servicePlan.ServicePlanName

                    out-logfile -string "Testing all enabled plans to determine if the plan name within the sku is enabled on the group..."

                    $test = @()
                    $test += $skuTracking | where {(($_.skuPartNumber -eq $sku.skuPartNumber) -and ($_.EnabledOnGroup -eq $TRUE) -and ($_.SerivicePlanName -eq $servicePlan.ServicePlanName))}

                    if ($test.count -gt 0)
                    {
                        out-logfile -string "The service plan on the sku is enabled on the group - setting the checkbox..."
                        $subnode.checked = $true
                    }
                    else
                    {
                        out-logfile -string "The service plan on the sku is not enabled on the group - set to unchecked..."
                    }

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