<#
.SYNOPSIS
    This PowerShell script ensures the specified registry key exists and sets the fBlockNonDomain value to 1, which configures Windows to block connections to non-domain networks when connected to a domain network.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000060 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000060).ps1 
#>
# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"
$valueName = "fBlockNonDomain"
$valueData = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWord -Force

# Output confirmation
Write-Host "Set '$valueName' to '$valueData' at '$registryPath'"

gpupdate /force
