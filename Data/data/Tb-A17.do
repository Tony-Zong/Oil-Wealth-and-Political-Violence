
clear all
use "Comprehensive Sample.dta"

* Table A17
	* use the same sample for comparability
	* get sample
	reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen cows=1 if e(sample)
	xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if pr==1, robust cluster(numcode)	
	gen prios=1 if e(sample)
	reg coup logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen coups=1 if e(sample)
	reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen iregs=1 if e(sample)
	reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
	gen exps=1 if e(sample)
	reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if democracy>0.005, robust cluster(numcode)
	gen expDs=1 if e(sample)
	reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M logpopdens democracy logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british if democracy<=0.005, robust cluster(numcode)
	gen expNDs=1 if e(sample)

* BASELINE
xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M     democracy i.numcode if cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg onsetUCS    logvaloilres_impute logGDP_M ecgrowth logpop_M     democracy i.numcode if prios==1, robust cluster(numcode)
	xi: reg dincidenceU    logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg coup        logvaloilres logGDP_M ecgrowth logpop_M     democracy i.numcode if coups==1, robust cluster(numcode)
	xi: reg dcoup          logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M     democracy i.numcode if iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)
	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M    democracy i.numcode if democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)

************************
************************
* EXCLUDE USA
xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if numcode!=840 & cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=840, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M  democracy i.numcode if numcode!=840 & prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=840, robust cluster(numcode)

xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if numcode!=840 & coups==1, robust cluster(numcode)
	xi: reg dcoup logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=840, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=840 & iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=840, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=840 & exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M  L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=840, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=840 & democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=840 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=840 & democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=840 & democracy<=0.005, robust cluster(numcode)

************************
************************
* EXCLUDE URSS
xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=810 & cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=810, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=810 & prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=810, robust cluster(numcode)

xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=810 & coups==1, robust cluster(numcode)
	xi: reg dcoup logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=810, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=810 & iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=810, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=810 & exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=810, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=810 & democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=810 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if numcode!=810 & democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & numcode!=810 & democracy<=0.005, robust cluster(numcode)

************************
************************
* CONTROL OPEC

xi: reg onset2COWCS logvaloilres opec logGDP_M ecgrowth logpop_M  democracy i.numcode if cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc opec wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute opec logGDP_M ecgrowth logpop_M  democracy i.numcode  if prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc opec wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg coup logvaloilres opec logGDP_M ecgrowth logpop_M  democracy i.numcode if coups==1 , robust cluster(numcode)
	xi: reg dcoup logvaldisc opec wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg periregular logvaloilres opec no_transition logGDP_M ecgrowth logpop_M  democracy i.numcode if iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc opec no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres opec logGDP_M ecgrowth logpop_M  democracy i.numcode if exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc opec wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres opec logGDP_M ecgrowth logpop_M  democracy i.numcode if democracy>0.005 & expDs==1, robust cluster(numcode)
			xi: reg dmilexpSIPRI logvaldisc opec wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres opec logGDP_M ecgrowth logpop_M  democracy i.numcode if democracy<=0.005 & expNDs==1, robust cluster(numcode)
			xi: reg dmilexpSIPRI logvaldisc opec wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)
	
************************
************************	
* LOW INCOME COUNTRIES according to WORLD BANK october 2008

xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if lowincsample==1 & cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & lowincsample==1, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M democracy i.numcode if lowincsample==1 & prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & lowincsample==1, robust cluster(numcode)

xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if lowincsample==1 & coups==1, robust cluster(numcode)
	xi: reg dcoup logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & lowincsample==1, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M democracy i.numcode if lowincsample==1 & iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & lowincsample==1, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if lowincsample==1 & exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & lowincsample==1, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if lowincsample==1 & democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & lowincsample==1 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if lowincsample==1 & democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & lowincsample==1 & democracy<=0.005, robust cluster(numcode)

************************
************************
* PREDOMINANTLY MOUNTAINOUS
tabstat logmountain, statistics( median ) columns(variables)

xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if logmountain>0.0218605 & cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & logmountain>0.0218605, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M democracy i.numcode if logmountain>0.0218605 & prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & logmountain>0.0218605, robust cluster(numcode)

xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if logmountain>0.0218605 & coups==1, robust cluster(numcode)
	xi: reg dcoup logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & logmountain>0.0218605, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M democracy i.numcode if logmountain>0.0218605 & iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & logmountain>0.0218605, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if logmountain>0.0218605 & exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & logmountain>0.0218605, robust cluster(numcode)
	
	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if logmountain>0.0218605 & democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & logmountain>0.0218605 & democracy>0.005, robust cluster(numcode)
	* non-democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if logmountain>0.0218605 & democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & logmountain>0.0218605 & democracy<=0.005, robust cluster(numcode)

************************
************************
* FRACTIONALIZED COUNTRIES 
xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if ethnic_fractionalization>0.005 & cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & ethnic_fractionalization>0.005, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M  democracy i.numcode if ethnic_fractionalization>0.005 & prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & ethnic_fractionalization>0.005, robust cluster(numcode)

xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if ethnic_fractionalization>0.005 & coups==1, robust cluster(numcode)
	xi: reg dcoup logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & ethnic_fractionalization>0.005, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M  democracy i.numcode if ethnic_fractionalization>0.005 & iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & ethnic_fractionalization>0.005, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if ethnic_fractionalization>0.005 & exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & ethnic_fractionalization>0.005, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if ethnic_fractionalization>0.005 & democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & ethnic_fractionalization>0.005 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if ethnic_fractionalization>0.005 & democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & ethnic_fractionalization>0.005 & democracy<=0.005, robust cluster(numcode)

************************
************************
* BAD GOVERNANCE COUNTRIES
xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if cows==1 & rule_law<0, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & rule_law<0, robust cluster(numcode)

xi: reg onsetUCS    logvaloilres_impute logGDP_M ecgrowth logpop_M democracy i.numcode if prios==1 & rule_law<0, robust cluster(numcode)
	xi: reg dincidenceU    logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & rule_law<0, robust cluster(numcode)

xi: reg coup        logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if coups==1 & rule_law<0, robust cluster(numcode)
	xi: reg dcoup          logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & rule_law<0, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M democracy i.numcode if iregs==1 & rule_law<0, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & rule_law<0, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if exps==1 & rule_law<0, robust cluster(numcode)
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & rule_law<0, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode if democracy>0.005 & expDs==1 & rule_law<0, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & democracy>0.005 & rule_law<0, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if democracy<=0.005 & expNDs==1 & rule_law<0, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & democracy<=0.005 & rule_law<0, robust cluster(numcode)
	
************************
************************	
* Post WWII

xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if year>1945 & cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & year>1945, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M democracy i.numcode if year>1945 & prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & year>1945, robust cluster(numcode)

xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if year>1945 & coups==1, robust cluster(numcode)
	xi: reg dcoup logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & year>1945, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M democracy i.numcode if year>1945 & iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & year>1945, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if year>1945 & exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & year>1945, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if year>1945 & democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & year>1945 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if year>1945 & democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & year>1945 & democracy<=0.005, robust cluster(numcode)
	
************************
************************	
* NO WAR at t-1
xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if L.incidence2COW==0 & cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & L.incidence2COW==0, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M democracy i.numcode if L.incidenceU==0 & prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & L.incidenceU==0, robust cluster(numcode)

xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if L.incidenceU==0 & coups==1, robust cluster(numcode)
	xi: reg dcoup logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & L.incidenceU==0, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M democracy i.numcode if L.incidenceU==0 & iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & L.incidenceU==0, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if L.incidenceU==0 & exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & L.incidenceU==0, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if L.incidenceU==0 & democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & L.incidenceU==0 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode if L.incidenceU==0 & democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.decade if wildcatsample==1 & L.incidenceU==0 & democracy<=0.005, robust cluster(numcode)

************************
************************
* ADD TIME FE

xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M democracy i.numcode i.year if cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.year if wildcatsample==1, robust cluster(numcode)

xi: reg onsetUCS logvaloilres_impute logGDP_M ecgrowth logpop_M  democracy i.numcode i.year if prios==1, robust cluster(numcode)
	xi: reg dincidenceU logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.year if wildcatsample==1, robust cluster(numcode)

xi: reg coup logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode i.year if coups==1, robust cluster(numcode)
	xi: reg dcoup logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.year if wildcatsample==1, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M  democracy i.numcode i.year if iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.year if wildcatsample==1, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode i.year if exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.year if wildcatsample==1, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode i.year if democracy>0.005 & expDs==1, robust cluster(numcode)
			xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.year if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M  democracy i.numcode i.year if democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.democracy i.numcode i.year if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)

************************
************************	
* X-POLITY
xi: reg onset2COWCS logvaloilres logGDP_M ecgrowth logpop_M x_dem i.numcode if cows==1, robust cluster(numcode)
	xi: reg dincidence2COW logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.x_dem i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg onsetUCS    logvaloilres_impute logGDP_M ecgrowth logpop_M x_dem i.numcode if prios==1, robust cluster(numcode)
	xi: reg dincidenceU    logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.x_dem i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg coup        logvaloilres logGDP_M ecgrowth logpop_M x_dem i.numcode if coups==1, robust cluster(numcode)
	xi: reg dcoup          logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.x_dem i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg periregular logvaloilres no_transition logGDP_M ecgrowth logpop_M x_dem i.numcode if iregs==1, robust cluster(numcode)
	xi: reg periregular logvaldisc no_transition wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.x_dem i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M x_dem i.numcode if exps==1, robust cluster(numcode)
	xi: reg dmilexpSIPRI   logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.x_dem i.numcode i.decade if wildcatsample==1, robust cluster(numcode)

	* democracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M x_dem i.numcode if democracy>0.005 & expDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.x_dem i.numcode i.decade if wildcatsample==1 & democracy>0.005, robust cluster(numcode)
	
	* nondemocracy
	xi: reg logmilexgdpSIPRI logvaloilres logGDP_M ecgrowth logpop_M x_dem i.numcode if democracy<=0.005 & expNDs==1, robust cluster(numcode)
		xi: reg dmilexpSIPRI logvaldisc wildcat L.logvaloilres L.logGDP_M L.ecgrowth L.logpop_M L.x_dem i.numcode i.decade if wildcatsample==1 & democracy<=0.005, robust cluster(numcode)

*************************
*************************




	
	
