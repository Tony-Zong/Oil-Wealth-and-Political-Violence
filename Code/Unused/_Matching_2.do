***** questions
// 1. why there are no observations with zero wildcat or discoveryaspoPC using transformed dataset
// 2. how matching was implemented in the original code

***** to-do's
// 1. change lag
// 2. change binarization thresholds
	// valdisc instead of discoveryaspoPC
// 3. change covariates (use diff)
// 4. change outcome


*******************************************************************************


// load data
clear all
// use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/Comprehensive-Sample.dta"
use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/ASPO-Sample.dta"

// use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full.dta"
// use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/comprehensive_new.dta"
// use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/comprehensive_new_full.dta"
// keep incidence2COW discoveryaspoPC index onset2COWCS onsetUCS coup periregular numcode year ecgrowth logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british no_transition popdens_diff pop_maddison_diff democracy_diff wildcat_diff out_regdisaster_diff valoilres_diff valoilres_binarize valoilres_public_diff valoilres_public_binarize oilpop_diff oilpop_binarize valoilres_impute_diff valoilres_impute_binarize oilpop_impute_diff oilpop_impute_binarize milexp_pergdpSIPRI_diff

// declare panel data
tsset numcode year, yearly

// data cleaning
* drop if missing(wildcat)
* drop if missing(discoveryaspoPC)

*******************************************************************************


// success = binarized discovery
gen success=1 if discoveryaspoPC>(0.1^5) & discoveryaspoPC!=. 
replace success=0 if discoveryaspoPC==(0.1^5)


// what predicts success in oil discovery
	// no lag
logit success logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british wildcat, robust cluster(numcode)

test logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british wildcat

teffects psmatch (onset2COWCS) (success logvaloilres logGDP_M logpop_M logpopdens)

	// one year's lag
logit success L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy L.logmountain L.ethnic_fractionalization L.religion_fractionalization L.language_fractionalization L.leg_british L.wildcat, robust cluster(numcode)

test L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy L.logmountain L.ethnic_fractionalization L.religion_fractionalization L.language_fractionalization L.leg_british L.wildcat


*******************************************************************************


// create wildcat_binary 
gen wildcat_binary = 1  if wildcat>0.1**5 & wildcat!=. 
replace wildcat_binary=0 if wildcat==0.1**5


// what predicts success in wildcat_binary
	// no lag
logit wildcat_binary logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)

test logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british

teffects psmatch (onset2COWCS) (wildcat_binary logdiscoveryaspo logvaloilres logGDP_M ecgrowth logpop_M logpopdens)

	// one year's lag
logit wildcat_binary L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy L.logmountain L.ethnic_fractionalization L.religion_fractionalization L.language_fractionalization L.leg_british, robust cluster(numcode)

test L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy L.logmountain L.ethnic_fractionalization L.religion_fractionalization L.language_fractionalization L.leg_british 
