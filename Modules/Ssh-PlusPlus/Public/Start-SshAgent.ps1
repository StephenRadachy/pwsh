<#
.SYNOPSIS
Starts ssh agent
 
.DESCRIPTION
Starts ssh agent

.EXAMPLE
Start-Ssh-Agent
#>

function Start-SshAgent() {
    Invoke-Expression 'ssh-agent -s | Out-Null'
}