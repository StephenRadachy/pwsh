function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$true)]
        [String]$image,
        [Parameter(Mandatory=$true)]
        [String]$command
    )
    $workingDirectory = (Get-Location)
    docker run -it --rm -v "$workingDirectory`:/current-dir" "$image" "$command"
}