function CalculateError
{
    param
    (
        [Parameter(Mandatory = $true)]
        $errorText
    )

    out-logfile -string "Entering Calculate Error Text"

    $errorText = ($errorText -split 'Status: 400')[0]

    $guidPattern = '[({]?[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}[)}]?'
    $result = $errorText | Select-String -Pattern $guidPattern -AllMatches
    $result.Matches.Value

    foreach ($item in $result)
    {
        out-logfile -string $item
    }

    out-logfile -string "Exiting Calculate Error Text"

    return $errorText
}