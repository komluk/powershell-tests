param(
  [Parameter(Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string]$FilePath
  )
Describe "Testing against PSSA rules (file = $FilePath)" {
       Context 'PSSA Standard Rules' {
	   
			$analysis = Invoke-ScriptAnalyzer -Path $FilePath
			$scriptAnalyzerRules = Get-ScriptAnalyzerRule

			forEach ($rule in $scriptAnalyzerRules) {
				It "Should pass $rule" {
					If ($analysis.RuleName -contains $rule) {
						$analysis |
							 Where RuleName -EQ $rule -outvariable failures |
							 Out-Default
						$failures | ForEach-Object { $_.ScriptName + ", line:" + $_.Line } | Should Be $Null
					}
				}
			}
    }
}