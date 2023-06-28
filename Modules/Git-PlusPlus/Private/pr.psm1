function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$false)]
        [Alias("f")]
        [Switch]$force,
        [Parameter(Mandatory=$false)]
        [Alias("r")]
        [string]$remote = "upstream"
    )

    $branch = (git rev-parse --abbrev-ref HEAD)
    
    if ($force) {
        git push -u -f $remote "$branch"
    } else {
        git push -u $remote "$branch"
    }
    
    gh upstream main
}