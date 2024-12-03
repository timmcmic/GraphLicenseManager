function GraphLicenseReport
{
    $functionGroupInfo = @()

    out-logfile string "Entering GraphLicenseReport"

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
            $group.Id
        }
    }
}