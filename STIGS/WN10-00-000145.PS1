<#
.SYNOPSIS
    This PowerShell script  suspends BitLocker on the C: drive, sets the system’s Data Execution Prevention policy to “OptOut” using BCDEdit, verifies the change, and then re-enables BitLocker protectors.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000145 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000145 ).ps1 
#>

<#
.SYNOPSIS
  Suspends BitLocker, configures Data Execution Prevention (DEP) to OptOut, and re-enables BitLocker.

.DESCRIPTION
  1. Checks for elevation.
  2. Suspends BitLocker protectors on C: to allow BCD modifications.
  3. Sets DEP policy to OptOut via BCDEDIT.
  4. (Optional) Verifies the new setting.
  5. Re-enables BitLocker protectors on C:.

.NOTES
  • Must be run from an elevated (Administrator) PowerShell session.
  • Tested on Windows 10 native PowerShell.
#>

# 1) Ensure script is running elevated
$currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "This script must be run as Administrator." -ForegroundColor Red
    exit 1
}

# 2) Suspend BitLocker protectors on C:
Write-Host "Suspending BitLocker protectors on C:..." -ForegroundColor Yellow
try {
    manage-bde -protectors -disable C: -ErrorAction Stop
    Write-Host "→ BitLocker protectors suspended." -ForegroundColor Green
} catch {
    Write-Error "Failed to suspend BitLocker: $_"
    exit 1
}

# 3) Configure DEP to OptOut
Write-Host "Configuring DEP (NX) policy to OptOut..." -ForegroundColor Yellow
try {
    bcdedit /set "{current}" nx OptOut 2>&1 | Write-Host
    Write-Host "→ DEP policy set to OptOut." -ForegroundColor Green
} catch {
    Write-Error "Failed to set DEP policy: $_"
}

# 4) (Optional) Verify the new DEP setting
Write-Host "Verifying DEP configuration for {current}..." -ForegroundColor Yellow
bcdedit /enum "{current}" | Select-String -Pattern "nx" | Write-Host

# 5) Re-enable BitLocker protectors on C:
Write-Host "Re-enabling BitLocker protectors on C:..." -ForegroundColor Yellow
try {
    manage-bde -protectors -enable C: -ErrorAction Stop
    Write-Host "→ BitLocker protectors re-enabled." -ForegroundColor Green
} catch {
    Write-Error "Failed to re-enable BitLocker: $_"
    exit 1
}

Write-Host "`n✔ DEP has been configured to OptOut and BitLocker protectors restored." -ForegroundColor Cyan
