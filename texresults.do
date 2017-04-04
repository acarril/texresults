discard
capture erase results.txt

sysuse auto, clear
reg mpg trunk weight foreign

texresults using results.txt, texmacro(rmse) result(e(rmse))
texresults using results.txt, texmacro(mainresult) coef(foreign) append
texresults using results.txt, texmacro(trunkSE) se(trunk) unitzero append

/*
texresults using results.txt, texmacro(extranjero) round(0.001) coef(foreign) append
texresults using results.txt, texmacro(extranjero_se) round(0.001) append se(foreign)

texresults using results.txt, texmacro(12) round(0.001) append result(e(r2))

texresults using results.txt, texmacro(12jds) round(0.001) append unitzero coef(weight)
texresults using results.txt, texmacro(weight_tstat) round(0.01) append unitzero tstat(weight)
texresults using results.txt, texmacro(foreign_pval) round(0.001) append unitzero pvalue(foreign)
*/
