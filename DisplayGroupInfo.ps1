$ExitDisplayButton_Click = {
}
function DisplayGroupInfo
{
    out-logfile -string "Entered Display Group Info"

    out-logfile -string "Obtaining group info..."

    $operationSuccessful=$false

    try {
        $graphGroupMember = Get-MgGroupMember -GroupId $global:graphGroup.id -All -ErrorAction STOP 
        $operationSuccessful = $TRUE
    }
    catch {
        $errorText = $_
        out-logfile -string ("Error to obtain graph group membership..."+$errorText)
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain graph group membership.."+$errorText, 'Warning')
    }

    if ($operationSuccessful -eq $TRUE)
    {
        $graphGroupMemberArray = @()

        foreach ($member in $GraphGRoupMember)
        {
            if ($member.AdditionalProperties.'@odata.Type' -eq "#microsoft.graph.user")
            {
                $functionObjectType = "User"
                $functionUPN = $member.AdditionalProperties.UserPrincipalName
            }
            elseif($member.AdditionalProperties.'@odata.Type' -eq "#microsoft.graph.group")
            {
                $functionObjectType = "Group"
                $functionUPN = "N/A"
            }
            elseif ($member.AdditionalProperties.'@odata.context' -eq "https://graph.microsoft.com/v1.0/$metadata#contacts/$entity")
            {
                $functionObjectType = "Contact"
                $functionUPN = "N/A"
            }

            $functionObject = New-Object PSObject -Property @{
                ID = $member.Id
                DisplayName = $member.additionalProperties.displayName
                UserPrincipalName = $functionUPN
                ObjectType = $functionObjectType
            }
        }
    }

    out-logfile -string "Obtaining all group members in an error status."

    if ($operationSuccessful -eq $TRUE)
    {
        out-logfile -string "Proceed with calculating fields."
    }
}