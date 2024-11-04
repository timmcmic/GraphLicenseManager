$GroupInformation = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$ExitDisplayButton = $null
[System.Windows.Forms.DataGridView]$MembersView = $null
[System.Windows.Forms.DataGridView]$ErrorsView = $null
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.Label]$Label2 = $null
[System.Windows.Forms.Label]$Label3 = $null
[System.Windows.Forms.TextBox]$MemberBox = $null
[System.Windows.Forms.TextBox]$SuccessfulBox = $null
[System.Windows.Forms.TextBox]$ErrorBox = $null
function InitializeComponent
{
$ExitDisplayButton = (New-Object -TypeName System.Windows.Forms.Button)
$MembersView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$ErrorsView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$Label2 = (New-Object -TypeName System.Windows.Forms.Label)
$Label3 = (New-Object -TypeName System.Windows.Forms.Label)
$MemberBox = (New-Object -TypeName System.Windows.Forms.TextBox)
$SuccessfulBox = (New-Object -TypeName System.Windows.Forms.TextBox)
$ErrorBox = (New-Object -TypeName System.Windows.Forms.TextBox)
([System.ComponentModel.ISupportInitialize]$MembersView).BeginInit()
([System.ComponentModel.ISupportInitialize]$ErrorsView).BeginInit()
$GroupInformation.SuspendLayout()
#
#ExitDisplayButton
#
$ExitDisplayButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]339,[System.Int32]514))
$ExitDisplayButton.Name = [System.String]'ExitDisplayButton'
$ExitDisplayButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]264,[System.Int32]23))
$ExitDisplayButton.TabIndex = [System.Int32]0
$ExitDisplayButton.Text = [System.String]'Close Display'
$ExitDisplayButton.UseVisualStyleBackColor = $true
$ExitDisplayButton.add_Click($ExitDisplayButton_Click)
#
#MembersView
#
$MembersView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$MembersView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]150))
$MembersView.Name = [System.String]'MembersView'
$MembersView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]452,[System.Int32]358))
$MembersView.TabIndex = [System.Int32]1
#
#ErrorsView
#
$ErrorsView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$ErrorsView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]470,[System.Int32]150))
$ErrorsView.Name = [System.String]'ErrorsView'
$ErrorsView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]468,[System.Int32]358))
$ErrorsView.TabIndex = [System.Int32]2
#
#Label1
#
$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]9))
$Label1.Name = [System.String]'Label1'
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]246,[System.Int32]23))
$Label1.TabIndex = [System.Int32]3
$Label1.Text = [System.String]'Number of Group Members'
$Label1.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#Label2
#
$Label2.ForeColor = [System.Drawing.SystemColors]::ControlText
$Label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]32))
$Label2.Name = [System.String]'Label2'
$Label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]246,[System.Int32]23))
$Label2.TabIndex = [System.Int32]4
$Label2.Text = [System.String]'Number of Licenses Processed Successfully'
$Label2.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#Label3
#
$Label3.ImageAlign = [System.Drawing.ContentAlignment]::MiddleRight
$Label3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]55))
$Label3.Name = [System.String]'Label3'
$Label3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]246,[System.Int32]23))
$Label3.TabIndex = [System.Int32]5
$Label3.Text = [System.String]'Number of Licenses Processed Errors'
$Label3.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#MemberBox
#
$MemberBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]264,[System.Int32]11))
$MemberBox.Name = [System.String]'MemberBox'
$MemberBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]21))
$MemberBox.TabIndex = [System.Int32]6
#
#SuccessfulBox
#
$SuccessfulBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]264,[System.Int32]34))
$SuccessfulBox.Name = [System.String]'SuccessfulBox'
$SuccessfulBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]21))
$SuccessfulBox.TabIndex = [System.Int32]7
#
#ErrorBox
#
$ErrorBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]264,[System.Int32]57))
$ErrorBox.Name = [System.String]'ErrorBox'
$ErrorBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]21))
$ErrorBox.TabIndex = [System.Int32]8
#
#GroupInformation
#
$GroupInformation.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]950,[System.Int32]572))
$GroupInformation.Controls.Add($ErrorBox)
$GroupInformation.Controls.Add($SuccessfulBox)
$GroupInformation.Controls.Add($MemberBox)
$GroupInformation.Controls.Add($Label3)
$GroupInformation.Controls.Add($Label2)
$GroupInformation.Controls.Add($Label1)
$GroupInformation.Controls.Add($ErrorsView)
$GroupInformation.Controls.Add($MembersView)
$GroupInformation.Controls.Add($ExitDisplayButton)
$GroupInformation.Name = [System.String]'GroupInformation'
$GroupInformation.Text = [System.String]'Display Group Information'
([System.ComponentModel.ISupportInitialize]$MembersView).EndInit()
([System.ComponentModel.ISupportInitialize]$ErrorsView).EndInit()
$GroupInformation.ResumeLayout($false)
$GroupInformation.PerformLayout()
Add-Member -InputObject $GroupInformation -Name ExitDisplayButton -Value $ExitDisplayButton -MemberType NoteProperty
Add-Member -InputObject $GroupInformation -Name MembersView -Value $MembersView -MemberType NoteProperty
Add-Member -InputObject $GroupInformation -Name ErrorsView -Value $ErrorsView -MemberType NoteProperty
Add-Member -InputObject $GroupInformation -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $GroupInformation -Name Label2 -Value $Label2 -MemberType NoteProperty
Add-Member -InputObject $GroupInformation -Name Label3 -Value $Label3 -MemberType NoteProperty
Add-Member -InputObject $GroupInformation -Name MemberBox -Value $MemberBox -MemberType NoteProperty
Add-Member -InputObject $GroupInformation -Name SuccessfulBox -Value $SuccessfulBox -MemberType NoteProperty
Add-Member -InputObject $GroupInformation -Name ErrorBox -Value $ErrorBox -MemberType NoteProperty
}
. InitializeComponent
