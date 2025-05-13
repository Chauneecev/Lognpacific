<#
.SYNOPSIS
    This script ensures the HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections key exists and sets the NC_ShowSharedAccessUI DWORD to 0, disabling the Shared Access UI.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000044 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000044).ps1 
#>
<#
.SYNOPSIS
  Disables the Shared Access UI by setting the NC_ShowSharedAccessUI policy to 0.

.DESCRIPTION
  • Ensures the registry path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections exists.
  • Creates or updates the NC_ShowSharedAccessUI DWORD value to 0.
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
$regPath    = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections'
$valueName  = 'NC_ShowSharedAccessUI'
$valueData  = 0

# 3) Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created registry path: $regPath"
}

# 4) Set the NC_ShowSharedAccessUI DWORD to 0
New-ItemProperty -Path $regPath `
                -Name $valueName `
                -Value $valueData `
                -PropertyType DWord `
                -Force | Out-Null

# 5) Confirmation output
Write-Host "✔ Set $valueName to $valueData at $regPath" -ForegroundColor Green
