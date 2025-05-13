<#
.SYNOPSIS
    ensures the registry key HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization exists and sets the NoLockScreenSlideshow DWORD value to 1, disabling the lock screen slideshow.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000010).ps1 
#>
<#
.SYNOPSIS
  Disables the lock screen slideshow by setting the NoLockScreenSlideshow policy.

.DESCRIPTION
  • Ensures the registry path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization exists.
  • Creates or updates the NoLockScreenSlideshow DWORD value to 1.
  • Requires an elevated (Administrator) PowerShell session.

.NOTES
  Tested on Windows 10 with the built-in PowerShell version.
#>

# 1) Verify running as Administrator
$currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# 2) Define registry path and values
$regPath    = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
$valueName  = 'NoLockScreenSlideshow'
$valueData  = 1

# 3) Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created registry path: $regPath"
}

# 4) Set the NoLockScreenSlideshow DWORD to 1
New-ItemProperty -Path $regPath `
                -Name $valueName `
                -Value $valueData `
                -PropertyType DWord `
                -Force | Out-Null

# 5) Confirmation output
Write-Host "✔ Set $valueName to $valueData at $regPath" -ForegroundColor Green
