<#
.SYNOPSIS
    ecursively retrieves all files from the directory C:\Program Files\Microsoft Configuration Manager\Logs, filters those modified in the last 7 days, and exports their names and last write times to a CSV file named recent_logs.csv.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000052).ps1 
#>
# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$valueName = "EccCurves"
$valueData = @("NistP384", "NistP256")

# Create the registry key if it doesn't exist
if (-not (Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the REG_MULTI_SZ value
New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType MultiString -Force

# Output confirmation
Write-Host "Set '$valueName' to '$valueData' at '$registryPath'"
