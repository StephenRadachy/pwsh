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
    $type = $split[0].ToUpper()
    $storyId = $split[1].ToUpper()

    if ($type -eq "STORY") {
        git commit -m "$($storyId): $($commitMessage)"
    } else {
        git commit -m "$($type): $($commitMessage)"
    }
}