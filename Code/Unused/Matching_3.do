// load data
clear all
use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full.dta"
// clear all
// use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo-sample.dta"

// declare panel data
tsset numcode year, yearly

// data cleaning
* drop obs with positive discovery and no wildcat
drop if valdisc > 0.00001 &valdisc!=. & wildcat < 0.5

// define lagged variables
foreach v in milexgdpSIPRI_diff popdens_diff pop_M_diff crude1990P_diff valoilres_diff democracy_diff out_regdisaster_diff oilpop_impute_diff oilreserves_diff logGDP_M ecgrowth crude1990P logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british incidence2COW {
	gen l1`v' = L.`v'
	gen l2`v'= L2.`v'
	gen l5`v'= L5.`v'
	gen l10`v'= L10.`v'
}


*******************************************************************************
** To-do:
*** try standard estimation on the sample for matching
**** example: match on same sub-sample	
	// xi: reg dincidence2COW     logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade, robust cluster(numcode)
	// keep if e(sample)
*******************************************************************************


// create wildcat_diff_binary 
gen wildcat_diff_binary = 1  if wildcat_diff>1.00e-05 & wildcat_diff!=. 
replace wildcat_diff_binary=0 if !(wildcat_diff>1.00e-05) & wildcat_diff!=. 

// success = binarized discovery
gen valdisc_binary=1 if valdisc>1.00e-05 & valdisc!=. 
replace valdisc_binary=0 if !(valdisc>1.00e-05) & valdisc!=. 

save "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta", replace


keep if democracy>0.005
save "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-demo.dta", replace

clear all 
use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta"
drop if democracy>0.005
save "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-non-demo.dta", replace

