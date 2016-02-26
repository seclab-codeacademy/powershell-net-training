<#
Last Changed: 2016-02-26

### Windows 7 32BIT Offset: 21100 (0x526C)
powershell -ep bypass -f patchme.ps1 -f cmd_disabled.exe  -offset 0x526C -value 0x21 -verbose

### Windows 7 64BIT Offset: 164474 (0x02827A)
powershell -ep bypass -f patchme.ps1 -f cmd_disabled.exe  -offset 0x02827A -value 0x21 -verbose
 
#>
param (
	[string]$filename  = $null,
	[int]$offSet       = 0x526C,
	[int]$value        = 0x21,
	[switch]$verbose   = $false
)


### MAIN ################################################

if ($verbose) {
	[byte[]]$Data = [IO.File]::ReadAllBytes($filename)
	'Offset     : 0x{0:X}' -f $offSet | Write-Host 
	'Old Value  : 0x{0:X}' -f $Data[$offSet] | Write-Host 
}

if (Test-Path $filename) {
	[byte[]]$Data = [IO.File]::ReadAllBytes($filename)
	$Data[$offSet]= [byte]$value
	[IO.File]::WriteAllBytes($filename, $Data) 
} else {
	Write-Warning "File '$filename' not found"
	exit
}

if ($verbose) {
	[byte[]]$Data = [IO.File]::ReadAllBytes($filename)
	'New Value  : 0x{0:X}' -f $Data[$offSet] | Write-Host 
}

