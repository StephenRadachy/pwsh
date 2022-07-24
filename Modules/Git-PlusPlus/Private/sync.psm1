function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$false)]
        [Alias("b")]
        [String]$syncBranch = "main"
    )
    $branch = (&git rev-parse --abbrev-ref HEAD)
    git checkout "$syncBranch"
    git fetch upstream
    git rebase upstream/"$syncBranch"
    git checkout "$branch"
}