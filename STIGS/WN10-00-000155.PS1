<#
.SYNOPSIS
    This PowerShell script checks whether the Windows PowerShell 2.0 features (MicrosoftWindowsPowerShellV2 and MicrosoftWindowsPowerShellV2Root) are enabled and reports any findings, exiting with an error code if they are.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000155

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000155).ps1 
#>

<#
.SYNOPSIS
  Checks for Windows PowerShell 2.0 optional features and reports any that are enabled.

.DESCRIPTION
  1. Queries the online Windows optional features for any with "PowerShellV2" in their name.
  2. Filters to those whose State is "Enabled".
  3. Reports each enabled feature as a finding.
  4. Exits with code 1 if any findings are present, or 0 if none.

.NOTES
  - Must be run from an elevated (Administrator) PowerShell prompt.
  - Tested on Windows 10.
#>

# List of features to check
$featureNames = @(
    'MicrosoftWindowsPowerShellV2',
    'MicrosoftWindowsPowerShellV2Root'
)

# Query online features and filter to our list
$features = Get-WindowsOptionalFeature -Online `
    | Where-Object { $featureNames -contains $_.FeatureName }

# Filter to those that are enabled
$enabled = $features | Where-Object State -eq 'Enabled'

if ($enabled.Count -gt 0) {
    Write-Host "FINDINGS: The following PowerShell v2 features are enabled:" -ForegroundColor Red
    $enabled | ForEach-Object {
        Write-Host "  - $($_.FeatureName) (`State`: $($_.State))"
    }
    exit 1
}
else {
    Write-Host "No PowerShell v2 features are enabled." -ForegroundColor Green
    exit 0
}
