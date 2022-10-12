<#
    .NOTES
        ==============================================================================================
        Copyright (c) 2022 JDMSFT. All rights reserved.
        ==============================================================================================
        Script:         Initialize-LOD
        Purpose:        Initialize Microsoft LOD virtual machine Azure PowerShell environment
        Version:        1.2
        DateCreated:    11/10/22
        DateModified:   11/10/22
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
        HOW TO USE
        ==============================================================================================
        Execute this script directly from VM by running this PowerShell (as Administrator) next line :
        iex ((New-Object System.Net.WebClient).DownloadString('https://jdmsft.com/lod'))
        ==============================================================================================
        ==============================================================================================
    .SYNOPSIS
        Initialize Microsoft LOD virtual machine Azure PowerShell environment
    .DESCRIPTION
        Initialize Microsoft LOD virtual machine Azure PowerShell environment
    .EXAMPLE
        C:\PS> .\Initialize-LOD
#>

cls
Write-Host "`nMicrosoft LOD Initializer v1.2 (JDMSFT - 2022)`n" -ForegroundColor Yellow
Write-Warning "This script is intented to configure Microsoft LOD virtual machine ONLY!"
Read-Host -Prompt "`nPress ENTER to continue or close this window to abort."

Write-Host "Switching to AZERTY keyboard..."
Set-WinUserLanguageList -LanguageList fr-fr -Force

Write-Host "Enforcing TLS 1.2..."
New-Item "C:\Users\StudentPC\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Value '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12' -Force | Out-Null

Write-Host "Trusting PSGallery..."
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Write-Host "Updating Az modules..."
Update-Module Az

Write-Host "Closing PowerShell console"
exit