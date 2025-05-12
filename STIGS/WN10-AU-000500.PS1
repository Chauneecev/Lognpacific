<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/Chauneecev
    Date Created    : 2025-05-11
    Last Modified   : 2025-05-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE# Define the registry path and value
$regPath  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$name     = 'MaxSize'
$value    = 0x8000          # 0x00008000

# Create the key if it doesn’t exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the MaxSize DWORD value
New-ItemProperty -Path $regPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

Write-Host "Registry value [$name] set to 0x$value at $regPath"
