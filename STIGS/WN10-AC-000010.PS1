<#
.SYNOPSIS
    This PowerShell script checks the current local account lockout threshold and, if it’s set to 0 or above 3 invalid logon attempts, resets it to 3.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000010  

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000010).ps1 
#>
<#
.SYNOPSIS
  Verifies and enforces a local account lockout threshold of 1–3 invalid logon attempts.

.DESCRIPTION
  • Reads the current “Lockout threshold” from the local Account Lockout Policy via `net accounts`.  
  • If it is set to 0 (no lockout) or greater than 3, reports a finding and sets it to 3.  
  • Otherwise, reports that no action is needed.  

.NOTES
  • Must be run in an elevated (Administrator) PowerShell session on Windows 10.  
  • Uses only built-in Windows tools (net.exe).
#>

# 1) Ensure we’re running as Administrator
$me = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $me.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# 2) Query current lockout threshold
$netOutput = net accounts 2>&1
$line = $netOutput | Select-String -Pattern 'Lockout threshold'
if ($line -and $line.Line -match ':\s*(\d+)\s*$') {
    $current = [int]$Matches[1]
    Write-Host "Current account lockout threshold: $current"
} else {
    Write-Error "Unable to determine current lockout threshold."
    exit 1
}

# 3) Check and remediate if it’s 0 or >3
if ($current -eq 0 -or $current -gt 3) {
    Write-Warning "Finding: Lockout threshold is $current (must be 1–3)."
    Write-Host "Setting account lockout threshold to 3..."
    net accounts /lockoutthreshold:3 | Out-Null
    Write-Host "✔ Account lockout threshold has been set to 3." -ForegroundColor Green
} else {
    Write-Host "✔ Account lockout threshold ($current) is within acceptable range (1–3)." -ForegroundColor Green
}
