# Remediation script
# Check if Firefox is installed in the user context, by searching the logged on users registry if so ... then this script will remove it
 
# Author: Kevin Foster
# Date: 13th January 2023
# Version: 1.00
 
#-----------------------------[Functions]----------------------------------
$Arguments = "/S"
$RemoveFile = $env:USERPROFILE + "\Downloads\Fire*.exe"
$RemoveFile1 = $env:USERPROFILE + "\Downloads\Mozilla*.exe"
$RemoveFolder = $env:LOCALAPPDATA + "\Mozilla"
$RemoveFolder1 = $env:APPDATA + "\Mozilla"
$AppName = "*Firefox*"
$Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$subkeys = Get-ChildItem -Path $Path 
$flag = $false
 
#-----------------------------[Declarations]--------------------------------

if (Get-Process -Name "Firefox" -ErrorAction SilentlyContinue) {

$title = "Firefox Uninstall Warning"
$message = "Please close Firefox, it will be automatically closed and uninstalled in 5 minutes."
$secs = 15

$wsh = New-Object -ComObject Wscript.Shell
$wsh.Popup($message, $secs, $title, 0x0 + 0x40)

Start-Sleep -Seconds 300
Stop-Process -name Firefox -force
}

foreach($subkey in $subkeys)
{
    $displayname = (Get-ItemProperty -Path $subkey.PsPath).DisplayName
    if($displayname -like $AppName)
    {
        $uninstallstring = (Get-ItemProperty -Path $subkey.PsPath).UninstallString
        Start-Process $uninstallstring -ArgumentList $Arguments -Wait -NoNewWindow
        $flag = $true
        break
    }
}

If ((Test-Path $RemoveFile)) {
Remove-Item "$env:USERPROFILE\Downloads\Firefox*.exe" -Recurse
}

If ((Test-Path $RemoveFile1)) {
Remove-Item "$env:USERPROFILE\Downloads\Mozilla*.exe" -Recurse
}

If ((Test-Path $RemoveFolder)) {
Start-Sleep -Seconds 5
Remove-Item "$env:USERPROFILE\AppData\Local\Mozilla" -Force -Recurse
}

If ((Test-Path $RemoveFolder1)) {
Start-Sleep -Seconds 5
Remove-Item "$env:USERPROFILE\AppData\Roaming\Mozilla" -Force -Recurse
}
