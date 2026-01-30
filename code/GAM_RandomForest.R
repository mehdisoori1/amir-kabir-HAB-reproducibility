## GAM and Random Forest analysis for chlorophyll-a
## R version 4.3.x

library(mgcv)
library(randomForest)

set.seed(123)

## Load data (monthly observations)
## Expected columns:
## Chl_a, Tair, Prain, Wwind, NO3, TP, Secchi
dat <- read.csv("data/monthly_water_quality.csv")

## ---------- Generalized Additive Model (GAM) ----------
gam_chl <- gam(
  log10(Chl_a) ~
    s(Tair,  k = 5, bs = "cr") +
    s(Prain, k = 5, bs = "cr") +
    s(Wwind, k = 5, bs = "cr") +
    NO3,
  data   = dat,
  family = gaussian(),
  method = "REML"
)

summary(gam_chl)
gam.check(gam_chl)

## ---------- Random Forest ----------
rf_chl <- randomForest(
  x = dat[, c("Tair", "Prain", "Wwind", "NO3", "TP", "Secchi")],
  y = dat$Chl_a,
  ntree      = 500,
  mtry       = 2,
  nodesize   = 5,
  importance = TRUE
)

print(rf_chl)
importance(rf_chl, type = 1)
