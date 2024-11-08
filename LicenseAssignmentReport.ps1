function LicenseAssignmentReport
{

}

. (Join-Path $PSScriptRoot 'licenseassignmentreport.designer.ps1')
$LicenseAssignmentreport.ShowDialog()