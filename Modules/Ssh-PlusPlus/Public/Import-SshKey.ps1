<#
.SYNOPSIS
Add ssh key to agent
 
.DESCRIPTION
Add ssh key to agent

.Parameter Name
Name of the ssh key to import

.EXAMPLE
Get-SshKeys
#>

function Import-SshKey() {
    Param (
        [Parameter(Mandatory)]
        [ArgumentCompleter({
            param($pCmd, $pParam, $pWord, $pAst, $pFakes)
            $keys = Get-SshKeys
            if ([string]::IsNullOrWhiteSpace($pWord)) { return $keys }
            $keys | Select-String "$pWord"
        })]
        [string] $name
    )

    ssh-add (Join-Path -Path (Get-SshKeyPath) -ChildPath $name)
}