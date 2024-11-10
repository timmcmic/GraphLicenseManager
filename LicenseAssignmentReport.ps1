$LicenseAssignmentReport_Load = {

    try {
        #$skus = Get-MgSubscribedSku -errorAction Stop
        $skus = getMGSku -errorAction STOP
        out-logfile -string "SKUs successfully obtained..."
        $ToolStripStatusLabel1.Text = "Get-MGSubscribedSKU SUCESSFUL"
    }
    catch {
        $errorText=$_
        out-logfile -string "Unable to obtain the skus within the tenant.."
        out-logfile -string $errorText
        $errorText = CalculateError $errorText
        $global:errorMessages+=$errorText
        $ToolStripStatusLabel1.Text = "Get-MGSubscribedSKU ERROR"
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain the skus within the tenant.."+$errorText, 'Warning')
        $global:telemetrySearcheErrors++
    }

    out-logfile -string "Removing all non-user SKUs"

    $skus = GetMGUserSku -skus $skus

    out-logfile -string "Build the custom powershell object for each of the sku / plan combinations that could be enabled."

    $ToolStripStatusLabel1.Text = "Enumerating all SKUs and SKU-Plans in tenant..."

    CalculateSkuTracking -skus $skus

    out-logfile -string "Populate the SKUBox with all of the USER skus in the tenant."

    $items = @()

    $items += $global:skuTracking | select-object SkuID -Unique

    $skuBox.items.addRange($items.SkuCommonName)
    $skuBox.selectedIndex = 0
    $SkuBox.add_SelectedIndexChanged($SkuBox_SelectedIndexChanged)
}
function LicenseAssignmentReport
{
    . (Join-Path $PSScriptRoot 'licenseassignmentreport.designer.ps1')
$LicenseAssignmentreport.ShowDialog()
}

