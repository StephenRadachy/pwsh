$global:OMPHOME = Split-Path -Path (Get-Item -Path $PSCommandPath).Target
Get-ChildItem -Path (Join-Path -Path $global:OMPHOME -ChildPath 'Core') -Filter *.ps1 | ForEach-Object { . $_.FullName }

. (Join-Path -Path $OMPHOME -ChildPath "Themes/Relatif.ps1")

New-LocalModuleBootstrap
Import-Module "Powershell-Utilities" -Force
Import-Module "Crypto-PlusPlus" -Force
Import-Module "Docker-PlusPlus" -Force
Import-Module "Download-PlusPlus" -Force
Import-Module "Git-PlusPlus" -Force
Import-Module "Ssh-PlusPlus" -Force
if (Test-Path (Join-Path -Path $OMPHOME -ChildPath "Modules/Work")) {
    Import-Module "Work" -Force
}
Remove-LocalModuleBootstrap

[ScriptBlock]$Prompt = {
    $lastCommandFailed = ($global:error.Count -gt $sl.ErrorCount) -or -not $?
    $prompt = (Write-Theme -lastCommandFailed $lastCommandFailed)
    $prompt
    Remove-Variable realLASTEXITCODE -Confirm:$false
}

Set-Item -Path Function:prompt -Value $Prompt -Force

Remove-Alias -Name sl -Force
Remove-Alias -Name fl -Force
Remove-Alias -Name sls -Force

Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

$env:PATH = "/opt/homebrew/bin:$HOME/.local/share/mise/shims:$env:PATH"
