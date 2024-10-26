## code to prepare `AIriskjobs` dataset goes here

library(readr)

AIriskjobs <- read_csv("data-raw/ai_job_market_insights.csv", show_col_types = FALSE)

usethis::use_data(AIriskjobs, overwrite = TRUE)

