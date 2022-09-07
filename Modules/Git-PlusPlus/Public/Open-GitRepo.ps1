#requires -Modules Powershell-Utilities
<#
.SYNOPSIS
Opens the current git repo using the default browser
 
.DESCRIPTION
Opens the current git repo using the default browser

.EXAMPLE
Open-GitRepo
#>
function Open-GitRepo () {
    Param (
        [Parameter(Mandatory=$false)]
        [ArgumentCompleter({
            param($pCmd, $pParam, $pWord, $pAst, $pFakes)
            $remoteList = (&git remote)
            if ([string]::IsNullOrWhiteSpace($pWord)) { return $remoteList }
            $remoteList | Select-String "$pWord"
        })]
        [string] $remote = "origin",

        [Parameter(Mandatory=$false)]
        [ArgumentCompleter({
            param($pCmd, $pParam, $pWord, $pAst, $pFakes)
            $branchList = (&git branch --format='%(refname:short)')
            if ([string]::IsNullOrWhiteSpace($pWord)) { return $branchList }
            $branchList | Select-String "$pWord"
        })]
        [string] $branch = "main"
    )

    $remoteUrl = "remote.$remote.url"
    $giturl = (&git config --get $remoteUrl)

    if (!$giturl) {
        Write-Error "$remoteUrl is not set"
        return
    }

    $uri = ($giturl -as [System.URI])

    if ($uri.Host) {
        $baseUrl = "https://$($uri.Host)$($uri.PathAndQuery -replace '\.git$','')"
    } else {
        $sshUrl = $giturl.split(':')
        $repoDomain = $sshUrl[0].split('@')[1]
        $repoPath = $sshUrl[1] -replace '\.git$',''
        $baseUrl = "https://$repoDomain/$repoPath"
    }

    if ($branch -eq "main") {
        $openUrl = $baseUrl
    } else {
        $openUrl = "$baseUrl/tree/$branch"
    }
    
    Open-Path $openUrl
}