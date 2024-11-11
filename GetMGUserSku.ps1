function GetMGUserSku
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $skus
    )

    out-logfile -string "Entering GetMGUserSKU"

    $skus = $skus | where {$_.appliesTo -eq "User"}

    out-xmlFile -itemToExport $skus -itemNameToExport ("GraphSKUSUserOnly-"+(Get-Date -Format FileDateTime))

    out-logfile -string "Exiting GetMGUserSKU"

    return $skus
}