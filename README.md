# Prenatal Smoking and Neonatal Birth Weight

**A frequentist comparative and regression analysis of the Baystate Low Birth Weight Study (n = 189)**

---

## Overview

This project investigates whether maternal smoking during pregnancy is associated with lower infant birth weight. It follows a complete biostatistical workflow: exploratory analysis, assumption checking, parametric and non-parametric hypothesis tests, effect size estimation, and crude versus covariate-adjusted linear regression with model diagnostics.

## Research Question

Do babies born to mothers who smoked during pregnancy weigh less than babies born to non-smokers, and does the association persist after adjusting for maternal age, maternal weight and race?

## Dataset

- **Name:** `birthwt`
- **Source:** Baystate Medical Center, Springfield, Massachusetts (1986), distributed with the `MASS` package in R
- **Size:** 189 births, 10 variables, no missing values

| Variable | Description |
|---|---|
| `bwt` | Birth weight in grams (outcome) |
| `smoke` | Maternal smoking during pregnancy (exposure) |
| `age` | Maternal age in years |
| `lwt` | Maternal weight (lbs) at last menstrual period |
| `race` | White, Black, Other |
| `low`, `ptl`, `ht`, `ui`, `ftv` | Low-birth-weight indicator, previous premature labours, hypertension, uterine irritability, first-trimester physician visits |

## Methods

1. **Exploratory analysis:** group summaries, boxplots, histograms
2. **Assumption checking:** QQ plots and Shapiro-Wilk test
3. **Welch two-sample t-test:** comparison of mean birth weight without assuming equal variances
4. **Mann-Whitney (Wilcoxon rank-sum) test:** non-parametric robustness check
5. **Effect size:** Cohen's d with pooled standard deviation
6. **Simple linear regression:** crude association, `bwt ~ smoke`
7. **Multiple linear regression:** adjusted for age, maternal weight and race
8. **Model diagnostics:** residual, QQ, scale-location and leverage plots

## Key Results

| Analysis | Result |
|---|---|
| Mean birth weight, non-smokers (n = 115) | 3055.7 g |
| Mean birth weight, smokers (n = 74) | 2771.9 g |
| Welch t-test | t = 2.73, df = 170.1, p = 0.007; difference 284 g (95% CI 79 to 489) |
| Mann-Whitney | W = 5249.5, p = 0.007 |
| Cohen's d | 0.40 (small-to-moderate) |
| Crude regression | Smoking coefficient -283.8 g (95% CI -494.8 to -72.8), R² = 0.036 |
| Adjusted regression | Smoking coefficient -401.7 g (95% CI -617.3 to -186.2, p < 0.001), adjusted R² = 0.125 |

## Conclusion

Maternal smoking was associated with roughly 284 g lower birth weight in the crude comparison, and about 402 g lower after adjusting for maternal age, weight and race. Parametric and non-parametric tests agreed. The adjusted estimate was larger than the crude one, which suggests that race acted as a confounder partly masking the smoking effect.

## Limitations

- Observational data from a single hospital, so the findings show association, not causation
- Smoking is recorded as yes/no, so dose-response cannot be assessed
- The adjusted model explains about 15% of the variation in birth weight
- Hypertension and previous premature labour were not included as covariates

## How to Run

1. Install R and RStudio
2. Install the plotting package once: `install.packages("ggplot2")`
3. Open `birthwt_smoking_analysis.R` and run it from top to bottom. The dataset loads automatically from the `MASS` package, so no download is needed.

## Skills Demonstrated

Hypothesis testing, assumption checking, Welch t-test, Mann-Whitney test, effect size estimation, confidence intervals, linear regression, confounding and adjustment, model diagnostics, R (`MASS`, `ggplot2`), statistical reporting

