## Prophet time-series analysis
## R version 4.3.x

library(prophet)

## Load data
## Expected columns:
## date (YYYY-MM-DD), Chl_a
dat <- read.csv("data/monthly_chlorophyll_timeseries.csv")
dat$date <- as.Date(dat$date)

## Prophet requires specific column names
df_prophet <- data.frame(
  ds = dat$date,
  y  = dat$Chl_a
)

## ---------- Fit Prophet model ----------
m <- prophet(
  df_prophet,
  yearly.seasonality = TRUE,
  weekly.seasonality = FALSE,
  daily.seasonality  = FALSE
)

## ---------- Forecast ----------
future <- make_future_dataframe(
  m,
  periods = 12,
  freq = "month"
)

forecast <- predict(m, future)

## ---------- Plot results ----------
plot(m, forecast)
prophet_plot_components(m, forecast)
