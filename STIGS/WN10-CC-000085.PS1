<#
.SYNOPSIS
    This PowerShell script ensures that the registry key HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch exists and sets the DriverLoadPolicy DWORD value to a specified value (1, 3, or 8), configuring the Early Launch AntiMalware Boot-Start Driver Initialization Policy accordingly.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000085 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000085).ps1 
#>
# Define the registry path
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch"

# Desired value: 3 (Good, unknown, and bad but critical)
$desiredValue = 3

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Retrieve the current DriverLoadPolicy value
$currentValue = Get-ItemProperty -Path $registryPath -Name "DriverLoadPolicy" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty DriverLoadPolicy -ErrorAction SilentlyContinue

# Check if the value is missing or set to 7 (which is a finding)
if (($null -eq $currentValue) -or ($currentValue -eq 7)) {
    # Set the DriverLoadPolicy to the desired value
    Set-ItemProperty -Path $registryPath -Name "DriverLoadPolicy" -Value $desiredValue -Type DWord
    Write-Host "DriverLoadPolicy was missing or set to an insecure value. It has been set to $desiredValue."
} else {
    Write-Host "DriverLoadPolicy is already set to a secure value: $currentValue."
}
