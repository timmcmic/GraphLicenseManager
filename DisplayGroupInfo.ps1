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

            out-logfile -string $functionObject
        }
    }

    $membersView.columnCount = 4

    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'displaygroupinfo.designer.ps1')
    $GroupInfo.ShowDialog()
}