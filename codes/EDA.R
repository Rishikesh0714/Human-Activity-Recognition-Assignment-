
#Exploratory Data Analysis

summary(train$classe)

library(corrplot)
mat <- cor(train[-c(2, 3, 4, 5, 59)])
corrplot(
        mat,
        type = "lower",
        method = "color",
        tl.cex = 0.6,
        tl.col = rgb(0, 0, 0)
)

#Heatmap
heatmap(as.matrix(train[-c(2, 3, 4, 5, 59)]))
