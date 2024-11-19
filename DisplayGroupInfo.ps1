$RefreshErrors_Click = {
    out-logfile -string "Refreshing user license errors selected."
    $errorsView.columns.clear()
    GetGroupErrors
    DrawDataGrid  -initialLoad $false
}

$ReprocessUsers_Click = {
    out-logfile -string "Reprocessing user licenses selected."

    $checkedRows = $errorsView.rows | where {$_.cells["CheckboxColumn"].value -eq $true}

    out-logfile -string ("Number of users for reprocessing: "+$checkedRows.count)

    if ($checkedRows.count -gt 0)
    {
        $successCount = 0
        $errorCount = 0
        out-logfile -string "There are users for reprocessing."

        foreach ($row in $checkedRows)
        {
            out-logfile -string ("Reprocessing user: "+$row.cells["ID"].value)

            try {
                Invoke-MGLicenseUser -userID $row.cells["ID"].value -errorAction STOP
                out-logfile -string "User reprocessed successfully."
                $successCount++
            }
            catch {
                out-logfile -string ("Unable to process a license reprocessing: "+$row.cells["ID"].value)
                $errorText = CalculateError $_
                [System.Windows.Forms.MessageBox]::Show("Unable to reprocess: "+$row.cells["ID"].value+" Error: "+$errorText, 'Warning')
                $errorCount++
            }
        }

        if ($errorCount -eq 0)
        {
            [System.Windows.Forms.MessageBox]::Show("All users reprocessed successfully.  View Entra audit logs for details or refresh error view.", 'Info')
        }
    }
    else 
    {
        out-logfile -string "No users for reprocessing."
    }
}
$GroupInfo_Load = {

    if ($global:allowReprocessing -eq $TRUE)
    {
        $RefreshErrors.show()
        $ReprocessUsers.show()
    }

    DrawDataGrid
}

$CloseDisplay_Click = {
    $GroupInfo.close()
}

function DrawDataGrid
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        $initialLoad = $true
    )

    if ($initialLoad -eq $TRUE)
    {
        out-logfile -string "Setting up the members columns.."

        $membersView.columnCount = 4

        $membersViewColumns = @()
        $membersViewColumns = @("ID","DisplayName","UserPrincipalName","ObjectType")

        foreach ($entry in $membersViewColumns )
        {
            out-logfile -string $entry
        }

        out-logfile -string "Adding member columns to table..."

        for ($i = 0 ; $i -lt $membersViewColumns.count ; $i++)
        {
            $membersView.columns[$i].name = $membersViewColumns[$i]
            $membersView.Columns[$i].ReadOnly = "true"
        }

        out-logfile -string "Adding all members information to the table..."
        
        foreach ($member in $global:graphMembersArray)
        {
            $membersView.rows.add($member.ID,$member.DisplayName,$member.UserPrincipalName,$member.ObjectType)
        }

        $membersView.Columns | Foreach-Object{
            $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
        }
    }
    
    out-logfile -string "Setting up errors columns..."

    #$errorsView.columnCount = 5

    $errorsViewColumns = @()
    $errorsViewColumns = @("ID","DisplayName","UserPrincipalName","Error","ObjectType")

    foreach ($entry in $errorsViewColumns )
    {
        out-logfile -string $entry
    }

    out-logfile -string "Creating checkbox column..."
    
    $checkboxColumn = New-Object System.Windows.Forms.DataGridViewCheckBoxColumn
    $checkboxColumn.HeaderText = "Select User"
    $checkboxColumn.Name = "CheckboxColumn"

    $errorsView.columns.add($checkboxColumn)

    out-logfile -string "Adding additional columns to the table..."

    for ($i = 0 ; $i -lt $errorsViewColumns.count ; $i++)
    {
        #$errorsView.columns[$i].name = $errorsViewColumns[$i]
        $errorsView.columns.add($errorsViewColumns[$i],$errorsViewColumns[$i])
    }

    for ($i = 1 ; $i -lt $errorsViewColumns.count ; $i++)
    {
        $errorsView.Columns[$i].ReadOnly = "true"
    }

    $wrapCellStyle = New-Object System.Windows.Forms.DataGridViewCellStyle
    $wrapCellStyle.WrapMode = [System.Windows.Forms.DataGridViewTriState]::True
    $errorsView.columns[4].defaultCellStyle = $wrapCellStyle

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
}

function GetGroupErrors
{
    $global:graphMembersErrorArray = @()
    $operationSuccessful = $false

    out-logfile -string "Determine if any group license errors exist."

    try {
        $global:graphErrorGroupMembers = Get-MgGroupMemberWithLicenseError -GroupId $global:graphGroup.id -all -errorAction Stop
        $operationSuccessful = $true
    }
    catch {
        $errorText = $_
        out-logfile -string "Unable to obtain the members in error..."
        out-logfile -string $_
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain the members in error..."+$errorText, 'Warning')
        $global:ErrorMessages += $errorText
    }

    $global:graphErrorGroupMembers = $global:graphErrorGroupMembers | Sort-Object -Property ID -Unique

    out-logfile -string "Parse the error members to obtain the error reason."

    if ($operationSuccessful -eq $TRUE)
    {
        if ($global:graphErrorGroupMembers.count -gt 0)
        {
            out-logfile -string "The group has users in error - process each user."

            foreach ($member in $global:graphErrorGroupMembers)
            {
                $functionUser = get-MGUser -userID $member.id -Property ID,DisplayName,assignedLicenses,licenseAssignmentStates | Select-Object -ExpandProperty LicenseAssignmentStates

                $functionUser = $functionUser | where {$_.AssignedByGroup -eq $global:graphGroup.Id}

                if ($functionUser.count -gt 0)
                {
                    $functionError = @()
                    out-logfile -string "The error count is gt 0"

                    foreach ($errorString in $functionUser)
                    {
                        $functionString = $errorString.error +"," + $errorString.SkuID + "," + $errorString.State
                        $functionError += $functionString
                    }

                    $functionError = $functionError -join "`r`n"
                }
                else 
                {
                    $functionString = $functionUser.error +"," + $functionUser.SkuID + "," + $functionUser.State
                    $functionError = $functionString
                }

                <#

                $functionError = $functionUser.Error

                if ($functionError.count -gt 0)
                {
                    out-logfile -string "There are more than one errors."
                    $functionError = $functionError -join ","
                }
                else 
                {
                    out-logfile -string "Single error leave it alone."
                }

                #>

                out-logfile -string ("The user error type is:")
                out-logfile -string $functionError

                out-logfile -string $member.AdditionalProperties.'@odata.type'

                if ($member.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.user")
                {
                    $functionObjectType = "User"
                    $functionUPN = $member.AdditionalProperties.userPrincipalName
                }
                elseif($member.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.group")
                {
                    $functionObjectType = "Group"
                    $functionUPN = "N/A"
                }
                elseif($member.AdditionalProperties.'@odata.context' -eq "https://graph.microsoft.com/v1.0/$metadata#contacts/$entity")
                {
                    $functionObjectType = "Contact"
                    $functionUPN = "N/A"
                }
    
                $functionObject = New-Object PSObject -Property @{
                    ID = $member.Id
                    DisplayName = $member.AdditionalProperties.displayName
                    UserPrincipalName = $functionUPN
                    Error = $functionError
                    ObjectType = $functionObjectType
                }
    
                $global:graphMembersErrorArray += $functionObject
            }

            out-logfile -string ("Count of error objects: "+$global:graphMembersErrorArray.count)
        }
    }
}

function DisplayGroupInfo
{
    $global:graphMembersErrorArray = @()
    $global:graphMembersArray = @()
    out-logfile -string "Obtaining group membership..."

    $operationSuccessful = $FALSE

    try
    {
        $graphGroupMembers = Get-MgGroupMember -GroupId $global:graphGroup.id -all -errorAction Stop
        $operationSuccessful = $TRUE
    }
    catch
    {
        $errorText = $_
        out-logfile -string "Unable to obtain graph group membership..."
        out-logfile -string $_
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain graph group membership..."+$errorText, 'Warning')
        $global:ErrorMessages += $errorText
    }

    out-logfile -string "Parse all members for information to add to the table."

    if ($operationSuccessful -eq $TRUE)
    {
        foreach ($member in $graphGroupMembers)
        {
            if ($member.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.user")
            {
                $functionObjectType = "User"
                $functionUPN = $member.AdditionalProperties.userPrincipalName
            }
            elseif($member.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.group")
            {
                $functionObjectType = "Group"
                $functionUPN = "N/A"
            }
            elseif($member.AdditionalProperties.'@odata.context' -eq "https://graph.microsoft.com/v1.0/$metadata#contacts/$entity")
            {
                $functionObjectType = "Contact"
                $functionUPN = "N/A"
            }

            $functionObject = New-Object PSObject -Property @{
                ID = $member.Id
                DisplayName = $member.AdditionalProperties.displayName
                UserPrincipalName = $functionUPN
                ObjectType = $functionObjectType
            }

            $global:graphMembersArray += $functionObject
        }
    }  
    
    if ($operationSuccessful -eq $TRUE)
    {
        GetGroupErrors
    }

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'displaygroupinfo.designer.ps1')
    $GroupInfo.ShowDialog()
}