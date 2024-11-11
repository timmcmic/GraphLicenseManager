
function LicenseAssignmentReport
{
    out-logfile -string "Entering license assignment report."

    out-logfile -string "Establishing global properties for getting users."

    try {
        #$skus = Get-MgSubscribedSku -errorAction Stop
        $skus = getMGSku -errorAction STOP
        out-logfile -string "SKUs successfully obtained..."
    }
    catch {
        $errorText=$_
        out-logfile -string "Unable to obtain the skus within the tenant.."
        out-logfile -string $errorText
        $errorText = CalculateError $errorText
        $global:errorMessages+=$errorText
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain the skus within the tenant.."+$errorText, 'Warning')
        $global:telemetrySearcheErrors++
    }

    out-logfile -string "Removing all non-user SKUs"

    $skus = GetMGUserSku -skus $skus

    out-logfile -string "Build the custom powershell object for each of the sku / plan combinations that could be enabled."

    CalculateSkuTracking -skus $skus


    . (Join-Path $PSScriptRoot 'licenseassignmentreport.designer.ps1')
$LicenseAssignmentreport.ShowDialog()
}

