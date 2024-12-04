$GroupInfo_Click = {
    out-logfile -string "Entering display group info."
    $form2.hide()
    DisplayGroupInfo
    $form2.show()
}

$ManageGroupLicense_Load = {
    out-logfile -string "Evaluating if this was a referred transaction."

    if ($global:referredObjectID -ne "")
    {
        out-logfile -string "This function was referred from another function call."

        $groupObjectIDText.clear()
        $groupObjectIDText.appendtext($global:referredObjectID)

        &$Button1_Click
    }
    else
    {
        out-logfile -string "Not a referred transactions."
    }
}

function PrintTree($printNode,$rootNodeName)
{
    $returnArray=@()

    foreach ($node in $printNode)
    {
        out-logfile -string $rootNodeName
        out-logfile -string $node.name

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
            SkuPartNumber_ServicePlanName = ($rootNodeName+"_"+$node.name)
            ServicePlanName = $node.name
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
    $global:telemetryOperationName = "Group License Manager"
    $planArray = @()
    $global:fakePlanID = "00000000-0000-0000-0000-000000000000"
    out-logfile -string "Entered manage group license..."

#****************************************************************************************************************************

    $commit_Click = {
        $ToolLabel.Text = "Beginning license commit operation..."
        $global:telemetryCommits++

        out-logfile -string "It is time to commit the changes that were made."

        $ToolLabel.Text = "Pulling all user defined options from the license tree - this may take a minute..."

        foreach ($rootNode in $licenseList.Nodes)
        {
            out-logfile -string $rootNode.Text
            $planArray +=PrintTree $rootNode.nodes $rootNode.name
        }

        $ToolLabel.Text = "Comparing previous license state to user defined license state - this may take a minute..."

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

        $ToolLabel.Text = "Evaluating for existing skus with plan changes..."
             
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

        $ToolLabel.Text = "Evaluating for SKUs entirely removed..."
        
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

        $ToolLabel.Text = "Evaluating for SKUs entirely added..."

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

        $ToolLabel.Text = "Evaluating SKUs for partial additions..."

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
            $ToolLabel.Text = "Applying the new license template to the group..."
            Set-MgGroupLicense -GroupId $global:groupID -BodyParameter $licenseParams -errorAction Stop
            $ToolLabel.Text = "License template successfully applied..."
            [System.Windows.Forms.MessageBox]::Show("LICENSE COMMIT SUCCESSFUL - RUN SEARCH TO REFRESH", 'SUCCESS')

        }
        catch {
            out-logfile -string "Error adjusting licenses on group."
            $errorText = $_
            out-logfile -string $errorText
            $errorText = CalculateError $errorText
            $global:errorMessages+=$errorText
            $ToolLabel.Text = "ERROR:  License template NOT successfully applied..."
            [System.Windows.Forms.MessageBox]::Show("Unable to adjust the licenses on the group: "+$errorText, 'Warning')
            $global:telemetryCommitErrors++        
        }
    }

#****************************************************************************************************************************

    $exit_Click = {
        [void]$form2.close()
    }

#****************************************************************************************************************************

    $Button1_Click = {

        $ToolLabel.Text = "Entering Group Search"
        $global:telemetrySearches++
        $global:skuRootIDPresent = @()
        $global:skuRootIDNotPresent = @()

        out-logfile -string "Search button selected..."

        out-logfile -string "Clearing all form controls..."

        $ToolLabel.Text = "Resetting Display Dialogs"

        $displayNameText.clear()
        $expirationDateTimeText.clear()
        $mailText.clear()
        $licenseProcessingText.clear()
        $groupTypeText.clear()
        $membershipRuleText.clear()
        $GroupMembersView.rows.clear()
        $dataGridView1.rows.clear()

        $licenseList.beginUpdate()
        $licenseList.Nodes.Clear()
        $licenseList.endUpdate()

        $ToolLabel.Text = "Obtaining Group ID"

        $global:groupID = $groupObjectIDText.Text
        Out-logfile -string "Group ID to Search:"
        out-logfile -string $global:groupID
        $getGroupFailure = $FALSE

        try
        {
            out-logfile -string "Attempt to locate the group via groupID..."
            $global:graphGroup = get-MGGroup -groupID $global:groupID -property ID,DisplayName,ExpirationDateTime,Mail,GroupTypes,MembershipRule,LicenseProcessingState,AssignedLicenses -errorAction STOP
            out-logfile -string "Group was successfully located..."
            out-logfile -string $global:graphGroup
            $getGroupFailure=$false
            out-xmlFile -itemToExport $global:graphGroup -itemNameToExport ("GraphGroup-"+(Get-Date -Format FileDateTime))
            $ToolLabel.Text = "GET-MGGroup Successful"
        }
        catch
        {
            $getGroupFailure=$true
            $errorText=$_
            out-logfile -string "The group was not located by group object id.."
            out-logfile -string $errorText
            $errorText = CalculateError $errorText
            $global:errorMessages+=$errorText
            $ToolLabel.Text = "GET-MGGroup ERROR"
            [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
            $global:telemetrySearcheErrors++
        }

        if ($getGroupFailure -eq $FALSE)
        {
            try
            {
                out-logfile -string "Attempt to obtain assigned licenses on the group by groupID..."
                #$global:graphGroupLicenses = get-MGGroup -groupID $global:groupID -property "AssignedLicenses" -errorAction STOP
                $global:graphGroupLicenses = $global:graphGroup
                out-logfile -string "Group and licenses were successfully located..."
                out-xmlFile -itemToExport $global:graphGroupLicenses -itemNameToExport ("GraphGroupLicense-"+(Get-Date -Format FileDateTime)) 
                $ToolLabel.Text = "Get Group Licenses Successful"
            }
            catch
            {
                $getGroupFailure=$true
                $errorText=$_
                out-logfile -string "The group was not located by group object id.."
                out-logfile -string $errorText
                $errorText = CalculateError $errorText
                $global:errorMessages+=$errorText
                $ToolLabel.Text = "Get Group Licenses ERROR"
                [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
                $global:telemetrySearcheErrors++
            }

        }

        if ($getGroupFailure -eq $FALSE)
        {
            out-logfile -string "Previous operations were successfuly - determine all skus within the tenant..."

            try {
                #$skus = Get-MgSubscribedSku -errorAction Stop
                $skus = getMGSku -errorAction STOP
                out-logfile -string "SKUs successfully obtained..."
                $getGroupFailure=$false
                $ToolLabel.Text = "Get-MGSubscribedSKU SUCESSFUL"
            }
            catch {
                $getGroupFailure=$true
                $errorText=$_
                out-logfile -string "Unable to obtain the skus within the tenant.."
                out-logfile -string $errorText
                $errorText = CalculateError $errorText
                $global:errorMessages+=$errorText
                $ToolLabel.Text = "Get-MGSubscribedSKU ERROR"
                [System.Windows.Forms.MessageBox]::Show("Unable to obtain the skus within the tenant.."+$errorText, 'Warning')
                $global:telemetrySearcheErrors++
            }

            out-logfile -string "Removing all non-user SKUs"

            $skus = GetMGUserSku -skus $skus

            out-logfile -string "Build the custom powershell object for each of the sku / plan combinations that could be enabled."

            $ToolLabel.Text = "Enumerating all SKUs and SKU-Plans in tenant..."

            CalculateSkuTracking -skus $skus
        }

        if ($getGroupFailure -eq $FALSE)
        {
            out-logfile -string "Previous operations were successfuly - determine all skus within the tenant..."

            $ToolLabel.Text = "Comparing SKU and SKU-Plan assignments on group to tenant SKU / SKU-Plans"

            EvaluateGroupLicenses
        }

        if ($getGroupFailure -eq $false)
        {
            $ToolLabel.Text = "Updating form controls with group and license information..."
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
            $licenseProcessingLabel.show()
            $licenseProcessingText.show()

            if ($global:userPermissions -ne "None")
            {
                $groupInfo.show()
            }

            $displayNameText.appendtext($global:graphGroup.displayName)
            $expirationDateTimeText.appendTExt($global:graphGroup.ExpirationDateTime)
            $mailText.appendtext($global:graphGroup.mail)
            $membershipRuleText.appendtext($global:graphGroup.membershipRule)
            $groupTypeText.appendtext($global:graphGroup.GroupTypes)
            $licenseProcessingText.appendText($global:graphGroup.LicenseProcessingState.State)

            if ($global:graphGroup.displayName.Length -gt 0)
            {
                out-logfile -string $global:graphGroup.displayName
            }

            if ($global:graphGroup.ExpirationDateTime.Length -gt 0)
            {
                out-logfile -string $global:graphGroup.ExpirationDateTime
            }

            if ($global:graphGroup.mail.Length -gt 0)
            {
                out-logfile -string $global:graphGroup.mail
            }

            if ($global:graphGroup.membershipRule.Length -gt 0)
            {
                out-logfile -string $global:graphGroup.membershipRule
            }

            if ($global:graphGroup.GroupTypes.Length -gt 0)
            {
                out-logfile -string $global:graphGroup.GroupTypes
            }
        }
        else
        {
            out-logfile -string "Relevant form controls not displayed due to previous failure."
        }

        if ($getGroupFailure -eq $FALSE)
        {
            out-logfile -string "Showing license display controls..."

            $licenseList.beginUpdate()
            $licenseLabel.show()
            $LicenseList.show()

            foreach ($sku in $skus)
            {
                out-logfile -string "Determine if the root sku is contained within the sku download."
                
                if ($global:skuHash[$sku.skuPartNumber])
                {
                    out-logfile -string "The sku part number was located in the csv file."
                    $rootNodeNameString = $global:skuHash[$sku.skuPartNumber].'???Product_Display_Name'
                    out-logfile -string $rootNodeNameString
                }
                else 
                {
                    out-logfile -string "The sku part number was not located in the CSV file."
                    $rootNodeNameString = $sku.skuPartNumber
                }


                $rootNode = New-Object System.Windows.Forms.TreeNode
                #$rootNode.text = $sku.SkuPartNumber
                $rootNode.text = $rootNodeNameString 
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
                        out-logfile -string "Determine if the service plan information is contained in the sku download."

                        if ($global:servicePlanHash[$servicePlan.servicePlanName])
                        {
                            out-logfile -string "The service plan was located in the sku download."
                            $subNodeNameString = $global:servicePlanHash[$servicePlan.servicePlanName].Service_Plans_Included_Friendly_Names
                            out-logfile -string $subNodeNameString
                        }
                        else 
                        {
                            $subNodeNameString = $servicePlan.ServicePlanName
                            out-logfile -string $subNodeNameString
                        }


                        $subnode = New-Object System.Windows.Forms.TreeNode
                        #$subnode.text = $servicePlan.ServicePlanName
                        $subNode.Text = $subNodeNameString
                        $subnode.name = $servicePlan.ServicePlanName

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
                $ToolLabel.Text = "License option selected - updating tree..."
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

        if ($getGroupFailure -eq $FALSE)
        {
            $dataGridView1.show()

            $dataGridView1.columnCount = 8

            $dataGridViewColumns = @()
            $dataGridViewColumns = @("SkuCommonName","SkuPartNumber","CapabilityStatus","ConsumedUnits","Enabled","LockedOut","Suspend","Warning")

            foreach ($entry in $dataGridViewColumns )
            {
                out-logfile -string $entry
            }

            for ($i = 0 ; $i -lt $dataGridViewColumns.count ; $i++)
            {
                $dataGridView1.columns[$i].name = $dataGridViewColumns[$i]
            }
            
            foreach ($sku in $skus)
            {
                if ($global:skuHash[$sku.skuPartNumber])
                {
                    out-logfile -string "The sku part number was located in the csv file."
                    $rootNodeNameString = $global:skuHash[$sku.skuPartNumber].'???Product_Display_Name'
                    out-logfile -string $rootNodeNameString
                }
                else 
                {
                    out-logfile -string "The sku part number was not located in the CSV file."
                    $rootNodeNameString = "Unavailable"
                }

                $dataGridView1.rows.add($rootNodeNameString,$sku.SkuPartNumber,$sku.capabilityStatus,$sku.consumedUnits,$sku.prepaidUnits.Enabled,$sku.prepaidUnits.LockedOut,$sku.prepaidUnits.Suspended,$sku.prepaidUnits.Warning)
            }

            $dataGridView1.Columns | Foreach-Object{
                $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
            }
        }
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}