$GroupInfo = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.DataGridView]$MembersView = $null
[System.Windows.Forms.DataGridView]$ErrorsView = $null
[System.Windows.Forms.Button]$CloseDisplay = $null
function InitializeComponent
{
$MembersView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$ErrorsView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$CloseDisplay = (New-Object -TypeName System.Windows.Forms.Button)
([System.ComponentModel.ISupportInitialize]$MembersView).BeginInit()
([System.ComponentModel.ISupportInitialize]$ErrorsView).BeginInit()
$GroupInfo.SuspendLayout()
#
#MembersView
#
$MembersView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$MembersView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]101))
$MembersView.Name = [System.String]'MembersView'
$MembersView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]490,[System.Int32]480))
$MembersView.TabIndex = [System.Int32]0
$MembersView.Visible = $false
#
#ErrorsView
#
$ErrorsView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$ErrorsView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]514,[System.Int32]101))
$ErrorsView.Name = [System.String]'ErrorsView'
$ErrorsView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]490,[System.Int32]480))
$ErrorsView.TabIndex = [System.Int32]1
$ErrorsView.Visible = $false
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
#GroupInfo
#
$GroupInfo.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$GroupInfo.Controls.Add($CloseDisplay)
$GroupInfo.Controls.Add($ErrorsView)
$GroupInfo.Controls.Add($MembersView)
$GroupInfo.Text = [System.String]'Display Group Information'
([System.ComponentModel.ISupportInitialize]$MembersView).EndInit()
([System.ComponentModel.ISupportInitialize]$ErrorsView).EndInit()
$GroupInfo.ResumeLayout($false)
Add-Member -InputObject $GroupInfo -Name MembersView -Value $MembersView -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name ErrorsView -Value $ErrorsView -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name CloseDisplay -Value $CloseDisplay -MemberType NoteProperty
}
. InitializeComponent
