$GroupInfo = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.DataGridView]$MembersView = $null
[System.Windows.Forms.DataGridView]$ErrorsView = $null
[System.Windows.Forms.Button]$CloseDisplay = $null
[System.Windows.Forms.Label]$ErrorLabel = $null
[System.Windows.Forms.Label]$MemberLabel = $null
[System.Windows.Forms.Button]$PoplateMembers = $null
function InitializeComponent
{
$MembersView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$ErrorsView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$CloseDisplay = (New-Object -TypeName System.Windows.Forms.Button)
$ErrorLabel = (New-Object -TypeName System.Windows.Forms.Label)
$MemberLabel = (New-Object -TypeName System.Windows.Forms.Label)
$PoplateMembers = (New-Object -TypeName System.Windows.Forms.Button)
([System.ComponentModel.ISupportInitialize]$MembersView).BeginInit()
([System.ComponentModel.ISupportInitialize]$ErrorsView).BeginInit()
$GroupInfo.SuspendLayout()
#
#MembersView
#
$MembersView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$MembersView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]72))
$MembersView.Name = [System.String]'MembersView'
$MembersView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]980,[System.Int32]240))
$MembersView.TabIndex = [System.Int32]0
#
#ErrorsView
#
$ErrorsView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$ErrorsView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]341))
$ErrorsView.Name = [System.String]'ErrorsView'
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
$ErrorLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]315))
$ErrorLabel.Name = [System.String]'ErrorLabel'
$ErrorLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]980,[System.Int32]23))
$ErrorLabel.TabIndex = [System.Int32]3
$ErrorLabel.Text = [System.String]'Group License Errors'
$ErrorLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#MemberLabel
#
$MemberLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]46))
$MemberLabel.Name = [System.String]'MemberLabel'
$MemberLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]980,[System.Int32]23))
$MemberLabel.TabIndex = [System.Int32]4
$MemberLabel.Text = [System.String]'Group Members'
$MemberLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#
#PoplateMembers
#
$PoplateMembers.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]587))
$PoplateMembers.Name = [System.String]'PoplateMembers'
$PoplateMembers.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$PoplateMembers.TabIndex = [System.Int32]5
$PoplateMembers.Text = [System.String]'Button1'
$PoplateMembers.UseVisualStyleBackColor = $true
$PoplateMembers.Visible = $false
#
#GroupInfo
#
$GroupInfo.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$GroupInfo.Controls.Add($PoplateMembers)
$GroupInfo.Controls.Add($MemberLabel)
$GroupInfo.Controls.Add($ErrorLabel)
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
Add-Member -InputObject $GroupInfo -Name ErrorLabel -Value $ErrorLabel -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name MemberLabel -Value $MemberLabel -MemberType NoteProperty
Add-Member -InputObject $GroupInfo -Name PoplateMembers -Value $PoplateMembers -MemberType NoteProperty
}
. InitializeComponent
