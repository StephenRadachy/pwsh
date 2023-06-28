function Invoke-Function() {
    Param(
        [Parameter(Mandatory=$true)]
        $type, 

        [Parameter(Mandatory=$true)]
        $description
    )

    git checkout -b "tm/stephen.radachy/$($type.ToLower())/$($description.ToLower())"
}