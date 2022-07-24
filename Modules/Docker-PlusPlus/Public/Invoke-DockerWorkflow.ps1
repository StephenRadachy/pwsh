<#
.SYNOPSIS
Invoke Docker workflow
 
.DESCRIPTION
Invoke Docker workflow - leverages Splatting
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting?view=powershell-7#:~:text=Splatting%20is%20a%20method%20of,collection%20with%20a%20command%20parameter.

Note: If you make a function into an advanced function by using either the CmdletBinding or Parameter attributes, the $args automatic variable is no longer available in the function. Advanced functions require explicit parameter definition.

.EXAMPLE
Invoke-DockerWorkflow
#>
function Invoke-DockerWorkflow() {
    param($command)

    $scriptPath = (Join-Path -Path $OMPHOME -ChildPath "Modules/Docker-PlusPlus/Private/Invoke-DockerWorkflow")
    
    if ($command -and (Test-Path (Join-Path -Path $scriptPath -ChildPath "$command.psm1"))) {
        Import-Module (Join-Path -Path $scriptPath -ChildPath "$command.psm1") -Force
        Get-Command -Module "Invoke-Function"
        Invoke-Function @Args
    } else {
        foreach($_ in Get-ChildItem $scriptPath -Name) {
            [System.IO.Path]::GetFileNameWithoutExtension($_)
        }
    }
}