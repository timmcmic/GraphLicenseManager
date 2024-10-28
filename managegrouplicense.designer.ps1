$Form2 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.TextBox]$GroupObjectIDText = $null
[System.Windows.Forms.Button]$Button1 = $null
[System.Windows.Forms.Label]$DisplayName = $null
[System.Windows.Forms.TextBox]$DisplayNameText = $null
[System.Windows.Forms.Label]$ExpirationDateTime = $null
[System.Windows.Forms.TextBox]$ExpirationDateTimeText = $null
[System.Windows.Forms.Label]$Mail = $null
[System.Windows.Forms.TextBox]$MailText = $null
[System.Windows.Forms.Label]$GroupTypes = $null
[System.Windows.Forms.TextBox]$GroupTypeText = $null
[System.Windows.Forms.Label]$MembershipRule = $null
[System.Windows.Forms.TextBox]$MembershipRuleText = $null
[System.Windows.Forms.Label]$GroupMembersName = $null
[System.Windows.Forms.DataGridView]$GroupMembersView = $null
[System.Windows.Forms.Label]$LicenseLabel = $null
[System.Windows.Forms.TreeView]$LicenseList = $null
[System.Windows.Forms.Button]$exit = $null
[System.Windows.Forms.Button]$commit = $null
[System.Windows.Forms.StatusStrip]$StatusStrip1 = $null
[System.Windows.Forms.ToolStripStatusLabel]$ToolLabel = $null
[System.Windows.Forms.DataGridView]$DataGridView1 = $null
[System.Windows.Forms.Label]$LicenseProcessingLabel = $null
[System.Windows.Forms.TextBox]$LicenseProcessingText = $null
function InitializeComponent
{
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$GroupObjectIDText = (New-Object -TypeName System.Windows.Forms.TextBox)
$Button1 = (New-Object -TypeName System.Windows.Forms.Button)
$DisplayName = (New-Object -TypeName System.Windows.Forms.Label)
$DisplayNameText = (New-Object -TypeName System.Windows.Forms.TextBox)
$ExpirationDateTime = (New-Object -TypeName System.Windows.Forms.Label)
$ExpirationDateTimeText = (New-Object -TypeName System.Windows.Forms.TextBox)
$Mail = (New-Object -TypeName System.Windows.Forms.Label)
$MailText = (New-Object -TypeName System.Windows.Forms.TextBox)
$GroupTypes = (New-Object -TypeName System.Windows.Forms.Label)
$GroupTypeText = (New-Object -TypeName System.Windows.Forms.TextBox)
$MembershipRule = (New-Object -TypeName System.Windows.Forms.Label)
$MembershipRuleText = (New-Object -TypeName System.Windows.Forms.TextBox)
$GroupMembersName = (New-Object -TypeName System.Windows.Forms.Label)
$GroupMembersView = (New-Object -TypeName System.Windows.Forms.DataGridView)
$LicenseLabel = (New-Object -TypeName System.Windows.Forms.Label)
$LicenseList = (New-Object -TypeName System.Windows.Forms.TreeView)
$exit = (New-Object -TypeName System.Windows.Forms.Button)
$commit = (New-Object -TypeName System.Windows.Forms.Button)
$StatusStrip1 = (New-Object -TypeName System.Windows.Forms.StatusStrip)
$ToolLabel = (New-Object -TypeName System.Windows.Forms.ToolStripStatusLabel)
$DataGridView1 = (New-Object -TypeName System.Windows.Forms.DataGridView)
$LicenseProcessingLabel = (New-Object -TypeName System.Windows.Forms.Label)
$LicenseProcessingText = (New-Object -TypeName System.Windows.Forms.TextBox)
([System.ComponentModel.ISupportInitialize]$GroupMembersView).BeginInit()
$StatusStrip1.SuspendLayout()
([System.ComponentModel.ISupportInitialize]$DataGridView1).BeginInit()
$Form2.SuspendLayout()
#
#Label1
#
$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]20))
$Label1.Name = [System.String]'Label1'
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]193,[System.Int32]23))
$Label1.TabIndex = [System.Int32]0
$Label1.Text = [System.String]'Group ObjectID:'
$Label1.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#GroupObjectIDText
#
$GroupObjectIDText.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]211,[System.Int32]22))
$GroupObjectIDText.Name = [System.String]'GroupObjectIDText'
$GroupObjectIDText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]702,[System.Int32]21))
$GroupObjectIDText.TabIndex = [System.Int32]1
#
#Button1
#
$Button1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]919,[System.Int32]22))
$Button1.Name = [System.String]'Button1'
$Button1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$Button1.TabIndex = [System.Int32]2
$Button1.Text = [System.String]'Search'
$Button1.UseVisualStyleBackColor = $true
$Button1.add_Click($Button1_Click)
#
#DisplayName
#
$DisplayName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]47))
$DisplayName.Name = [System.String]'DisplayName'
$DisplayName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]193,[System.Int32]23))
$DisplayName.TabIndex = [System.Int32]3
$DisplayName.Text = [System.String]'DisplayName'
$DisplayName.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$DisplayName.Visible = $false
#
#DisplayNameText
#
$DisplayNameText.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]211,[System.Int32]49))
$DisplayNameText.Name = [System.String]'DisplayNameText'
$DisplayNameText.ReadOnly = $true
$DisplayNameText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]702,[System.Int32]21))
$DisplayNameText.TabIndex = [System.Int32]4
$DisplayNameText.Visible = $false
#
#ExpirationDateTime
#
$ExpirationDateTime.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]73))
$ExpirationDateTime.Name = [System.String]'ExpirationDateTime'
$ExpirationDateTime.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]193,[System.Int32]23))
$ExpirationDateTime.TabIndex = [System.Int32]5
$ExpirationDateTime.Text = [System.String]'ExpirationDateTime:'
$ExpirationDateTime.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$ExpirationDateTime.Visible = $false
#
#ExpirationDateTimeText
#
$ExpirationDateTimeText.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]211,[System.Int32]75))
$ExpirationDateTimeText.Name = [System.String]'ExpirationDateTimeText'
$ExpirationDateTimeText.ReadOnly = $true
$ExpirationDateTimeText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]702,[System.Int32]21))
$ExpirationDateTimeText.TabIndex = [System.Int32]6
$ExpirationDateTimeText.Visible = $false
#
#Mail
#
$Mail.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]100))
$Mail.Name = [System.String]'Mail'
$Mail.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]193,[System.Int32]23))
$Mail.TabIndex = [System.Int32]7
$Mail.Text = [System.String]'Mail:'
$Mail.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$Mail.Visible = $false
#
#MailText
#
$MailText.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]211,[System.Int32]102))
$MailText.Name = [System.String]'MailText'
$MailText.ReadOnly = $true
$MailText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]702,[System.Int32]21))
$MailText.TabIndex = [System.Int32]8
$MailText.Visible = $false
#
#GroupTypes
#
$GroupTypes.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]123))
$GroupTypes.Name = [System.String]'GroupTypes'
$GroupTypes.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]193,[System.Int32]23))
$GroupTypes.TabIndex = [System.Int32]9
$GroupTypes.Text = [System.String]'GroupTypes:'
$GroupTypes.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$GroupTypes.Visible = $false
#
#GroupTypeText
#
$GroupTypeText.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]211,[System.Int32]125))
$GroupTypeText.Name = [System.String]'GroupTypeText'
$GroupTypeText.ReadOnly = $true
$GroupTypeText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]702,[System.Int32]21))
$GroupTypeText.TabIndex = [System.Int32]10
$GroupTypeText.Visible = $false
#
#MembershipRule
#
$MembershipRule.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]146))
$MembershipRule.Name = [System.String]'MembershipRule'
$MembershipRule.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]193,[System.Int32]23))
$MembershipRule.TabIndex = [System.Int32]11
$MembershipRule.Text = [System.String]'MembershipRule:'
$MembershipRule.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$MembershipRule.Visible = $false
#
#MembershipRuleText
#
$MembershipRuleText.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]211,[System.Int32]148))
$MembershipRuleText.Name = [System.String]'MembershipRuleText'
$MembershipRuleText.ReadOnly = $true
$MembershipRuleText.ScrollBars = [System.Windows.Forms.ScrollBars]::Both
$MembershipRuleText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]702,[System.Int32]21))
$MembershipRuleText.TabIndex = [System.Int32]12
$MembershipRuleText.Visible = $false
#
#GroupMembersName
#
$GroupMembersName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]530))
$GroupMembersName.Name = [System.String]'GroupMembersName'
$GroupMembersName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]10,[System.Int32]23))
$GroupMembersName.TabIndex = [System.Int32]14
$GroupMembersName.Text = [System.String]'Group Members'
$GroupMembersName.TextAlign = [System.Drawing.ContentAlignment]::TopCenter
$GroupMembersName.Visible = $false
$GroupMembersName.add_Click($GroupMembersName_Click)
#
#GroupMembersView
#
$GroupMembersView.AutoSizeColumnsMode = [System.Windows.Forms.DataGridViewAutoSizeColumnsMode]::AllCells
$GroupMembersView.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$GroupMembersView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]556))
$GroupMembersView.MultiSelect = $false
$GroupMembersView.Name = [System.String]'GroupMembersView'
$GroupMembersView.ReadOnly = $true
$GroupMembersView.RowHeadersVisible = $false
$GroupMembersView.SelectionMode = [System.Windows.Forms.DataGridViewSelectionMode]::CellSelect
$GroupMembersView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]10,[System.Int32]10))
$GroupMembersView.TabIndex = [System.Int32]15
$GroupMembersView.Visible = $false
#
#LicenseLabel
#
$LicenseLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]200))
$LicenseLabel.Name = [System.String]'LicenseLabel'
$LicenseLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]982,[System.Int32]23))
$LicenseLabel.TabIndex = [System.Int32]17
$LicenseLabel.Text = [System.String]'Licenses'
$LicenseLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$LicenseLabel.Visible = $false
#
#LicenseList
#
$LicenseList.CheckBoxes = $true
$LicenseList.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]226))
$LicenseList.Name = [System.String]'LicenseList'
$LicenseList.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]488,[System.Int32]339))
$LicenseList.TabIndex = [System.Int32]18
$LicenseList.Visible = $false
#
#exit
#
$exit.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]572))
$exit.Name = [System.String]'exit'
$exit.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]256,[System.Int32]23))
$exit.TabIndex = [System.Int32]19
$exit.Text = [System.String]'Exit Graph License Manager'
$exit.UseVisualStyleBackColor = $true
$exit.add_Click($exit_Click)
#
#commit
#
$commit.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]734,[System.Int32]571))
$commit.Name = [System.String]'commit'
$commit.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]260,[System.Int32]23))
$commit.TabIndex = [System.Int32]20
$commit.Text = [System.String]'Commit License Changes'
$commit.UseVisualStyleBackColor = $true
$commit.Visible = $false
$commit.add_Click($commit_Click)
#
#StatusStrip1
#
$StatusStrip1.Items.AddRange([System.Windows.Forms.ToolStripItem[]]@($ToolLabel))
$StatusStrip1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]597))
$StatusStrip1.Name = [System.String]'StatusStrip1'
$StatusStrip1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]22))
$StatusStrip1.TabIndex = [System.Int32]21
$StatusStrip1.Text = [System.String]'StatusStrip1'
#
#ToolLabel
#
$ToolLabel.Name = [System.String]'ToolLabel'
$ToolLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]17))
#
#DataGridView1
#
$DataGridView1.AllowUserToAddRows = $false
$DataGridView1.AllowUserToDeleteRows = $false
$DataGridView1.AllowUserToResizeColumns = $false
$DataGridView1.AllowUserToResizeRows = $false
$DataGridView1.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$DataGridView1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]506,[System.Int32]226))
$DataGridView1.Name = [System.String]'DataGridView1'
$DataGridView1.RowHeadersVisible = $false
$DataGridView1.RowHeadersWidthSizeMode = [System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode]::AutoSizeToAllHeaders
$DataGridView1.SelectionMode = [System.Windows.Forms.DataGridViewSelectionMode]::FullRowSelect
$DataGridView1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]488,[System.Int32]339))
$DataGridView1.TabIndex = [System.Int32]22
$DataGridView1.Visible = $false
#
#LicenseProcessingLabel
#
$LicenseProcessingLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]174))
$LicenseProcessingLabel.Name = [System.String]'LicenseProcessingLabel'
$LicenseProcessingLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]193,[System.Int32]23))
$LicenseProcessingLabel.TabIndex = [System.Int32]23
$LicenseProcessingLabel.Text = [System.String]'License Processing State:'
$LicenseProcessingLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#LicenseProcessingText
#
$LicenseProcessingText.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]211,[System.Int32]176))
$LicenseProcessingText.Name = [System.String]'LicenseProcessingText'
$LicenseProcessingText.ReadOnly = $true
$LicenseProcessingText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]702,[System.Int32]21))
$LicenseProcessingText.TabIndex = [System.Int32]24
$LicenseProcessingText.Visible = $false
#
#Form2
#
$Form2.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1006,[System.Int32]619))
$Form2.ControlBox = $false
$Form2.Controls.Add($LicenseProcessingText)
$Form2.Controls.Add($LicenseProcessingLabel)
$Form2.Controls.Add($DataGridView1)
$Form2.Controls.Add($StatusStrip1)
$Form2.Controls.Add($commit)
$Form2.Controls.Add($exit)
$Form2.Controls.Add($LicenseList)
$Form2.Controls.Add($LicenseLabel)
$Form2.Controls.Add($GroupMembersView)
$Form2.Controls.Add($GroupMembersName)
$Form2.Controls.Add($MembershipRuleText)
$Form2.Controls.Add($MembershipRule)
$Form2.Controls.Add($GroupTypeText)
$Form2.Controls.Add($GroupTypes)
$Form2.Controls.Add($MailText)
$Form2.Controls.Add($Mail)
$Form2.Controls.Add($ExpirationDateTimeText)
$Form2.Controls.Add($ExpirationDateTime)
$Form2.Controls.Add($DisplayNameText)
$Form2.Controls.Add($DisplayName)
$Form2.Controls.Add($Button1)
$Form2.Controls.Add($GroupObjectIDText)
$Form2.Controls.Add($Label1)
$Form2.MaximizeBox = $false
$Form2.MinimizeBox = $false
$Form2.ShowIcon = $false
$Form2.Text = [System.String]'Graph License Manager'
([System.ComponentModel.ISupportInitialize]$GroupMembersView).EndInit()
$StatusStrip1.ResumeLayout($false)
$StatusStrip1.PerformLayout()
([System.ComponentModel.ISupportInitialize]$DataGridView1).EndInit()
$Form2.ResumeLayout($false)
$Form2.PerformLayout()
Add-Member -InputObject $Form2 -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name GroupObjectIDText -Value $GroupObjectIDText -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name Button1 -Value $Button1 -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name DisplayName -Value $DisplayName -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name DisplayNameText -Value $DisplayNameText -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name ExpirationDateTime -Value $ExpirationDateTime -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name ExpirationDateTimeText -Value $ExpirationDateTimeText -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name Mail -Value $Mail -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name MailText -Value $MailText -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name GroupTypes -Value $GroupTypes -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name GroupTypeText -Value $GroupTypeText -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name MembershipRule -Value $MembershipRule -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name MembershipRuleText -Value $MembershipRuleText -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name GroupMembersName -Value $GroupMembersName -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name GroupMembersView -Value $GroupMembersView -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name LicenseLabel -Value $LicenseLabel -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name LicenseList -Value $LicenseList -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name exit -Value $exit -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name commit -Value $commit -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name StatusStrip1 -Value $StatusStrip1 -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name ToolLabel -Value $ToolLabel -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name DataGridView1 -Value $DataGridView1 -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name LicenseProcessingLabel -Value $LicenseProcessingLabel -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name LicenseProcessingText -Value $LicenseProcessingText -MemberType NoteProperty
}
. InitializeComponent
