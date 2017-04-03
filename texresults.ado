*! 1.1 Alvaro Carril 03apr2017
program define texresults
syntax [using], ///
	MACROname(string) ///
	[ ///
		replace append ///
		Round(real 0) UNITzero ///
		result(string) coef(varname) se(varname) tstat(varname) pvalue(varname) ///
	]


* Initial checks and processing
*------------------------------------------------------------------------------
// Parse file action
if !missing("`replace'") & !missing("`append'") {
	di as error "{bf:replace} and {bf:append} may not be specified simultaneously"
	exit 198
}
local action `replace' `append'

// Process macroname
local macroname = "\" + "`macroname'"


* Process and store [rounded] result
*------------------------------------------------------------------------------

// general result (scalar, local, etc.)
if !missing("`result'") {
	local result = round(`result', `round')
}
// coefficient
if !missing("`coef'") {
	local result = round(_b[`coef'], `round')
}
// standard error
if !missing("`se'") {
	local result = round(_se[`se'], `round')
}
// t-stat
if !missing("`tstat'") {
	local result = round(_b[`tstat']/_se[`tstat'], `round')
}
// p-value
if !missing("`pvalue'") {
	local result = round(2 * ttail(e(df_r), abs(_b[`pvalue']/_se[`pvalue'])), `round')
}

// Add unit zero if option is specified and result qualifies
if (!missing("`unitzero'") & abs(`result') < 1) {
	if (`result' > 0) local result 0`result'
	else local result = "-0"+"`=abs(`result')'"
}

* Create or modify macros file
*------------------------------------------------------------------------------
file open texresultsfile `using', write `action'
file write texresultsfile "\newcommand{`macroname'}{$`result'$}" _n
file close texresultsfile
*di as text `" Open {browse results.txt}"'

end
