
<# 
.NAME
    test

#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(592,575)
$Form.text                       = "Form"
$Form.TopMost                    = $false

$WindDiskClean                   = New-Object system.Windows.Forms.Button
$WindDiskClean.text              = "Windows Disk Cleanup"
$WindDiskClean.width             = 325
$WindDiskClean.height            = 60
$WindDiskClean.location          = New-Object System.Drawing.Point(128,84)
$WindDiskClean.Font              = New-Object System.Drawing.Font('Agency FB',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Title                           = New-Object system.Windows.Forms.Label
$Title.text                      = "Windows Cleaner"
$Title.AutoSize                  = $true
$Title.width                     = 25
$Title.height                    = 30
$Title.Anchor                    = 'top,right,bottom,left'
$Title.location                  = New-Object System.Drawing.Point(102,10)
$Title.Font                      = New-Object System.Drawing.Font('Comic Sans MS',35,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$TempFiles                       = New-Object system.Windows.Forms.Button
$TempFiles.text                  = "Temporary Files"
$TempFiles.width                 = 325
$TempFiles.height                = 60
$TempFiles.location              = New-Object System.Drawing.Point(126,210)
$TempFiles.Font                  = New-Object System.Drawing.Font('Agency FB',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Apps                            = New-Object system.Windows.Forms.Button
$Apps.text                       = "Apps"
$Apps.width                      = 325
$Apps.height                     = 60
$Apps.location                   = New-Object System.Drawing.Point(127,330)
$Apps.Font                       = New-Object System.Drawing.Font('Agency FB',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$SystemFileCheck                 = New-Object system.Windows.Forms.Button
$SystemFileCheck.text            = "System File Checker"
$SystemFileCheck.width           = 162.5
$SystemFileCheck.height          = 60
$SystemFileCheck.location        = New-Object System.Drawing.Point(127,450)
$SystemFileCheck.Font            = New-Object System.Drawing.Font('Agency FB',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$DiskCheck                       = New-Object system.Windows.Forms.Button
$DiskCheck.text                  = "Disk Check"
$DiskCheck.width                 = 162.5
$DiskCheck.height                = 60
$DiskCheck.location              = New-Object System.Drawing.Point(291,450)
$DiskCheck.Font                  = New-Object System.Drawing.Font('Agency FB',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Form.controls.AddRange(@($WindDiskClean,$Title,$TempFiles,$Apps,$SystemFileCheck,$DiskCheck))




$WindDiskClean.Add_Click({
    Start-Process "cleanmgr.exe"
})
$TempFiles.Add_Click({
    Invoke-Item "C:\Windows\Temp"
    Invoke-Item "$env:USERPROFILE\AppData\Local\Temp"
    Invoke-Item "C:\Windows\Prefetch"
})
$Apps.Add_Click({ 
    Start-Process "ms-settings:appsfeatures"
})
$SystemFileCheck.Add_Click({
    Start-Process "cmd.exe" -ArgumentList "/c sfc /scannow" -Verb RunAs
})
$DiskCheck.Add_Click({
    Start-Process "cmd.exe" -ArgumentList "/c DISM.exe /Online /Cleanup-image /Restorehealth" -Verb RunAs
})


[void]$Form.ShowDialog()