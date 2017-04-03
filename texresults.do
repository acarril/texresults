discard
sysuse auto, clear
reg mpg trunk weight foreign
local lala 137



texresults using results.txt, macroname(extranjero) round(0.001) replace coef(foreign)
texresults using results.txt, macroname(extranjero_se) round(0.001) append se(foreign)

texresults using results.txt, macroname(cualquierwea) round(0.001) append result(e(r2))

texresults using results.txt, macroname(peso) round(0.001) append unitzero coef(weight)
texresults using results.txt, macroname(weight_tstat) round(0.01) append unitzero tstat(weight)
texresults using results.txt, macroname(foreign_pval) round(0.001) append unitzero pvalue(foreign)
