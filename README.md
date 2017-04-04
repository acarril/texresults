# texresults
Stata program to export results as Latex macros

## Description

*texresults* is a convenience command to easily store any computed result to a LaTeX macro.
After running an estimation command in Stata, *texresults* can be used to create a new LaTeX macro, which is stored in an external text file.
This file may be called from a LaTeX document in order to use those results.

One of the main advantages of a Stata/LaTeX workflow is the automatic updating of tables and figures.
For instance, if we add a new control variable to a regression, we can correct the do-file that produces a table of coefficients and compile the LaTeX document again to see the updated table.
However, that advantage doesn't extend to in-text mentions of coefficients (or other results).
This leads to documents that contain inconsistent results, which have to be manually checked every time a preliminary result changes. 

This sitation can be remedied by creating an external file with LaTeX macros that store all cited results of an analysis.
Using these macros instead of manually copying results in the text is much less error prone, and we can be certain that results are consistent throughout the document.
