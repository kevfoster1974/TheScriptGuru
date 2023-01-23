$AppName = "*Firefox*"
$Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$subkeys = Get-ChildItem -Path $Path 
foreach($subkey in $subkeys)
{
    $displayname = (Get-ItemProperty -Path $subkey.PsPath).DisplayName
    if($displayname -like $AppName)
    {
        Write-Host "Required"
        break
    }
}
