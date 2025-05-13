<#
.SYNOPSIS
    This PowerShell script sets the NoNameReleaseOnDemand registry value to 1 under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netbt\Parameters, configuring the system to ignore NetBIOS name release requests from non-WINS servers, thereby enhancing security by mitigating potential denial-of-service attacks that exploit name release mechanisms.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000035 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000035).ps1 
#>
# Define the registry path and value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Netbt\Parameters"
$valueName = "NoNameReleaseOnDemand"
$valueData = 1

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output confirmation
Write-Host "Set '$valueName' to '$valueData' at '$registryPath'"
