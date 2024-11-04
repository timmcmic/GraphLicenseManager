function GetLicenseData
{
    [string]$licenseDownloadURL = "https://learn.microsoft.com/en-us/entra/identity/users/licensing-service-plan-reference"
    $licenseJSON = $null

    $licenseExport = $global:logFile.replace(".log",".xml")

    try
    {
        out-logfile -string "Invoking web request to obtain HTML data."
        $functionHTMLData = invoke-WebRequest -URL $licenseDownloadURL -errorAction STOP
        out-logfile -string "License URL HTML successfully obtained."
    }
    catch 
    {
        out-logfile -string "Unable to obtain the license HTML Data."
        out-logfile -string $_ -isError:$TRUE
    }

    $functionDownloadLink = $functionHTMLData.links | where {$_.innerText -eq "Here"}

    $functionDownloadLink = $functionDownloadLink.href

    try {
        out-logfile -string "Attempting to obtain the license CSV."
        $global:functionCSVData = Invoke-WebRequest -Uri $functionDownloadLink -errorAction Stop
        out-logfile -string "The license CSV data was successfully obtained."
    }
    catch {
        out-logfile -string "Unable to obtain the license CSV data."
        out-logfile -string $_ -isError:$TRUE
    }

    out-logfile -string "Converting the raw data downloaded to CSV format."

    try {
        $global:functionCSVData = ConvertFrom-CSV $functionCSVData -ErrorAction STOP
    }
    catch {
        out-logfile -string "Unable to convert the data to CSV."
        out-logfile -string $_ -errorAction:STOP
    }
}