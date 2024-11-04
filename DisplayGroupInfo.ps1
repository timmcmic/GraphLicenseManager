$CloseDisplay_Click = {
    $GroupInfo.close()
}

function DisplayGroupInfo
{
    Add-Type -AssemblyName System.Windows.Forms
    . (Join-Path $PSScriptRoot 'displaygroupinfo.designer.ps1')
    $GroupInfo.ShowDialog()

    out-logfile -string "Obtaining group membership..."

    $operationSuccessful = $FALSE

    try
    {
        $graphGroupMembers = Get-MgGroupMember -GroupId $global:graphGroup.id -errorAction Stop
        $operationSuccessful = $TRUE
    }
    catch
    {
        $errorText = $_
        out-logfile -string "Unable to obtain graph group membership..."
        out-logfile -string $_
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain graph group membership..."+$errorText, 'Warning')
    }

    out-logfile -string $graphGroupMembers
}