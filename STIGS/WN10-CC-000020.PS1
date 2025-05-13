<#
.SYNOPSIS
    ensures it’s running as administrator, creates the HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters registry key if missing, and sets the DisableIpSourceRouting DWORD to 2 to disable IPv6 source routing.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000020 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000020).ps1 
#>
<#
.SYNOPSIS
  Configures IPv6 source routing behavior by setting DisableIpSourceRouting to 2.

.DESCRIPTION
  • Ensures the registry path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters exists.
  • Creates or updates the DisableIpSourceRouting DWORD value to 2 (disable source routing for safe only).
  • Requires an elevated (Administrator) PowerShell session.

.NOTES
  Tested on Windows 10 with the built-in PowerShell version.
#>

# 1) Verify running as Administrator
$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# 2) Define registry path and values
$regPath    = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters'
$valueName  = 'DisableIpSourceRouting'
$valueData  = 2

# 3) Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created registry path: $regPath"
}

# 4) Set the DisableIpSourceRouting DWORD to 2
New-ItemProperty -Path $regPath `
                -Name $valueName `
                -Value $valueData `
                -PropertyType DWord `
                -Force | Out-Null

# 5) Confirmation output
Write-Host "✔ Set $valueName to $valueData at $regPath" -ForegroundColor Green
