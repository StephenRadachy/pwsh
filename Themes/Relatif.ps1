#region Config
[ConsoleColor[]] $dirColors = @(
    [ConsoleColor]::Magenta,
    [ConsoleColor]::Red,
    [ConsoleColor]::Blue
)
#endregion Config

function Write-Theme ([bool] $lastCommandFailed, [string] $with) {
    [System.Text.StringBuilder] $script:prompt = [System.Text.StringBuilder]::new()
    if (Get-GitStatus) {
        $gitprompt = '[ ' + (&starship prompt) + ' ] '
        Write-Segment -Text $gitprompt -Color ([ConsoleColor]::gray)
    } else {
        Write-Segment -Text '[ ' -Color ([ConsoleColor]::White)
        Write-Location
        Write-Segment -Text ' ] ' -Color ([ConsoleColor]::White)
    }
}

#region Location
function Write-Location {
    if (Get-GitStatus) { return }
    $currentLocation = (Get-Location).tostring()
    if ($currentLocation -match $HOME) {
        Write-RelativeLocation '~' $currentLocation.Substring($HOME.length)
    } else {
        Write-RelativeLocation '/' $currentLocation
    }
}

function Write-RelativeLocation ([string] $basePath, [string] $relativePath) {
    Write-Segment -Text $basePath -Color ([ConsoleColor]::Blue)
    [string[]] $ary = Split-PathBySeparator $relativePath
    if ($ary.Length -eq 0) { return }
    (0..($ary.Length - 1)) | ForEach-Object {
        Write-Separator
        Write-Segment -Text $ary[$_] -Color $dirColors[$_ % $dirColors.Length]
    }
}
#endregion Location

#region Utilities
function Write-Separator { Write-Segment -Text " | " -Color ([ConsoleColor]::White) }
function Write-Segment ([string]$text, [ConsoleColor]$color) { $prompt | Write-Prompt -Object $text -ForegroundColor $color }
function Split-PathBySeparator { $args[0].Trim().Split([System.IO.Path]::DirectorySeparatorChar).Where{ $_ } }
#endregion Utilities