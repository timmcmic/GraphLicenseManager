function Start-GraphLicenseManager
{
    $ErrorActionPreference = 'Stop'

    establishGraphConnection

    manageGroupLicense
}