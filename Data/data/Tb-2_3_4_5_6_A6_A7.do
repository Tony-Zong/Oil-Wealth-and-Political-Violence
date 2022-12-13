
clear all
use "Comprehensive Sample.dta"

**********************************************
****************   TB 2    *******************
**********************************************

*GLEDITSCH-COW sample
* OLS;
	* No FE
	reg onset2COWCS         logvaloilres       logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmpl=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS     logvaloilres       logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if cowsmpl==1, robust cluster(numcode)
	* country FE same sample as pooled OLS
	xi: reg onset2COWCS     logvaloilres       logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmpl==1, robust cluster(numcode)

* IV - COUNTRY FE 
	* IV public reserves
	tsset numcode year
	xi: ivreg2 onset2COWCS    logGDP_M ecgrowth logpop_M    democracy  i.numcode (logvaloilres=logvaloilres_public) if cowsmpl==1, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy i.numcode) endog(logvaloilres) ffirst
	* IV using disaster, reserves, disaster*reserves
	gen disaster_res=(logoutreg)*(logoilres)
	xi: ivreg2 onset2COWCS    logGDP_M ecgrowth logpop_M    democracy  i.numcode (logvaloilres=logoutreg logoilres disaster_res ) if cowsmpl==1, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy i.numcode) endog(logvaloilres) first

**************************
* UPPSALA-PRIO
* OLS
	* no FE 2008
	xi: reg onsetUCS        logvaloilres_impute logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british , robust cluster(numcode)	
	gen priosmpl08=1 if e(sample)
	* small region FE 2008
	xi: reg onsetUCS        logvaloilres_impute logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion, robust cluster(numcode)
* IV WITH COUNTRY FE 
	gen disaster_res08=logoutreg*logoilres_impute
	* IV using disaster, reserves, disaster*reserves
	xi: ivreg2 onsetUCS      logGDP_M ecgrowth logpop_M    democracy  i.numcode (logvaloilres_impute=logoutreg logoilres_impute disaster_res08) , robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy i.numcode) endog(logvaloilres_impute) first


**********************************************
************      TB 3       *****************
**********************************************
* PANEL A
* DEMOCRACIES ONLY
	* OLS no FE;
	reg onset2COWCS         logvaloilres         logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if democracy>0.005, robust cluster(numcode)
	gen cowsmplD=1 if e(sample)

	reg onsetUCS            logvaloilres_impute  logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if democracy>0.005, robust cluster(numcode)
	gen priosmpl08D=1 if e(sample)	
			
	* OLS country FE
	xi: reg onset2COWCS     logvaloilres         logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmplD==1, robust cluster(numcode)
	xi: reg onsetUCS        logvaloilres_impute  logGDP_M ecgrowth logpop_M            democracy i.numcode if priosmpl08D==1, robust cluster(numcode)
	
	* IV 3 instruments: disaster, reserves, disaster*reserves
	xtivreg2 onset2COWCS    logGDP_M ecgrowth logpop_M      democracy (logvaloilres =logoutreg logoilres disaster_res)                 if cowsmplD==1, robust cluster(numcode) fe endog(logvaloilres) first
	xtivreg2 onsetUCS       logGDP_M ecgrowth logpop_M      democracy (logvaloilres_impute =logoutreg logoilres_impute disaster_res08) if priosmpl08D==1, robust cluster(numcode) fe endog(logvaloilres_impute) first
		
****************************
* PANEL B
* NON-DEMOCRACIES ONLY	
	* OLS no FE;
	reg onset2COWCS         logvaloilres         logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if democracy<=0.005, robust cluster(numcode)
	gen cowsmplND=1 if e(sample)
 	reg onsetUCS            logvaloilres_impute  logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if democracy<=0.005, robust cluster(numcode)
	gen priosmpl08ND=1 if e(sample)
 	
	* country FE
	xi: reg onset2COWCS     logvaloilres         logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmplND==1, robust cluster(numcode)
 	xi: reg onsetUCS        logvaloilres_impute  logGDP_M ecgrowth logpop_M            democracy i.numcode if priosmpl08ND==1, robust cluster(numcode)
 	
	* IV 3 instruments: disaster,reserves, disaster*reserves
	xtivreg2 onset2COWCS    logGDP_M ecgrowth logpop_M      democracy (logvaloilres =logoutreg logoilres disaster_res)                 if cowsmplND==1, robust cluster(numcode) fe endog(logvaloilres) first
 	xtivreg2 onsetUCS       logGDP_M ecgrowth logpop_M      democracy (logvaloilres_impute =logoutreg logoilres_impute disaster_res08) if priosmpl08ND==1, robust cluster(numcode) fe endog(logvaloilres_impute) first
 			
**************************
*PANEL C
* NON-MONOTONIC EFFECT
* redefine log oil to have positive values only
gen templogvaloil=log(valoilres+1)/100
gen templogvaloil2=templogvaloil^2

gen templogvaloil08=log(valoilres_impute+1)/100
gen templogvaloil08_2=templogvaloil08^2
	
	* OLS no FE;
	reg onset2COWCS         templogvaloil templogvaloil2      logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen smpl2=1 if e(sample)
	reg onsetUCS            templogvaloil08 templogvaloil08_2 logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen priosmpl2=1 if e(sample)
		
	* country FE
	xi: reg onset2COWCS     templogvaloil templogvaloil2      logGDP_M ecgrowth logpop_M            democracy i.numcode if smpl2==1, robust cluster(numcode)
	xi: reg onsetUCS        templogvaloil08 templogvaloil08_2 logGDP_M ecgrowth logpop_M            democracy i.numcode if priosmpl2==1, robust cluster(numcode)
	
	* IV 3 instruments
	gen disaster_res2=disaster_res^2
	gen disaster_res08_2=disaster_res08^2	
	
	gen logoutreg2=logoutreg^2 
	gen templogoil=log(oilpop+1)
	gen templogoil2=templogoil^2
	
	gen templogoil08=log(oilpop_impute+1)
	gen templogoil08_2=templogoil08^2	
	
	xtivreg2 onset2COWCS    logGDP_M ecgrowth logpop_M      democracy (templogvaloil templogvaloil2     =logoutreg templogoil logoutreg2 templogoil2 disaster_res disaster_res2)           if cowsmpl==1, robust cluster(numcode) fe endog(templogvaloil templogvaloil2) first
	xtivreg2 onsetUCS       logGDP_M ecgrowth logpop_M      democracy (templogvaloil08 templogvaloil08_2=logoutreg templogoil08 logoutreg2 templogoil08_2 disaster_res08 disaster_res08_2) if priosmpl08==1, robust cluster(numcode) fe endog(templogvaloil08 templogvaloil08_2) first

*********************	
*PANEL D	
* OIL PRODUCTION
	* OLS no FE;
	reg onset2COWCS         logvalprod        logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmplP=1 if e(sample)
	reg onsetUCS            logvalprod_impute logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen priosmpl08P=1 if e(sample)
		
	* country FE
	xi: reg onset2COWCS     logvalprod        logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmplP==1, robust cluster(numcode)
	xi: reg onsetUCS        logvalprod_impute logGDP_M ecgrowth logpop_M            democracy i.numcode if priosmpl08P==1, robust cluster(numcode)
	
* IV
gen L5logoilres=L5.logoilres
gen lagres_dis=L5.logoilres*logoutreg

gen L5logoilres_impute=L5.logoilres_impute
gen lagres08_dis=L5.logoilres_impute*logoutreg

* IV 3 instruments
xi: ivreg2 onset2COWCS    logGDP_M ecgrowth logpop_M    democracy i.numcode (logvalprod=L5logoilres logoutreg lagres_dis)                 if cowsmplP==1, robust cluster(numcode) partial( _Inumcode_* logGDP_M ecgrowth logpop_M democracy) endog(logvalprod) first
xi: ivreg2 onsetUCS       logGDP_M ecgrowth logpop_M    democracy i.numcode (logvalprod_impute=L5logoilres_impute logoutreg lagres08_dis) if priosmpl08P==1, robust cluster(numcode) partial( _Inumcode_*  logGDP_M ecgrowth logpop_M democracy) endog(logvalprod_impute) first
	
**********************************************
************   TB 4, Tb A6   *****************
**********************************************

* PANEL A: All Countries
reg coup        logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
gen coupsmpl=1 if e(sample)
*country FE
xi: reg coup    logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if coupsmpl==1, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 coup              logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logvaloilres_public) if coupsmpl==1, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster, reserves, disaster*reserves country FE
xi: ivreg2 coup              logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logoutreg logoilres disaster_res) if coupsmpl==1, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
*****************************
reg periregular     logvaloilres no_transition logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
gen irregsmpl=1 if e(sample)
* country FE
xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M            democracy i.numcode if irregsmpl==1, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 periregular           no_transition logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logvaloilres_public) if irregsmpl==1, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy no_transition i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster, reserves, disaster*reserves country FE
xi: ivreg2 periregular           no_transition logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logoutreg logoilres disaster_res) if irregsmpl==1, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy no_transition i.numcode) endog(logvaloilres) first
******************************
* PANEL B: DEMOCRACIES
reg coup     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if coupsmpl==1 & democracy>0.005, robust cluster(numcode)
* country FE
xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if coupsmpl==1 & democracy>0.005, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 coup           logGDP_M ecgrowth logpop_M             democracy  i.numcode (logvaloilres=logvaloilres_public) if coupsmpl==1 & democracy>0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster, reserves, disaster*reserves
xi: ivreg2 coup           logGDP_M ecgrowth logpop_M             democracy  i.numcode (logvaloilres=logoutreg logoilres disaster_res) if coupsmpl==1 & democracy>0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
****************************
reg periregular     logvaloilres no_transition logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if irregsmpl==1 & democracy>0.005, robust cluster(numcode)
* country FE
xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M            democracy i.numcode if irregsmpl==1 & democracy>0.005, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 periregular           no_transition logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logvaloilres_public) if irregsmpl==1 & democracy>0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy no_transition i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster, reserves, disaster*reserves
xi: ivreg2 periregular           no_transition logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logoutreg logoilres disaster_res) if irregsmpl==1 & democracy>0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy no_transition i.numcode) endog(logvaloilres) first
*****************************
* PANEL C: NONDEMOCRACIES
reg coup     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if coupsmpl==1 & democracy<=0.005, robust cluster(numcode)
* country FE
xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if coupsmpl==1 & democracy<=0.005, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 coup           logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logvaloilres_public) if coupsmpl==1 & democracy<=0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster, reserves, disaster*reserves
xi: ivreg2 coup           logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logoutreg logoilres disaster_res) if coupsmpl==1 & democracy<=0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
***********************
reg periregular     logvaloilres no_transition logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if irregsmpl==1 & democracy<=0.005, robust cluster(numcode)
* country FE
xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M            democracy i.numcode if irregsmpl==1 & democracy<=0.005, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 periregular           no_transition logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logvaloilres_public) if irregsmpl==1 & democracy<=0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy no_transition i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster, reserves, disaster*reserves
xi: ivreg2 periregular           no_transition logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logoutreg logoilres disaster_res) if irregsmpl==1 & democracy<=0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy no_transition i.numcode) endog(logvaloilres) first

**********************************************
************   TB 5, Tb A6   *****************
**********************************************
reg logmilexgdpSIPRI     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
gen milexpsmpl=1 if e(sample)
* country FE
xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if milexpsmpl==1, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 logmilexgdpSIPRI           logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logvaloilres_public) if milexpsmpl==1, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster and reserves country FE
xi: ivreg2 logmilexgdpSIPRI           logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logoutreg logoilres) if milexpsmpl==1, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
*****************************
* PANEL B.  DEMOCRACIES
reg logmilexgdpSIPRI     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if milexpsmpl==1 & democracy>0.005, robust cluster(numcode)
* country FE
xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if milexpsmpl==1 & democracy>0.005, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 logmilexgdpSIPRI           logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logvaloilres_public) if milexpsmpl==1 & democracy>0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster and reserves country FE
xi: ivreg2 logmilexgdpSIPRI           logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logoutreg logoilres) if milexpsmpl==1 & democracy>0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first

*****************************
* PANEL C.  NON-DEMOCRATIC COUNTRIES
reg logmilexgdpSIPRI     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if milexpsmpl==1 & democracy<=0.005, robust cluster(numcode)
* country FE
xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if milexpsmpl==1 & democracy<=0.005, robust cluster(numcode)
* IV public reserves country FE
xi: ivreg2 logmilexgdpSIPRI           logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logvaloilres_public) if milexpsmpl==1 & democracy<=0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first
* Tb A6 IV disaster and reserves country FE
xi: ivreg2 logmilexgdpSIPRI           logGDP_M ecgrowth logpop_M              democracy  i.numcode (logvaloilres=logoutreg logoilres) if milexpsmpl==1 & democracy<=0.005, robust cluster(numcode) partial(logGDP_M ecgrowth logpop_M democracy  i.numcode) endog(logvaloilres) first

**********************************************
************   TB 6, Tb A7   *****************
**********************************************

* report tests using the sample used in Tb 6 col 2
gen d2incidence2COW=F.incidence2COW-L.incidence2COW
xi: reg d2incidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
gen smpl=1 if e(sample)

* ARE SUCCESSFUL AND FAILED WILDCATS SIMILAR?
gen success=1 if discoveryaspoPC>0 & discoveryaspoPC!=. & smpl==1
replace success=0 if discoveryaspoPC==0 & smpl==1

* SUMMARY STATISTICS
* report means 
replace logvaloilres = logvaloilres*100
replace logvaldisc = logvaldisc*100
replace logGDP_M = logGDP_M*100
replace ecgrowth = ecgrowth*100
replace logpop_M = logpop_M*100
replace logpopdens = logpopdens*100
replace democracy = democracy*100
replace x_dem=x_dem*100
replace logmountain = logmountain*100
replace ethnic_fractionalization = ethnic_fractionalization*100
replace language_fractionalization =language_fractionalization*100
replace religion_fractionalization = religion_fractionalization*100
replace leg_british = leg_british*100

sum L.logvaloilres L.wildcat L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy L.x_dem ///
	L.logmountain L.religion_fractionalization L.ethnic_fractionalization ///
	L.language_fractionalization L.leg_british if success==1 

sum L.logvaloilres L.wildcat L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy L.x_dem ///
	L.logmountain L.religion_fractionalization L.ethnic_fractionalization ///
	L.language_fractionalization L.leg_british if success==0

* TESTS OF SAMPLE BALANCE	 
reg L.logvaloilres success, cluster(numcode)
reg L.logGDP_M success, cluster(numcode)
reg L.ecgrowth success, cluster(numcode)
reg L.logpop_M success, cluster(numcode)
reg L.logpopdens success, cluster(numcode)
reg L.democracy success, cluster(numcode)
reg L.x_dem success, cluster(numcode)
reg L.logmountain success, cluster(numcode)
reg L.ethnic_fractionalization success, cluster(numcode)
reg L.religion_fractionalization success, cluster(numcode)
reg L.language_fractionalization success, cluster(numcode)
reg L.leg_british success, cluster(numcode)
reg L.wildcat success, cluster(numcode)

logit success L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy ///
	L.logmountain L.ethnic_fractionalization L.religion_fractionalization  ///
	L.language_fractionalization L.leg_british L.wildcat, robust cluster(numcode)
	 
test L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy ///
	L.logmountain L.ethnic_fractionalization L.religion_fractionalization  ///
	L.language_fractionalization L.leg_british L.wildcat








	


					




