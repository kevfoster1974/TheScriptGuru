# Remediation script
# Check if WireSharkis installed if so ... then this script will remove it
 
# Author: Kevin Foster
# Date: 24th January 2023
# Version: 1.00
 
#-----------------------------[Parameters]----------------------------------
$Arguments = "/S"
$AppName = "*Wireshark*"
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
$wowPath = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$subkeys = Get-ChildItem -Path $Path 
$flag = $false

#-----------------------------[Script]----------------------------------

# Check the main registry key
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

# If not found check the Wow6432Node registry key
if (!$flag) {
    $wowSubkeys = Get-ChildItem -Path $wowPath 
    foreach($subkey in $wowSubkeys)
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
}