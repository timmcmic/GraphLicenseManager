$GroupInfo_Load = {

    if ($global:allowReprocessing -eq $TRUE)
    {
        $RefreshErrors.show()
        $ReprocessUsers.show()
    }

    DrawDataGrid
}

function DrawDataGrid
{
    out-logfile -string "Setting up group assignment view..."

    #$errorsView.columnCount = 5

    $groupAssignmentColumns = @()
    $groupAssignmentColumns = @("Group Name","Group ID","Member Count","Error Count","Licenses","License Processing State")

    foreach ($entry in $groupAssignmentColumns )
    {
        out-logfile -string $entry
    }

    out-logfile -string "Creating checkbox column..."
    
    $checkboxColumn = New-Object System.Windows.Forms.DataGridViewCheckBoxColumn
    $checkboxColumn.HeaderText = "Select User"
    $checkboxColumn.Name = "CheckboxColumn"

    $groupAssignmentColumns.columns.add($checkboxColumn)

    out-logfile -string "Adding additional columns to the table..."

    for ($i = 0 ; $i -lt $errorsViewColumns.count ; $i++)
    {
        #$errorsView.columns[$i].name = $errorsViewColumns[$i]
        $groupAssignmentColumns.columns.add($groupAssignmentColumns[$i],$groupAssignmentColumns[$i])
    }

    for ($i = 1 ; $i -lt $errorsViewColumns.count ; $i++)
    {
        $groupAssignmentColumns.Columns[$i].ReadOnly = "true"
    }

    $wrapCellStyle = New-Object System.Windows.Forms.DataGridViewCellStyle
    $wrapCellStyle.WrapMode = [System.Windows.Forms.DataGridViewTriState]::True
    $groupAssignmentColumns.columns[4].defaultCellStyle = $wrapCellStyle

    <#

    out-logfile -string "Adding error information to the table..."
    
    foreach ($member in $global:graphMembersErrorArray)
    {
        $errorsView.rows.add($false,$member.ID,$member.DisplayName,$member.UserPrincipalName,$member.error,$member.ObjectType)
    }

    $errorsView.Columns | Foreach-Object{
        $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
    }

    $errorsView.autosizerowsmode = "AllCells"

    if ($initialLoad -eq $TRUE)
    {
        if ($global:graphMembersArray.count -gt 0)
        {
            $groupCountBox.appendtext($global:graphMembersArray.count.tostring())
        }
        else 
        {
            $groupCountBox.appendtext("0")
        }
    }

    if ($global:graphMembersErrorArray.count -gt 0)
    {
        $errorCountBox.clear()
        $errorCountBox.appendtext($global:graphMembersErrorArray.count.tostring())
    }
    else 
    {
        $errorCountBox.clear()
        $errorCountBox.appendtext("0")
    }

    $LicenseTextBox.clear()
    $LicenseTextBox.appendText($global:graphGroup.LicenseProcessingState.State)

    #>
}

function GroupLicenseReport
{
    $functionGroupInfo = @()

    out-logfile -string "GroupLicenseReport"

    out-logfile -string "Get all groups where licenses are assigned."

    try {
        $groupsWithLicense = Get-MgGroup -All -Property Id, MailNickname, DisplayName, GroupTypes, Description, AssignedLicenses , LicenseProcessingState -errorAction STOP | Where-Object {$_.AssignedLicenses -ne $null }
        $okToProceed = $true
    }
    catch {
        out-logfile -string "Unable to obtain groups and filter for licenses."
        out-logfile -string $_
        $errorText = CalculateError -errorText $_
        out-logfile -string $errorText
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain all groups with license assignments using group.."+$errorText, 'Warning')
        $okToProceed = $false
    }

    if ($okToProceed -eq $TRUE)
    {
        out-logfile -string "Groups were successfully obtained."

        foreach ($group in $groupsWithLicense)
        {
            $errorMembers = (Get-MgGroupMemberWithLicenseError -all -GroupId $group.id).count
            out-logfile -string ("Error count on group: "+$errorMembers.toString())

            $memberCount = (Get-MgGroupMember -GroupId $group.id -all).count
            out-logfile -string ("Member count on group: "+$memberCount.tostring())

            $skuOutput = @()

            foreach ($sku in $group.AssignedLicenses.SkuId)
            {
                $commonName = $global:skuGuidHash[$sku].'???Product_Display_Name'
                out-logfile -string $commonName
                $skuOutput += $commonName
            }

            $skuOutput = $skuOutput -join ","
            out-logfile -string ("Skus on Group: "+ $skuOutput)

            $processingState = $group.LicenseProcessingState.State
            out-logfile -string ("License Processing State:" +$processingState)

            $groupInfo = New-Object PSObject
            $groupInfo | Add-Member -MemberType NoteProperty -Name "Group Name" -Value $group.DisplayName
            $groupInfo | Add-Member -MemberType NoteProperty -Name "Group ID" -Value $group.Id
            $groupInfo | Add-Member -MemberType NoteProperty -Name "Member Count" -value $memberCount
            $groupInfo | Add-Member -MemberType NoteProperty -Name "Error Count" -value $errorMembers
            $groupInfo | Add-Member -MemberType NoteProperty -Name "Licenses" -value $skuOutput
            $groupInfo | Add-Member -MemberType NoteProperty -Name "License Processing State" -value $processingState

            $functionGroupInfo += $groupInfo
        }
    }

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'grouplicensereport.designer.ps1')
    [void]$GroupLicenseReport.ShowDialog()
}