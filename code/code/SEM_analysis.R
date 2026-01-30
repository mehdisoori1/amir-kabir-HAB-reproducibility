## Structural Equation Modeling (SEM)
## R version 4.3.x

library(lavaan)

## Load monthly dataset
## Expected columns:
## Chl_a, Secchi, Tair, Prain, Wwind, TP, NO3
dat <- read.csv("data/monthly_water_quality.csv")

## ---------- SEM specification ----------
sem_model <- '
  ## Latent variables
  Meteorology =~ Tair + Prain + Wwind
  Nutrients   =~ TP + NO3

  ## Structural paths
  Nutrients ~ Meteorology
  Chl_a     ~ Nutrients
  Secchi   ~ Chl_a
'

## ---------- Fit SEM ----------
fit_sem <- sem(
  sem_model,
  data = dat,
  std.lv = TRUE
)

summary(fit_sem, fit.measures = TRUE, standardized = TRUE)
