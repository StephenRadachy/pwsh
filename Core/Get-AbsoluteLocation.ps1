<#
.SYNOPSIS
Finds the absolute location of a file
 
.DESCRIPTION
Finds the absolute location of a file
 
.PARAMETER path
Path to find absolute location of
 
.EXAMPLE
Get-AbsoluteLocation $PSCommandPath
#>
function Get-AbsoluteLocation([string] $path) {
    # https://stackoverflow.com/a/818054
    $isSymlink = (Get-Item $path -Force -ea SilentlyContinue).Attributes -band [IO.FileAttributes]::ReparsePoint
    
    if ($isSymlink) {
        return [string](Get-Item $path).Target
    } else {
        return [string]$path
    }
}
