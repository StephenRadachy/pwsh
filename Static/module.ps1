$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
Foreach($import in @($Public + $Private)) {
    Try { . $import.fullname }
    Catch { Write-Error -Message "Failed to import function $($import.fullname): $_" }
}
(Import-Csv $PSScriptRoot\Aliases.csv -Header Alias, Function) | ForEach-Object {
    New-Alias -Name $_.Alias -Value $_.Function -Force
}
Export-ModuleMember -Function $Public.Basename -Alias *