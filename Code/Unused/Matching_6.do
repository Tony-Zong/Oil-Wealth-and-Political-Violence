******************************************************************************
************************ STRATIFICATION AND FE *******************************
******************************************************************************

* foreach v in onset2COWCS d2incidence2COW d3_6incidence2COW onsetUCS dincidenceU d3_6incidenceU dcoup dperiregular milexgdpSIPRI_diff{
* 	**
* }



****************************** FULL SAMPLE ************************************ 

** use significance level of 0.05

************** no lag **************
* onset2COWCS
	* reinitialize the dataset
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta"
	* work on the same sample
	reg onset2COWCS  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	* check propensity score
	logit wildcat_diff_binary oilreserves_diff crude1990P_diff ecgrowth popdens_diff democracy_diff logmountain incidence2COW 
	* pscore block
	pscore wildcat_diff_binary ecgrowth logmountain, pscore(p1) blockid(b1) logit comsup 
	* Stratification and fixed effect -- no lag
	reg onset2COWCS  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade i.b1, robust cluster(numcode)
	* reg onset2COWCS  wildcat_diff_binary ecgrowth popdens_diff democracy_diff logmountain  ethnic_fractionalization religion_fractionalization language_fractionalization leg_british i.decade i.b1, robust cluster(numcode)
	* doubly robust IPW regression-adjusted ATE estimation
	teffects aipw (onset2COWCS ecgrowth popdens_diff democracy_diff i.numcode i.decade) (wildcat_diff_binary ecgrowth logmountain, logit)
	* teffects aipw (onset2COWCS ecgrowth popdens_diff democracy_diff i.numcode i.decade) (wildcat_diff_binary ecgrowth logmountain, logit)


* defense burden
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta"
	reg milexgdpSIPRI_diff  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	logit wildcat_diff_binary oilreserves_diff crude1990P_diff ecgrowth popdens_diff democracy_diff logmountain incidence2COW 
	pscore wildcat_diff_binary oilreserves_diff, pscore(p1) blockid(b1) logit comsup 
	reg onset2COWCS  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade i.b1, robust cluster(numcode)
	teffects aipw (milexgdpSIPRI_diff ecgrowth popdens_diff democracy_diff i.numcode i.decade) (wildcat_diff_binary oilreserves_diff, logit)

******** one year lag **************
* onset2COWCS
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta"
	reg onset2COWCS  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	logit wildcat_diff_binary l1oilreserves_diff l1crude1990P_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1incidence2COW 
		
	pscore wildcat_diff_binary l1oilreserves_diff l1ecgrowth l1logmountain, pscore(p1) blockid(b1) logit comsup 
	reg onset2COWCS  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade i.b1, robust cluster(numcode)
	teffects aipw (onset2COWCS  l1popdens_diff l1democracy_diff  i.numcode i.decade) (wildcat_diff_binary l1oilreserves_diff l1ecgrowth l1logmountain, logit)
	
* defense burden
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta"
	reg milexgdpSIPRI_diff  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample) 
	logit wildcat_diff_binary l1oilreserves_diff l1crude1990P_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1incidence2COW 
		
	pscore wildcat_diff_binary l1crude1990P_diff l1ecgrowth, pscore(p1) blockid(b1) logit comsup 
	reg milexgdpSIPRI_diff  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade i.b1, robust cluster(numcode)
	teffects aipw (onset2COWCS  l1popdens_diff l1democracy_diff  i.numcode i.decade) (wildcat_diff_binary l1crude1990P_diff  l1ecgrowth, logit)

	
	
	
****************************** DEMO SAMPLE ************************************ 

************ no lag **************
* onset2COWCS
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-demo.dta"
	reg onset2COWCS  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	logit wildcat_diff_binary oilreserves_diff crude1990P_diff ecgrowth popdens_diff democracy_diff logmountain incidence2COW 
		
	** no significant covariate for matching
	teffects aipw (onset2COWCS  ecgrowth popdens_diff democracy_diff logmountain  ethnic_fractionalization religion_fractionalization language_fractionalization leg_british) (wildcat_diff_binary)

* defense burden
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-demo.dta"
	reg milexgdpSIPRI_diff  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	logit wildcat_diff_binary oilreserves_diff crude1990P_diff  ecgrowth popdens_diff democracy_diff logmountain incidence2COW 
	** no significant covariate for matching
	teffects aipw (milexgdpSIPRI_diff ecgrowth popdens_diff democracy_diff i.numcode i.decade) (wildcat_diff_binary)

******** one year lag **************
* onset2COWCS
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-demo.dta"
	reg onset2COWCS  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	logit wildcat_diff_binary l1oilreserves_diff l1crude1990P_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1incidence2COW 
	** no significant confounders
	teffects aipw (onset2COWCS   l1ecgrowth l1popdens_diff l1democracy_diff  i.numcode i.decade) (wildcat_diff_binary)

* defense burden
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-demo.dta"
	reg milexgdpSIPRI_diff  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	logit wildcat_diff_binary  l1oilreserves_diff l1crude1990P_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1incidence2COW 
	pscore wildcat_diff_binary l1crude1990P_diff  l1ecgrowth, pscore(p1) blockid(b1) logit comsup 
	reg milexgdpSIPRI_diff  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade i.b1, robust cluster(numcode)
	teffects aipw (milexgdpSIPRI_diff  l1ecgrowth l1popdens_diff l1democracy_diff  i.numcode i.decade) (wildcat_diff_binary l1crude1990P_diff l1ecgrowth, logit)
	
	
	
*************************** NON-DEMO SAMPLE *********************************** 


************** no lag **************
* onset2COWCS
	* reinitialize the dataset
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-non-demo.dta"
	* work on the same sample
	reg onset2COWCS  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	* check propensity score
	logit wildcat_diff_binary oilreserves_diff crude1990P_diff ecgrowth popdens_diff democracy_diff logmountain incidence2COW 
		
	* pscore block
	pscore wildcat_diff_binary  ecgrowth, pscore(p1) blockid(b1) logit comsup 
	* Stratification and fixed effect -- no lag
	reg onset2COWCS  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade i.b1, robust cluster(numcode)
	* doubly robust IPW regression-adjusted ATE estimation
	teffects aipw (onset2COWCS  ecgrowth popdens_diff democracy_diff logmountain  ethnic_fractionalization religion_fractionalization language_fractionalization leg_british) (wildcat_diff_binary ecgrowth, logit)

* defense burden
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-non-demo.dta"
	reg milexgdpSIPRI_diff  wildcat_diff_binary ecgrowth popdens_diff democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	logit wildcat_diff_binary  oilreserves_diff crude1990P_diff ecgrowth popdens_diff democracy_diff logmountain incidence2COW 
		
	** no significant confounders
	teffects aipw (milexgdpSIPRI_diff ecgrowth popdens_diff democracy_diff  i.numcode i.decade) (wildcat_diff_binary)

******** one year lag **************
* onset2COWCS
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-non-demo.dta"
	reg onset2COWCS  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample)
	logit wildcat_diff_binary  l1oilreserves_diff l1crude1990P_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1incidence2COW 
		
	pscore wildcat_diff_binary l1crude1990P_diff, pscore(p1) blockid(b1) logit comsup 
	reg onset2COWCS  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade i.b1, robust cluster(numcode)
	** no significant confounders
	teffects aipw (onset2COWCS  l1ecgrowth l1popdens_diff l1democracy_diff  i.numcode i.decade) (wildcat_diff_binary)
	
* defense burden
	clear all
	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-non-demo.dta"
	reg milexgdpSIPRI_diff  wildcat_diff_binary  l1ecgrowth l1popdens_diff l1democracy_diff i.numcode i.decade, robust cluster(numcode)
		keep if e(sample) 
	logit wildcat_diff_binary l1oilreserves_diff l1crude1990P_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1incidence2COW 
		
	** no significant confounders
	teffects aipw (milexgdpSIPRI_diff l1ecgrowth l1popdens_diff l1democracy_diff  i.numcode i.decade) (wildcat_diff_binary)



********************************************************************************
* check propensity score
* logitwildcat_diff_binary oilreserves_diff crude1990P_diff ecgrowth popdens_diff democracy_diff logmountain incidence2COW 
** pscore block
* pscore wildcat ecgrowth, pscore(p2) blockid(b2) logitcomsup numblo(8)

*******************************************************************************
** To-do:
* for the purpose of matching get higher terms, interaction terms
	// gen o2=Llogoilres^2
	// gen dem2=Ldemocracy^2
	// gen dem3=Ldemocracy^3
	// gen odem=Llogoilres*Ldemocracy
	// gen o2dem=Llogoilres^2*Ldemocracy
	// gen crude2=Lcrude1990P^2
	// gen ocrude=Llogoilres*Lcrude1990P
	// gen warcrude=Lincidence2COW*Lcrude1990P
*******************************************************************************	

************************************************
** To-do:
** kernel matching
** kmatch
** psmatch2
************************************************







