function CalculateError
{
    param
    (
        [Parameter(Mandatory = $true)]
        $errorText
    )

    out-logfile -string "Entering Calculate Error Text"

    $errorText = ($errorText -split 'Status: 400')[0]

    out-logfile -string "Exiting Calculate Error Text"

    return $errorText
}