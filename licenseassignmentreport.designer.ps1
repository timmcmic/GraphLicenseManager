$LicenseAssignmentReport = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Label]$SkuName = $null
[System.Windows.Forms.ComboBox]$ComboBox1 = $null
[System.Windows.Forms.Label]$PlanName = $null
[System.Windows.Forms.ComboBox]$ComboBox2 = $null
[System.Windows.Forms.DataGridView]$DataGridView1 = $null
[System.Windows.Forms.Button]$ReportExitButton = $null
[System.Windows.Forms.Button]$ExportCSV = $null
function InitializeComponent
{
$SkuName = (New-Object -TypeName System.Windows.Forms.Label)
$ComboBox1 = (New-Object -TypeName System.Windows.Forms.ComboBox)
$PlanName = (New-Object -TypeName System.Windows.Forms.Label)
$ComboBox2 = (New-Object -TypeName System.Windows.Forms.ComboBox)
$DataGridView1 = (New-Object -TypeName System.Windows.Forms.DataGridView)
$ReportExitButton = (New-Object -TypeName System.Windows.Forms.Button)
$ExportCSV = (New-Object -TypeName System.Windows.Forms.Button)
([System.ComponentModel.ISupportInitialize]$DataGridView1).BeginInit()
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
#ComboBox1
#
$ComboBox1.FormattingEnabled = $true
$ComboBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]115,[System.Int32]19))
$ComboBox1.Name = [System.String]'ComboBox1'
$ComboBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]351,[System.Int32]21))
$ComboBox1.TabIndex = [System.Int32]1
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
#ComboBox2
#
$ComboBox2.FormattingEnabled = $true
$ComboBox2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]578,[System.Int32]19))
$ComboBox2.Name = [System.String]'ComboBox2'
$ComboBox2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]351,[System.Int32]21))
$ComboBox2.TabIndex = [System.Int32]3
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
$ReportExitButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]584))
$ReportExitButton.Name = [System.String]'ReportExitButton'
$ReportExitButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]454,[System.Int32]23))
$ReportExitButton.TabIndex = [System.Int32]5
$ReportExitButton.Text = [System.String]'Exit'
$ReportExitButton.UseVisualStyleBackColor = $true
#
#ExportCSV
#
$ExportCSV.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]540,[System.Int32]584))
$ExportCSV.Name = [System.String]'ExportCSV'
$ExportCSV.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]454,[System.Int32]23))
$ExportCSV.TabIndex = [System.Int32]6
$ExportCSV.Text = [System.String]'Export to CSV'
$ExportCSV.UseVisualStyleBackColor = $true
#
#LicenseAssignmentReport
#
$LicenseAssignmentReport.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$LicenseAssignmentReport.Controls.Add($ExportCSV)
$LicenseAssignmentReport.Controls.Add($ReportExitButton)
$LicenseAssignmentReport.Controls.Add($DataGridView1)
$LicenseAssignmentReport.Controls.Add($ComboBox2)
$LicenseAssignmentReport.Controls.Add($PlanName)
$LicenseAssignmentReport.Controls.Add($ComboBox1)
$LicenseAssignmentReport.Controls.Add($SkuName)
$LicenseAssignmentReport.Name = [System.String]'LicenseAssignmentReport'
$LicenseAssignmentReport.Text = [System.String]'License Assignment Report'
([System.ComponentModel.ISupportInitialize]$DataGridView1).EndInit()
$LicenseAssignmentReport.ResumeLayout($false)
Add-Member -InputObject $LicenseAssignmentReport -Name SkuName -Value $SkuName -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ComboBox1 -Value $ComboBox1 -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name PlanName -Value $PlanName -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ComboBox2 -Value $ComboBox2 -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name DataGridView1 -Value $DataGridView1 -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ReportExitButton -Value $ReportExitButton -MemberType NoteProperty
Add-Member -InputObject $LicenseAssignmentReport -Name ExportCSV -Value $ExportCSV -MemberType NoteProperty
}
. InitializeComponent
