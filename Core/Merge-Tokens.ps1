<#
.SYNOPSIS
Replaces tokens in a block of text with a specified value.
 
.DESCRIPTION
Replaces tokens in a block of text with a specified value.
 
.PARAMETER template
The block of text that contains text and tokens to be replaced.
 
.PARAMETER tokens
Token name / value hashtable.
 
.EXAMPLE
$content = Get-Content <filename>.template | Merge-Tokens -tokens @{FirstName: 'foo'; LastName: 'bar'}
Pass template to function via pipeline.
#>
function Merge-Tokens() {
    [CmdletBinding()] 
    param (
        [Parameter(Mandatory=$True, ValueFromPipeline=$true)]
        [AllowEmptyString()]
        [String] $template,

        [Parameter(Mandatory=$true)]
        [HashTable] $tokens
    ) 
    begin { Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin" }
    process {
        Write-Verbose "$($MyInvocation.MyCommand.Name)::Process"
        try {
            [regex]::Replace( $template, '__(?<tokenName>[\w\.]+)__', {
              param($match)

              $tokenName = $match.Groups['tokenName'].Value
              Write-Debug $tokenName
              
              $tokenValue = Invoke-Expression "`$tokens.$tokenName"
              Write-Debug $tokenValue

              if ($tokenValue) { return $tokenValue } else { return $match }
            })
        } catch { Write-Error $_ }
    }
    end { Write-Verbose "$($MyInvocation.MyCommand.Name)::End" }
}
