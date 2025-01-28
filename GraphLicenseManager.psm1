function Start-GraphLicenseManager
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$logFolderPath,
        [Parameter(Mandatory = $false)]
        [string]$EntraTenantID="",
        [Parameter(Mandatory = $false)]
        [string]$certificateThumbprint="",
        [Parameter(Mandatory = $false)]
        [string]$appID="",
        [Parameter(Mandatory = $false)]
        [boolean]$allowTelemetryCollection=$TRUE,
        [Parameter(Mandatory = $false)]
        $accessToken=$NULL
    )

    #Initialize telemetry collection.

    $appInsightAPIKey = "63d673af-33f4-401c-931e-f0b64a218d89"
    #$appInsightAPIKey = "ebaef937-84c8-4e48-a29a-4a66ba482a32"
    $traceModuleName = "GraphLicenseManager"

    if ($allowTelemetryCollection -eq $TRUE)
    {
        start-telemetryConfiguration -allowTelemetryCollection $allowTelemetryCollection -appInsightAPIKey $appInsightAPIKey -traceModuleName $traceModuleName -errorAction STOP
    }

    Set-Variable -Name "EntraTenantID" -Value $EntraTenantID -Scope Global
    Set-Variable -name "CertificateThumbPrint" -Value $certificateThumbprint -scope Global
    set-variable -name "AppID" -Value $appID -scope global
    set-variable -name "accessToken" -value $accessToken -scope Global
    #Define telemetry items.

    $telemetryEventName = "GraphLicenseManager"
    $global:telemetryOperationName = ""
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
    [double]$global:telemetrySearches=0
    [double]$global:telemetryCommits=0
    [double]$global:telemetrySearcheErrors=0
    [double]$global:telemetryCommitErrors=0
    [double]$global:telemetryRefresh=0
    [double]$global:telemetryCSVExport=0
    $global:telemetryattributesSelected = @()
    [double]$global:telemetryLicensesViewed = 0
    $global:ErrorMessages=@()


    $ErrorActionPreference = 'Stop'
    $global:logFile=$NULL
    $logFileName = "GraphLicenseManager_"+(Get-Date -Format FileDateTime)

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
    $telemetryMSGraphDirectory = Test-PowershellModule -powershellModuleName "Microsoft.Graph.Identity.DirectoryManagement" -powershellVersionTest:$TRUE
    $telemetryMSGraphUsers = Test-PowershellModule -powershellModuleName "Microsoft.Graph.Users" -powershellVersionTest:$TRUE
    $telemetryMSGraphGroups = Test-PowershellModule -powershellModuleName "Microsoft.Graph.Groups" -powershellVersionTest:$TRUE

    out-logfile -string "************************************************************************"
    out-logfile -string "Starting graph license manager."
    out-logfile -string "************************************************************************"

    out-logfile -string "Obtaining license CSV data."

    GetLicenseData

    out-logfile -string "Validate if access token is specified."

    if ($global:accessToken -ne $NULL)
    {
        out-logfile -string "Access token specified - check tenant ID"

        if ($global:EntraTenantID -eq "")
        {
            out-logfile -string "When using access token please specify -EntraTenantID TENANTID" -isError:$TRUE
        }
        else 
        {
            out-logfile -string "TenantID and Access token specified - proceed."
        }
    }
    else 
    {
        out-logfile -string "Access token not specified - continue with standard authentication."
    }

    out-logfile -string "Invoking establish graph connection..."

    $telemetryAuthenticationStartTime = get-universalDateTime
    establishGraphConnection
    $telemetryAuthenticationEndTime = get-universalDateTime
    $telemetryAuthentictionTime= get-elapsedTime -startTime $telemetryAuthenticationStartTime -endTime $telemetryAuthenticationEndTime

    out-logfile -string "Invoking manage group license..."
    $telemetryLicenseManagementStartTime = get-universalDateTime

    if ($global:exitSelected -eq $false)
    {
        if ($global:selectedOperation -eq "Group License Manager")
        {
            out-logfile -string "Connection successful -> manage group license"
            manageGroupLicense
        }
        elseif ($global:selectedOperation -eq "License Assignment Report")
        {
            out-logfile -string "Connection successful -> license assignment report"
            LicenseAssignmentReport
        }
        elseif ($global:selectedOperation -eq "Group Assignment Report") 
        {
            out-logfile -string "Connection successful -> group assignment report"
            GroupLicenseReport
        }
    }

    $telemetryLicenseManagementEndTime = get-universalDateTime
    $telemetryLicenseManagementTime = get-elapsedTime -startTime $telemetryLicenseManagementStartTime -endTime $telemetryLicenseManagementEndTime

    $telemetryEndTime = get-universalDateTime
    $telemetryElapsedSeconds = get-elapsedTime -startTime $telemetryStartTime -endTime $telemetryEndTime

    $telemetryEventProperties = @{
        GraphLicenseManagerCommand = $telemetryEventName
        OperationName = $global:telemetryOperationName
        GraphLicenseManagerVersion = $telemetryGraphLicenseManagerVersion
        GraphAuthenticationVersion = $telemetryMSGraphAuthentication
        GraphIdentityDirectoryManagementVersion = $telemetryMSGraphDirectory
        GraphUsersVersion = $telemetryMSGraphUsers
        GraphGroupVersion = $telemetryMSGraphGroups
        OSVersion = $telemetryOSVersion
        CommandStartTimeUTC = $telemetryStartTime
        CommandEndTimeUTC = $telemetryEndTime
        AuthenticationStateTime = $telemetryAuthenticationStartTime
        AuthenticationEndTime = $telemetryAuthenticationEndTime
        AuthenciationElapsedTime = $telemetryAuthentictionTime
        LicenseManagementStartTime = $telemetryLicenseManagementStartTime
        LicenseManagementEndTime = $telemetryLicenseManagementEndTime
        LicenseManagementElapsedTime = $telemetryLicenseManagementTime
        TelemetryAttributesSelected = $global:telemetryattributesSelected
        ErrorText = $global:errorMessages
    }

    $telemetryEventMetrics = @{
        TotalCommandTime = $telemetryElapsedSeconds
        TotalSearches = $global:telemetrySearches
        TotalCommits = $global:telemetryCommits
        TotalCommitErrors = $global:telemetryCommitErrors
        TotalSearchErrors = $global:telemetrySearcheErrors
        TotalRefreshOperations = $global:telemetryRefresh
        TotalCSVExports = $global:telemetryCSVExport
        TotalLicensesViewed = $global:telemetryLicensesViewed
    }

    out-logfile -string "Sending telemetry event."

    if ($allowTelemetryCollection -eq $TRUE)
    {
        send-TelemetryEvent -traceModuleName $traceModuleName -eventName $telemetryEventName -eventMetrics $telemetryEventMetrics -eventProperties $telemetryEventProperties -errorAction STOP
    }

    Disconnect-MgGraph
}