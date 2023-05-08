#Version2 with if statements to filter better the info------------------------------------------------------------------
#Lucas Milhomem 
#date: 5/5/2023
#fixed script
$test = "C:\Users\lucas\Downloads\Test"
#made by Lucas Milhomem
#variables---------------------------------------------------------------------------
$admxPolicy = "C:\Windows\PolicyDefinitions"
$admlPolicy = "C:\Windows\PolicyDefinitions\en-US"
$URL =  " https://dl.google.com/dl/edgedl/chrome/policy/policy_templates.zip"
$ExtractName = "C:\Temp\unzipped\policy_templates.zip"
$ExtractPath = "C:\Temp\"
$tempFolder = "C:\Temp\unzipped"
#------------------------------------------------------------------------------------
#checking if folder exists,if not it will create a temp folder
$checkpath = Test-Path $ExtractPath
$checkpath2 = Test-path $tempFolder
if($checkpath -eq $true -and $checkpath2 -eq $true)
{
#New-Item -Path "C:\Temp\" -Name "unzipped" -ItemType "directory"
Invoke-WebRequest -Uri $URL -OutFile $ExtractName 
Expand-Archive -Path $ExtractName -DestinationPath $tempFolder
echo "here1"
}
elseif($checkpath -eq $true -and $checkpath2 -ne $true){ 
New-Item -Path $ExtractPath -Name "unzipped" -ItemType "directory"
Invoke-WebRequest -Uri $URL -OutFile $ExtractName 
Expand-Archive -Path $ExtractName -DestinationPath $tempFolder
echo "here2"
}

else{
New-Item -Path "c:\" -Name "Temp" -ItemType "directory"
New-Item -Path "C:\Temp\" -Name "unzipped" -ItemType "directory"
Invoke-WebRequest -Uri $URL -OutFile $ExtractName 
Expand-Archive -Path $ExtractPath -DestinationPath $tempFolder
echo "here3"
}
 
#mving files to policy tremplates folder 
Copy-Item -path "C:\Temp\unzipped\windows\admx\chrome.admx",    #-------make sure to set correct directory on this copy item line
"C:\Temp\unzipped\windows\admx\google.admx"  -Destination $admxPolicy
Copy-Item -path "C:\Temp\unzipped\windows\admx\en-US\chrome.adml",
"C:\Temp\unzipped\windows\admx\en-us\google.adml" -destination $admlPolicy
Remove-Item $tempFolder -Force  -Recurse -ErrorAction SilentlyContinue