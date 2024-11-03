function DisplayGroupInfo
{
    out-logfile -string "Entered Display Group Info"

    out-logfile -string "Obtaining group info..."

    $operationSuccessful=$false

    try {
        $graphGroupMember = Get-MgGroupMember -GroupId $global:graphGroup.id -All -ErrorAction
        $operationSuccessful = $TRUE
    }
    catch {
        $errorText = $_
        out-logfile -string ("Error to obtain graph group membership..."+$errorText)
        [System.Windows.Forms.MessageBox]::Show("Unable to obtain graph group membership.."+$errorText, 'Warning')
    }

    
}