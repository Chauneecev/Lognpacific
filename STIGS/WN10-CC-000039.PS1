<#
.SYNOPSIS
    sets the SuppressionPolicy registry value to 4096 across multiple file type associations (batfile, cmdfile, exefile, mscfile) to suppress user consent prompts for elevated privilege operations.

.NOTES
    Author          : Chauneece Vance
    LinkedIn        : linkedin.com/in/chauneecevance/
    GitHub          : github.com/chauneecev
    Date Created    : 2025-05-13
    Last Modified   : 2025-05-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000039 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000039).ps1 
#>
# Define the registry paths and value
$registryPaths = @(
    "HKLM:\SOFTWARE\Classes\batfile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\cmdfile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\exefile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\mscfile\shell\runasuser"
)
$valueName = "SuppressionPolicy"
$valueData = 0x00001000  # Hexadecimal value 4096

# Set the registry value for each path
foreach ($path in $registryPaths) {
    Set-ItemProperty -Path $path -Name $valueName -Value $valueData -Type DWord
}

# Output confirmation
Write-Host "Set '$valueName' to '$valueData' at the following registry paths:"
foreach ($path in $registryPaths) {
    Write-Host "- $path"
}
