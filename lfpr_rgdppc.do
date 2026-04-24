clear all
cd "C:\Users\jaiswa40\Downloads" //CHANGE THIS TO YOUR DIRECTORY
*OPEN LOG FILE
log using "ECO475_term_paper.log", replace text name (ECO475_TERM_PAPER)


*Setup:
clear all
set more off


******************************************************
* STEP 1: IMPORT DATA AND DECLARE IT AS TIME SERIES
******************************************************
*Import data:
cd "C:\Users\jaiswa40\Downloads" //CHANGE THIS TO YOUR DIRECTORY
insheet using LFRGDP_ECO475_term_paper_data.csv, comma clear
browse
rename RGDPPC rgdppc

*labeling the variables
label variable rgdppc "Real GDP Per Capita (Chained 2017 dollars)"
label variable lfpr "Labor Force Participation Rate"
label variable inv "Investment in Inventories (x1,000,000) (Chained 2017 dollars)"
label variable prd "Labor Productivity (in business sector) (Index 2017 = 100)"

*Declaring dataset as time series
gen t = 12*11 + 7 + _n
tsset t, quarter
label variable t "Time"
sum rgdppc lfpr inv prd

******************************************************
* STEP 2: PLOTS AND VISUAL EVIDENCE ON NONSTATIONARITY
******************************************************
* Plot Real GDP Per Capita in levels
tsline rgdppc, ///
    title("RGDP Per Capita in Levels") ///
    ytitle("RGDP Per Capita") ///
    xtitle("Time")
graph export "RGDP PC_levels.png", replace width(2000)

* Plot Labor Force Participation Rate in levels
tsline lfpr, ///
    title("LFPR in Levels") ///
    ytitle("LFPR") ///
    xtitle("Time")
graph export "LFPR_levels.png", replace width(2000)

* Plot Labor Investment in Inventories in levels
tsline inv, ///
    title("Investment in Inventories in Levels") ///
    ytitle("Investment in Inventories") ///
    xtitle("Time")
graph export "INV_levels.png", replace width(2000)

* Plot Labor Productivity in levels
tsline prd, ///
    title("Labor Productivity") ///
    ytitle("Labor Productivity") ///
    xtitle("Time")
graph export "PRD_levels.png", replace width(2000)

/*
tsline rgdppc
tsline lfpr
tsline inv
tsline prd
*/

******************************************************
* STEP 3: UNIT ROOT TESTS
******************************************************
*ADF test in levels including trend
dfuller rgdppc, lags(4) trend
dfuller lfpr, lags(4) trend 
dfuller inv, lags(4) trend 
dfuller prd, lags(4) trend 

*Generating the variables for ΔX_t and ΔY_t (first differences)
gen drgdppc = D.rgdppc
label variable drgdppc "1st diff in Real GDP Per Capita"
gen dlfpr = D.lfpr
label variable dlfpr "1st diff in Labor Force Participation Rate"
gen dinv = D.inv
label variable dinv "1st diff in Investment in Inventories"
gen dprd = D.prd
label variable dprd "1st diff in Labor Productivity"


*ADF test in first differences (no trend)
dfuller drgdppc, lags(4)
dfuller dlfpr, lags(4)
dfuller dinv, lags(4)
dfuller dprd, lags(4)


*Plots of first differences over time

*Plot of ΔLFPR over time
tsline dlfpr, ///
    title("ΔLFPR over time") ///
    ytitle("ΔLFPR") ///
    xtitle("Time")
graph export "ΔLFPR.png", replace width(2000)

*Plot of ΔINV over time
tsline dinv, ///
    title("ΔINV over time") ///
    ytitle("ΔINV") ///
    xtitle("Time")
graph export "ΔINV.png", replace width(2000)

*Plot of ΔPRD over time
tsline dprd, ///
    title("ΔPRD over time") ///
    ytitle("ΔPRD") ///
    xtitle("Time")
graph export "ΔPRD.png", replace width(2000)

*Plot of ΔRGDPPC over time
tsline drgdppc, ///
    title("ΔRGDPPC over time") ///
    ytitle("ΔRGDPPC") ///
    xtitle("Time")
graph export "ΔRGDPPC.png", replace width(2000)

******************************************************
* STEP 4: COINTEGRATION CHECK (ONLY IF ALL ARE I(1))
******************************************************
*Regressing Y_t on X_t to get residuals
reg rgdppc lfpr prd
*reg rgdppc lfpr inv prd
predict residual, res

*Running ADF test on the residuals
dfuller residual, noconstant lags(4) // there is cointegration between the three variables rgdppc lfpr and prd

*Plot of residuals over time
tsline residual, ///
    title("residuals over time") ///
    ytitle("Δu^t (residuals)") ///
    xtitle("Time")
graph export "Δu^t(residuals).png", replace width(2000)


********************************************************************************
* STEP 5: REGRESSION OF Y ON X's WITH APPROPRIATE TRANSFORMATION (NEWEY-WEST) 
********************************************************************************
*Newey–West HAC regression
newey drgdppc dlfpr inv dprd, lag(4) // All are I(1) except inv which is is I(0)
estimate store Newey
predict Y

* Plot actual vs fitted values

tsline drgdppc Y, ///
    title("Actual vs Fitted Values: ΔY_t") ///
    ytitle("ΔY_t") ///
    legend(order(1 "ΔY_t" 2 "Fitted ΔY_t"))
graph export "actual_vs_fitted.png", replace width(2000)

esttab Newey using "regression_results_term_paper.tex", replace label b(3)se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs title ("Regression Results") noomitted

log close ECO475_TERM_PAPER
capture log close ECO475_TERM_PAPER

