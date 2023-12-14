library(readxl)
library(tidyverse)
library(dplyr)

setwd("~/BIOS611project")
data <- read.csv("data/cardio_train.csv",header = TRUE, sep = ";")

#take a look at the data set in general
colnames(data)
head(data)
cat(sprintf("The dataset contains the following %d variables: %s. \n", 
            ncol(data), paste(colnames(data), collapse = ", ")), 
    file="data_explore.txt", append = FALSE);


#take a closer look at each of the variables
summary(data$id)

#First look at the discrete (categorical) variables
cat(sprintf("Let us first take a look at the discrete (categorical) covariates. "), 
    file="data_explore.txt", append = TRUE);

table(data$gender)
data<-subset(data, gender!="Other") # only one non-binary gender, not large enough sample size.
cat(sprintf("There are %d females, %d males in the dataset. ", 
            table(data$gender)[1],table(data$gender)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$smoke)
cat(sprintf("For the smoking status, %d never smoked, %d smokes in the dataset. ", 
            table(data$smoke)[1],table(data$smoke)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$alco)
cat(sprintf("There are %d never drunk alcohol, %d drinks alcohol in the dataset. ", 
            table(data$alco)[1],table(data$alco)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$active)
cat(sprintf("There are %d without physical activities, %d with physical activities in the dataset. ", 
            table(data$active)[1],table(data$active)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$cardio)
cat(sprintf("There are %d does not have presence of cardiovascular disease, %d has the presence of cardiovascular disease in the dataset. ", 
            table(data$cardio)[1],table(data$cardio)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$cholesterol)
cat(sprintf("For the Cholesterol status, %d is normal level, %d above normal level, %d well above normal. ", 
            table(data$cholesterol)[1],table(data$cholesterol)[2],table(data$cholesterol)[3]), 
    file="data_explore.txt", append = TRUE);

table(data$gluc)
cat(sprintf("For the Glucose status, %d is normal level, %d above normal level, %d well above normal. ", 
            table(data$gluc)[1],table(data$gluc)[2],table(data$gluc)[3]), 
    file="data_explore.txt", append = TRUE);

#Then look at the continuous variables
cat(sprintf("\nLet us then take a look at the continuous covariates. "), 
    file="data_explore.txt", append = TRUE);

summary(data$age)
sum_age=summary(data$age)
cat(sprintf("For the age arrange, the minimum is %s and the maximum is %s. The median is %s, which is clearly more than the mean %s, indicating that the distribution is left skewed. ", 
            sum_age[1],sum_age[6],
            sum_age[3],round(sum_age[4], digits=2)), 
    file="data_explore.txt", append = TRUE);

summary(data$height)
sum_height=summary(data$height)
cat(sprintf("For the height arrange, the minimum is %s and the maximum is %s. The median is %s, which is clearly more than the mean %s, indicating that the distribution is left skewed. ", 
            sum_height[1],sum_height[6],
            sum_height[3],round(sum_height[4], digits=2)), 
    file="data_explore.txt", append = TRUE);

summary(data$weight)
sum_weight=summary(data$weight)
cat(sprintf("For the weight arrange, the minimum is %s and the maximum is %s. The median is %s, which is clearly less than the mean %s, indicating that the distribution is right skewed. ", 
            sum_weight[1],sum_weight[6],
            sum_weight[3],round(sum_weight[4], digits=2)), 
    file="data_explore.txt", append = TRUE);

summary(data$ap_hi)
sum_hi=summary(data$ap_hi)
cat(sprintf("For the weight arrange, the minimum is %s and the maximum is %s. The median is %s, which is clearly less than the mean %s, indicating that the distribution is right skewed. ", 
            sum_hi[1],sum_hi[6],
            sum_hi[3],round(sum_hi[4], digits=2)), 
    file="data_explore.txt", append = TRUE);

summary(data$ap_lo)
sum_lo=summary(data$ap_lo)
cat(sprintf("For the weight arrange, the minimum is %s and the maximum is %s. The median is %s, which is clearly less than the mean %s, indicating that the distribution is right skewed. ", 
            sum_lo[1],sum_lo[6],
            sum_lo[3],round(sum_lo[4], digits=2)), 
    file="data_explore.txt", append = TRUE);

#id will not help our analysis, so might as well remove this column
data <- data %>% dplyr::select(-id)

write_csv(data, "data/clean_data.csv")

