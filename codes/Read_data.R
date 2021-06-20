# Reading files
pml_training <-
        read.csv(
                "D:/Science/R_proggrame_coursera/Practical_Machine_Learning/Assignment ML/Data/pml-training.csv"
                ,
                na.strings = c(" ", "", "NA")
        )

pml_testing <-
        read.csv(
                "D:/Science/R_proggrame_coursera/Practical_Machine_Learning/Assignment ML/Data/pml-testing.csv"
                ,
                na.strings = c(" ", "", "NA")
        )

#Cleaning Data
library(lubridate)

pml_training$cvtd_timestamp <-
        as_datetime(pml_training$cvtd_timestamp)
pml_testing$cvtd_timestamp <-
        as_datetime(pml_testing$cvtd_timestamp)
pml_training$classe <- as.factor(pml_training$classe)

pml_training[is.na(pml_training)] <- 0
pml_testing[is.na(pml_testing)] <- 0



#
library(caret)
set.seed(4321)

NZV <- nearZeroVar(pml_training)
inTrain <-
        createDataPartition(pml_training$classe, p = 0.75, list = FALSE)
train <- pml_training[inTrain, -NZV]
valid <- pml_training[-inTrain, -NZV]
