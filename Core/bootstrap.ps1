$env:PSModulePath = $env:PSModulePath + "$([System.IO.Path]::PathSeparator)$(Join-Path -Path $global:OMPHOME -ChildPath 'Modules')"

function New-LocalModuleBootstrap() {
    Get-ChildItem -Path (Join-Path -Path $global:OMPHOME -ChildPath 'Modules') | ForEach-Object {
        $moduleName = $_.Name
        New-Symlink -target (Join-Path -Path "$global:OMPHOME/Static" -ChildPath 'module.ps1') -link (Join-Path -Path "$global:OMPHOME/Modules" -ChildPath "$moduleName/$moduleName.psm1")
    }
}

function Remove-LocalModuleBootstrap() {
    Get-ChildItem -Path (Join-Path -Path $global:OMPHOME -ChildPath 'Modules') | ForEach-Object {
        $moduleDir = $_.FullName
        $moduleName = $_.Name
        Remove-Item -Path "$moduleDir/$moduleName.psm1"
    }
}

function New-Backup([string] $path) {
    if (Test-Path $path -PathType Leaf) { 
        if ($IsMacOS) { # as of 3/2/2020 Move-Item doesn't work with hidden files on Mac OS
            mv $path "$path.bak"
        } else {
            Move-Item -Path $path -Destination "$path.bak" -Force
        }
    }
}

function Install-PrerequisiteModule([string] $module) { Install-Module $module -Scope CurrentUser -Force }

function Get-Configuration() {
    $tokens = @{
        Home = $HOME
        ScriptRoot = $global:OMPHOME
        Profile = (Split-Path -Path $PROFILE.CurrentUserAllHosts)
    }

    $tempFile = New-TemporaryFile
    Get-Content (Resolve-Path -path "$global:OMPHOME/Configuration/Configuration.psd1") | Merge-Tokens -tokens $tokens | Out-File -FilePath $tempFile -Force
    $config = Import-PowerShellDataFile -Path $tempFile
    Remove-Item -Path $tempFile -Force
    return $config
}

function New-GeneratedTemplates([PSCustomObject] $templates) {
    class TemplatedConfig {
        [ValidateNotNullOrEmpty()][string]$name
        [ValidateNotNullOrEmpty()][string]$templateFilename
        [ValidateNotNullOrEmpty()][string]$path
        [PSCustomObject]$tokens
    
        TemplatedConfig($name, $path, $tokens) {
            $this.name = $name
            $this.templateFilename = (Join-Path -Path $global:OMPHOME -ChildPath "Templates/$name.template")
            $this.path = $path
            $this.tokens = $tokens
        }
    }

    $generatedFolder = 'Generated'

    # Recreate Generated folder
    if (Test-Path -Path $generatedFolder) { Remove-Item -Path $generatedFolder -Recurse -Force }
    New-Item -Path $generatedFolder -ItemType 'directory' | Out-Null

    $templates | ForEach-Object { 
        return [TemplatedConfig]::new($_.Name, $_.Path, $_.Tokens)
    } | ForEach-Object {
        New-Backup -path $_.path
        $generated = [string](Join-Path -Path $generatedFolder -ChildPath $_.name)
        Get-Content $_.templateFilename | Merge-Tokens -tokens $_.tokens | Out-File -FilePath $generated -Force
        New-Symlink -target (Join-Path -Path $global:OMPHOME -ChildPath $generated) -link $_.path
    }
}