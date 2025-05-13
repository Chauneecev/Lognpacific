<#
.SYNOPSIS
    This PowerShell script connects to Microsoft 365 using the Connect-MgGraph module with specific scopes and retrieves all user objects from Azure AD using the Microsoft Graph API.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000050 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000050).ps1 
#>
# Define the registry path and values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths"
$netlogonValueName = "\\*\NETLOGON"
$netlogonValueData = "RequireMutualAuthentication=1, RequireIntegrity=1"
$sysvolValueName = "\\*\SYSVOL"
$sysvolValueData = "RequireMutualAuthentication=1, RequireIntegrity=1"

# Set the registry values
Set-ItemProperty -Path $registryPath -Name $netlogonValueName -Value $netlogonValueData -Type String
Set-ItemProperty -Path $registryPath -Name $sysvolValueName -Value $sysvolValueData -Type String

# Output confirmation
Write-Host "Set '$netlogonValueName' to '$netlogonValueData' and '$sysvolValueName' to '$sysvolValueData' at '$registryPath'"
