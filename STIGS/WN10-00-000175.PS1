<#
.SYNOPSIS
    This PowerShell script verifies the “Secondary Logon” (seclogon) service’s startup type and status, and if it isn’t disabled or is running, it disables the service’s startup type and confirms the update.
.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000175).ps1 
#>

<#
.SYNOPSIS
  Check and disable the Secondary Logon service if it’s set to start or currently running.

.DESCRIPTION
  1. Retrieves the Secondary Logon (seclogon) service.
  2. Reports a finding if its StartupType is not Disabled or if it’s currently running.
  3. Sets the service’s StartupType to Disabled.

.NOTES
  - Must be run in an elevated (Administrator) PowerShell session.
  - Tested on Windows 10 (native PowerShell version).
#>

# Define the service name
$serviceName = 'seclogon'

# Get the service object (for Status) and WMI/CIM object (for StartMode)
$svc       = Get-Service -Name $serviceName -ErrorAction Stop
$svcCim    = Get-CimInstance -ClassName Win32_Service -Filter "Name='$serviceName'" -ErrorAction Stop

# Extract current values
$currentStatus    = $svc.Status          # e.g. Running, Stopped
$currentStartMode = $svcCim.StartMode    # e.g. Auto, Manual, Disabled

# Check for findings
if ($currentStartMode -ne 'Disabled' -or $currentStatus -eq 'Running') {
    Write-Host "FINDING: Secondary Logon (`$serviceName`) is set to '$currentStartMode' and is '$currentStatus'." -ForegroundColor Yellow

    # Remediation: disable startup type
    Write-Host "Remediating: setting StartupType to 'Disabled'..."
    Set-Service -Name $serviceName -StartupType Disabled

    # Confirm change
    $newStartMode = (Get-CimInstance Win32_Service -Filter "Name='$serviceName'").StartMode
    Write-Host "StartupType is now: $newStartMode" -ForegroundColor Green
}
else {
    Write-Host "✔ Secondary Logon service is already disabled and not running." -ForegroundColor Green
}
