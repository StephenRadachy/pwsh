<#
.SYNOPSIS
Sets the location to the root of a git repository
 
.DESCRIPTION
Sets the location to the root of a git repository

.EXAMPLE
Set-LocationToGitRoot
#>
function Set-LocationToGitRoot () { Set-Location -Path (&git rev-parse --show-toplevel) }