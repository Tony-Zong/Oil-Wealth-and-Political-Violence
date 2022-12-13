
clear all
use "Comprehensive Sample.dta"

***********************************************
****************   TB A3 **********************
***********************************************
* instrument
gen disaster_res=logoutreg*logoilres
gen level_disaster_res=out_regdisaster*oilpop

* panel A
gen templogvaloil=log(valoilres+1)/100

	dprobit onset2COWCS  templogvaloil logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	reg onset2COWCS      templogvaloil logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmpl=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS  templogvaloil logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if cowsmpl==1, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS  templogvaloil logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmpl==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 onset2COWCS               logGDP_M ecgrowth logpop_M             democracy (templogvaloil=logvaloilres_public) if cowsmpl==1, robust cluster(numcode) fe endog(templogvaloil) ffirst
	* IV using disaster, reserves, disaster*reserves
   xtivreg2 onset2COWCS                logGDP_M ecgrowth logpop_M             democracy (templogvaloil=logoutreg logoilres disaster_res) if cowsmpl==1, robust cluster(numcode) fe endog(templogvaloil) first
drop cowsmpl


* panel B
gen valoilresL=valoilres/10000
	dprobit onset2COWCS     valoilresL logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	reg onset2COWCS         valoilresL logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmpl=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS     valoilresL logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if cowsmpl==1, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS     valoilresL logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmpl==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 onset2COWCS              logGDP_M ecgrowth logpop_M             democracy (valoilresL=valoilres_public) if cowsmpl==1, robust cluster(numcode) fe endog(valoilresL) ffirst
	* IV using disaster, reserves, disaster*reserves
   xtivreg2 onset2COWCS               logGDP_M ecgrowth logpop_M             democracy (valoilresL=out_regdisaster oilpop level_disaster_res) if cowsmpl==1, robust cluster(numcode) fe endog(valoilresL) first
drop cowsmpl
  
   
* panel C
gen Llogvaloilres=L.logvaloilres
gen Ldisaster_res=L.disaster_res
gen Llogvaloilres_public=L.logvaloilres_public

	dprobit onset2COWCS     Llogvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if year<=2003, robust cluster(numcode)
	reg onset2COWCS         Llogvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if year<=2003, robust cluster(numcode)
	gen cowsmplB=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS     Llogvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if cowsmplB==1, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS     Llogvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmplB==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 onset2COWCS                  logGDP_M ecgrowth logpop_M            democracy (Llogvaloilres=Llogvaloilres_public) if cowsmplB==1, robust cluster(numcode) fe endog(Llogvaloilres) ffirst
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset2COWCS                  logGDP_M ecgrowth logpop_M            democracy (Llogvaloilres=L.logoutreg L.logoilres Ldisaster_res) if cowsmplB==1, robust cluster(numcode) fe endog(Llogvaloilres) first
drop cowsmplB
	
* panel D
	dprobit onset2COWCS     logoilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	reg onset2COWCS         logoilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmplC=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS     logoilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if cowsmplC==1, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS     logoilres logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmplC==1, robust cluster(numcode)

	* IV public reserves
	tsset numcode year
	xtivreg2 onset2COWCS              logGDP_M ecgrowth logpop_M            democracy (logoilres=logoilres_public) if cowsmplC==1, robust cluster(numcode) fe endog(logoilres) ffirst
drop cowsmplC

* panel E do not restrict the sample
	dprobit onset2COWCS     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	reg onset2COWCS         logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	* small region FE
	xi: reg onset2COWCS     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS     logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode, robust cluster(numcode)

	* IV public reserves
	tsset numcode year
	xtivreg2 onset2COWCS                  logGDP_M ecgrowth logpop_M            democracy (logvaloilres=logvaloilres_public), robust cluster(numcode) fe endog(logvaloilres) ffirst
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset2COWCS                  logGDP_M ecgrowth logpop_M            democracy (logvaloilres=logoutreg logoilres disaster_res), robust cluster(numcode) fe endog(logvaloilres) first
			
* panel F
 gen disaster_resfull=logoutreg*logoilres_full

	dprobit onset2COWCS     logvaloilres_full logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	reg onset2COWCS         logvaloilres_full logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmplE=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS     logvaloilres_full logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if cowsmplE==1, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS     logvaloilres_full logGDP_M ecgrowth logpop_M            democracy i.numcode, robust cluster(numcode)

	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset2COWCS                      logGDP_M ecgrowth logpop_M            democracy (logvaloilres_full=logoutreg logoilres_full disaster_resfull) , robust cluster(numcode) fe endog(logvaloilres_full) first
drop cowsmplE

***********************************************
****************   TB A4 **********************
***********************************************
* panel A
* use polarization instead of fractionalization
	reg onset2COWCS         logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ETHPOL_reynal RELPOL_reynal language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmpl=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ETHPOL_reynal RELPOL_reynal language_fractionalization leg_british i.smallregion if cowsmpl==1, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS     logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if cowsmpl==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 onset2COWCS                 logGDP_M ecgrowth logpop_M            democracy (logvaloilres=logvaloilres_public) if cowsmpl==1, robust cluster(numcode) fe endog(logvaloilres) ffirst
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset2COWCS                 logGDP_M ecgrowth logpop_M            democracy (logvaloilres=logoutreg logoilres disaster_res) if cowsmpl==1, robust cluster(numcode) fe endog(logvaloilres) first
drop cowsmpl

* panel B
* use panel data on fractionalization
	* country FE
	* do not restrict data as sample is too small
	xi: reg onset2COWCS     logvaloilres logGDP_M ecgrowth logpop_M   efrac lfrac rfrac          democracy i.numcode , robust cluster(numcode)
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset2COWCS                  logGDP_M ecgrowth logpop_M  efrac lfrac rfrac        democracy (logvaloilres=logoutreg logoilres disaster_res) , robust cluster(numcode) fe endog(logvaloilres) first

* panel C
* use x-polity
	reg onset2COWCS         logvaloilres logGDP_M ecgrowth logpop_M logpopdens x_dem logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmpl=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS     logvaloilres logGDP_M ecgrowth logpop_M logpopdens x_dem logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if cowsmpl==1, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS     logvaloilres logGDP_M ecgrowth logpop_M            x_dem i.numcode if cowsmpl==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 onset2COWCS                 logGDP_M ecgrowth logpop_M            x_dem (logvaloilres=logvaloilres_public) if cowsmpl==1, robust cluster(numcode) fe endog(logvaloilres) ffirst
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset2COWCS                 logGDP_M ecgrowth logpop_M            x_dem (logvaloilres=logoutreg logoilres disaster_res) if cowsmpl==1, robust cluster(numcode) fe endog(logvaloilres) first
drop cowsmpl

* panel D
* use lagged controls
	reg onset2COWCS         logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmpl=1 if e(sample)
	* small region FE
	xi: reg onset2COWCS     logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.logpopdens L.democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if cowsmpl==1, robust cluster(numcode)
	* country FE
	xi: reg onset2COWCS     logvaloilres L.logGDP_M L.ecgrowth L.logpop_M              L.democracy i.numcode if cowsmpl==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 onset2COWCS                 L.logGDP_M L.ecgrowth L.logpop_M            L.democracy (logvaloilres=logvaloilres_public) if cowsmpl==1, robust cluster(numcode) fe endog(logvaloilres) ffirst
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset2COWCS                 L.logGDP_M L.ecgrowth L.logpop_M            L.democracy (logvaloilres=logoutreg logoilres disaster_res) if cowsmpl==1, robust cluster(numcode) fe endog(logvaloilres) first
drop cowsmpl

***********************************************
****************   TB A5 **********************
***********************************************
***FEARON
	reg onset_FearonCS         logvaloilres_impute logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen fearonsmpl08=1 if e(sample)	
	* small region FE
	xi: reg onset_FearonCS     logvaloilres_impute logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if fearonsmpl08==1, robust cluster(numcode)
	* country FE
	xi: reg onset_FearonCS     logvaloilres_impute logGDP_M ecgrowth logpop_M            democracy i.numcode if fearonsmpl08==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 onset_FearonCS                        logGDP_M ecgrowth logpop_M            democracy (logvaloilres_impute=logvaloilres_public) if fearonsmpl08==1, robust cluster(numcode) fe endog(logvaloilres_impute) ffirst
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset_FearonCS                        logGDP_M ecgrowth logpop_M            democracy (logvaloilres_impute=logoutreg logoilres_impute disaster_res08) if fearonsmpl08==1, robust cluster(numcode) fe endog(logvaloilres_impute) first
drop fearonsmpl08

***SAMBANIS
	reg onset_SambanisCS         logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen sambanissmpl=1 if e(sample)
	* small region FE
	xi: reg onset_SambanisCS     logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if sambanissmpl==1, robust cluster(numcode)
	
	* country FE
	xi: reg onset_SambanisCS     logvaloilres logGDP_M ecgrowth logpop_M            democracy i.numcode if sambanissmpl==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 onset_SambanisCS                  logGDP_M ecgrowth logpop_M            democracy (logvaloilres=logvaloilres_public) if sambanissmpl==1, robust cluster(numcode) fe endog(logvaloilres) ffirst
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 onset_SambanisCS                  logGDP_M ecgrowth logpop_M            democracy (logvaloilres=logoutreg logoilres disaster_res) if sambanissmpl==1, robust cluster(numcode) fe endog(logvaloilres) first
drop sambanissmpl

***Using Powell and ThyneÕs Coup Data
	reg any_coup              logvaloilres_impute logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen coup08=1 if e(sample)	
	* small region FE
	xi: reg any_coup          logvaloilres_impute logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.smallregion if coup08==1, robust cluster(numcode)
	* country FE
	xi: reg any_coup          logvaloilres_impute logGDP_M ecgrowth logpop_M            democracy i.numcode if coup08==1, robust cluster(numcode)
	* IV public reserves
	tsset numcode year
	xtivreg2 any_coup                             logGDP_M ecgrowth logpop_M            democracy (logvaloilres_impute=logvaloilres_public) if coup08==1, robust cluster(numcode) fe endog(logvaloilres_impute) ffirst
	* IV using disaster, reserves, disaster*reserves
    xtivreg2 any_coup                             logGDP_M ecgrowth logpop_M            democracy (logvaloilres_impute=logoutreg logoilres_impute disaster_res08) if coup08==1, robust cluster(numcode) fe endog(logvaloilres_impute) first
drop coup08







