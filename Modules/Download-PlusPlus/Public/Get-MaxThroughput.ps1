<#
.SYNOPSIS
Converts curl commands to aria2 for maximum throughput 💪🔥
 
.DESCRIPTION
Converts curl commands to aria2 for maximum throughput 💪🔥
 
.PARAMETER command
curl command

.EXAMPLE
Get-MaxThroughput -command "<curl_command>"
#>

function Get-MaxThroughput() {
    Param (
        [Parameter(Mandatory=$true)]
        [String] $command
    )
    $command = (Write-Output "$command" | sed 's/curl/aria2c -x16 -s16/g' | sed 's/--compressed/--http-accept-gzip/g' | sed 's/-H/--header/g' | sed 's/(--insecure|)/--check-certificate false/g')
    Invoke-Expression $command
}
