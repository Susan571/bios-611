library(readr)
library(tidyverse) 
library(ggplot2)   
data <- read.csv("/Users/susanefforta/BIOS611project/data/embeddings_output_clean.csv")
pca_result <- prcomp(data, scale. = TRUE)
explained_variance <- pca_result$sdev^2
explained_variance_ratio <- explained_variance / sum(explained_variance)
df_variance <- data.frame(PC = 1:length(explained_variance_ratio), Variance = explained_variance_ratio)
ggplot(df_variance, aes(x = PC, y = Variance)) +
  geom_line() +
  geom_point() +
  labs(title = "Scree Plot of Principal Components", x = "Principal Component", y = "Proportion of Variance Explained") +
  theme_minimal()