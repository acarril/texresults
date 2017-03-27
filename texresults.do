capture program drop texresults

program define texresults
syntax varname [using], MACROname(string) [replace append Round(real 0) UNITzero]

// Parse file action
if !missing("`replace'") & !missing("`append'") {
	di as error "{bf:replace} and {bf:append} may not be specified simultaneously"
	exit 198
}
local action `replace' `append'

// Process macroname
local macroname = "\" + "`macroname'"

// Store [rounded] result
local result = round(_b[`varlist'], `round')

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
cd "/Users/alvaro/Library/Application Support/Stata/ado/personal/texresults"
sysuse auto, clear
reg mpg trunk weight foreign

texresults foreign using results.txt, macroname(lamacro) round(0.001) replace
texresults weight using results.txt, macroname(otramacro) round(0.001) append unitzero
