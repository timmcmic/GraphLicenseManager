$RefreshLicenseReport_Click = {

    $GroupLicenseReport.close()
    $GroupLicenseReport.dispose()
    GroupLicenseReport

}
$InvokeManageLicense_Click = {
    $global:referredObjectID = $global:selectedGroupID
    $GroupLicenseReport.hide()
    ManageGroupLicense
    $GroupLicenseReport.show()    
    $InvokeManageLicense.hide()
    $InvokeProperties.hide()
}



$CloseLicenseReport_Click = {
    $GroupLicenseReport.close()
}



$InvokeProperties_Click = {

    $global:graphGroup = get-mgGroup -GroupId $global:selectedGroupID -Property Id, MailNickname, DisplayName, GroupTypes, Description, AssignedLicenses , LicenseProcessingState -errorAction Stop
    $GroupLicenseReport.hide()
    DisplayGroupInfo
    $GroupLicenseReport.show()
    $InvokeManageLicense.hide()
    $InvokeProperties.hide()
}


<#

$GroupLicenseReport.add_Load($GroupReport_Load)
$GroupView.add_ItemSelectionChanged($GroupView_ItemSelectionChanged)

#>

$GroupView_ItemSelectionChanged = {
    out-logfile -string "Item selection changed."
    $global:selectedGroupID = $_.item.text
    out-logfile -string $selectedGroupID
    $InvokeManageLicense.show()
    $InvokeProperties.show()
}

$GroupReport_Load = {
    out-logfile -string "Starting load."
       DrawDataGridReport
}

function DrawDataGridReport
{
    #$GroupView.Dock = 'Fill'
    $GroupView.View = 'Details'
    $GroupView.FullRowSelect = $true

    $groupReportColumns = @("Group ID","Group Name","Member Count","Error Count","Licenses","License Processing State")

    foreach ($entry in $groupReportColumns )
    {
        out-logfile -string $entry
    }

    foreach ($member in $groupReportColumns)
    {
        $groupView.columns.add($member)
    }

    foreach ($member in $functionGroupInfo)
    {
        $ListViewItem = New-Object System.Windows.Forms.ListViewItem($member.'Group ID')
        $ListViewItem.Subitems.Add($member.'Group Name')
        $ListViewItem.Subitems.Add($member.'Member Count')
        $ListViewItem.Subitems.Add($member.'Error Count')
        $ListViewItem.Subitems.Add($member.'Licenses')
        $ListViewItem.Subitems.Add($member.'License Processing State')

        $groupView.items.add($ListViewItem)
    }

    for ($i = 0 ; $i -lt $groupView.columns.count ; $i++)
    {
        if (($groupView.columns[$i].text -ne "Member Count") -and ($groupView.columns[$i].text -ne "Error Count"))
        {
            $groupView.autoResizeColumn($i,'ColumnContent')
        }
        else 
        {
            $groupView.autoResizeColumn($i,'HeaderSize')
        }
    }

    <#
    out-logfile -string "Setting up group assignment view..."

    $groupReportColumns = @()
    $groupReportColumns = @("Group Name","Group ID","Member Count","Error Count","Licenses","License Processing State")

    foreach ($entry in $groupReportColumns )
    {
        out-logfile -string $entry
    }

    out-logfile -string "Creating checkbox column..."
    
    $checkboxColumn = New-Object System.Windows.Forms.DataGridViewCheckBoxColumn
    $checkboxColumn.HeaderText = "Select Group"
    $checkboxColumn.Name = "CheckboxColumn"

    $groupReport.columns.add($checkboxColumn)

    out-logfile -string "Adding additional columns to the table..."

    for ($i = 0 ; $i -lt $groupReportColumns.count ; $i++)
    {
        #$groupReport.columns[$i].name = $groupReportColumns[$i]
        $groupReport.columns.add($groupReportColumns[$i],$groupReportColumns[$i])
    }

    for ($i = 1 ; $i -lt $groupReportColumns.count ; $i++)
    {
        $groupReport.Columns[$i].ReadOnly = "true"
    }

    $wrapCellStyle = New-Object System.Windows.Forms.DataGridViewCellStyle
    $wrapCellStyle.WrapMode = [System.Windows.Forms.DataGridViewTriState]::True
    $groupReport.columns[4].defaultCellStyle = $wrapCellStyle

    out-logfile -string "Adding error information to the table..."
    
    foreach ($member in $functionGroupInfo)
    {
        $groupReport.rows.add($false,$member.'Group Name',$member.'Group ID',$member.'Member Count',$member.'Error Count',$member.'Licenses',$member.'License Processing State')
    }

    $groupReport.Columns | Foreach-Object{
        $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
    }

    $groupReport.autosizerowsmode = "AllCells"

    #>
}

function GroupLicenseReport
{
    $global:referredObjectID=""

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