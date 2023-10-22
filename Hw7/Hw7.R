library(readr)
library(matlab) 
library(tidyverse)
ufo_data <- read_csv("/Users/susanefforta/Downloads/ufo_data.csv")
embedding<-read_csv("/Users/susanefforta/Downloads/embeddings_output_clean.csv",col_names = F) %>%
  select(-last_col())

imagesc(embedding %>% as.matrix())
