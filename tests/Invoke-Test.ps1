$ErrorActionPreference = 'stop'
Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force -Confirm:$false
Import-Module Pester
Import-Module PSScriptAnalyzer
$srcDirectory = '..\src\'
$files = Get-ChildItem -Path $srcDirectory -Filter *.ps1 -Recurse -Name
forEach ($file in $files) {
	$outfile = "$srcDirectory$file.PSSAResults.xml" -replace "\\", "-"
	Invoke-Pester -OutputFile $outfile -OutputFormat 'NUnitXml' -Script @{Path='.\PSSA.tests.ps1'; Parameters=@{FilePath="$srcDirectory$file"}}
}