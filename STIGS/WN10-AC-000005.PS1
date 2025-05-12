<#
.SYNOPSIS
    This PowerShell script  checks the current Windows account lockout duration and, if it’s greater than zero but less than 15 minutes, automatically updates it to 15 minutes; otherwise, it leaves the setting unchanged.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000005).ps1 
#>

<#
.SYNOPSIS
  Verify and enforce a minimum account lockout duration of 15 minutes (or allow 0).

.DESCRIPTION
  • Uses `net accounts` to read the current lockout duration.
  • If Duration > 0 and < 15, reports a finding and sets it to 15.
  • If Duration = 0 or ≥ 15, reports no action needed.
  • Requires an elevated (Administrator) session.
#>

# 1) Retrieve the "Lockout duration" line
$lockoutLine = net accounts | Select-String 'Lockout duration'

if (-not $lockoutLine) {
    Write-Error "Unable to determine current account lockout duration."
    exit 1
}

# 2) Parse out the numeric value (minutes)
if ($lockoutLine.Line -match ':\s*(\d+)\s*$') {
    $duration = [int]$Matches[1]
} else {
    Write-Error "Unexpected format: '$($lockoutLine.Line)'"
    exit 1
}

Write-Host "Current account lockout duration: $duration minute(s)."

# 3) Check & remediate if needed
if ($duration -gt 0 -and $duration -lt 15) {
    Write-Warning "Finding: lockout duration is less than 15 minutes."
    Write-Host "Remediating: setting lockout duration to 15 minutes..."
    net accounts /lockoutduration:15 | Out-Null
    Write-Host "✔ Account lockout duration is now 15 minutes."
} else {
    Write-Host "✔ No action required (duration is $duration minute(s))."
}
