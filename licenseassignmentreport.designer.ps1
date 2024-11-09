$LicenseAssignmentReport = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Label]$SkuName = $null
[System.Windows.Forms.ComboBox]$SkuBox = $null
[System.Windows.Forms.Label]$PlanName = $null
[System.Windows.Forms.ComboBox]$PlanBox = $null
[System.Windows.Forms.DataGridView]$DataGridView1 = $null
[System.Windows.Forms.Button]$ReportExitButton = $null
[System.Windows.Forms.Button]$ExportCSV = $null
[System.Windows.Forms.StatusStrip]$StatusStrip1 = $null
[System.Windows.Forms.ToolStripStatusLabel]$ToolStripStatusLabel1 = $null
function InitializeComponent
{
$SkuName = (New-Object -TypeName System.Windows.Forms.Label)
$SkuBox = (New-Object -TypeName System.Windows.Forms.ComboBox)
$PlanName = (New-Object -TypeName System.Windows.Forms.Label)
$PlanBox = (New-Object -TypeName System.Windows.Forms.ComboBox)
$DataGridView1 = (New-Object -TypeName System.Windows.Forms.DataGridView)
$ReportExitButton = (New-Object -TypeName System.Windows.Forms.Button)
$ExportCSV = (New-Object -TypeName System.Windows.Forms.Button)
$StatusStrip1 = (New-Object -TypeName System.Windows.Forms.StatusStrip)
$ToolStripStatusLabel1 = (New-Object -TypeName System.Windows.Forms.ToolStripStatusLabel)
([System.ComponentModel.ISupportInitialize]$DataGridView1).BeginInit()
$StatusStrip1.SuspendLayout()
$LicenseAssignmentReport.SuspendLayout()
#
#SkuName
#
$SkuName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]19))
$SkuName.Name = [System.String]'SkuName'
$SkuName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$SkuName.TabIndex = [System.Int32]0
$SkuName.Text = [System.String]'Sku Name'
$SkuName.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#SkuBox
#
$SkuBox.FormattingEnabled = $true
$SkuBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]115,[System.Int32]19))
$SkuBox.Name = [System.String]'SkuBox'
$SkuBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]351,[System.Int32]21))
$SkuBox.TabIndex = [System.Int32]1
#
#PlanName
#
$PlanName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]472,[System.Int32]17))
$PlanName.Name = [System.String]'PlanName'
$PlanName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$PlanName.TabIndex = [System.Int32]2
$PlanName.Text = [System.String]'Plan Name'
$PlanName.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#PlanBox
#
$PlanBox.FormattingEnabled = $true
$PlanBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]578,[System.Int32]19))
$PlanBox.Name = [System.String]'PlanBox'
$PlanBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]351,[System.Int32]21))
$PlanBox.TabIndex = [System.Int32]3
#
#DataGridView1
#
$DataGridView1.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$DataGridView1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]55))
$DataGridView1.Name = [System.String]'DataGridView1'
$DataGridView1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]982,[System.Int32]509))
$DataGridView1.TabIndex = [System.Int32]4
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
#LicenseAssignmentReport
#
$LicenseAssignmentReport.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$LicenseAssignmentReport.Controls.Add($StatusStrip1)
$LicenseAssignmentReport.Controls.Add($ExportCSV)
$LicenseAssignmentReport.Controls.Add($ReportExitButton)
$LicenseAssignmentReport.Controls.Add($DataGridView1)
$LicenseAssignmentReport.Controls.Add($PlanBox)
$LicenseAssignmentReport.Controls.Add($PlanName)
$LicenseAssignmentReport.Controls.Add($SkuBox)
$LicenseAssignmentReport.Controls.Add($SkuName)
$LicenseAssignmentReport.Text = [System.String]'License Assignment Report'
$LicenseAssignmentReport.add_Load($LicenseAssignmentReport_Load)
([System.ComponentModel.ISupportInitialize]$DataGridView1).EndInit()
$StatusStrip1.ResumeLayout($false)
$StatusStrip1.PerformLayout()
$LicenseAssignmentReport.ResumeLayout($false)
$LicenseAssignmentReport.PerformLayout()
Add-Member -InputObject $LicenseAssignmentReport -Name SkuName -Value $SkuName -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name SkuBox -Value $SkuBox -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name PlanName -Value $PlanName -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name PlanBox -Value $PlanBox -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name DataGridView1 -Value $DataGridView1 -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ReportExitButton -Value $ReportExitButton -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ExportCSV -Value $ExportCSV -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name StatusStrip1 -Value $StatusStrip1 -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ToolStripStatusLabel1 -Value $ToolStripStatusLabel1 -MemberType NoteProperty
}
. InitializeComponent
