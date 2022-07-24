function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$true)]
        $type, 

        [Parameter(Mandatory=$true)]
        $description
    )

    git checkout -b "$($type.ToLower())/$($description.ToLower())"
}