function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$false)]
        [Alias("f")]
        [Switch]$force
    )

    $branch = (git rev-parse --abbrev-ref HEAD)
    
    if ($force) {
        git push -u -f origin "$branch"
    } else {
        git push -u origin "$branch"
    }
    
    gh upstream main
}