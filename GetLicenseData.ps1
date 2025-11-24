function GetLicenseData
{
    [string]$licenseDownloadURL = "https://learn.microsoft.com/en-us/entra/identity/users/licensing-service-plan-reference"
    $licenseJSON = $null

    $licenseExport = $global:logFile.replace(".log",".csv")

    try
    {
        out-logfile -string "Invoking web request to obtain HTML data."
        $functionHTMLData = invoke-WebRequest -URI $licenseDownloadURL -errorAction STOP
        out-logfile -string "License URL HTML successfully obtained."
    }
    catch 
    {
        out-logfile -string "Attempting to utilize basic parsing assuming IE engine is not available."

        try {
            $functionHTMLData = invoke-WebRequest -URI $licenseDownloadURL -errorAction STOP -useBasicParsing
        }
        catch {
            out-logfile -string "Unable to obtain the license HTML Data."
            out-logfile -string $_ -isError:$TRUE
        }
    }

    $functionDownloadLink = $functionHTMLData.links | where {$_.innerText -eq "Here"}

    $functionDownloadLink = $functionDownloadLink.href

    out-logfile -string ("Download link obtained from page: "+$functionDownloadLink)

    try {
        out-logfile -string "Attempting to obtain the license CSV."
        $functionCSVData = Invoke-WebRequest -Uri $functionDownloadLink -errorAction Stop
        out-logfile -string "The license CSV data was successfully obtained."
    }
    catch {
        out-lgfile -string "Attempting to utilize basic parsing assuming IE engine is not available."

        try {
            $functionCSVData = Invoke-WebRequest -Uri $functionDownloadLink -errorAction Stop -useBasicParsing
        }
        catch {
            out-logfile -string "Unable to obtain the license CSV data."
            out-logfile -string $_ -isError:$TRUE

            $errorText = $_
            $global:ErrorMessages += $errorText
        }
    }

    out-logfile -string "Converting the raw data downloaded to CSV format."

    try {
        $functionCSVData = ConvertFrom-CSV $functionCSVData -ErrorAction STOP
    }
    catch {
        out-logfile -string "Unable to convert the data to CSV."
        $errorText = $_
        $global:ErrorMessages += $errorText
        out-logfile -string $_ -errorAction:STOP
    }

    out-logfile -string "Retaining the CSV file that was used for evaluation on this run."

    try
    {
        $functionCSVData | export-csv $licenseExport -errorAction STOP
    }
    catch 
    {
        out-logfile -string "Unable to export the csv license data."
        $errorText = $_
        $global:ErrorMessages += $errorText
        out-logfile -string $_ -isError:$TRUE
    }

    out-logfile -string "Convert the CSV file to indexed hash tables."

    $skuCSV = $functionCSVData | Group-Object String_ID | ForEach-Object {$_.Group[0] }
    $skuGuidCSV = $functionCSVData | Group-Object GUID | ForEach-Object {$_.Group[0] }
    $servicePlanCSV = $functionCSVData | Group-Object Service_Plan_Name | ForEach-Object {$_.Group[0] }
    $servicePlanIDCSV = $functionCSVData | Group-Object Service_Plan_ID | ForEach-Object {$_.Group[0] }


    $global:skuHash = @{}
    $global:servicePlanHash = @{}
    $global:skuGuidHash = @{}
    $global:skuServicePlanIDHash = @{}

    foreach ($member in $skuCSV)
    {
        $key = $member.string_ID
        $global:skuHash[$key] = $member
    }

    foreach ($member in $servicePlanCSV)
    {
        $key = $member.Service_Plan_Name
        $global:servicePlanhash[$key] = $member
    }

    foreach ($member in $skuGuidCSV)
    {
        $key = $member.GUID
        $global:skuGuidHash[$key] = $member
    }

    foreach ($member in $servicePlanIDCSV)
    {
        $key = $member.Service_Plan_ID
        $global:skuServicePlanIDHash[$key] = $member
    }
}