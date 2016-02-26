<#
Last Changed: 2016-02-26

powershell -ep bypass -f md5hash.ps1 -f md5hash.exe

#>
param (
	[string]$filename    = $null
)

### FUNCTION##################################################################

function Get-MD5Hash($fileName) {
	if([System.IO.File]::Exists($fileName)) {
		$fileStream = New-Object System.IO.FileStream($fileName,[System.IO.FileMode]::Open,[System.IO.FileAccess]::Read,[System.IO.FileShare]::ReadWrite)
		$MD5Hash = New-Object System.Security.Cryptography.MD5CryptoServiceProvider
		[byte[]]$fileByteChecksum = $MD5Hash.ComputeHash($fileStream)
		$fileChecksum = ([System.Bitconverter]::ToString($fileByteChecksum)).Replace("-","")
		$fileStream.Close()
	} else {
		$fileChecksum = "ERROR: $fileName Not Found"
	}

	return $fileChecksum
}


### MAIN #####################################################################


if (Test-Path $filename) {
	$md5 = Get-MD5Hash $filename

	Write-Host "$md5 -- $filename"
} else {
	Write-Warning "File '$filename' not found" 
}
