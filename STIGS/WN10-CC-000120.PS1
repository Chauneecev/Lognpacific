<#
.SYNOPSIS
    This PowerShell script sets the DontDisplayNetworkSelectionUI registry value to 1 under HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System, thereby disabling the network selection UI on the Windows logon screen and preventing users from changing network connections without signing in.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000120 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000120).ps1 
#>
Define the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

# Desired value
$desiredValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the DontDisplayNetworkSelectionUI value
Set-ItemProperty -Path $registryPath -Name "DontDisplayNetworkSelectionUI" -Value $desiredValue -Type DWord

# Output confirmation
Write-Host "Set 'DontDisplayNetworkSelectionUI' to '$desiredValue' at '$registryPath'"
