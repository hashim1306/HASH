

function Create-Folder {
    Param ([string]$path)
    if ((Test-Path $path) -eq $false) 
    {
        Write-Host "$path doesn't exist. Creating now.."
        New-Item -ItemType "directory" -Path $path
    }
}

function Download-File{
    Param ([string]$src, [string] $dst)

    (New-Object System.Net.WebClient).DownloadFile($src,$dst)
    #Invoke-WebRequest $src -OutFile $dst
}

function WaitForFile($File) {
  while(!(Test-Path $File)) {    
    Start-Sleep -s 10;   
  }  
} 


#Setup Folders

$setupFolder = "C:\WEB-CLIENT"
Create-Folder "$setupFolder"

Create-Folder "$setupFolder\training"
$setupFolder = "$setupFolder\training"



$os_type = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x64)’

# webRDP-Client Installation 
if((Test-Path "$setupFolder\webRDP-Client_1.2.0.42-32.exe") -eq $false)
{
    Write-Host "Downloading WEBRDP-CLIENT installation file.."
    if ($os_type -eq "True"){
        Download-File "https://shuk06-my.sharepoint.com/personal/syed_shuk06_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=170c5247fd9664ac89af5beda6036364a&authkey=AaFHc8Vve_8ukS4KElnjdKQ" "$setupFolder\webRDP-Client_1.2.0.42-32.exe"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}

# upload license
Write-Host "upload license file.."
if((Test-Path "$setupFolder\G7_CR_Technologies-license.swl") -eq $false)
{
    Write-Host "upload license file G7_CR_Technologies-license.swl"
    if ($os_type -eq "True"){
        Download-File "https://shuk06-my.sharepoint.com/personal/syed_shuk06_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=1bde5d1ccd0274f408bee17afeda1b987&authkey=Ae-GknK-TWpfRNUKPx565Ms" "$setupFolder\G7_CR_Technologies-license.swl"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}

# upload EXE
Write-Host "upload EXE file.."
if((Test-Path "$setupFolder\WEB123.exe") -eq $false)
{
    Write-Host "upload  WEB123.exe"
    if ($os_type -eq "True"){
        Download-File https://shuk06-my.sharepoint.com/personal/syed_shuk06_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=16ec4d75eeddb45868e028a3abb6f4ff0&authkey=AceH-I8QtPC_QvbQOXz7uV0 "$setupFolder\WEB123.exe"}else {
        Write-Host "32 Bit system is not supported"
    }    
}

Write-Host "Installing WEB-RDP CLIENT.."
    Start-Process -FilePath "$setupFolder\WEB123.exe"
    Start-Sleep -s 80;
    Write-Host 'Installation completed.'
 




