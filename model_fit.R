library(MASS)
library(pROC)
library(caret)
library(dplyr)
library(adabag)

setwd("~/BIOS611project")
data <- read.csv("data/clean_data.csv")
data <- as.data.frame(unclass(data), stringsAsFactors = TRUE)


#First split the data into training and testing sets.
set.seed(359)
train_test_data <- data %>% mutate(train=runif(nrow(.)) < 0.75)
train <- train_test_data %>% dplyr::filter(train) %>% dplyr::select(-train)
test <- train_test_data %>% dplyr::filter(!train) %>% dplyr::select(-train)




cat(sprintf("Linear Discrimnant Analysis, Logistic Regression, and Adaboost will be used to model the dataset. \n"), 
    file="data_analysis.txt", append = FALSE);


#Linear Discriminant analysis
lda_results <- lda(cardio~.,data=train)
lda_results


lda_pred_train <- predict(lda_results, train)
lda_pred_test <- predict(lda_results, test)

png('./figures/lda.png')
ldahist(data = lda_pred_train$x, g = train$cardio)
dev.off()


roc_LDA<-roc(test$cardio, lda_pred_test$posterior[,2]) 
auc_LDA=auc(roc_LDA)



cat(sprintf("Using Linear Discriminant Analysis, the auc is %s for the testing set. \n", 
            auc_LDA), 
    file="data_analysis.txt", append = TRUE);


#fit a logistic model with the age variables
logistic_model <- glm(cardio ~ . , family =binomial, data = train);
summary(logistic_model)
anova(logistic_model, test="Chisq")

logistic_pred_test <- predict(logistic_model, newdata = test, type = "response")

roc_logistic <- roc(test$cardio,  logistic_pred_test)
auc_logistic=auc(roc_logistic)


logistic_model_step<-step(logistic_model)
logistic_pred_test1 <- predict(logistic_model_step, newdata = test, type = "response")
roc_logistic1 <- roc(test$cardio,  logistic_pred_test1)
auc_logistic1 <- auc(roc_logistic1)


cat(sprintf("Using logistic regression, the auc is %s for the testing set. After a stepwise variable selection, the auc is %s with ten variables: systolic blood pressure, diastolic blood pressure, smoking, alcohol intake, height, glucose, physical activity, weight, cholesterol, age. \n", 
            auc_logistic, auc_logistic1), 
    file="data_analysis.txt", append = TRUE);


#adaboost
train$cardio <- as.factor(train$cardio)
test$cardio <- as.factor(test$cardio)

model <- boosting(cardio ~ ., data=train, boos=TRUE, mfinal=50)

adaboost_pred <- predict(model, test)
adaboost_pred$confusion
adaboost_pred$error


roc_adaboost <- roc(test$cardio, adaboost_pred$prob[,2])
auc_adaboost <- auc(roc_adaboost)

cat(sprintf("Using adaboost, the auc is %s for the testing set. \n ", 
            auc_logistic), 
    file="data_analysis.txt", append = TRUE);


#plot the ROC curve for LDA, logistic regression
png('./figures/roc.png')
par(mfrow=c(2,2))
plot(roc_LDA, xlab="False Positive Percentage", ylab="True Positive Percentage", main="LDA ROC")
plot(roc_logistic, xlab="False Positive Percentage", ylab="True Positive Percentage", main="Logistic ROC")
plot(roc_adaboost, xlab="False Positive Percentage", ylab="True Positive Percentage", main="Adaboost ROC")
dev.off()
