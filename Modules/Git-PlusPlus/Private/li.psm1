function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$false)]
        [Alias("b")]
        [String]$squashBranch = "main"
    )

    $branchCommitCount = [int](&git rev-list --count HEAD "^$squashBranch")
    if ($branchCommitCount -lt 2) {
        Write-Error "Not enough commits on this branch to squash"
        return
    }

    git rebase -i "head~$branchCommitCount"
}