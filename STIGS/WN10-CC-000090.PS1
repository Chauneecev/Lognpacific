<#
.SYNOPSIS
    This PowerShell script exports the membership of an Active Directory group to a CSV file by retrieving the group's distinguished name and using Get-ADGroupMember to list its members.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000090 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000090).ps1 
#>
# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"

# Desired value
$desiredValue = 0

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the NoGPOListChanges value
Set-ItemProperty -Path $registryPath -Name "NoGPOListChanges" -Value $desiredValue -Type DWord

# Output confirmation
Write-Host "Set 'NoGPOListChanges' to '$desiredValue' at '$registryPath'"
