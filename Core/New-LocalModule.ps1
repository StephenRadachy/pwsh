<#
.SYNOPSIS
Create New local powershell module
 
.DESCRIPTION
Create New local powershell module

.Parameter Name
Name of the local powershell module to create

.EXAMPLE
New-LocalModule -Name New-Module
New-LocalModule -Name New-Module -Here
#>

function New-LocalModule() {
    Param (
        [Parameter(Mandatory)]
        [string] $name,
        [Parameter(Mandatory=$false)]
        [Switch] $here
    )

    if ($here) {
        $location = Get-Location
    } else {
        $location = $OMPHOME
    }

    $loadedModules = (Get-Module | ForEach-Object { $_.Name })
    $localModules = (Get-ChildItem -Path (Join-Path -Path $OMPHOME -ChildPath 'Modules') | ForEach-Object { $_.Name })
    $combinedModules = ("$loadedModules$localModules" | Sort-Object -Unique).Split(' ')
    
    if ($combinedModules -like $name) {
        Write-Warning "Module $name exists. Please choose another name"
    } else {
        New-Item -ItemType Directory -Path (Join-Path -Path $location -ChildPath "Modules/$Name")
        New-Item -ItemType Directory -Path (Join-Path -Path $location -ChildPath "Modules/$Name/Public")
        New-Item -ItemType Directory -Path (Join-Path -Path $location -ChildPath "Modules/$Name/Private")
        New-Item -ItemType Directory -Path (Join-Path -Path $location -ChildPath "Modules/$Name/Tests")
        New-Item -ItemType File -Path (Join-Path -Path $location -ChildPath "Modules/$Name/Aliases.csv")
        New-Item -ItemType File -Path (Join-Path -Path $location -ChildPath "Modules/$Name/Public/.empty")
        New-Item -ItemType File -Path (Join-Path -Path $location -ChildPath "Modules/$Name/Private/.empty")
        New-Item -ItemType File -Path (Join-Path -Path $location -ChildPath "Modules/$Name/Tests/.empty")
    }
}