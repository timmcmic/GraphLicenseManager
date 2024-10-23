$GroupMembersName_Click = {
}

function PrintTree($printNode,$rootNodeName)
{
    $returnArray=@()

    foreach ($node in $printNode)
    {
        out-logfile -string $rootNodeName
        out-logfile -string $node.text

        if ($node.checked)
        {
            out-logfile -string "IsChecked:TRUE"
        }
        else
        {
            out-logfile -string "IsChecked:FALSE"
        }

        $functionObject = New-Object PSObject -Property @{
            SkuPartNumber = $rootNodeName
            SkuPartNumber_ServicePlanName = ($rootNodeName+"_"+$node.text)
            ServicePlanName = $node.text
            EnabledNew = $node.checked
        }

        $returnArray += $functionObject
    }

    return $returnArray
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
    $planArray = @()
    $global:fakePlanID = "00000000-0000-0000-0000-000000000000"
    out-logfile -string "Entered manage group license..."

#****************************************************************************************************************************

    $commit_Click = {
        out-logfile -string "It is time to commit the changes that were made."

        foreach ($rootNode in $licenseList.Nodes)
        {
            out-logfile -string $rootNode.Text
            $planArray +=PrintTree $rootNode.nodes $rootNode.text
        }

        foreach ($sku in $global:skuTracking)
        {
            out-logfile -string ("Evaluting Sku: "+$sku.SkuPartNumber_ServicePlanName)

            if ($planArray.SkuPartNumber_ServicePlanName.contains($sku.SkuPartNumber_ServicePlanName))
            {
                out-logfile -string "SKU located within the plan tree - this was expected."

                $planUpdate = $planArray | where {$_.SkuPartNumber_ServicePlanName -eq $sku.SkuPartNumber_ServicePlanName}

                out-logfile -string $planUpdate

                $sku.enabledNew = $planUpdate.EnabledNew

                out-logfile -string $sku
            }
        }

        out-xmlFile -itemToExport $global:skuTracking -itemNameToExport ("GlobalSKUTrackingPostUpdate-"+(Get-Date -Format FileDateTime))

        $skusToRemove=@()
        $licenseParams = @{}
        $skusToAdd=@()
             
        out-logfile -string "Searching for changes to existing skus."
        
        foreach ($id in $global:skuRootIDPresent)
        {
            out-logfile -string ('Evaluating ID: '+$id)
            $skusToAddHash=@{}
            $disabledPlans=@()
            $addTest=@()
            $addTestEnabled=@()
            $addTestDisabled=@()

            $addTest += $global:skuTracking | where {$_.skuID -eq $id}
            $addTestEnabled += $global:skuTracking | where {($_.skuID -eq $id) -and ($_.enabledNew -eq $true)}
            $addTestDisabled += $global:skuTracking | where {($_.skuID -eq $id) -and ($_.enabledNew -eq $false)}

            
            out-logfile -string ("Count of all found skus: "+$addTest.count.tostring())
            out-logfile -string ("Count of all found skus enabled: "+$addTestEnabled.count.tostring())
            out-logfile -string ("Count of all found skus disabled: "+$addTestDisabled.count.tostring())

            if (($addTestEnabled.count -gt 0) -and ($id -ne $global:fakePlanID))
            {
                out-logfile -string "The sku is present - updating disalbed plans."

                foreach ($sku in $addTestDisabled)
                {
                    out-logfile -string "Building disabled IDs"
                    out-logfile -string $sku.ServicePlanID
                    $disabledPlans+=$sku.ServicePlanID
                }

                $skusToAddHash.add("DisabledPlans",$disabledPlans)
                $skusToAddHash.add("SkuID",$id)
                $skusToAdd+=$skusToAddHash
            }
            else
            {
                out-logfile -string "The sku was not modified partially."
            }
        }
        
        out-logfile -string "Begin to look for skus that have been removed..."

        foreach ($id in $global:skuRootIDPresent)
        {
            $removeTest=@()
            $removeTestDisabled=@()
            out-logfile -string ('Evaluating ID: '+$id)
            $removeTest += $global:skuTracking | where {$_.skuID -eq $id}
            $removeTestDisabled += $global:skuTracking | where {($_.skuID -eq $id) -and ($_.enabledNew -eq $false)}

            out-logfile -string ("The number of skus to test for removal: "+$removeTest.count.tostring())
            out-logfile -string ("The number of skus to test with plans removed: "+$removeTestDisabled.count.toString())

            if (($removeTest.count -eq $removeTestDisabled.count) -and ($id -ne $global:fakePlanID))
            {
                out-logfile -string "The number of sku references equals number of plans disalbed -> remove sku."
                out-logfile -string $id
                $skusToRemove += $id
                out-logfile -string "Remove the entry from the active array - it's no longer active."
                $global:skuRootIDPresent = $global:skuRootIDPresent | where {$_ -ne $id}
                $global:skuRootIDNotPresent += $id
            }
            else
            {
                out-logfile -string "The SKU is not a SKU that was entirely removed."
            }
        }

        out-logfile -string "Determine if any entire skus were added to the new license template by reviewing skus that were not already there."

        foreach ($id in $global:skuRootIDNotPresent)
        {
            out-logfile -string ('Evaluating ID: '+$id)
            $skusToAddHash=@{}
            $disabledPlans=@()
            $addTest=@()
            $addTestEnabled=@()

            $addTest += $global:skuTracking | where {$_.skuID -eq $id}
            $addTestEnabled += $global:skuTracking | where {($_.skuID -eq $id) -and ($_.enabledNew -eq $true)}
            out-logfile -string ("Count of all found skus: "+$addTest.count.tostring())
            out-logfile -string ("Count of all found skus enabled: "+$addTestEnabled.count.tostring())

            if (($addTest.count -eq $addTestEnabled.count) -and ($id -ne $global:fakePlanID))
            {
                out-logfile -string "The number of sku references and plan references are equal -> the entire sku was added"
                out-logfile -string $id
                $skusToAddHash.add("DisabledPlans",$disabledPlans)
                $skusToAddHash.add("SkuID",$id)
                $skusToAdd+=$skusToAddHash
                out-logfile -string "Remove from the IDs not present - it is now present."
                $global:skuRootIDNotPresent = $global:skuRootIDNotPresent | where {$_ -ne $id}
                $global:skuRootIDPresent += $id
            }
            else
            {
                out-logfile -string "The SKU was not a SKU that was entirely added."
            }
        }

        out-logfile -string "Searching for new skus that were partially added."

        foreach ($id in $global:skuRootIDNotPresent)
        {
            out-logfile -string ('Evaluating ID: '+$id)
            $skusToAddHash=@{}
            $disabledPlans=@()
            $addTest=@()
            $addTestEnabled=@()
            $addTestDisabled=@()

            $addTest += $global:skuTracking | where {$_.skuID -eq $id}
            $addTestEnabled += $global:skuTracking | where {($_.skuID -eq $id) -and ($_.enabledNew -eq $true)}
            $addTestDisabled += $global:skuTracking | where {($_.skuID -eq $id) -and ($_.enabledNew -eq $false)}

            out-logfile -string ("Count of all found skus: "+$addTest.count.tostring())
            out-logfile -string ("Count of all found skus enabled: "+$addTestEnabled.count.tostring())
            out-logfile -string ("Count of all found skus disabled: "+$addTestDisabled.count.tostring())

            if (($addTestEnabled.count -gt 0) -and ($addTestDisabled.count -gt 0) -and ($id -ne $global:fakePlanID))
            {
                out-logfile -string "The sku was added but only partially added."

                foreach ($sku in $addTestDisabled)
                {
                    out-logfile -string "Building disabled IDS"
                    out-logfile -string $sku.ServicePlanID
                    $disabledPlans+=$sku.ServicePlanID
                }

                $skusToAddHash.add("DisabledPlans",$disabledPlans)
                $skusToAddHash.add("SkuID",$id)
                $skusToAdd+=$skusToAddHash

                $global:skuRootIDNotPresent = $global:skuRootIDNotPresent | where {$_ -ne $id}
                $global:skuRootIDPresent += $id
            }
            else
            {
                out-logfile -string "The sku was not added even partially."
            }
        }

        $licenseParams.add("AddLicenses",$skusToAdd)
        $licenseParams.add("RemoveLicenses",$skusToRemove)

        out-xmlFile -itemToExport $licenseParams -itemNameToExport ("LicenseParams-"+(Get-Date -Format FileDateTime))

        try {
            Set-MgGroupLicense -GroupId $global:groupID -BodyParameter $licenseParams -errorAction Stop
        }
        catch {
            out-logfile -string "Error adjusting licenses on group."
            $errorText = $_
            out-logfile -string $errorText
            [System.Windows.Forms.MessageBox]::Show("Unable to adjust the licenses on the group: "+$errorText, 'Warning')
            out-logfile -string "Resetting arrays for re-validation if license application is checked..."
        }
    }

#****************************************************************************************************************************

    $exit_Click = {
        $form2.close()
    }

#****************************************************************************************************************************

    $Button1_Click = {

        $global:skuTracking = @()
        $global:skuRootIDPresent = @()
        $global:skuRootIDNotPresent = @()

        out-logfile -string "Search button selected..."

        out-logfile -string "Clearing all form controls..."

        $displayNameText.clear()
        $expirationDateTimeText.clear()
        $mailText.clear()
        $groupTypeText.clear()
        $membershipRuleText.clear()
        $GroupMembersView.rows.clear()

        $licenseList.beginUpdate()
        $licenseList.Nodes.Clear()
        $licenseList.endUpdate()

        $global:groupID = $groupObjectIDText.Text
        Out-logfile -string "Group ID to Search:"
        out-logfile -string $global:groupID
        $getGroupFailure = $FALSE

        try
        {
            out-logfile -string "Attempt to locate the group via groupID..."
            $graphGroup = get-MGGroup -groupID $global:groupID -errorAction STOP
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

        out-xmlFile -itemToExport $graphGroup -itemNameToExport ("GraphGroup-"+(Get-Date -Format FileDateTime))

        try
        {
            out-logfile -string "Attempt to obtain assigned licenses on the group by groupID..."
            $graphGroupLicenses = get-MGGroup -groupID $global:groupID -property "AssignedLicenses" -errorAction STOP
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

        out-xmlFile -itemToExport $graphGroupLicenses -itemNameToExport ("GraphGroupLicense-"+(Get-Date -Format FileDateTime)) 

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

            out-xmlFile -itemToExport $skus -itemNameToExport ("GraphSKUS-"+(Get-Date -Format FileDateTime))

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
                            SkuPartNumber_ServicePlanName = $sku.SkuPartNumber+"_"+$servicePlan.ServicePlanName
                            ServicePlanID = $servicePlan.ServicePlanId
                            ServicePlanName = $servicePlan.ServicePlanName
                            EnabledOnGroup = $false
                            EnabledNew = $false
                        }

                        $global:skuTracking += $functionObject
                    }
                }
            }           

            out-xmlFile -itemToExport $global:skuTracking -itemNameToExport ("SkuTracking-"+(Get-Date -Format FileDateTime))

            out-logfile -string "Evaluating the skus in the tenant against the group provided."

            if ($graphGroupLicenses.assignedLicenses.count -gt 0)
            {
                out-logfile -string "The group specified has licenses - being the evaluation."

                foreach ($skuObject in $global:skuTracking)
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

            out-xmlFile -itemToExport $global:skuTracking -itemNameToExport ("SkuTrackingGroupEvaluation-"+(Get-Date -Format FileDateTime))
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

        <#

        if ($getGroupFailure -eq $false)
        {
            out-logfile -string "Previous operation was successful proceed with locating membership."
            try
            {
                $groupMembers = get-mgGroupMember -groupID $global:groupID -all -errorAction STOP

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

            out-xmlFile -itemToExport $groupMembers -itemNameToExport ("GroupMembers-"+(Get-Date -Format FileDateTime))

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

        #>

        if ($getGroupFailure -eq $FALSE)
        {
            out-logfile -string "Showing license display controls..."

            $licenseList.beginUpdate()
            $licenseLabel.show()
            $LicenseList.show()

            foreach ($sku in $skus)
            {
                $rootNode = New-Object System.Windows.Forms.TreeNode
                $rootNode.text = $sku.SkuPartNumber
                $rootNode.name = $sku.SkuPartNumber

                out-logfile -string "Testing all licenses on the group to determine if any portion of the sku is available..."

                $test = @()
                $test += $global:skuTracking | where {($_.skuPartNumber -eq $sku.skuPartNumber) -and ($_.EnabledOnGroup -eq $TRUE)}

                if ($test.count -gt 0)
                {
                    out-logfile -string "A plan within the sku is enabled -> set the main sku to checked..."
                    $rootNode.checked=$true
                    $global:skuRootIDPresent+=$sku.SkuID
                }
                else
                {
                    $global:skuRootIDNotPresent+=$sku.skuID
                    out-logfile -string "No plans within the sku are enabled -> set the main sku to unchecked."
                }

                [void]$licenseList.nodes.add($rootNode)

                foreach ($servicePlan in $sku.servicePlans)
                {
                    if ($servicePlan.appliesTo -ne "Company")
                    {
                        $subnode = New-Object System.Windows.Forms.TreeNode
                        $subnode.text = $servicePlan.ServicePlanName

                        out-logfile -string "Testing all enabled plans to determine if the plan name within the sku is enabled on the group..."

                        $test = @()
                        $test += $global:skuTracking | where {(($_.skuPartNumber -eq $sku.skuPartNumber) -and ($_.EnabledOnGroup -eq $TRUE) -and ($_.ServicePlanName -eq $servicePlan.ServicePlanName))}

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
            }

            $licenseList.endUpdate()

            $global:skuRootIDPresent+=$global:fakePlanID
            $global:skuRootIDNotPresent+=$global:fakePlanID
            $global:skuRootIDPresent+=$global:fakePlanID
            $global:skuRootIDNotPresent+=$global:fakePlanID

            $licenseList.add_AfterCheck{
                $commit.show()
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