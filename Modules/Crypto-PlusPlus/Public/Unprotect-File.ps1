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
Unprotect-File -input file.enc -output file.txt
#>

function Unprotect-File() {
    Param (
        [Parameter(Mandatory=$true)]
        [String] $in,
        [Parameter(Mandatory=$true)]
        [String] $out
    )
    $command = "/usr/local/opt/libressl/bin/openssl enc -aes-256-cbc -pbkdf2 -d -in `"$in`" -out `"$out`""
    Invoke-Expression $command
}
