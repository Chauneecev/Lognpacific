<#
.SYNOPSIS
    sets the NoWebServices registry value to 1 under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer, disabling access to web-based services such as the Web publishing and online ordering wizards in Windows Explorer.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000105 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000105).ps1 
#>
# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"

# Desired value
$desiredValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the NoWebServices value
Set-ItemProperty -Path $registryPath -Name "NoWebServices" -Value $desiredValue -Type DWord

# Output confirmation
Write-Host "Set 'NoWebServices' to '$desiredValue' at '$registryPath'"
