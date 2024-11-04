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
        $graphMembersArray = @()

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

            $graphMembersArray += $functionObject
        }
    }

    $graphMemberCount = $graphGroupMembers.count

    $operationSuccessful = $false

    out-logfile -string "Determine if any group license errors exist."

    try {
        $graphErrorGroupMembers = Get-MgGroupMemberWithLicenseError -GroupId $global:graphGroup.id -errorAction Stop
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
        if ($graphErrorGroupMembers.count -gt 0)
        {
            $graphMembersErrorArray = @()

            out-logfile -string "The group has users in error - process each user."

            foreach ($member in $graphErrorGroupMembers)
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
    
            }
        }
    }

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'displaygroupinfo.designer.ps1')
    $GroupInfo.ShowDialog()
}