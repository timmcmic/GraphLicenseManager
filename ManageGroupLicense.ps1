

function ManageGroupLicense
{
    _AfterCheck=[System.Windows.Forms.TreeViewEventHandler]{
    #Event Argument: $_ = [System.Windows.Forms.TreeViewEventArgs]
        if($_.Action -ne 'Unknown'){
            if($_.Node.Nodes.Count -gt 0){
                CheckAllChildNodes $_.Node $_.Node.Checked
            }
        }
    }
    
    function CheckAllChildNodes($treeNode, $nodeChecked){
        foreach($node in $treeNode.Nodes){
            $node.Checked = $nodeChecked
            if($node.Nodes.Count -gt 0){
                CheckAllChildNodes $node $nodeChecked
            }
        }
    }

    $licenseList_BeforeExpand=[System.Windows.Forms.TreeViewCancelEventHandler]{
        #Event Argument: $_ = [System.Windows.Forms.TreeViewCancelEventArgs]
            if($_.Action -eq 'ByMouse'){$_.Cancel = $true}
        }

    $Button1_Click = {

        $groupID = $groupObjectIDText.Text
        $getGroupFailure = $FALSE

        try
        {
            $graphGroup = get-MGGroup -groupID $groupID -errorAction STOP
            $getGroupFailure=$false
        }
        catch
        {
            $getGroupFailure=$true
            $errorText=$_
            [System.Windows.Forms.MessageBox]::Show("The group was not located by group object id.."+$errorText, 'Warning')
        }

        try
        {
            $graphGroupLicenses = get-MGGroup -groupID $groupID -property "AssignedLicense" -errorAction STOP
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

            #==================================================================
            #Create a custom powershell object that represents if an item is changed or removed.
            #==================================================================




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
        }
    }

    . (Join-Path $PSScriptRoot 'managegrouplicense.designer.ps1')
    $Form2.ShowDialog()
}