#paths for chrome policy keys used in the scripts
$policyexists = Test-Path HKLM:\SOFTWARE\Policies\Mozilla\Firefox\
$policyexistshome = Test-Path HKLM:\SOFTWARE\Policies\Mozilla\Firefox\RestoreOnStartupURLs
$regKeysetup = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox"
$regKeyhome = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox\RestoreOnStartupURLs"
$url = "https://dmsi.login.duosecurity.com"


#setup policy dirs in registry if needed and set pwd manager
#else sets them to the correct values if they exist
if ($policyexists -eq $false){
New-Item -path HKLM:\SOFTWARE\Policies\Mozilla
New-Item -path HKLM:\SOFTWARE\Policies\Mozilla\Firefox
New-ItemProperty -path $regKeysetup -Name RestoreOnStartup -PropertyType string -Value $url
}

Else {
Set-ItemProperty -Path $regKeysetup -Name RestoreOnStartup -Value $url
}

#This entry requires a subfolder in the registry
#For more then one page create another new-item and set-item line with the name -2 and the new url
if ($policyexistshome -eq $false){
New-Item -path HKLM:\SOFTWARE\Policies\Mozilla\Firefox\RestoreOnStartupURLs
New-ItemProperty -path $regKeyhome -Name URL -PropertyType String -Value $url
}
Else {
Set-ItemProperty -Path $regKeyhome -Name URL -Value $url
}
