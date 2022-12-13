******************************************************************************
************************** STANDARD MATCHING *********************************
******************************************************************************
** does not include Llogoilres Lcrude1990P africa southam asia oceania

********************* FULL SAMPLE ************************

clear all
use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta"

// simplified version - no lag
teffects psmatch (onset2COWCS) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (d2incidence2COW) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 
teffects psmatch (d3_6incidence2COW) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (onsetUCS) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (dincidenceU) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (d3_6incidenceU) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) // overlapping assumption violated
teffects psmatch (dcoup) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) // p=0.033
teffects psmatch (dperiregular) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) // overlapping assumption violated
teffects psmatch (milexgdpSIPRI_diff) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 

// full version - no lag
* foreach `v' in onset2COWCS d2incidence2COW d3_6incidence2COW onsetUCS dincidenceU d3_6incidenceU dcoup periregular milexgdpSIPRI_diff{
* 	clear all
* 	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta"
* 	logit wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
*	mfx
* 	teffects psmatch (`v') (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit), generate(stub)
* 	predict ps0 ps1, ps // The propensity scores for each group.
*   predict y0 y1, po // The potential outcome estimated for each group.
*   predict te // The treatment effect estimated for each group.
*   sum te
*   tebalance summarize
* }

// simplified version - one year lag
teffects psmatch (onset2COWCS) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)    
teffects psmatch (d2incidence2COW) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)  
teffects psmatch (d3_6incidence2COW) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (onsetUCS) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (dincidenceU) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (d3_6incidenceU) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) 
teffects psmatch (dcoup) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) 
teffects psmatch (periregular) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) // p=0.005
teffects psmatch (milexgdpSIPRI_diff) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) // overlapping assumption violated

// full version - one year lag
* foreach `v' in onset2COWCS d2incidence2COW d3_6incidence2COW onsetUCS dincidenceU d3_6incidenceU dcoup periregular milexgdpSIPRI_diff{
* 	clear all
* 	use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching.dta"
* 	logit wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, robust cluster(numcode)
*	mfx
* 	teffects psmatch (`v') (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit), generate(stub)
* 	predict ps0 ps1, ps // The propensity scores for each group.
*   predict y0 y1, po // The potential outcome estimated for each group.
*   predict te // The treatment effect estimated for each group.
*   sum te
*   tebalance summarize
* }


********************* DEMOCRATIC SAMPLE ************************

clear all
use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-demo.dta"

// no lag
teffects psmatch (onset2COWCS) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (d2incidence2COW) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 
teffects psmatch (d3_6incidence2COW) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (onsetUCS) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) // p=0.024 
teffects psmatch (dincidenceU) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (d3_6incidenceU) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 
teffects psmatch (dcoup) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) // p=0.033
teffects psmatch (periregular) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 
teffects psmatch (milexgdpSIPRI_diff) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 


// one year lag
teffects psmatch (onset2COWCS) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)    
teffects psmatch (d2incidence2COW) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)  
teffects psmatch (d3_6incidence2COW) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (onsetUCS) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (dincidenceU) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (d3_6incidenceU) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) 
teffects psmatch (dcoup) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) 
teffects psmatch (periregular) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) 
teffects psmatch (milexgdpSIPRI_diff) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)




********************* NON-DEMOCRATIC SAMPLE ************************

clear all
use "/Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/Data/data/aspo_full_matching-non-demo.dta"

// no lag
teffects psmatch (onset2COWCS) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
	// overlapping assumption violated ... 
teffects psmatch (d2incidence2COW) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 
teffects psmatch (d3_6incidence2COW) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (onsetUCS) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 
teffects psmatch (dincidenceU) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (d3_6incidenceU) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 
teffects psmatch (dcoup) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
teffects psmatch (periregular) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit) 
	// overlapping assumption violated [end]
teffects psmatch (milexgdpSIPRI_diff) (wildcat_diff_binary valoilres_diff ecgrowth popdens_diff democracy_diff logmountain ethnic_fractionalization religion_fractionalization language_fractionalization leg_british, probit)
 


// one year lag
teffects psmatch (onset2COWCS) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)    
teffects psmatch (d2incidence2COW) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)  
teffects psmatch (d3_6incidence2COW) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (onsetUCS) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (dincidenceU) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit)
teffects psmatch (d3_6incidenceU) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) 
teffects psmatch (dcoup) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) 
teffects psmatch (periregular) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) 
teffects psmatch (milexgdpSIPRI_diff) (wildcat_diff_binary l1valoilres_diff l1ecgrowth l1popdens_diff l1democracy_diff l1logmountain l1ethnic_fractionalization l1religion_fractionalization l1language_fractionalization l1leg_british, probit) // overlapping assumption violated

*******************************************************************************



