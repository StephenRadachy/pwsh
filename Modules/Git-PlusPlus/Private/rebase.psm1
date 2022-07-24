function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$false)]
        [Alias("b")]
        [String]$syncBranch = "main"
    )

    git rebase "$syncBranch"
}