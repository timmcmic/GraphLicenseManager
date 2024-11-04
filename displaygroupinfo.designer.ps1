$GroupInfo = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.DataGridView]$MembersView = $null
[System.Windows.Forms.DataGridView]$ErrorsView = $null
[System.Windows.Forms.Button]$CloseDisplay = $null
[System.Windows.Forms.Label]$ErrorLabel = $null
[System.Windows.Forms.Label]$MemberLabel = $null
[System.Windows.Forms.Label]$LicenseProcessingState = $null
[System.Windows.Forms.TextBox]$LicenseTextBox = $null
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.TextBox]$GroupCountBox = $null
[System.Windows.Forms.TextBox]$ErrorCountBox = $null
[System.Windows.Forms.Label]$Label2 = $null
function InitializeComponent
{
$MembersView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$ErrorsView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$CloseDisplay = (New-Object -TypeName System.Windows.Forms.Button)
$ErrorLabel = (New-Object -TypeName System.Windows.Forms.Label)
$MemberLabel = (New-Object -TypeName System.Windows.Forms.Label)
$LicenseProcessingState = (New-Object -TypeName System.Windows.Forms.Label)
$LicenseTextBox = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$GroupCountBox = (New-Object -TypeName System.Windows.Forms.TextBox)
$ErrorCountBox = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label2 = (New-Object -TypeName System.Windows.Forms.Label)
([System.ComponentModel.ISupportInitialize]$MembersView).BeginInit()
([System.ComponentModel.ISupportInitialize]$ErrorsView).BeginInit()
$GroupInfo.SuspendLayout()
#
#MembersView
#
$MembersView.AllowUserToAddRows = $false
$MembersView.AllowUserToDeleteRows = $false
$MembersView.AllowUserToResizeColumns = $false
$MembersView.AllowUserToResizeRows = $false
$MembersView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$MembersView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]35))
$MembersView.Name = [System.String]'MembersView'
$MembersView.RowHeadersWidthSizeMode = [System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode]::AutoSizeToAllHeaders
$MembersView.SelectionMode = [System.Windows.Forms.DataGridViewSelectionMode]::FullRowSelect
$MembersView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]980,[System.Int32]240))
$MembersView.TabIndex = [System.Int32]0
#
#ErrorsView
#
$ErrorsView.AllowUserToAddRows = $false
$ErrorsView.AllowUserToDeleteRows = $false
$ErrorsView.AllowUserToResizeColumns = $false
$ErrorsView.AllowUserToResizeRows = $false
$ErrorsView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$ErrorsView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]304))
$ErrorsView.Name = [System.String]'ErrorsView'
$ErrorsView.RowHeadersWidthSizeMode = [System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode]::AutoSizeToAllHeaders
$ErrorsView.SelectionMode = [System.Windows.Forms.DataGridViewSelectionMode]::FullRowSelect
$ErrorsView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]980,[System.Int32]240))
$ErrorsView.TabIndex = [System.Int32]1
#
#CloseDisplay
#
$CloseDisplay.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]334,[System.Int32]587))
$CloseDisplay.Name = [System.String]'CloseDisplay'
$CloseDisplay.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]348,[System.Int32]23))
$CloseDisplay.TabIndex = [System.Int32]2
$CloseDisplay.Text = [System.String]'Close Display'
$CloseDisplay.UseVisualStyleBackColor = $true
$CloseDisplay.add_Click($CloseDisplay_Click)
#
#ErrorLabel
#
$ErrorLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]278))
$ErrorLabel.Name = [System.String]'ErrorLabel'
$ErrorLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]980,[System.Int32]23))
$ErrorLabel.TabIndex = [System.Int32]3
$ErrorLabel.Text = [System.String]'Group License Errors'
$ErrorLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#MemberLabel
#
$MemberLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]9))
$MemberLabel.Name = [System.String]'MemberLabel'
$MemberLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]980,[System.Int32]23))
$MemberLabel.TabIndex = [System.Int32]4
$MemberLabel.Text = [System.String]'Group Members'
$MemberLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#LicenseProcessingState
#
$LicenseProcessingState.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]547))
$LicenseProcessingState.Name = [System.String]'LicenseProcessingState'
$LicenseProcessingState.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]130,[System.Int32]25))
$LicenseProcessingState.TabIndex = [System.Int32]5
$LicenseProcessingState.Text = [System.String]'License Processing State'
$LicenseProcessingState.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#LicenseTextBox
#
$LicenseTextBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]148,[System.Int32]549))
$LicenseTextBox.Name = [System.String]'LicenseTextBox'
$LicenseTextBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]130,[System.Int32]21))
$LicenseTextBox.TabIndex = [System.Int32]6
#
#Label1
#
$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]358,[System.Int32]547))
$Label1.Name = [System.String]'Label1'
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]130,[System.Int32]25))
$Label1.TabIndex = [System.Int32]7
$Label1.Text = [System.String]'Group Member Count'
$Label1.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#GroupCountBox
#
$GroupCountBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]494,[System.Int32]549))
$GroupCountBox.Name = [System.String]'GroupCountBox'
$GroupCountBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]130,[System.Int32]21))
$GroupCountBox.TabIndex = [System.Int32]8
#
#ErrorCountBox
#
$ErrorCountBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]864,[System.Int32]550))
$ErrorCountBox.Name = [System.String]'ErrorCountBox'
$ErrorCountBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]130,[System.Int32]21))
$ErrorCountBox.TabIndex = [System.Int32]9
#
#Label2
#
$Label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]728,[System.Int32]547))
$Label2.Name = [System.String]'Label2'
$Label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]130,[System.Int32]25))
$Label2.TabIndex = [System.Int32]10
$Label2.Text = [System.String]'Group Error Count'
$Label2.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#GroupInfo
#
$GroupInfo.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$GroupInfo.Controls.Add($Label2)
$GroupInfo.Controls.Add($ErrorCountBox)
$GroupInfo.Controls.Add($GroupCountBox)
$GroupInfo.Controls.Add($Label1)
$GroupInfo.Controls.Add($LicenseTextBox)
$GroupInfo.Controls.Add($LicenseProcessingState)
$GroupInfo.Controls.Add($MemberLabel)
$GroupInfo.Controls.Add($ErrorLabel)
$GroupInfo.Controls.Add($CloseDisplay)
$GroupInfo.Controls.Add($ErrorsView)
$GroupInfo.Controls.Add($MembersView)
$GroupInfo.Text = [System.String]'Display Group Information'
$GroupInfo.add_Load($GroupInfo_Load)
([System.ComponentModel.ISupportInitialize]$MembersView).EndInit()
([System.ComponentModel.ISupportInitialize]$ErrorsView).EndInit()
$GroupInfo.ResumeLayout($false)
$GroupInfo.PerformLayout()
Add-Member -InputObject $GroupInfo -Name MembersView -Value $MembersView -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name ErrorsView -Value $ErrorsView -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name CloseDisplay -Value $CloseDisplay -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name ErrorLabel -Value $ErrorLabel -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name MemberLabel -Value $MemberLabel -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name LicenseProcessingState -Value $LicenseProcessingState -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name LicenseTextBox -Value $LicenseTextBox -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name GroupCountBox -Value $GroupCountBox -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name ErrorCountBox -Value $ErrorCountBox -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name Label2 -Value $Label2 -MemberType NoteProperty
}
. InitializeComponent
