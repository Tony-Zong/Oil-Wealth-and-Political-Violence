

clear all
use "Comprehensive Sample.dta"

* FIGURE 1 Gleditsch-COW data
	* use sample of countries used for regressions in Table 2 cols 1-4
	reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmpl=1 if e(sample)	
	by numcode: egen sampleC=max(cowsmpl)
	replace sampleC=. if year<1930 | year>2003

by numcode, sort: egen no_onsetCOW=total(onset2COWCS) if sampleC==1
by numcode, sort: egen temp=count( incidence2COW) if sampleC==1
gen meanonset=no_onsetCOW/temp
by numcode, sort: egen wealthCOW=mean(logvaloilres) if sampleC==1

keep if year==2000
keep if sampleC==1
keep numcode code3 meanonset wealthCOW

twoway (scatter meanonset wealthCOW, sort mcolor(black) msize(vsmall) mlabel(code3) mlabsize(vsmall) mlabcolor(black) mlabposition(12) mlabangle(forty_five)), ytitle(Likelihood of Civil War Onset) xtitle(Average Oil Wealth) legend(off) || lfit meanonset wealthCOW 
reg meanonset wealthCOW

**************************
**************************
clear all
set more off
use "/Users/acotet/Documents\WAR AEJ3\AEJ5\PUBLISHED\Comprehensive Sample.dta"
* FIGURE A1 UCDP large sample
* get sample from Table 2 col 9
xi: reg onsetUCS     logvaloilres_impute  logGDP_M ecgrowth logpop_M    democracy  i.numcode  , robust cluster(numcode)	
	gen priosmpl08=1 if e(sample)
	by numcode: egen sampleU=max(priosmpl08)
	replace sampleU=. if year<1946 | year>2008

by numcode, sort: egen no_onsetUCDP=total(onsetUCS) if sampleU==1
by numcode, sort: egen temp=count(incidenceU) if sampleU==1

gen meanonset=no_onsetUCDP/temp
by numcode, sort: egen wealthU=mean(logvaloilres) if sampleU==1

keep if year==2000
keep if sampleU==1

keep numcode code3 meanonset wealthU

twoway (scatter meanonset wealthU, sort mcolor(black) msize(vsmall) mlabel(code3) mlabsize(vsmall) mlabcolor(black) mlabposition(12) mlabangle(forty_five)), ytitle(Likelihood of Civil War Onset) xtitle(Average Oil Wealth) legend(off) || lfit meanonset wealthU 
reg meanonset wealthU

**************************
**************************
clear all
set more off
use "/Users/acotet/Documents\WAR AEJ3\AEJ5\PUBLISHED\Comprehensive Sample.dta"
* Figure 2
* Table 2 col 1-4
	reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cowsmpl=1 if e(sample)
	keep if cowsmpl==1
	
	xi: reg onset2COWCS  i.numcode if cowsmpl==1
	predict r_war, residuals
	xi: reg logvaloilres i.numcode if cowsmpl==1
	predict r_oil, residuals

lpoly r_war r_oil, kernel(epan2) bwidth (0.03) degree(1) noscatter ci 


***********************
***********************
clear all
set more off
use "/Users/acotet/Documents\WAR AEJ3\AEJ5\PUBLISHED\Comprehensive Sample.dta"
* Figure A2
* Table 2 col 9
	* UCDP
	gen disaster_res08=logoutreg*logoilres_impute
	xi: reg onsetUCS      logvaloilres_impute logGDP_M ecgrowth logpop_M    democracy  i.numcode, robust cluster(numcode) 
	gen priosmpl08=1 if e(sample)
	keep if priosmpl08==1
	
	xi: reg onsetUCS  i.numcode if priosmpl08==1
	predict r_war, residuals
	xi: reg logvaloilres i.numcode if priosmpl08==1
	predict r_oil, residuals

lpoly r_war r_oil, kernel(epan2) bwidth (0.03) degree(1) noscatter ci 
***********************
***********************
clear all
set more off
use "/Users/acotet/Documents\WAR AEJ3\AEJ5\PUBLISHED\Comprehensive Sample.dta"	
* Table 4 Panel C sample
reg logmilexgdpSIPRI logoilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if democracy<=0.5, robust cluster(numcode)
keep if e(sample)

	xi: reg logmilexgdpSIPRI  i.numcode 
	predict r_milexpND, residuals
	xi: reg logvaloilres i.numcode 
	predict r_oilND, residuals

lpoly r_milexpND r_oilND, kernel(epan2) bwidth (0.03) degree(1) noscatter ci 
***********************
***********************
clear all
use "/Users/acotet/Documents\WAR AEJ3\AEJ4\FINAL\Comprehensive Sample.dta"

* report summary statistics for the sample of countries used Tb 2 col 1-4 
reg onset2COWCS         logvaloilres       logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
gen used=1 if e(sample)
by numcode: egen sample=max(used)
replace sample=. if year<1930 | year>2003
drop used
keep if sample==1

* get sample countries with NO OIL
by numcode, sort: egen temp=mean(oilreserves)
gen nooil=1 if temp==0
drop temp

* get sample countries with  Small vs Big OIL
gen temp=logvaloilres if oilreserves>0 & oilreserves!=.
by numcode: egen oil=mean(temp) 
drop temp
tabstat oil, statistics( median ) columns(variables)

gen smalloil=1 if oil<=0.01236 & oil!=.
gen bigoil=1 if oil>0.01236 & oil!=.
 
* SUMMARY STATISTICS
* NOTE: in the paper we report the means of variables not divided by 100
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
	
*ALL SAMPLE
sum logvaloilres logvaldisc ///
	onset2COWCS onsetUCS coup periregular logmilexgdpSIPRI ///
 	logGDP_M ecgrowth logpop_M logpopdens democracy x_dem logmountain ethnic_fractionalization ///
	language_fractionalization religion_fractionalization leg_british wildcat 
*NO OIL
sum logvaloilres logvaldisc ///
	onset2COWCS onsetUCS coup periregular logmilexgdpSIPRI ///
 	logGDP_M ecgrowth logpop_M logpopdens democracy x_dem logmountain ethnic_fractionalization ///
	language_fractionalization religion_fractionalization leg_british wildcat if nooil==1 
* SMALL OIL
sum logvaloilres logvaldisc ///
	onset2COWCS onsetUCS coup periregular logmilexgdpSIPRI ///
 	logGDP_M ecgrowth logpop_M logpopdens democracy x_dem logmountain ethnic_fractionalization ///
	language_fractionalization religion_fractionalization leg_british wildcat if smalloil==1 
* BIG OIL
sum logvaloilres logvaldisc ///
	onset2COWCS onsetUCS coup periregular logmilexgdpSIPRI ///
 	logGDP_M ecgrowth logpop_M logpopdens democracy x_dem logmountain ethnic_fractionalization ///
	language_fractionalization religion_fractionalization leg_british wildcat if bigoil==1 

* TESTS 
replace nooil=0 if sample==1 & nooil==.
replace smalloil=0 if sample==1 & smalloil==.
replace bigoil=0 if sample==1 & bigoil==.


reg logvaloilres smalloil bigoil , cluster(numcode)
test smalloil bigoil
reg logvaldisc smalloil bigoil , cluster(numcode)
test smalloil bigoil 

reg onset2COWCS smalloil bigoil , cluster(numcode) 
test smalloil bigoil
reg onsetUCS smalloil bigoil , cluster(numcode) 
test smalloil bigoil
reg coup smalloil bigoil , cluster(numcode)
test smalloil bigoil 
reg periregular smalloil bigoil , cluster(numcode) 
test smalloil bigoil
reg logmilexgdpSIPRI smalloil bigoil, cluster(numcode)
test smalloil bigoil

reg logGDP_M smalloil bigoil, cluster(numcode)
test smalloil bigoil 
reg ecgrowth smalloil bigoil, cluster(numcode)
test smalloil bigoil 
reg logpop_M smalloil bigoil, cluster(numcode)
test smalloil bigoil 
reg logpopdens smalloil bigoil, cluster(numcode)
test smalloil bigoil 
reg democracy smalloil bigoil, cluster(numcode)
test smalloil bigoil 
reg x_dem smalloil bigoil, cluster(numcode)
test smalloil bigoil
reg logmountain smalloil bigoil , cluster(numcode)
test smalloil bigoil 
reg ethnic_fractionalization smalloil bigoil , cluster(numcode)
test smalloil bigoil	
reg religion_fractionalization smalloil bigoil , cluster(numcode) 
test smalloil bigoil
reg language_fractionalization smalloil bigoil , cluster(numcode) 
test smalloil bigoil
reg leg_british smalloil bigoil, cluster(numcode) 
test smalloil bigoil
reg wildcat smalloil bigoil , cluster(numcode)
test smalloil bigoil




	
