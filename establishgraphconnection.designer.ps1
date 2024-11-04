$Form1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.TextBox]$TextBox1 = $null
[System.Windows.Forms.RadioButton]$RadioButton1 = $null
[System.Windows.Forms.TextBox]$TextBox2 = $null
[System.Windows.Forms.Label]$Label2 = $null
[System.Windows.Forms.TextBox]$TextBox3 = $null
[System.Windows.Forms.Label]$Label3 = $null
[System.Windows.Forms.RadioButton]$RadioButton2 = $null
[System.Windows.Forms.Button]$Button1 = $null
[System.Windows.Forms.Button]$ExitButton = $null
[System.Windows.Forms.ComboBox]$EnvironmentBox = $null
[System.Windows.Forms.Label]$Label4 = $null
[System.Windows.Forms.StatusStrip]$StatusStrip1 = $null
[System.Windows.Forms.ToolStripStatusLabel]$LoginStatusLabel = $null
[System.Windows.Forms.Label]$DirectoryPermissions = $null
[System.Windows.Forms.Label]$GroupPermissions = $null
[System.Windows.Forms.ComboBox]$DirectoryPermissionsBox = $null
[System.Windows.Forms.ComboBox]$GroupPermissionsBox = $null
[System.Windows.Forms.ComboBox]$ComboBox1 = $null
[System.Windows.Forms.Label]$User Permissions = $null
function InitializeComponent
{
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$TextBox1 = (New-Object -TypeName System.Windows.Forms.TextBox)
$RadioButton1 = (New-Object -TypeName System.Windows.Forms.RadioButton)
$TextBox2 = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label2 = (New-Object -TypeName System.Windows.Forms.Label)
$TextBox3 = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label3 = (New-Object -TypeName System.Windows.Forms.Label)
$RadioButton2 = (New-Object -TypeName System.Windows.Forms.RadioButton)
$Button1 = (New-Object -TypeName System.Windows.Forms.Button)
$ExitButton = (New-Object -TypeName System.Windows.Forms.Button)
$EnvironmentBox = (New-Object -TypeName System.Windows.Forms.ComboBox)
$Label4 = (New-Object -TypeName System.Windows.Forms.Label)
$StatusStrip1 = (New-Object -TypeName System.Windows.Forms.StatusStrip)
$LoginStatusLabel = (New-Object -TypeName System.Windows.Forms.ToolStripStatusLabel)
$DirectoryPermissions = (New-Object -TypeName System.Windows.Forms.Label)
$GroupPermissions = (New-Object -TypeName System.Windows.Forms.Label)
$DirectoryPermissionsBox = (New-Object -TypeName System.Windows.Forms.ComboBox)
$GroupPermissionsBox = (New-Object -TypeName System.Windows.Forms.ComboBox)
$ComboBox1 = (New-Object -TypeName System.Windows.Forms.ComboBox)
$User Permissions = (New-Object -TypeName System.Windows.Forms.Label)
$StatusStrip1.SuspendLayout()
$Form1.SuspendLayout()
#
#Label1
#
$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]9))
$Label1.Name = [System.String]'Label1'
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]159,[System.Int32]33))
$Label1.TabIndex = [System.Int32]0
$Label1.Text = [System.String]'TenantID'
$Label1.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$Label1.add_Click($Label1_Click)
#
#TextBox1
#
$TextBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]177,[System.Int32]16))
$TextBox1.Name = [System.String]'TextBox1'
$TextBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]630,[System.Int32]21))
$TextBox1.TabIndex = [System.Int32]1
#
#RadioButton1
#
$RadioButton1.Checked = $true
$RadioButton1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]19,[System.Int32]55))
$RadioButton1.Name = [System.String]'RadioButton1'
$RadioButton1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]152,[System.Int32]24))
$RadioButton1.TabIndex = [System.Int32]2
$RadioButton1.TabStop = $true
$RadioButton1.Text = [System.String]'Certificate Authentication'
$RadioButton1.UseVisualStyleBackColor = $true
$RadioButton1.add_CheckedChanged($RadioButton1_CheckedChanged)
#
#TextBox2
#
$TextBox2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]177,[System.Int32]92))
$TextBox2.Name = [System.String]'TextBox2'
$TextBox2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]630,[System.Int32]21))
$TextBox2.TabIndex = [System.Int32]3
$TextBox2.add_TextChanged($TextBox2_TextChanged)
#
#Label2
#
$Label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]92))
$Label2.Name = [System.String]'Label2'
$Label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]159,[System.Int32]23))
$Label2.TabIndex = [System.Int32]4
$Label2.Text = [System.String]'Certificate Thumbprint'
$Label2.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$Label2.add_Click($Label2_Click)
#
#TextBox3
#
$TextBox3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]177,[System.Int32]133))
$TextBox3.Name = [System.String]'TextBox3'
$TextBox3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]630,[System.Int32]21))
$TextBox3.TabIndex = [System.Int32]5
$TextBox3.add_TextChanged($TextBox3_TextChanged)
#
#Label3
#
$Label3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]130))
$Label3.Name = [System.String]'Label3'
$Label3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]165,[System.Int32]23))
$Label3.TabIndex = [System.Int32]6
$Label3.Text = [System.String]'Application ID'
$Label3.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#RadioButton2
#
$RadioButton2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]186))
$RadioButton2.Name = [System.String]'RadioButton2'
$RadioButton2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]152,[System.Int32]24))
$RadioButton2.TabIndex = [System.Int32]7
$RadioButton2.Text = [System.String]'Interactive Credentials'
$RadioButton2.UseVisualStyleBackColor = $true
$RadioButton2.add_CheckedChanged($RadioButton2_CheckedChanged)
#
#Button1
#
$Button1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]19,[System.Int32]283))
$Button1.Name = [System.String]'Button1'
$Button1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]646,[System.Int32]23))
$Button1.TabIndex = [System.Int32]8
$Button1.Text = [System.String]'Connect Microsoft Graph'
$Button1.UseVisualStyleBackColor = $true
$Button1.add_Click($Button1_Click)
#
#ExitButton
#
$ExitButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]683,[System.Int32]283))
$ExitButton.Name = [System.String]'ExitButton'
$ExitButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]124,[System.Int32]23))
$ExitButton.TabIndex = [System.Int32]9
$ExitButton.Text = [System.String]'Quit'
$ExitButton.UseVisualStyleBackColor = $true
$ExitButton.add_Click($ExitButton_Click)
#
#EnvironmentBox
#
$EnvironmentBox.FormattingEnabled = $true
$EnvironmentBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]177,[System.Int32]243))
$EnvironmentBox.Name = [System.String]'EnvironmentBox'
$EnvironmentBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]198,[System.Int32]21))
$EnvironmentBox.TabIndex = [System.Int32]10
$EnvironmentBox.add_SelectedIndexChanged($EnvironmentBox_SelectedIndexChanged)
#
#Label4
#
$Label4.ImageAlign = [System.Drawing.ContentAlignment]::MiddleRight
$Label4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]13,[System.Int32]241))
$Label4.Name = [System.String]'Label4'
$Label4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]158,[System.Int32]23))
$Label4.TabIndex = [System.Int32]11
$Label4.Text = [System.String]'Graph Environment Selection'
$Label4.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#StatusStrip1
#
$StatusStrip1.Items.AddRange([System.Windows.Forms.ToolStripItem[]]@($LoginStatusLabel))
$StatusStrip1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]309))
$StatusStrip1.Name = [System.String]'StatusStrip1'
$StatusStrip1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]819,[System.Int32]22))
$StatusStrip1.TabIndex = [System.Int32]12
$StatusStrip1.Text = [System.String]'StatusStrip1'
#
#LoginStatusLabel
#
$LoginStatusLabel.Name = [System.String]'LoginStatusLabel'
$LoginStatusLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]0,[System.Int32]17))
#
#DirectoryPermissions
#
$DirectoryPermissions.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]445,[System.Int32]187))
$DirectoryPermissions.Name = [System.String]'DirectoryPermissions'
$DirectoryPermissions.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]158,[System.Int32]23))
$DirectoryPermissions.TabIndex = [System.Int32]13
$DirectoryPermissions.Text = [System.String]'Directory Permissions'
$DirectoryPermissions.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$DirectoryPermissions.Visible = $false
#
#GroupPermissions
#
$GroupPermissions.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]445,[System.Int32]214))
$GroupPermissions.Name = [System.String]'GroupPermissions'
$GroupPermissions.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]158,[System.Int32]23))
$GroupPermissions.TabIndex = [System.Int32]14
$GroupPermissions.Text = [System.String]'Group Permissions'
$GroupPermissions.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$GroupPermissions.Visible = $false
#
#DirectoryPermissionsBox
#
$DirectoryPermissionsBox.FormattingEnabled = $true
$DirectoryPermissionsBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]609,[System.Int32]189))
$DirectoryPermissionsBox.Name = [System.String]'DirectoryPermissionsBox'
$DirectoryPermissionsBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]198,[System.Int32]21))
$DirectoryPermissionsBox.TabIndex = [System.Int32]15
$DirectoryPermissionsBox.Visible = $false
$DirectoryPermissionsBox.add_SelectedIndexChanged($DirectoryPermissionsBox_SelectedIndexChanged)
#
#GroupPermissionsBox
#
$GroupPermissionsBox.FormattingEnabled = $true
$GroupPermissionsBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]609,[System.Int32]216))
$GroupPermissionsBox.Name = [System.String]'GroupPermissionsBox'
$GroupPermissionsBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]198,[System.Int32]21))
$GroupPermissionsBox.TabIndex = [System.Int32]16
$GroupPermissionsBox.Visible = $false
$GroupPermissionsBox.add_SelectedIndexChanged($GroupPermissionsBox_SelectedIndexChanged)
#
#ComboBox1
#
$ComboBox1.FormattingEnabled = $true
$ComboBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]609,[System.Int32]243))
$ComboBox1.Name = [System.String]'ComboBox1'
$ComboBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]198,[System.Int32]21))
$ComboBox1.TabIndex = [System.Int32]17
#
#User Permissions
#
$User Permissions.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]496,[System.Int32]241))
$User Permissions.Name = [System.String]'User Permissions'
$User Permissions.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]107,[System.Int32]23))
$User Permissions.TabIndex = [System.Int32]18
$User Permissions.Text = [System.String]'User Permissions'
$User Permissions.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#
#Form1
#
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]819,[System.Int32]331))
$Form1.ControlBox = $false
$Form1.Controls.Add($User Permissions)
$Form1.Controls.Add($ComboBox1)
$Form1.Controls.Add($GroupPermissionsBox)
$Form1.Controls.Add($DirectoryPermissionsBox)
$Form1.Controls.Add($GroupPermissions)
$Form1.Controls.Add($DirectoryPermissions)
$Form1.Controls.Add($StatusStrip1)
$Form1.Controls.Add($Label4)
$Form1.Controls.Add($EnvironmentBox)
$Form1.Controls.Add($ExitButton)
$Form1.Controls.Add($Button1)
$Form1.Controls.Add($RadioButton2)
$Form1.Controls.Add($Label3)
$Form1.Controls.Add($TextBox3)
$Form1.Controls.Add($Label2)
$Form1.Controls.Add($TextBox2)
$Form1.Controls.Add($RadioButton1)
$Form1.Controls.Add($TextBox1)
$Form1.Controls.Add($Label1)
$Form1.MaximizeBox = $false
$Form1.MinimizeBox = $false
$Form1.Text = [System.String]'Connect Microsoft Graph'
$StatusStrip1.ResumeLayout($false)
$StatusStrip1.PerformLayout()
$Form1.ResumeLayout($false)
$Form1.PerformLayout()
Add-Member -InputObject $Form1 -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name TextBox1 -Value $TextBox1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name RadioButton1 -Value $RadioButton1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name TextBox2 -Value $TextBox2 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name Label2 -Value $Label2 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name TextBox3 -Value $TextBox3 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name Label3 -Value $Label3 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name RadioButton2 -Value $RadioButton2 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name Button1 -Value $Button1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name ExitButton -Value $ExitButton -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name EnvironmentBox -Value $EnvironmentBox -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name Label4 -Value $Label4 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name StatusStrip1 -Value $StatusStrip1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name LoginStatusLabel -Value $LoginStatusLabel -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name DirectoryPermissions -Value $DirectoryPermissions -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name GroupPermissions -Value $GroupPermissions -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name DirectoryPermissionsBox -Value $DirectoryPermissionsBox -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name GroupPermissionsBox -Value $GroupPermissionsBox -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name ComboBox1 -Value $ComboBox1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name User Permissions -Value $User Permissions -MemberType NoteProperty
}
. InitializeComponent
