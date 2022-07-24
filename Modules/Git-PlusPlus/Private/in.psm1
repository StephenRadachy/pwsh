function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$false)]
        [Alias("m")]
        [Switch]$message,

        [Parameter(Mandatory=$true)]
        [String]$commitMessage
    )
    git add .
    git commit -m "🚧: $($commitMessage)"
}