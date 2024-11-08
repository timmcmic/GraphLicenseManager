function getMGSku
{
    out-logfile -string "Entering GetMGSku"

    $skus = Get-MgSubscribedSku

    out-xmlFile -itemToExport $skus -itemNameToExport ("GraphSKUS-"+(Get-Date -Format FileDateTime))

    out-logfile -string "Ending GetMGSku"

    return $skus
}