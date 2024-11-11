$LicenseAssignmentReport = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Label]$SkuName = $null
[System.Windows.Forms.ComboBox]$SkuBox = $null
[System.Windows.Forms.DataGridView]$UserLicenseView = $null
[System.Windows.Forms.Button]$ReportExitButton = $null
[System.Windows.Forms.Button]$ExportCSV = $null
[System.Windows.Forms.StatusStrip]$StatusStrip1 = $null
[System.Windows.Forms.ToolStripStatusLabel]$ToolStripStatusLabel1 = $null
[System.Windows.Forms.CheckedListBox]$PropertyBox = $null
[System.Windows.Forms.Button]$RefreshButton = $null
function InitializeComponent
{
$SkuName = (New-Object -TypeName System.Windows.Forms.Label)
$SkuBox = (New-Object -TypeName System.Windows.Forms.ComboBox)
$UserLicenseView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$ReportExitButton = (New-Object -TypeName System.Windows.Forms.Button)
$ExportCSV = (New-Object -TypeName System.Windows.Forms.Button)
$StatusStrip1 = (New-Object -TypeName System.Windows.Forms.StatusStrip)
$ToolStripStatusLabel1 = (New-Object -TypeName System.Windows.Forms.ToolStripStatusLabel)
$PropertyBox = (New-Object -TypeName System.Windows.Forms.CheckedListBox)
$RefreshButton = (New-Object -TypeName System.Windows.Forms.Button)
([System.ComponentModel.ISupportInitialize]$UserLicenseView).BeginInit()
$StatusStrip1.SuspendLayout()
$LicenseAssignmentReport.SuspendLayout()
#
#SkuName
#
$SkuName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]249,[System.Int32]17))
$SkuName.Name = [System.String]'SkuName'
$SkuName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$SkuName.TabIndex = [System.Int32]0
$SkuName.Text = [System.String]'Sku Name'
$SkuName.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#SkuBox
#
$SkuBox.FormattingEnabled = $true
$SkuBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]355,[System.Int32]19))
$SkuBox.Name = [System.String]'SkuBox'
$SkuBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]351,[System.Int32]21))
$SkuBox.TabIndex = [System.Int32]1
#
#UserLicenseView
#
$UserLicenseView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$UserLicenseView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]55))
$UserLicenseView.Name = [System.String]'UserLicenseView'
$UserLicenseView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]728,[System.Int32]500))
$UserLicenseView.TabIndex = [System.Int32]4
#
#ReportExitButton
#
$ReportExitButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]570))
$ReportExitButton.Name = [System.String]'ReportExitButton'
$ReportExitButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]454,[System.Int32]23))
$ReportExitButton.TabIndex = [System.Int32]5
$ReportExitButton.Text = [System.String]'Exit'
$ReportExitButton.UseVisualStyleBackColor = $true
#
#ExportCSV
#
$ExportCSV.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]540,[System.Int32]570))
$ExportCSV.Name = [System.String]'ExportCSV'
$ExportCSV.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]454,[System.Int32]23))
$ExportCSV.TabIndex = [System.Int32]6
$ExportCSV.Text = [System.String]'Export to CSV'
$ExportCSV.UseVisualStyleBackColor = $true
#
#StatusStrip1
#
$StatusStrip1.Items.AddRange([System.Windows.Forms.ToolStripItem[]]@($ToolStripStatusLabel1))
$StatusStrip1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]597))
$StatusStrip1.Name = [System.String]'StatusStrip1'
$StatusStrip1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]22))
$StatusStrip1.TabIndex = [System.Int32]7
$StatusStrip1.Text = [System.String]'StatusStrip1'
#
#ToolStripStatusLabel1
#
$ToolStripStatusLabel1.Name = [System.String]'ToolStripStatusLabel1'
$ToolStripStatusLabel1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]17))
#
#PropertyBox
#
$PropertyBox.CheckOnClick = $true
$PropertyBox.FormattingEnabled = $true
$PropertyBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]746,[System.Int32]55))
$PropertyBox.Name = [System.String]'PropertyBox'
$PropertyBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]248,[System.Int32]468))
$PropertyBox.TabIndex = [System.Int32]8
$PropertyBox.add_SelectedIndexChanged($PropertyBox_SelectedIndexChanged)
#
#RefreshButton
#
$RefreshButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]746,[System.Int32]532))
$RefreshButton.Name = [System.String]'RefreshButton'
$RefreshButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]248,[System.Int32]23))
$RefreshButton.TabIndex = [System.Int32]9
$RefreshButton.Text = [System.String]'Refresh Data'
$RefreshButton.UseVisualStyleBackColor = $true
$RefreshButton.add_Click($RefreshButton_Click)
#
#LicenseAssignmentReport
#
$LicenseAssignmentReport.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$LicenseAssignmentReport.Controls.Add($RefreshButton)
$LicenseAssignmentReport.Controls.Add($PropertyBox)
$LicenseAssignmentReport.Controls.Add($StatusStrip1)
$LicenseAssignmentReport.Controls.Add($ExportCSV)
$LicenseAssignmentReport.Controls.Add($ReportExitButton)
$LicenseAssignmentReport.Controls.Add($UserLicenseView)
$LicenseAssignmentReport.Controls.Add($SkuBox)
$LicenseAssignmentReport.Controls.Add($SkuName)
$LicenseAssignmentReport.Text = [System.String]'License Assignment Report'
$LicenseAssignmentReport.add_Load($LicenseAssignmentReport_Load)
([System.ComponentModel.ISupportInitialize]$UserLicenseView).EndInit()
$StatusStrip1.ResumeLayout($false)
$StatusStrip1.PerformLayout()
$LicenseAssignmentReport.ResumeLayout($false)
$LicenseAssignmentReport.PerformLayout()
Add-Member -InputObject $LicenseAssignmentReport -Name SkuName -Value $SkuName -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name SkuBox -Value $SkuBox -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name UserLicenseView -Value $UserLicenseView -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ReportExitButton -Value $ReportExitButton -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ExportCSV -Value $ExportCSV -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name StatusStrip1 -Value $StatusStrip1 -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ToolStripStatusLabel1 -Value $ToolStripStatusLabel1 -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name PropertyBox -Value $PropertyBox -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name RefreshButton -Value $RefreshButton -MemberType NoteProperty
}
. InitializeComponent
