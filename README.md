# PML_homework
## Practical machine learning - homework

All analyses were done in R 3.2.2 under Ubuntu Linux. The first step was loading of caret. Next, the training set was loaded. Then I explored data to check meaning of columns. It turned out that columns 1:7 are useless for machine learning, so they were removed. Data contain a lot of missing values, columns with missing values were removed. The training set was paritioned to "real" training set and in-training validation set (50+50 %). It was trained by Random Forest with a cross-validation. The result was:

```{R}
rfmod
#
rf_model$finalModel
#
```

Then I prepared Figure 1:

```{R}
plot(rf_model$finalModel)
```

The outcomes for the in-training validation set were predicted and the confusion matrix was calculated and ploted:

```{R}
first.pred <- predict(rfmod, first.testing)
cm<-confusionMatrix(first.pred, first.testing$classe)
image(1:5, 1:5, cm$table, col=rainbow(100)[70:1], zlim=c(0,3000),
    axes=F, xlab="predicted class", ylab="real class")
axis(1, labels=c("A","B","C","D","E"), at=1:5)
axis(2, labels=c("A","B","C","D","E"), at=1:5)
xpos <- rep(1:5, times=5)
ypos <- rep(1:5, each=5)
text(xpos, ypos, labels=as.vector(cm$table))
```

Next, results were predicted for the test dataset:

```{R}
testing <- read.csv("pml-testing.csv", header=T)
```
