# load caret
require(caret)

# load the training set
training <- read.csv("pml-training.csv", header=T, na=c("NA",""))

# explore data
dim(training)                       # to see how it looks like
training$X                          # X are just indexes, useless for machine learning, index 1
table(training$user_name)           # user names are useless for machine learning, index 2
plot(training$raw_timestamp_part_1) # useless for machine learning, index 3
plot(training$raw_timestamp_part_2) # useless for machine learning, index 4
plot(training$cvtd_timestamp)       # useless for machine learning, index 5
plot(training$new_window)           # useless for machine learning, index 6
plot(training$num_window)           # useless for machine learning, index 7
table(training$classe)              # to see how outcomes look like

training.filt <- training[,8:ncol(training)]

isna <- is.na(training.filt)
isna.col <- apply(isna, 2, sum)==0
training.pure <- training.filt[,isna.col]

# partition the training set to training and in-training validation
set.seed(666)                       # set seed
train.logical <-createDataPartition(training.pure$classe,p=0.5,list=FALSE)
real.training <- training.pure[train.logical,]
first.testing <- training.pure[-train.logical,]

# train Random Forest
set.seed(667)                       # set seed
rfmod <- train(classe~., data=real.training,
               method="rf", trControl=trainControl(method="cv"))

# checking results
rfmod
rfmod$finalModel

# ploting results
plot(rfmod$finalModel)

# ploting confusion matrix
first.pred <- predict(rfmod, first.testing)
cm<-confusionMatrix(first.pred, first.testing$classe)
image(1:5, 1:5, cm$table, col=rainbow(100)[70:1], zlim=c(0,3000),
      axes=F, xlab="predicted class", ylab="real class")
axis(1, labels=c("A","B","C","D","E"), at=1:5)
axis(2, labels=c("A","B","C","D","E"), at=1:5)
xpos <- rep(1:5, times=5)
ypos <- rep(1:5, each=5)
text(xpos, ypos, labels=as.vector(cm$table))

# application to the test set
testing <- read.csv("pml-testing.csv", header=T)

