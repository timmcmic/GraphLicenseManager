$GroupLicenseReport = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.ListView]$GroupView = $null
[System.Windows.Forms.Button]$InvokeProperties = $null
[System.Windows.Forms.Button]$CloseLicenseReport = $null
[System.Windows.Forms.Button]$InvokeManageLicense = $null
function InitializeComponent
{
$GroupView = (New-Object -TypeName System.Windows.Forms.ListView)
$InvokeProperties = (New-Object -TypeName System.Windows.Forms.Button)
$CloseLicenseReport = (New-Object -TypeName System.Windows.Forms.Button)
$InvokeManageLicense = (New-Object -TypeName System.Windows.Forms.Button)
$GroupLicenseReport.SuspendLayout()
#
#GroupView
#
$GroupView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]12))
$GroupView.MultiSelect = $false
$GroupView.Name = [System.String]'GroupView'
$GroupView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]982,[System.Int32]556))
$GroupView.TabIndex = [System.Int32]0
$GroupView.UseCompatibleStateImageBehavior = $false
$GroupView.add_ItemSelectionChanged($GroupView_ItemSelectionChanged)
#
#InvokeProperties
#
$InvokeProperties.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]574))
$InvokeProperties.Name = [System.String]'InvokeProperties'
$InvokeProperties.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]336,[System.Int32]23))
$InvokeProperties.TabIndex = [System.Int32]1
$InvokeProperties.Text = [System.String]'Display Group Properties'
$InvokeProperties.UseVisualStyleBackColor = $true
$InvokeProperties.Visible = $false
$InvokeProperties.add_Click($InvokeProperties_Click)
#
#CloseLicenseReport
#
$CloseLicenseReport.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]436,[System.Int32]574))
$CloseLicenseReport.Name = [System.String]'CloseLicenseReport'
$CloseLicenseReport.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]135,[System.Int32]23))
$CloseLicenseReport.TabIndex = [System.Int32]3
$CloseLicenseReport.Text = [System.String]'Exit'
$CloseLicenseReport.UseVisualStyleBackColor = $true
$CloseLicenseReport.add_Click($CloseLicenseReport_Click)
#
#InvokeManageLicense
#
$InvokeManageLicense.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]658,[System.Int32]574))
$InvokeManageLicense.Name = [System.String]'InvokeManageLicense'
$InvokeManageLicense.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]336,[System.Int32]23))
$InvokeManageLicense.TabIndex = [System.Int32]4
$InvokeManageLicense.Text = [System.String]'Manage Licenses'
$InvokeManageLicense.UseVisualStyleBackColor = $true
$InvokeManageLicense.Visible = $false
$InvokeManageLicense.add_Click($InvokeManageLicense_Click)
#
#GroupLicenseReport
#
$GroupLicenseReport.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$GroupLicenseReport.Controls.Add($InvokeManageLicense)
$GroupLicenseReport.Controls.Add($CloseLicenseReport)
$GroupLicenseReport.Controls.Add($InvokeProperties)
$GroupLicenseReport.Controls.Add($GroupView)
$GroupLicenseReport.Text = [System.String]'Group License Report'
$GroupLicenseReport.ResumeLayout($false)
Add-Member -InputObject $GroupLicenseReport -Name GroupView -Value $GroupView -MemberType NoteProperty
Add-Member -InputObject $GroupLicenseReport -Name InvokeProperties -Value $InvokeProperties -MemberType NoteProperty
Add-Member -InputObject $GroupLicenseReport -Name CloseLicenseReport -Value $CloseLicenseReport -MemberType NoteProperty
Add-Member -InputObject $GroupLicenseReport -Name InvokeManageLicense -Value $InvokeManageLicense -MemberType NoteProperty
}

$GroupLicenseReport.add_Load($GroupReport_Load)

. InitializeComponent
