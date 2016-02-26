<#
Last Changed: 2016-02-26

powershell -ep bypass -f Base64Decoder.ps1  -i exploit.exe.b64  -o exploit.exe 

#>
param (
	[string]$inFile    = $null,
	[string]$outFile   = $null,
	[switch]$verbose   = $false
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


### MAIN ######################################################################

if (Test-Path $inFile) {

	$Data = [IO.File]::ReadAllText($inFile)
	[IO.File]::WriteAllBytes(($outFile), [system.convert]::FromBase64String($Data))

	$md5 = Get-MD5Hash $outFile
	Write-Host "Input Base64 Filename     : $inFile"
	Write-Host "Extracted Base64 Filename : $outFile"
	Write-Host "MD5                       : $md5"
} else {
	Write-Warning "File '$inFile' not found" 
}

