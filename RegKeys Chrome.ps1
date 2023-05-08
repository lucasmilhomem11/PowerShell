#paths for Chrome policy keys used in the scripts
$policyexists = Test-Path HKLM:\SOFTWARE\Policies\Google\Chrome
$policyexistshome = Test-Path HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs
$regKeysetup = "HKLM:\SOFTWARE\Policies\Google\Chrome"
$regKeyhome = "HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs"
$url = "https://dmsi.login.duosecurity.com"


#else sets them to the correct values if they exist
if ($policyexists -eq $false){
New-Item -path HKLM:\SOFTWARE\Policies\Google
New-Item -path HKLM:\SOFTWARE\Policies\Google\Chrome
New-ItemProperty -path $regKeysetup -Name 1 -PropertyType string -Value $url
New-ItemProperty -Path $regKeysetup -name RestoreOnStartup -PropertyType DWORD -Value 4
}

Else {
Set-ItemProperty -Path $regKeysetup -Name 1 -Value $url
New-ItemProperty -Path $regKeysetup -name RestoreOnStartup -PropertyType DWORD -Value 4
}

#This entry requires a subfolder in the registry created by the other script
#For more then one page create another new-item and set-item line with the name -2 and the new url
if ($policyexistshome -eq $false){
New-Item -path HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs
New-ItemProperty -path $regKeyhome -Name 1 -PropertyType String -Value $url
New-ItemProperty -Path $regKeyhome -name RestoreOnStartup -PropertyType DWORD -Value 4
}
Else {
Set-ItemProperty -Path $regKeyhome -Name 1 -Value $url
}