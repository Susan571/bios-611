library(ggplot2)
library(ggpubr)
library(MASS)
library(PerformanceAnalytics)

setwd("~/BIOS611project")
data <- read.csv("data/clean_data.csv")


#visualizing the categorical and continuous variables
png('./figures/variable_distributions.png')
#categorical
gender_distribution <- data %>%
  ggplot(aes(x = gender, fill = as.factor(cardio))) +geom_bar()
smoke_distribution <- data %>%
  ggplot(aes(x = smoke, fill = as.factor(cardio))) +geom_bar()
alco_distribution <- data %>%
  ggplot(aes(x = alco, fill = as.factor(cardio))) +geom_bar()
active_distribution <- data %>%
  ggplot(aes(x = active, fill = as.factor(cardio))) +geom_bar()
cholesterol_distribution <- data %>%
  ggplot(aes(x = cholesterol, fill = as.factor(cardio))) +geom_bar()
gluc_distribution <- data %>%
  ggplot(aes(x = gluc, fill = as.factor(cardio))) +geom_bar()

#continuous
age_distribution <- data %>%
  ggplot(aes(x = age, fill = as.factor(cardio))) + geom_histogram(bins=30) +
  theme(legend.position="none")
height_distribution <- data %>%
  ggplot(aes(x = height, fill = as.factor(cardio))) + geom_histogram(bins=30) +
  theme(legend.position="none")
weight_distribution <- data %>%
  ggplot(aes(x = weight, fill = as.factor(cardio))) + geom_histogram(bins=30) +
  theme(legend.position="none")
hi_distribution <- data %>%
  ggplot(aes(x = ap_hi, fill = as.factor(cardio))) + geom_histogram(bins=30) +
  theme(legend.position="none")
lo_distribution <- data %>%
  ggplot(aes(x = ap_lo, fill = as.factor(cardio))) + geom_histogram(bins=30) +
  theme(legend.position="none")

#put into the same frame
figure <- ggarrange(gender_distribution, smoke_distribution, alco_distribution,
                    active_distribution, cholesterol_distribution, gluc_distribution, 
                    age_distribution, height_distribution, weight_distribution,
                    hi_distribution, lo_distribution,
                    ncol = 3, nrow = 4)
figure
dev.off()

#plot the a correlation chart
png('./figures/cardio_variables.png')
#transform the data into numerics to compute a correlation chart
correlation_data <- as.data.frame(unclass(data), stringsAsFactors = TRUE)
correlation_data[sapply(correlation_data, is.factor)] <-
  data.matrix(correlation_data[sapply(correlation_data, is.factor)])
#compute the correlation chart
chart.Correlation(correlation_data)
dev.off()

#a primary PCA analysis
prin_comp <- prcomp(correlation_data, scale. = T)

png('./figures/pca.png')
biplot(prin_comp, scale = 0)
dev.off()
