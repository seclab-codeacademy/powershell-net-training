<#
Last Changed: 2016-02-25

powershell -ep bypass -f patchme.ps1 -f cmd_disabled.exe  -offset 0x526C -value 0x42 -verbose

#>
param (
	[string]$filename  = "cmd_disabled.exe",
	[int]$offSet       = 0x526C,
	[int]$value        = 0x42,
	[switch]$verbose   = $false
)


### MAIN ################################################


if ($verbose) {
	[byte[]]$Data = [IO.File]::ReadAllBytes($filename)
	'Offset     : 0x{0:X}' -f $offSet | Write-Host 
	'Old Value  : 0x{0:X}' -f $Data[$offSet] | Write-Host 
}


[byte[]]$Data = [IO.File]::ReadAllBytes($filename)
$Data[$offSet]= [byte]$value
[IO.File]::WriteAllBytes($filename, $Data) 


if ($verbose) {
	[byte[]]$Data = [IO.File]::ReadAllBytes($filename)
	'New Value  : 0x{0:X}' -f $Data[$offSet] | Write-Host 
}

