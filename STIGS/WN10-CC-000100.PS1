<#
.SYNOPSIS
    This PowerShell script ensures that the registry key HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers exists and sets the DisableWebPnPDownload DWORD value to 1, effectively disabling the downloading of print drivers over HTTP.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000100 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000100).ps1 
#>
# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"

# Desired value
$desiredValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the DisableWebPnPDownload value
Set-ItemProperty -Path $registryPath -Name "DisableWebPnPDownload" -Value $desiredValue -Type DWord

# Output confirmation
Write-Host "Set 'DisableWebPnPDownload' to '$desiredValue' at '$registryPath'"
