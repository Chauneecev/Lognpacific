<#
.SYNOPSIS
    This PowerShell script configures the registry setting AllowProtectedCreds under \SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation to enable the delegation of non-exportable credentials on Windows systems, ensuring compliance with security policies.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000068 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000068).ps1 
#>
# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
$valueName = "AllowProtectedCreds"
$valueData = 1

# Check if the registry path exists, create it if necessary
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output confirmation
Write-Host "Set '$valueName' to '$valueData' at '$registryPath'"
