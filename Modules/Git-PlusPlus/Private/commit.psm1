function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$false)]
        [Alias("m")]
        [Switch]$message,

        [Parameter(Mandatory=$true)]
        [String]$commitMessage
    )

    $branchName = (&git rev-parse --abbrev-ref HEAD)
    
    if (!$branchName) { return }

    $split = $branchName.split("/")
    

    if ($split.length == 2) {
        # for jdi/add-nodeid-to-span
        $type = $split[0].ToUpper()
        $storyId = $split[1].ToUpper()
    } elseif ($split.length == 4) {
        # for tm/stephen.radachy/jdi/add-nodeid-to-span
        $type = $split[2].ToUpper()
        $storyId = $split[3].ToUpper()
    }

    if ($type -eq "STORY") {
        git commit -m "$($storyId): $($commitMessage)"
    } else {
        git commit -m "$($type): $($commitMessage)"
    }
}