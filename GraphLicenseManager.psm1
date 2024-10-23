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

    $global:exitSelected = $false

    new-logfile -logFileName $logFileName -logFolderPath $logFolderPath

    out-logfile -string "************************************************************************"
    out-logfile -string "Starting graph license manager."
    out-logfile -string "************************************************************************"

    out-logfile -string "Invoking establish graph connection..."
    establishGraphConnection

    if ($global:exitSelected -eq $TRUE)
    {
        out-logfile -string "The quit button was selected - exit."
        exit
    }
    else 
    {
        out-logfile -string "No exit selected - continue."
    }

    out-logfile -string "Invoking manage group license..."
    manageGroupLicense
}