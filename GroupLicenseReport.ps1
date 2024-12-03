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
                $commonName = $global:skuGuidHash[$sku.SkuID].'???Product_Display_Name'
                out-logfile -string $commonName
                $skuOutput += $commonName
            }

            $skuOutput = $skuOutput -join ","
            out-logfile -string ("Skus on Group: "+ $skuOutput)

            out-logfile -string ("License Processing State:" +$group.LicenseProcessingState)
        }
    }
}