# Timeline

@Nov 23/24 data analysis

@Nov 27 first draft

# Nov 14, 2022 Talk with Victor

1. Are the characteristics distinguishable for each unit? If not, then not much interesting to do (First thing to do)

2. Within-year variation may be too large

3. 1. Maybe the year is a better IV than draft eligibility?

   2. 1. Because there may be some cross-year variation
      2. Check Argentinian history if that’s the case
      3. Break up analysis by year - only then IV assumption can hold
      4. No not break up analysis by year - just use year as IV?

4. Binarize data: ⅓ most and ⅓ least on the treatment variable

5. Fit a few ML models and see the results (robust to the model chosen)

6. 1. Check the covariates

   2. 1. they do not seem super relevant according to Victor
      2. confounding effect is not obvious because we are taking an average of a fairly large and diverse population

7. More sophisticated: the effects still hold in other years?

Next steps:

1. Check across-unit variation
2. Check across-year variation

# Nov 15, 2022 Memo: Changing paper

## Why we want to change paper

./OldPaper/SanityCheck.ipynb

- The argentine paper has little variance in covariates (origins (argentine/indigenous/naturalized) and districts) within years. For example, the summary stats in year 1958:

  ![Screen Shot 2022-11-15 at 2.07.15 PM](assets/Screen Shot 2022-11-15 at 2.07.15 PM.png)

  - We cannot group observation by years, because we only have 5 year's data of covariates. 

## New paper

- https://www.aeaweb.org/articles?id=10.1257%2Fmac.5.1.49

- Observation: country-year

- Dataset: oil discovery and oil production for the top 62 oil countries over the period 1930-2003 + counrties with zero oil endowment

  - 103 countries in total

- Treatment: oil abudance

- Covariates: Democracy, per capita income, rough terrain, etc.

- Outcome: 

  - Civil war and other violence measures (like coups)

  - Defense burden

    ![Screen Shot 2022-11-15 at 2.46.25 PM](assets/Screen Shot 2022-11-15 at 2.46.25 PM.png)

  ### Model 1: FE, Oil reserves as treatment![Screen Shot 2022-11-15 at 2.49.46 PM](assets/Screen Shot 2022-11-15 at 2.49.46 PM.png)

  - violence is not affected by oil reserves
  - Oil reserves -> larger defense burden (among non-democratic samples)
  - not casual because RESERVE is endogenous to violence (e.g. via oil exploration decisions)

  ### Model 2: Propensity score matching, Oil discoveries as treatment

  - oil discovery -> (expectation and profitability of finding oil, related to political stability) -> oil exploration
    - -> success -> wealth increase; -> failure
      - empirically not affected by most covariates
  - to control for selection into exploration (wildcat drilling, first borehole)
    - Same results to model 1![Screen Shot 2022-11-15 at 3.04.08 PM](assets/Screen Shot 2022-11-15 at 3.04.08 PM.png)

  ### Sensitivity analysis

## questions and NEXT Steps

1. ML models that incorporate FE

   1. just take country as a covariate
   2. flatten out coutry-year observations and assume iid draw

   - [x] check covariates' variance

2. Covering every analysis in the paper?

   1. Yes--we will learn about robustness check and sensitivity analysis next class

3. Meeting: Wed 4:30- or Fri 3:30-

   - [x] send Prof Veitch an email to schedule a meeting

# Nov 16, 2022: Variable's variance

./covariate_variance_check.ipynb

- Large variance across the whole sample

- Small within-country variance fo covariates like religion
  - [x] should we throw them away in our machine learning model?
  - [x] ok to take country-year as observations, or aggregate to country-level? 
    - we have a dataset that collapses the data into averages for the period 1960-2003
  
  - [x] is the final paper a comparison of our and their findings, or more like a brand new presentation
  
  # Nov 18. 2022: Basic Analysis
  
  /Users/zwanran/Desktop/STAT27420/Final/STAT27420-final-code/1_basic_analysis.ipynb
  
  - Binarized the treatment

- [ ] transform data into the year-to-year difference form

- [ ] fit in models
  - [ ] covariate set 1: country + year
  - [ ] covariate set 2: static country characteristics + year
  - [ ] Clustering?
  
- [ ] Consider lagging

- [ ] nuances of oil discovery
  - [ ] match countries with same probability of oil exploration together

# Misc resources

ML models on matching: https://humboldt-wi.github.io/blog/research/applied_predictive_modeling_19/matching_methods/

ML models on FE: https://github.com/hcchuang/Revamping-Firm-Fixed-Effects-Models-with-Machine-Learning/blob/main/README.md