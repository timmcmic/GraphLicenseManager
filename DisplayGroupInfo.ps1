$GroupInfo_Load = {
    $membersView.columnCount = 4

    $membersViewColumns = @()
    $membersViewColumns = @("ID","DisplayName","UserPrincipalName","ObjectType")

    foreach ($entry in $membersViewColumns )
    {
        out-logfile -string $entry
    }

    for ($i = 0 ; $i -lt $membersViewColumns.count ; $i++)
    {
        $membersView.columns[$i].name = $membersViewColumns[$i]
    }
    
    foreach ($member in $global:graphMembersArray)
    {
        $membersView.rows.add($member.ID,$member.DisplayName,$member.UserPrincipalName,$member.ObjectType)
    }

    $membersView.Columns | Foreach-Object{
        $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
    }
}

$CloseDisplay_Click = {
    $GroupInfo.close()
}

function DisplayGroupInfo
{
    out-logfile -string "Obtaining group membership..."

    $operationSuccessful = $FALSE

    try
    {
        $graphGroupMembers = Get-MgGroupMember -GroupId $global:graphGroup.id -errorAction Stop
        $operationSuccessful = $TRUE
    }
    catch
    {
        $errorText = $_
        out-logfile -string "Unable to obtain graph group membership..."
        out-logfile -string $_
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain graph group membership..."+$errorText, 'Warning')
    }

    out-logfile -string "Parse all members for information to add to the table."

    if ($operationSuccessful -eq $TRUE)
    {
        $global:graphMembersArray = @()

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

    if ($graphGroupMembers.count -gt 0)
    {
        $graphMemberCount = $graphGroupMembers.count
    }
    else 
    {
        $graphMemberCount = 0
    }
    

    $operationSuccessful = $false

    out-logfile -string "Determine if any group license errors exist."

    try {
        $global:$graphErrorGroupMembers = Get-MgGroupMemberWithLicenseError -GroupId $global:graphGroup.id -errorAction Stop
        $operationSuccessful = $true
    }
    catch {
        $errorText = $_
        out-logfile -string "Unable to obtain the members in error..."
        out-logfile -string $_
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain the members in error..."+$errorText, 'Warning')
    }

    out-logfile -string "Parse the error members to obtain the error reason."

    if ($operationSuccessful -eq $TRUE)
    {
        if ($global:$graphErrorGroupMembers.count -gt 0)
        {
            $graphMembersErrorArray = @()

            out-logfile -string "The group has users in error - process each user."

            foreach ($member in $global:$graphErrorGroupMembers)
            {
                $functionUser = get-MGUser -userID $member.id -Property ID,DisplayName,assignedLicenses,licenseAssignmentStates | Select-Object -ExpandProperty LicenseAssignmentStates

                $functionUser = $functionUser | where {$_.AssignedByGroup -eq $global:graphGroup.Id}

                $functionError = $functionUser.Error

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
    
                $graphMembersErrorArray += $functionObject
            }
        }
    }

    if ($graphMembersErrorArray.count -gt 0)
    {
        $graphMemberErrorCount = $graphMembersErrorArray.count
    }
    else 
    {
        $graphMemberErrorCount = 0
    }

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'displaygroupinfo.designer.ps1')
    $GroupInfo.ShowDialog()

    if ($operationSuccessful -eq $TRUE)
    {
        out-logfile -string "Made it here."
        $PoplateMembers_Click
    }
}