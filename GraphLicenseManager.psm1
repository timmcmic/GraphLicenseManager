function Start-GraphLicenseManager
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$logFolderPath,
        [Parameter(Mandatory = $false)]
        [boolean]$allowTelemetryCollection=$TRUE
    )

    #Initialize telemetry collection.

    $appInsightAPIKey = "63d673af-33f4-401c-931e-f0b64a218d89"
    $traceModuleName = "GraphLicenseManager"

    if ($allowTelemetryCollection -eq $TRUE)
    {
        start-telemetryConfiguration -allowTelemetryCollection $allowTelemetryCollection -appInsightAPIKey $appInsightAPIKey -traceModuleName $traceModuleName
    }

    #Define telemetry items.

    $telemetryGraphLicenseManagerVersion = $NULL
    $telemetryMSGraphAuthentication = $NULL
    $telemetryMSGraphDirectory = $NULL
    $telemetryMSGraphUsers = $NULL
    $telemetryMSGraphGroups = $NULL
    $telemetryOSVersion = (Get-CimInstance Win32_OperatingSystem).version
    $telemetryStartTime = get-universalDateTime
    $telemetryAuthenticationStartTime = $null
    $telemetryAuthenticationEndTime = $NULL
    [double]$telemetryAuthentictionTime = 0
    $telemetryLicenseManagementStartTime = $NULL
    $telemetryLicenseManagementEndTime = $NULL
    [double]$telemetryLicenseManagementTime = 0
    $telemetryEndTime = $NULL
    [double]$telemetryElapsedSeconds = 0
    $telemetryEventName = "Start-DistributionListMigration"
    [double]$telemetrySearches=0
    [double]$telemetryCommits=0

    $ErrorActionPreference = 'Stop'
    $global:logFile=$NULL
    $logFileName = "LicenseChangeOperation_"+(Get-Date -Format FileDateTime)

    $global:exitSelected = $false

    new-logfile -logFileName $logFileName -logFolderPath $logFolderPath

    out-logfile -string "********************************************************************************"
    out-logfile -string "NOTICE"
    out-logfile -string "Telemetry collection is now enabled by default."
    out-logfile -string "For information regarding telemetry collection see https://timmcmic.wordpress.com/2022/11/14/4288/"
    out-logfile -string "Administrators may opt out of telemetry collection by using -allowTelemetryCollection value FALSE"
    out-logfile -string "Telemetry collection is appreciated as it allows further development and script enhancement."
    out-logfile -string "********************************************************************************"

    $telemetryGraphLicenseManagerVersion = Test-PowershellModule -powershellModuleName "GraphLicenseManager" -powershellVersionTest:$TRUE
    $telemetryMSGraphAuthentication = Test-PowershellModule -powershellModuleName "Microsoft.Graph.Authentication" -powershellVersionTest:$TRUE
    $telemetryMSGraphDirectory = Test-PowershellModule -powershellModuleName "Microsoft.Graph.DirectoryManagement" -powershellVersionTest:$TRUE
    $telemetryMSGraphUsers = Test-PowershellModule -powershellModuleName "Microsoft.Graph.Users" -powershellVersionTest:$TRUE
    $telemetryMSGraphGroups = Test-PowershellModule -powershellModuleName "Microsoft.Graph.Groups" -powershellVersionTest:$TRUE


    out-logfile -string "************************************************************************"
    out-logfile -string "Starting graph license manager."
    out-logfile -string "************************************************************************"

    out-logfile -string "Invoking establish graph connection..."

    $telemetryAuthenticationStartTime = get-universalDateTime
    establishGraphConnection
    $telemetryAuthenticationEndTime = get-universalDateTime
    $telemetryAuthentictionTime= get-elapsedTime -startTime $telemetryAuthenticationStartTime -endTime $telemetryAuthenticationEndTime

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
    $telemetryLicenseManagementStartTime = get-universalDateTime
    manageGroupLicense
    $telemetryLicenseManagementEndTime = get-universalDateTime
    $telemetryLicenseManagementTime = get-elapsedTime -startTime $telemetryLicenseManagementStartTime -endTime $telemetryLicenseManagementEndTime

    $telemetryEndTime = get-universalDateTIme
    $telemetryElapsedSeconds = get-elapsedTime -startTime $telemetryStartTime -endTime $telemetryEndTime
}