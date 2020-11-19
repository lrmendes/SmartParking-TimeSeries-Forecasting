library(prophet)
library(tidyverse)

df <- read.csv('dataset_grouped_by_hour.csv')

df <- df %>% 
  rename(
    ds = timeFrom,
    y = TotalParkings
  )

# Keep only important columns
keep = c('ds','y')
df <- df[keep]

# Drop Zero Parking Hours
df <- filter(df, y > 0)

# Start Prophet Object
m <- prophet(df)

# Predict Period
future <- make_future_dataframe(m, periods = 365)
future

# Forecast
forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

# Plot
plot(m, forecast)

