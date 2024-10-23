function Start-GraphLicenseManager
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$logFolderPath
    )

    $ErrorActionPreference = 'Stop'
    $global:logFile=$NULL
    $global:logFileName = "LicenseChangeOperation_"+(Get-Date -Format FileDateTime)

    new-logfile -logFileName $logFileName -logFolderPath $global:logFileName

    out-logfile -string "************************************************************************"
    out-logfile -string "Starting graph license manager."
    out-logfile -string "************************************************************************"

    out-logfile -string "Invoking establish graph connection..."
    establishGraphConnection

    out-logfile -string "Invoking manage group license..."
    manageGroupLicense
}