function Start-GraphLicenseManager
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$logFolderPath
    )

    $ErrorActionPreference = 'Stop'
    $global:logFile=$NULL
    $logFileName = "LicenseChangeOperation_"+(Get-Date -Format FileDateTime)

    new-logfile -logFileName $logFileName -logFolderPath $logFolderPath

    out-logfile -string "************************************************************************"
    out-logfile -string "Starting graph license manager."
    out-logfile -string "************************************************************************"
    
    establishGraphConnection

    manageGroupLicense
}