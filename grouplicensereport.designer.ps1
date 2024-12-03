$GroupLicenseReport = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.DataGridView]$GroupReport = $null
function InitializeComponent
{
$GroupReport = (New-Object -TypeName System.Windows.Forms.DataGridView)
([System.ComponentModel.ISupportInitialize]$GroupReport).BeginInit()
$GroupLicenseReport.SuspendLayout()
#
#GroupReport
#
$GroupReport.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$GroupReport.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]12))
$GroupReport.Name = [System.String]'GroupReport'
$GroupReport.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]982,[System.Int32]521))
$GroupReport.TabIndex = [System.Int32]0


#
#GroupLicenseReport
#
$GroupLicenseReport.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$GroupLicenseReport.Controls.Add($GroupReport)
$GroupLicenseReport.Text = [System.String]'Group License Report'
([System.ComponentModel.ISupportInitialize]$GroupReport).EndInit()
$GroupLicenseReport.ResumeLayout($false)
Add-Member -InputObject $GroupLicenseReport -Name GroupReport -Value $GroupReport -MemberType NoteProperty
}
$GroupLicenseReport.add_Load($GroupInfo_Load)
. InitializeComponent