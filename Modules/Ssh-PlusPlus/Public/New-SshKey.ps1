<#
.SYNOPSIS
Create new ssh key
 
.DESCRIPTION
Create new ssh key

.Parameter Name
Name of the new ssh key

.EXAMPLE
New-SshKey -Name github
#>

function New-SshKey() {
    Param (
        [Parameter(Mandatory)]
        [string] $name
    )

    if (Test-Path (Join-Path -Path (Get-SshKeyPath) -ChildPath $name)) {
        Write-Warning "Ssh key $name exists. Please choose another name"
    } else {
        ssh-keygen -b 4096 -t rsa -f (Join-Path -Path (Get-SshKeyPath) -ChildPath $name) -C (whoami)
    }
}