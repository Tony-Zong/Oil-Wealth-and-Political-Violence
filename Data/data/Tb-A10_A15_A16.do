

clear all
use "ASPO Sample.dta"
* interaction
	gen disaster_disc=logoutreg*logdiscoveryaspo
	
*****************************************************************
***********************    Table A10  ****************************
*****************************************************************
* COW-Gleditsch
	xi: reg d2incidence2COW     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d3incidence2COW     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d3yrsCOW            logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d5yrsCOW            logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

*********************************************
* UCDP/PRIO	
	xi: reg d2incidenceU     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d3incidenceU     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d3yrsU           logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d5yrsU           logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

*********************************************
*COUP
	xi: reg d2coup     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d3coup     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d3yrsCOUP  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d5yrsCOUP  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

*********************************************
*MILITARY EXPENDITURES
	xi: reg d2milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d3milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d3yrsSIPRI        logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg d5yrsSIPRI        logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

* democracy
	xi: reg d2milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
	xi: reg d3milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
	xi: reg d3yrsSIPRI        logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
	xi: reg d5yrsSIPRI        logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)

* non-democracy
	xi: reg d2milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
	xi: reg d3milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
	xi: reg d3yrsSIPRI        logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
	xi: reg d5yrsSIPRI        logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)

*****************************************************************
***********************    Table A15  ***************************
*****************************************************************
* Panel A
	xi: reg dFearon_war     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg dFearon_war     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* discovery, disaster, interaction
	xi: xtivreg2 dFearon_war           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
	* unexpected discovery
	xi: xtivreg2 dFearon_war           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

	xi: reg d3_6Fearon_war     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* discovery, disaster, interaction
	xi: xtivreg2 d3_6Fearon_war           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
	* unexpected discovery
	xi: xtivreg2 d3_6Fearon_war           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

**************************
* Panel B
	xi: reg dSambanis_war     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg dSambanis_war     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* discovery, disaster, interaction
	xi: xtivreg2 dSambanis_war           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
	* unexpected discovery
	xi: xtivreg2 dSambanis_war           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

	xi: reg d3_6Sambanis_war     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* discovery, disaster, interaction
	xi: xtivreg2 d3_6Sambanis_war           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
	* unexpected discovery
	xi: xtivreg2 d3_6Sambanis_war           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

**************************
* Panel C
	xi: reg dany_coup     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg dany_coup     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* discovery, disaster, interaction
	xi: xtivreg2 dany_coup           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
	* unexpected discovery
	xi: xtivreg2 dany_coup           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

	xi: reg d3_6any_coup     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* discovery, disaster, interaction
	xi: xtivreg2 d3_6any_coup           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
	* unexpected discovery
	xi: xtivreg2 d3_6any_coup           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

*****************************************************************
***********************    Table A16  ***************************
*****************************************************************
clear all
use "/Users/acotet/Documents\WAR AEJ3\AEJ5\LongRunAverages.dta"
xi: reg incidence2COW    logendowmentPC logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.largeregion, robust                 
xi: reg incidenceU       logendowmentPC logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.largeregion, robust                 
xi: reg coup             logendowmentPC logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.largeregion, robust                 
xi: reg periregular      logendowmentPC no_transition logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.largeregion, robust                 
xi: reg logmilexgdpSIPRI logendowmentPC logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.largeregion, robust                 
	
	
	
	
