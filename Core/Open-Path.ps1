<#
.SYNOPSIS
Crossplatform open path
 
.DESCRIPTION
Crossplatform open path
 
.PARAMETER $path
path to open
 
.EXAMPLE
Open-Path https://google.com
#>

function Open-Path([string] $path) {
	if ($IsLinux) {
        xdg-open $path
    } elseif ($IsMacOS) {
        open $path
    } elseif ($IsWindows) {
        Write-Error "TODO"
    }
}