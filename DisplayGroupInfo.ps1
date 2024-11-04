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

            $graphGroupMemberArray += $functionObject
        }

        $MembersView.columnCount = 4

        $memberViewColumns = @()
        $memberViewColumns = @("ID","DisplayName","UserPrincipalName","ObjectType")

        foreach ($entry in $memberViewColumns )
        {
            out-logfile -string $entry
        }

        for ($i = 0 ; $i -lt $memberViewColumns.count ; $i++)
        {
            $MembersView.columns[$i].name = $memberViewColumns[$i]
        }
        
        foreach ($member in $graphGroupMemberArray)
        {
            $MembersView.rows.add($member.id,$member.displayName,$member.UserPrincipalName,$member.ObjectType)
        }

        $MembersView.Columns | Foreach-Object{
            $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
        }
    }

    out-logfile -string "Obtaining all group members in an error status."

    if ($operationSuccessful -eq $TRUE)
    {
        out-logfile -string "Proceed with calculating fields."
    }
}