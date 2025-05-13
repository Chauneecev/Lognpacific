<#
.SYNOPSIS
    creates (if necessary) the registry key for the webcam consent store under HKLM and sets its “Value” to “Deny,” effectively blocking all applications from accessing the webcam.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000007 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000007 ).ps1 
#>
<#
.SYNOPSIS
  Denies webcam access by setting the CapabilityAccessManager policy.

.DESCRIPTION
  - Ensures the registry key for webcam consent exists.
  - Sets the "Value" entry to "Deny" under the local machine policy hive.
  - Requires an elevated (Administrator) PowerShell session.

.NOTES
  Tested on Windows 10 with built-in PowerShell.
#>

# 1) Verify running as Administrator
$current = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $current.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# 2) Define registry path and desired value
$regPath   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam'
$valueName = 'Value'
$valueData = 'Deny'

# 3) Create the key path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created registry path: $regPath"
}

# 4) Set the "Value" entry to "Deny"
New-ItemProperty -Path $regPath -Name $valueName -Value $valueData -PropertyType String -Force | Out-Null

# 5) Confirmation output
Write-Host "Set $valueName to $valueData at $regPath" -ForegroundColor Green
