<#
.SYNOPSIS
    that the DisableHTTPPrinting registry value is set to 1 under the specified path, effectively disabling printing over HTTP. This setting corresponds to the Group Policy "Turn off printing over HTTP" and is useful for enhancing security by preventing printing over HTTP.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000110 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000110).ps1 
#>
# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"

# Desired value
$desiredValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the DisableHTTPPrinting value
Set-ItemProperty -Path $registryPath -Name "DisableHTTPPrinting" -Value $desiredValue -Type DWord

# Output confirmation
Write-Host "Set 'DisableHTTPPrinting' to '$desiredValue' at '$registryPath'"
