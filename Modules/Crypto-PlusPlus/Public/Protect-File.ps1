<#
.SYNOPSIS
Encrypts a file using openssl
 
.DESCRIPTION
Encrypts a file using openssl
 
.PARAMETER in
input file path
 
.PARAMETER out
output file path

.EXAMPLE
Protect-File -input file.txt -output file.enc
#>

function Protect-File() {
    Param (
        [Parameter(Mandatory=$true)]
        [String] $in,
        [Parameter(Mandatory=$true)]
        [String] $out
    )
    $command = "/usr/local/opt/libressl/bin/openssl enc -aes-256-cbc -pbkdf2 -in `"$in`" -out `"$out`""
    Invoke-Expression $command
}
