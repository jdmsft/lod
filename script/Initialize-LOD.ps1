<#
    .NOTES
        ==============================================================================================
        Copyright (c) 2022-2023 JDMSFT. All rights reserved.
        ==============================================================================================
        Script:         Initialize-LOD
        Purpose:        Initialize Microsoft LOD virtual machine Azure PowerShell environment
        Version:        1.4
        DateCreated:    11/10/22
        DateModified:   15/02/23
        ==============================================================================================
        DISCLAIMER
        ==============================================================================================
        This script is not supported under any Microsoft standard support program or service.
        This script is provided AS IS without warranty of any kind.
        Microsoft further disclaims all implied warranties including, without limitation, 
        any implied warranties of merchantability or of fitness for a particular purpose.
        The entire risk arising out of the use or performance of the script
        and documentation remains with you. In no event shall Microsoft, its authors,
        or anyone else involved in the creation, production, or delivery of the
        script be liable for any damages whatsoever (including, without limitation,
        damages for loss of business profits, business interruption, loss of business
        information, or other pecuniary loss) arising out of the use of or inability
        to use the sample scripts or documentation, even if Microsoft has been
        advised of the possibility of such damages.
        ==============================================================================================
    .SYNOPSIS
        Initialize Microsoft LOD virtual machine Azure PowerShell environment
    .DESCRIPTION
        Initialize Microsoft LOD virtual machine Azure PowerShell environment
    .EXAMPLE
        C:\PS> .\Initialize-LOD
#>

cls
Write-Host "`nMicrosoft LOD Initializer v1.4 (JDMSFT - 2023)`n" -ForegroundColor Yellow
Write-Warning "This script is intented to configure Microsoft LOD virtual machine ONLY!"
Read-Host -Prompt "`nPress ENTER to continue or close this window to abort."

Write-Host "Switching to AZERTY keyboard..."
Set-WinUserLanguageList -LanguageList fr-fr -Force

Write-Host "Enforcing TLS 1.2..."
New-Item "C:\Users\StudentPC\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Value '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12' -Force | Out-Null

Write-Host "Trusting PSGallery..."
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Write-Host 'Disabling Windows Update (Automatic Update)...'
Stop-Service wuauserv
Set-Service wuauserv -StartupType Disabled
New-Item -Path "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
New-Item -Path "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
Set-ItemProperty -Path "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAutoUpdate -Value 1

Write-Host 'Disabling Microsoft Edge Update...'
Stop-Service edgeupdate
Set-Service edgeupdate -StartupType Disabled
Stop-Service edgeupdatem
Set-Service edgeupdatem -StartupType Disabled

Write-Host "Disabling Acrobat Reader and Acrobat Manager Update..."
Stop-Service AdobeARMservice
Set-Service AdobeARMservice -StartupType Disabled

Write-Host "Disabling Microsoft Compatibility Telemetry..."
Get-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" | Disable-ScheduledTask

# Download lab files locally (if applicable)
# For WSPLUS Azure Automation
If (Test-Path "C:\Users\Student\Desktop\Copy-StudentFiles.ps1") 
{ 
    Write-Host "Downloading student files (in another PS window)..."
    Start-Process PowerShell -ArgumentList "-command C:\Users\Student\Desktop\Copy-StudentFiles.ps1" 
}

Write-Host "Updating Az modules..."
Update-Module Az

Write-Host "Closing PowerShell console"
exit