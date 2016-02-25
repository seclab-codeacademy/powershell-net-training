<#
Last Changed: 2016-02-25

powershell -ep bypass -f splitfile.ps1 -verbose


// usage:   split [infile] [offset]  [out-part1]  [out-part2]
// 
// check file size of dark.gif: 2,281 bytes  >> will be used as offset
// copy /b dark.gif+HxD.exe dark_Hxd.gif
// split dark_psinfo.gif 2281 dark_original.gif exploit.exe 


#>
param (
	[string]$inFilename    = "dark_psinfo.gif",
	[int]$offSet           = 2281,
	[string]$outFilename1  = "dark_part1.gif",
	[string]$outFilename2  = "exploit.exe",
	[switch]$verbose       = $false
)


if ($verbose) {
	"In Filename  : $inFilename " | Write-Host 
	"Offset       : 0x{0:X}  (Decimal: $offSet)" -f $offSet | Write-Host 
	"Chunk part 1 : $outFilename1 " | Write-Host 
	"Chunk part 2 : $outFilename2 " | Write-Host 
}

[byte[]]$Data = [IO.File]::ReadAllBytes($InFilename);

$outstream1 = New-Object IO.FileStream $outFilename1, ([IO.FileMode]::Create); 
$outstream1.Write($Data, 0, $offset); 
$outstream1.Close(); 

$outstream2 = New-Object IO.FileStream $outFilename2, ([IO.FileMode]::Create); 
$outstream2.Write($Data, $offset, $Data.length-$offset); 
$outstream2.Close();


