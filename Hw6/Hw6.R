library(readr)
library(ggplot2)
library(dplyr)
library(tidyverse)
data <- read.csv("/Users/susanefforta/BIOS611project/data/cardio_train.csv", sep = ";")
gender_cardio_table <- data %>%
  group_by(cardio, gender) %>%
  summarise(count = n()) %>%
  arrange(cardio, desc(count))

data$Gender <- factor(data$gender, levels = c(1, 2), labels = c("Male", "Female")) 
data$Cardio <- factor(data$cardio, levels = c(0, 1), labels = c("No", "Yes")) 

plot1 <- function() {ggplot(data, aes(x = Cardio, fill = Gender)) + 
  geom_bar(position = "stack", stat = "count") +
  labs(title = "Gender Distribution within Each Cardio Category",
       x = "Cardiovascular Disease (Cardio)",
       y = "Count",
       fill = "Gender") +
  theme_minimal()
}

plot2 <- function() {ggplot(data, aes(x = Cardio)) + 
  geom_bar(position = "stack", stat = "count") +
  labs(title = "Distribution of Cardiovascular Disease",
       x = "Cardiovascular Disease",
       y = "Count") +
  theme_minimal()
}
plot1()
plot2()
