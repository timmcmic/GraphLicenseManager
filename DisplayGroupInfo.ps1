function DisplayGroupInfo
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $GroupInfo
    )

    write-host $groupInfo.DisplayName

}