capture program drop texresults

program define texresults
syntax [using], ///
	MACROname(string) ///
	[ ///
		replace append ///
		Round(real 0) UNITzero ///
		result(string) coef(varname) se(varname) tstat(varname) pvalue(varname) ///
	]

// Parse file action
if !missing("`replace'") & !missing("`append'") {
	di as error "{bf:replace} and {bf:append} may not be specified simultaneously"
	exit 198
}
local action `replace' `append'

// Process macroname
local macroname = "\" + "`macroname'"

// Store [rounded] result
if !missing("`result'") {
	local result = round(`result', `round')
}

if !missing("`coef'") {
	local result = round(_b[`coef'], `round')
}

if !missing("`se'") {
	local result = round(_se[`se'], `round')
}

if !missing("`tstat'") {
	local result = round(_b[`tstat']/_se[`tstat'], `round')
}

if !missing("`pvalue'") {
	local result = round(2 * ttail(e(df_r), abs(_b[`pvalue']/_se[`pvalue'])), `round')
}

// Add unit zero if option is specified and result qualifies
if (!missing("`unitzero'") & abs(`result') < 1) {
	if (`result' > 0) local result 0`result'
	else local result = "-0"+"`=abs(`result')'"
}

// Create macro file
file open texresultsfile `using', write `action'
file write texresultsfile "\newcommand{`macroname'}{$`result'$}" _n
file close texresultsfile
*di as text `" Open {browse results.txt}"'

end

*
*cd "/Users/alvaro/Library/Application Support/Stata/ado/personal/texresults"
sysuse auto, clear
reg mpg trunk weight foreign
local lala 137



texresults using results.txt, macroname(extranjero) round(0.001) replace coef(foreign)
texresults using results.txt, macroname(extranjero_se) round(0.001) append se(foreign)

texresults using results.txt, macroname(cualquierwea) round(0.001) append result(e(r2))

texresults using results.txt, macroname(peso) round(0.001) append unitzero coef(weight)
texresults using results.txt, macroname(weight_tstat) round(0.01) append unitzero tstat(weight)
texresults using results.txt, macroname(foreign_pval) round(0.001) append unitzero pvalue(foreign)
