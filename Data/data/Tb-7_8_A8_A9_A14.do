
clear all
use "/Users/acotet/Documents/WAR AEJ3/AEJ5/DATASET/ASPO Sample.dta"

* to improve readability
	replace valdisc=valdisc/100

* INSTRUMENT DISASTER
* interaction
	gen disaster_disc=logoutreg*logdiscoveryaspo
	gen level_disaster_disc=out_regdisaster*discoveryaspoPC

**************************************************
***********    Tb 7        ***********************
**************************************************

********************    GLEDITSCH COW DATA   ********************************
****** PANEL A: ALL COUNTRIES ********************
******* 1 YEAR 
* POOLED OLS Sample of positive wildcat decade FE
	xi: reg dincidence2COW      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy L.logpopdens logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1, robust cluster(numcode)
* Add country FE
	xi: reg dincidence2COW      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 dincidence2COW            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 dincidence2COW            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

	* Appendix A14. discovery NOT log
	* Pooled OLS
		xi: reg dincidence2COW        valdisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy L.logpopdens logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1, robust cluster(numcode)	
	* Add country FE
		xi: reg dincidence2COW        valdisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* INSTRUMENT disaster	
		xi: xtivreg2 dincidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (valdisc=out_regdisaster discoveryaspoPC level_disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(valdisc) first
	* INSTRUMENT unexpected discovery
		xi: xtivreg2 dincidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (valdisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(valdisc) ffirst

******* 3_6 YEARS
* Add country FE
	xi: reg d3_6incidence2COW     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d3_6incidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d3_6incidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

	* Appendix A14. 3_6 YEARS discovery NOT log
	* Pooled OLS
		xi: reg d3_6incidence2COW        valdisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy L.logpopdens logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1, robust cluster(numcode)	
	* Add country FE
		xi: reg d3_6incidence2COW        valdisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* INSTRUMENT disaster	
		xi: xtivreg2 d3_6incidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (valdisc=out_regdisaster discoveryaspoPC level_disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(valdisc) first
	* INSTRUMENT unexpected discovery
		xi: xtivreg2 d3_6incidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (valdisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(valdisc) ffirst

********** PANEL B: DEMOCRACY ************
****** 1 YEAR
* POOLED OLS Sample of positive wildcat decade FE
	xi: reg dincidence2COW      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy L.logpopdens logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
* Add country FE
	xi: reg dincidence2COW      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy>0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 dincidence2COW            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 dincidence2COW            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

******* 3-6 YEARS
* Add country FE
	xi: reg d3_6incidence2COW     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy>0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d3_6incidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d3_6incidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

********** PANEL C: NON-DEMOCRACY ************
****** 1 YEAR
* POOLED OLS Sample of positive wildcat decade FE
	xi: reg dincidence2COW      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy L.logpopdens logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
* Add country FE
	xi: reg dincidence2COW      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy<=0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 dincidence2COW            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 dincidence2COW            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

******* 3-6 YEARS
* Add country FE
	xi: reg d3_6incidence2COW     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy<=0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d3_6incidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d3_6incidence2COW           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst


****************************     PRIO   DATA      *********************************
****** PANEL A: ALL COUNTRIES ********************
****** 1 YEAR
* POOLED OLS Sample of positive wildcat decade FE
	xi: reg dincidenceU      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy L.logpopdens logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1, robust cluster(numcode)
* Add country FE
	xi: reg dincidenceU      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 dincidenceU            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 dincidenceU            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

******* 3-6 YEARS
* Add country FE
	xi: reg d3_6incidenceU     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d3_6incidenceU           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d3_6incidenceU           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

********** PANEL B: DEMOCRACY ************
****** 1 YEAR
* POOLED OLS Sample of positive wildcat decade FE
	xi: reg dincidenceU      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy L.logpopdens logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
* Add country FE
	xi: reg dincidenceU      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy>0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 dincidenceU            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 dincidenceU            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

******* 3-6 YEARS
* Add country FE
	xi: reg d3_6incidenceU     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy>0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d3_6incidenceU           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d3_6incidenceU           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

********** PANEL C: NON-DEMOCRACY ************
****** 1 YEAR
* POOLED OLS Sample of positive wildcat decade FE
	xi: reg dincidenceU      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy L.logpopdens logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
* Add country FE
	xi: reg dincidenceU      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy<=0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 dincidenceU            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 dincidenceU            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

******* 3-6 YEARS
* Add country FE
	xi: reg d3_6incidenceU     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy<=0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d3_6incidenceU           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d3_6incidenceU           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst


**************************************************
***********    Tb A8        ***********************
**************************************************
********************    GLEDITSCH COW DATA   ********************************
******* 7-10 YEARS
****** PANEL A: ALL COUNTRIES ********************
* Add country FE
	xi: reg d7_10incidence2COW  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d7_10incidence2COW        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d7_10incidence2COW        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

********** PANEL B: DEMOCRACY ************
******* 7-10 YEARS
* Add country FE
	xi: reg d7_10incidence2COW  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy>0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d7_10incidence2COW        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d7_10incidence2COW        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

********** PANEL C: NON-DEMOCRACY ************
******* 7-10 YEARS
* Add country FE
	xi: reg d7_10incidence2COW  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy<=0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d7_10incidence2COW        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d7_10incidence2COW        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

****************************     PRIO   DATA      *********************************
****** PANEL A: ALL COUNTRIES ********************
******* 7-10 YEARS
* Add country FE
	xi: reg d7_10incidenceU  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d7_10incidenceU        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d7_10incidenceU        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

********** PANEL B: DEMOCRACY ************
******* 7-10 YEARS
* Add country FE
	xi: reg d7_10incidenceU  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy>0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d7_10incidenceU        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d7_10incidenceU        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

********** PANEL C: NON-DEMOCRACY ************
******* 7-10 YEARS
* Add country FE
	xi: reg d7_10incidenceU  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1  & democracy<=0.005, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d7_10incidenceU        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d7_10incidenceU        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1  & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst


*******************************************
************  TABLE A9   ******************
*******************************************

**************************     COUP  ***************************************************
****** 1 YEAR
* Add country FE
	xi: reg dcoup      logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 dcoup            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 dcoup            wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

******* 3-6 YEARS
* Add country FE
	xi: reg d3_6coup     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d3_6coup           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d3_6coup           wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst

******* 7-10 YEARS
* Add country FE
	xi: reg d7_10coup  logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 d7_10coup        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 d7_10coup        wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst


**************************   IRREGULAR TRANSITION           ****************************
* Add country FE
	xi: reg periregular      logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
* INSTRUMENT disaster	
	xi: xtivreg2 periregular            no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
* INSTRUMENT unexpected discovery
	xi: xtivreg2 periregular            no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M      L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst


**************************************************
***********    Tb 8        ***********************
**************************************************
****** 1 YEAR
* OLS
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
		* democracy
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
		* non-democracy
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
* IV
  * INSTRUMENT disaster
	xi: xtivreg2 dmilexpSIPRI          wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
		* democracy
	xi: xtivreg2 dmilexpSIPRI          wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1 & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
		* non-democracy
	xi: xtivreg2 dmilexpSIPRI          wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1 & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
  * INSTRUMENT unexpected discovery
	xi: xtivreg2 dmilexpSIPRI          wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst
		* democracy
	xi: xtivreg2 dmilexpSIPRI          wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1 & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst
		* non-democracy
	xi: xtivreg2 dmilexpSIPRI          wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1 & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst
	
******* 3-6 YEARS
* OLS
	xi: reg d3_6milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
		* democracy
	xi: reg d3_6milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
		* non-democracy
	xi: reg d3_6milexpSIPRI     logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
* IV
  * INSTRUMENT disaster	
	xi: xtivreg2 d3_6milexpSIPRI       wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
		* democracy
	xi: xtivreg2 d3_6milexpSIPRI       wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1 & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
		* non-democracy
	xi: xtivreg2 d3_6milexpSIPRI       wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=logoutreg logdiscoveryaspo disaster_disc) if wildcatsample==1 & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) first
  * INSTRUMENT unexpected discovery
	xi: xtivreg2 d3_6milexpSIPRI       wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst
		* democracy
	xi: xtivreg2 d3_6milexpSIPRI       wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1 & democracy>0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst
		* non-democracy
	xi: xtivreg2 d3_6milexpSIPRI       wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.decade (logvaldisc=unexpdisc_log) if wildcatsample==1 & democracy<=0.005, robust cluster(numcode) fe partial(i.decade) endog(logvaldisc) ffirst
	
	


