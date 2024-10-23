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
[System.Windows.Forms.GroupBox]$GroupBox1 = $null
[System.Windows.Forms.RadioButton]$ChinaButton = $null
[System.Windows.Forms.RadioButton]$USDoDButton = $null
[System.Windows.Forms.RadioButton]$usgovbutton = $null
[System.Windows.Forms.RadioButton]$GlobalButton = $null
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
$GroupBox1 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$ChinaButton = (New-Object -TypeName System.Windows.Forms.RadioButton)
$USDoDButton = (New-Object -TypeName System.Windows.Forms.RadioButton)
$usgovbutton = (New-Object -TypeName System.Windows.Forms.RadioButton)
$GlobalButton = (New-Object -TypeName System.Windows.Forms.RadioButton)
$GroupBox1.SuspendLayout()
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
$Button1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]19,[System.Int32]246))
$Button1.Name = [System.String]'Button1'
$Button1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]646,[System.Int32]23))
$Button1.TabIndex = [System.Int32]8
$Button1.Text = [System.String]'Connect Microsoft Graph'
$Button1.UseVisualStyleBackColor = $true
$Button1.add_Click($Button1_Click)
#
#ExitButton
#
$ExitButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]683,[System.Int32]246))
$ExitButton.Name = [System.String]'ExitButton'
$ExitButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]124,[System.Int32]23))
$ExitButton.TabIndex = [System.Int32]9
$ExitButton.Text = [System.String]'Quit'
$ExitButton.UseVisualStyleBackColor = $true
$ExitButton.add_Click($ExitButton_Click)
#
#GroupBox1
#
$GroupBox1.Controls.Add($ChinaButton)
$GroupBox1.Controls.Add($USDoDButton)
$GroupBox1.Controls.Add($usgovbutton)
$GroupBox1.Controls.Add($GlobalButton)
$GroupBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]177,[System.Int32]174))
$GroupBox1.Name = [System.String]'GroupBox1'
$GroupBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]557,[System.Int32]42))
$GroupBox1.TabIndex = [System.Int32]10
$GroupBox1.TabStop = $false
$GroupBox1.Text = [System.String]'Graph Environment Selection'
$GroupBox1.add_Enter($GroupBox1_Enter)
#
#ChinaButton
#
$ChinaButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]418,[System.Int32]12))
$ChinaButton.Name = [System.String]'ChinaButton'
$ChinaButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]131,[System.Int32]24))
$ChinaButton.TabIndex = [System.Int32]11
$ChinaButton.TabStop = $true
$ChinaButton.Text = [System.String]'China'
$ChinaButton.UseVisualStyleBackColor = $true
#
#USDoDButton
#
$USDoDButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]281,[System.Int32]12))
$USDoDButton.Name = [System.String]'USDoDButton'
$USDoDButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]131,[System.Int32]24))
$USDoDButton.TabIndex = [System.Int32]11
$USDoDButton.TabStop = $true
$USDoDButton.Text = [System.String]'UsDOD'
$USDoDButton.UseVisualStyleBackColor = $true
#
#usgovbutton
#
$usgovbutton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]144,[System.Int32]12))
$usgovbutton.Name = [System.String]'usgovbutton'
$usgovbutton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]131,[System.Int32]24))
$usgovbutton.TabIndex = [System.Int32]11
$usgovbutton.TabStop = $true
$usgovbutton.Text = [System.String]'UsGOV'
$usgovbutton.UseVisualStyleBackColor = $true
#
#GlobalButton
#
$GlobalButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]12))
$GlobalButton.Name = [System.String]'GlobalButton'
$GlobalButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]131,[System.Int32]24))
$GlobalButton.TabIndex = [System.Int32]0
$GlobalButton.TabStop = $true
$GlobalButton.Text = [System.String]'Global'
$GlobalButton.UseVisualStyleBackColor = $true
#
#Form1
#
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]819,[System.Int32]281))
$Form1.ControlBox = $false
$Form1.Controls.Add($GroupBox1)
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
$GroupBox1.ResumeLayout($false)
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
Add-Member -InputObject $Form1 -Name GroupBox1 -Value $GroupBox1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name ChinaButton -Value $ChinaButton -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name USDoDButton -Value $USDoDButton -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name usgovbutton -Value $usgovbutton -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name GlobalButton -Value $GlobalButton -MemberType NoteProperty
}
. InitializeComponent
