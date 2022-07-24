<#
.SYNOPSIS
Creates a symbolic link.
 
.DESCRIPTION
Creates a symbolic link. Powershell version of "ln -s <target> <link_name>"
 
.PARAMETER target
Path to create a symbolic link to
 
.PARAMETER link
Path for symbolic link to be created at
 
.EXAMPLE
New-Symlink -Target "$HOME/.gitconfig" -Link "$HOME/repo/gitconfig.generated"
#>
function New-Symlink ([string] $target, [string] $link) { New-Item -Path $link -ItemType SymbolicLink -Value $target -Force | Out-Null }
