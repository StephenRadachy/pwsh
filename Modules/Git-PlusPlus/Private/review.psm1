function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$true)]
        [Alias("i")]
        [String]$prId
    )

    git branch -D "PR-$($prId)"
    git fetch upstream "pull/$($prId)/head:PR-$($prId)"
    git checkout "PR-$($prId)"
}