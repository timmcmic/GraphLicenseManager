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
[System.Windows.Forms.Label]$GroupMembers = $null
[System.Windows.Forms.ListView]$GroupMemberView = $null
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
$GroupMembers = (New-Object -TypeName System.Windows.Forms.Label)
$GroupMemberView = (New-Object -TypeName System.Windows.Forms.ListView)
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
$GroupObjectIDText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]749,[System.Int32]21))
$GroupObjectIDText.TabIndex = [System.Int32]1
#
#Button1
#
$Button1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]966,[System.Int32]22))
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
$DisplayNameText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]749,[System.Int32]21))
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
$ExpirationDateTimeText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]749,[System.Int32]21))
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
$MailText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]749,[System.Int32]21))
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
$GroupTypeText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]749,[System.Int32]21))
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
$MembershipRuleText.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]749,[System.Int32]21))
$MembershipRuleText.TabIndex = [System.Int32]12
$MembershipRuleText.Visible = $false
#
#GroupMembers
#
$GroupMembers.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]185))
$GroupMembers.Name = [System.String]'GroupMembers'
$GroupMembers.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]475,[System.Int32]23))
$GroupMembers.TabIndex = [System.Int32]14
$GroupMembers.Text = [System.String]'Group Members'
$GroupMembers.TextAlign = [System.Drawing.ContentAlignment]::TopCenter
$GroupMembers.Visible = $false
#
#GroupMemberView
#
$GroupMemberView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]211))
$GroupMemberView.Name = [System.String]'GroupMemberView'
$GroupMemberView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]475,[System.Int32]576))
$GroupMemberView.TabIndex = [System.Int32]15
$GroupMemberView.UseCompatibleStateImageBehavior = $false
$GroupMemberView.Visible = $false
#
#Form2
#
$Form2.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1074,[System.Int32]799))
$Form2.Controls.Add($GroupMemberView)
$Form2.Controls.Add($GroupMembers)
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
Add-Member -InputObject $Form2 -Name GroupMembers -Value $GroupMembers -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name GroupMemberView -Value $GroupMemberView -MemberType NoteProperty
}
. InitializeComponent
