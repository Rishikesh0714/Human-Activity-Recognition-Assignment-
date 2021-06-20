# Model selection

# Decisison tree
set.seed(534)
library(rpart)
library(rattle)
modDT <- rpart(classe ~ ., data  = train[-1], method = 'class')
fancyRpartPlot(modDT)
dev.copy(
        png,
        "D:/Science/R_proggrame_coursera/Practical_Machine_Learning/Assignment ML/Outputs/Decision_Tree.png"
)

predDT <- predict(modDT, valid, type = "class")
conmat1 <- confusionMatrix(predDT, valid$classe)
acc1 <- conmat1$overall["Accuracy"]

#Random Forest
library(randomForest)
modRF <- randomForest(classe ~ . , data = train)
predRF <- predict(modRF, valid, type = "class")
conmat2 <- confusionMatrix(predRF, valid$classe)
acc2 <- conmat2$overall["Accuracy"]
acc2

#GBM
library(gbm)
set.seed(332)
modGbm <- gbm(classe ~ ., data = train[-c(1, 2, 3, 4, 5)])
predGBM <- predict.gbm(modGbm, valid, type = "response")
labels = colnames(predGBM)[apply(predGBM, 1, which.max)]
conmat3 <- confusionMatrix(as.factor(labels), valid$classe)
acc3 <-  conmat3$overall['Accuracy']
acc3

# accuracy
acc <- c(acc1, acc2, acc3)
model <- c("DT", "RF", "GBM")

data.frame(model, acc)

# prediction
prediction <- predict(modRF, pml_testing, type = "class")
write.table(prediction,
            file = "D:/Science/R_proggrame_coursera/Practical_Machine_Learning/Assignment ML/Outputs/Prediction.csv",
            sep = ",",
            qmethod = "double")
