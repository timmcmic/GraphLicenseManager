$Form2 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.TreeView]$TreeView1 = $null
function InitializeComponent
{
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$TreeView1 = (New-Object -TypeName System.Windows.Forms.TreeView)
$Form2.SuspendLayout()
#
#Label1
#
$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]38))
$Label1.Name = [System.String]'Label1'
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]455,[System.Int32]23))
$Label1.TabIndex = [System.Int32]1
$Label1.Text = [System.String]'SKU and PLANS in Tenant'
$Label1.add_Click($Label1_Click)
#
#TreeView1
#
$TreeView1.CheckBoxes = $true
$TreeView1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]64))
$TreeView1.Name = [System.String]'TreeView1'
$TreeView1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]466,[System.Int32]460))
$TreeView1.TabIndex = [System.Int32]2
#
#Form2
#
$Form2.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]967,[System.Int32]561))
$Form2.Controls.Add($TreeView1)
$Form2.Controls.Add($Label1)
$Form2.Text = [System.String]'Graph License Manager'
$Form2.ResumeLayout($false)
Add-Member -InputObject $Form2 -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $Form2 -Name TreeView1 -Value $TreeView1 -MemberType NoteProperty
}
. InitializeComponent
