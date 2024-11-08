function getMGSku
{
    out-logfile -string "Entering GetMGSku"

    $skus = Get-MgSubscribedSku

    out-logfile -string "Ending GetMGSku"

    return $skus
}