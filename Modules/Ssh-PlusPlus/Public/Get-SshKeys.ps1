<#
.SYNOPSIS
Get list of ssh-keys
 
.DESCRIPTION
Get list of ssh-keys
 
.EXAMPLE
Get-SshKeys
#>

function Get-SshKeys() {
    $exclude = @('*.pub', 'authorized_keys', 'config', 'known_hosts')
    return (Get-ChildItem (Get-SshKeyPath) -Recurse -Exclude $exclude | ForEach-Object { $_.Name })
}