<#
.SYNOPSIS
Confirms that a URL is valid
 
.DESCRIPTION
Confirms that a URL is valid
 
.PARAMETER Address
Address to confirm
 
.EXAMPLE
Confirm-Url -Address https://google.com
#>

function Confirm-Url([string] $address) {
	$url = $address -as [System.URI]
	if ($null -ne $url.AbsoluteURI) { return $false }
	if ($url.Scheme -match '[http|https]') { return $true } else { return $false }
}