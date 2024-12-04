function CalculateError
{
    param
    (
        [Parameter(Mandatory = $true)]
        $errorText
    )

    out-logfile -string "Entering Calculate Error Text"

    $errorTextOutput = ($errorText -split 'Status: 400')[0]
    $errorTextOutput = $errorTextOutput -replace '^\s*$', ''
    $errorTextOutput = $errorTextOutput.tostring()

    out-logfile -string $errorTextOutput

    $guidPattern = '[({]?[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}[)}]?'
    $result = $errorTextOutput | Select-String -Pattern $guidPattern -AllMatches

    if ($result.count -gt 0)
    {
        out-logfile -string "More than one GUID pattern found in error string."

        foreach ($entry in $result.Matches.Value)
        {
            $tempString = ""
            out-logfile -string $entry

            if ($global:skuServicePlanIDHash[$entry])
            {
                out-logfile -string $global:skuServicePlanIDHash[$entry].Service_Plans_Included_Friendly_Names
                $tempString = $global:skuServicePlanIDHash[$entry].Service_Plans_Included_Friendly_Names
            }
            elseif ($global:skuGuidHash[$entry])
            {
                out-logfile -string $global:skuGuidHash[$entry].'???Product_Display_Name'
                $tempString = $global:skuGuidHash[$entry].'???Product_Display_Name'
            }

            if ($tempString -ne "")
            {
                out-logfile -string "A friendly name was located."

                $errorString = $entry + " (" + $tempString + ")"

                out-logfile -string $errorString

                $errorTextOutput = $errorTextOutput.replace($entry,$errorString)

                out-logfile -string $errorTextOutput
            }
        }
    }
    else 
    {
        $tempString = ""

        out-logfile -string "Only a single GUID patter was found in the error string."

        out-logfile -string $result.Matches.Value

        if ($global:skuServicePlanIDHash[$result.Matches.Value])
        {
            out-logfile -string $global:skuServicePlanIDHash[$result.Matches.Value].Service_Plans_Included_Friendly_Names
            $tempString = $global:skuServicePlanIDHash[$result.Matches.Value].Service_Plans_Included_Friendly_Names
        }
        elseif ($global:skuGuidHash[$result.Matches.Value])
        {
            out-logfile -string $global:skuGuidHash[$result.Matches.Value].'???Product_Display_Name'
            $tempString = $global:skuGuidHash[$result.Matches.Value].'???Product_Display_Name'
        }

        if ($tempString -ne "")
        {
            out-logfile -string "A friendly name was located."

            $errorString = $result.Matches.Value + " (" + $tempString + ")"

            out-logfile -string $errorString

            $errorTextOutput = $errorTextOutput.replace($entry,$errorString)

            out-logfile -string $errorTextOutput
        }
    }

    out-logfile -string "Exiting Calculate Error Text"

    return $errorTextOutput
}