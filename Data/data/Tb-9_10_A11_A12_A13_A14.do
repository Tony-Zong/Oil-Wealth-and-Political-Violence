

clear all
use "ASPO Sample.dta"

* DROP OBS WITH POSITIVE DISCOVERY AND NO WILDCAT
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
*************************************
**********  TB 10 *******************
*************************************
	* Gleditsch-COW 1 year
	xi: reg dincidence2COW     logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M  Ldemocracy i.numcode i.decade, robust cluster(numcode)
	* Gleditsch-COW 3-6 years
	xi: reg d3_6incidence2COW  logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M  Ldemocracy i.numcode i.decade, robust cluster(numcode)
	* PRIO
	xi: reg dincidenceU        logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M  Ldemocracy i.numcode i.decade, robust cluster(numcode)
	* PRIO 3-6 years
	xi: reg d3_6incidenceU     logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M  Ldemocracy i.numcode i.decade, robust cluster(numcode)
	* Military EXP
	xi: reg dmilexpSIPRI       logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M Ldemocracy i.numcode i.decade, robust cluster(numcode)
	* Military EXP democracy
	xi: reg dmilexpSIPRI       logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M  Ldemocracy i.numcode i.decade if democracy>0.005, robust cluster(numcode)
	* Military EXP non-democracy
	xi: reg dmilexpSIPRI       logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M  Ldemocracy i.numcode i.decade if democracy<=0.005, robust cluster(numcode)
	
	* Tb A14
	xi: reg dincidence2COW        valdisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M   Ldemocracy i.numcode i.decade, robust cluster(numcode)
	xi: reg d3_6incidence2COW     valdisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M   Ldemocracy i.numcode i.decade, robust cluster(numcode)
	
******************** MATCHING ON Gleditsch-COW 1 year**********************
clear all
use "ASPO Sample.dta"

***************** Wanran's edit**********************
gen drill = 1 if wildcat > 0 & wildcat !=.
replace drill = 0 if wildcat == 0  & wildcat !=.
*****************************************************
 
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	xi: reg dincidence2COW     logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade, robust cluster(numcode)
	keep if e(sample)
	
* TB 9 PROPENSITY SCORE
logit drill Llogoilres 
mfx
logit drill Lcrude1990P 
mfx	
logit drill Ldemocracy  
mfx
logit drill Lincidence2COW  
mfx
logit drill Llogoilres Lcrude1990P Ldemocracy Lincidence2COW 
mfx
logit drill Llogoilres Lcrude1990P Ldemocracy Lincidence2COW africa asia oceania southam
mfx	

* for the purpose of matching get higher terms, interaction terms
	gen o2=Llogoilres^2
	gen dem2=Ldemocracy^2
	gen dem3=Ldemocracy^3
	gen odem=Llogoilres*Ldemocracy
	gen o2dem=Llogoilres^2*Ldemocracy
	gen crude2=Lcrude1990P^2
	gen ocrude=Llogoilres*Lcrude1990P
	gen warcrude=Lincidence2COW*Lcrude1990P

* stratification with region FE
* for detailed results for balancing tests tables add option "detail" to the command below
pscore drill o2 ocrude  odem Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup numblo(8)

	* TB 10
	xi: reg d2incidence2COW logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	* Tb A13
	xi: reg d2incidence2COW logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	* Tb A14
	xi: reg d2incidence2COW valdisc            wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	
* kernel with region FE
set more off
psmatch2 drill o2 o2dem odem dem2 crude2 dem3 warcrude Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(dincidence2COW) kerneltype(epan) bwidth(0.05) common logit
pstest         o2 o2dem odem dem2 crude2 dem3 warcrude Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 

	* Tb 10
	xi: reg dincidence2COW logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A13
	xi: reg dincidence2COW logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A 14
	xi: reg dincidence2COW valdisc            wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
		
**************** MATCHING Gleditsch-COW 3-6 years*********************
clear all
use "ASPO Sample.dta"
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	xi: reg d3_6incidence2COW         logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade, robust cluster(numcode)
	keep if e(sample)	
* for the purpose of matching get higher terms, interaction terms
	gen o2=Llogoilres^2
	gen odem=Llogoilres*Ldemocracy
	gen ocrude=Llogoilres*Lcrude1990P
	gen o2crude=(Llogoilres^2)*Lcrude1990P
	gen crude2=Lcrude1990P^2
	gen o3=Llogoilres^3
	gen asiacrude=asia*Lcrude1990P
	gen crudewar=Lcrude1990P*Lincidence2COW
	gen odem2=Llogoilres*(Ldemocracy^2)	
	gen dem3=Ldemocracy^3	
	gen crudedem2=Lcrude1990P*(Ldemocracy^2)
	gen odem3=Llogoilres*(Ldemocracy^3)
	gen o2dem2=(Llogoilres^2)*(Ldemocracy^2)
* stratification with region FE
set more off
pscore drill o2 odem o2crude Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup numblo(8)
	* Tb 10
	xi: reg d3_6incidence2COW        logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	* Tb A14
	xi: reg d3_6incidence2COW           valdisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	
*kernel matching
psmatch2 drill crude2 asiacrude odem odem2 crudewar  ocrude o3  Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(d3_6incidence2COW) kerneltype(epan) bwidth(0.05) common logit
pstest         crude2 asiacrude odem odem2 crudewar  ocrude o3  Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 
	* Tb 10
	xi: reg d3_6incidence2COW        logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A14
	xi: reg d3_6incidence2COW           valdisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
		
************************ MATCHING PRIO**********************************
clear all
use "ASPO Sample.dta"
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	xi: reg dincidenceU     logvaldisc wildcat Llogvaloilres       LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade, robust cluster(numcode)
	keep if e(sample)
* for the purpose of matching get higher terms, interaction terms
	gen o2=Llogoilres^2
	gen o3=Llogoilres^3
	gen dem3=Ldemocracy^3
	gen crude3=Lcrude1990P^3
	gen owar=Llogoilres*LincidenceU
	gen ocrude=Llogoilres*Lcrude1990P
	gen o2dem=(Llogoilres^2)*Ldemocracy
	gen dem2o=(Ldemocracy^2)*Llogoilres
	gen crudeasia=Lcrude1990P* asia
* stratification with region FE
set more off
pscore drill o3 o2 ocrude owar crude3  crudeasia Ldemocracy LincidenceU Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup numblo(21)
	* Tb 10
	xi: reg dincidenceU logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	* Tb A13
	xi: reg dincidenceU logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
drop p1 b1 comsup

* kernel with region FE	
psmatch2 drill o2dem o3 owar  crude3  dem3 dem2o Ldemocracy LincidenceU Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(dincidenceU) kerneltype(epan) bwidth(0.05) common logit
pstest         o2dem o3 owar  crude3  dem3 dem2o Ldemocracy LincidenceU Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 
	* Tb 10
	xi: reg dincidenceU logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A13
	xi: reg dincidenceU logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
		
******************** MATCHING PRIO 3-6 years****************************
clear all
use "ASPO Sample.dta"
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	xi: reg d3_6incidenceU     logvaldisc wildcat Llogvaloilres       LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade, robust cluster(numcode)
	keep if e(sample)
* for the purpose of matching get higher terms, interaction terms
	gen ocrude=Llogoilres*Lcrude1990P
	gen warcrude=LincidenceU*Lcrude1990P
	gen asiawar=asia*LincidenceU
	gen dem2=Ldemocracy^2
	gen dem3=Ldemocracy^3	
	gen o2=Llogoilres^2	
	gen o3=Llogoilres^3
	gen wardem=LincidenceU*Ldemocracy
	gen o3dem=Ldemocracy*(Llogoilres^3)	
	gen o2dem2=(Llogoilres^2)*(Ldemocracy^2)
* stratification with region FE
set more off
pscore drill o2 ocrude warcrude Ldemocracy LincidenceU Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup numblo(7)
	* Tb 10
	xi: reg d3_6incidenceU logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)

* kernel with region FE
set more off
psmatch2 drill asiawar dem2 dem3  wardem o2  o3 o2dem2 o3dem  Ldemocracy LincidenceU Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(d3_6incidenceU) kerneltype(epan) bwidth(0.05) common logit
pstest         asiawar dem2 dem3  wardem o2  o3 o2dem2 o3dem   Ldemocracy LincidenceU Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 
	* Tb 10
	xi: reg d3_6incidenceU logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)

	
******************* MATCHING Military EXP*******************************
clear all
use "ASPO Sample.dta"
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	xi: reg dmilexpSIPRI     logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M Ldemocracy i.numcode i.decade, robust cluster(numcode)
	keep if e(sample)
* for the purpose of matching get higher terms, interaction terms
	gen dem2=Ldemocracy^2
	gen odem=Llogoilres*Ldemocracy
* stratification with region FE
set more off
pscore drill  Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup 
	* Tb 10
	xi: reg dmilexpSIPRI logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	* Tb A13
	xi: reg dmilexpSIPRI logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	
* kernel with region FE
psmatch2 drill  dem2 odem Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(dmilexpSIPRI) kerneltype(epan) bwidth(0.05) common logit
pstest          dem2 odem Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 
	* Tb 10
	xi: reg dmilexpSIPRI logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M       Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A13
	xi: reg dmilexpSIPRI logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M       Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	
	
***************** MATCHING Military EXP democracy**************************
clear all
use "ASPO Sample.dta"
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	xi: reg dmilexpSIPRI     logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade if democracy>0.005, robust cluster(numcode)
	keep if e(sample)
* for the purpose of matching get higher terms, interaction terms
	gen crude2=Lcrude1990P^2
	gen dem2war=(Ldemocracy^2)*Lincidence2COW
	gen oilsouth=Llogoilres*southam
* stratification with region FE
set more off
pscore drill  Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup 
	* Tb 10
	xi: reg dmilexpSIPRI logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M       Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	* Tb A13
	xi: reg dmilexpSIPRI logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M       Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)

* kernel with region FE		
psmatch2 drill oilsouth dem2war crude2 Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(dmilexpSIPRI) kerneltype(epan) bwidth(0.05) common logit
pstest         oilsouth dem2war crude2 Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 
	* Tb 10
	xi: reg dmilexpSIPRI logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M       Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A13
	xi: reg dmilexpSIPRI logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M       Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	
	
**************** MATCHING Military EXP non-democracy************************
clear all
use "ASPO Sample.dta"
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	xi: reg dmilexpSIPRI     logvaldisc wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade if democracy<=0.005, robust cluster(numcode)
	keep if e(sample)
* for the purpose of matching get higher terms, interaction terms
	gen o2=Llogoilres^2
	gen dem2=Ldemocracy^2
* stratification region FE	
set more off
pscore drill dem2 o2 Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup numblo(10)
	* Tb 10	
	xi: reg dmilexpSIPRI logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)	
	* Tb A13
	xi: reg dmilexpSIPRI logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)	

* kernel region FE
psmatch2 drill Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(dmilexpSIPRI) kerneltype(epan) bwidth(0.05) common logit
pstest         Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 
	* Tb 10
	xi: reg dmilexpSIPRI logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A13
	xi: reg dmilexpSIPRI logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M     Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	

******************** MATCHING COUP  ****************************
clear all
use "/Users/acotet/Documents\WAR AEJ3\AEJ5\ASPO Sample.dta"
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	* Tb A11
	xi: reg dcoup     logvaldisc wildcat Llogvaloilres        LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade, robust cluster(numcode)
	keep if e(sample)
* for the purpose of matching get higher terms, interaction terms	
	gen o2=Llogoilres^2
	gen o3=Llogoilres^3
	gen dem2=Ldemocracy^2
	gen o2dem=Llogoilres^2*Ldemocracy	
	gen asiawar=asia*Lincidence2COW
	gen crudedem=Lcrude1990P*Ldemocracy
	gen crudewar=Lcrude1990P*Lincidence2COW
	gen demwar=Ldemocracy*Lincidence2COW
	gen o2crude=o2*Lcrude1990P
	gen dem2war=dem2*Lincidence2COW
	gen odem=Ldemocracy*Llogoilres

* STRATIFICATION with region FE
set more off
pscore drill  asiawar o2 o2crude dem2 dem2war crudewar crudedem demwar  Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup numblo(9)
	* Tb A12
	xi: reg dcoup logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	* Tb A13
	xi: reg dcoup logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)

* kernel with region FE
psmatch2 drill odem o2dem o3 asiawar crudewar Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(dcoup) kerneltype(epan) bwidth(0.05) common logit
pstest         odem o2dem o3 asiawar crudewar Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 
	* Tb A12
	xi: reg dcoup logvaldisc         wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A13
 	xi: reg dcoup logvaldisc failure wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	
******************** MATCHING IRREGULAR TRANSITION ****************************
clear all
use "ASPO Sample.dta"
* drop obs with positive discovery and no wildcat
drop if newdiscovery_aspo>0 & newdiscovery_aspo!=. & wildcat==0 
* to improve readability
replace valdisc=valdisc/100
	* match on same sub-sample	
	* Tb A11
	xi: reg periregular     logvaldisc no_transition wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M              Ldemocracy i.numcode i.decade, robust cluster(numcode)
	keep if e(sample)
* for the purpose of matching get higher terms, interaction terms
	gen o2=Llogoilres^2
	gen o3=Llogoilres^3
	gen dem2=Ldemocracy^2
	gen dem3=Ldemocracy^3
	gen odem=Llogoilres*Ldemocracy
	gen dem2o=dem2*Llogoilres
	gen ocrude=Llogoilres*Lcrude1990P
	gen o2crude=Llogoilres^2*Lcrude1990P
	gen demcrude2=Ldemocracy*(Lcrude1990P^2)
	gen o2crude2=Llogoilres^2*Lcrude1990P^2

* stratification with region FE
set more off
pscore drill o2 odem dem2 Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, pscore(p1) blockid(b1) logit comsup
	* Tb A12
	xi: reg periregular logvaldisc         no_transition wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)
	* Tb A13
	xi: reg periregular logvaldisc failure no_transition wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade i.b1, robust cluster(numcode)

* kernel with region FE
psmatch2 drill dem2o o2 ocrude dem3 o2crude o2crude2 demcrude2 o3 Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, kernel outcome(periregular) kerneltype(epan) bwidth(0.05) common logit
pstest         dem2o o2 ocrude dem3 o2crude o2crude2 demcrude2 o3 Ldemocracy Lincidence2COW Llogoilres Lcrude1990P africa southam asia oceania, t(drill) sup( _support) 
	* Tb A12
	xi: reg periregular logvaldisc         no_transition wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	* Tb A13
	xi: reg periregular logvaldisc failure no_transition wildcat Llogvaloilres LlogGDP_M Lecgrowth Llogpop_M      Ldemocracy i.numcode i.decade if _support==1 [pweight=_weight], robust cluster(numcode)
	
	
	
	
	

