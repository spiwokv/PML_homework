# PML_homework
## Practical machine learning - homework

All analyses were done in R 3.2.2 under Ubuntu Linux. The first step was loading of caret. Next, the training set was loaded. Then I explored data to check meaning of columns. It turned out that columns 1:7 are useless for machine learning, so they were removed. Data contain a lot of missing values, columns with missing values were removed. The training set was paritioned to "real" training set and in-training validation set (50+50 %). It was trained by Random Forest with a cross-validation. The result was:

```{R}
> rfmod
Random Forest 

9812 samples
  52 predictors
   5 classes: 'A', 'B', 'C', 'D', 'E' 

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 8831, 8831, 8833, 8830, 8831, 8831, ... 
Resampling results across tuning parameters:

  mtry  Accuracy   Kappa      Accuracy SD  Kappa SD   
   2    0.9876685  0.9843997  0.003733782  0.004722544
  27    0.9893004  0.9864663  0.004136378  0.005229355
  52    0.9797192  0.9743445  0.006765749  0.008556532

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was mtry = 27. 
> rfmod$finalModel

Call:
 randomForest(x = x, y = y, mtry = param$mtry) 
               Type of random forest: classification
                     Number of trees: 500
No. of variables tried at each split: 27

        OOB estimate of  error rate: 1.05%
Confusion matrix:
     A    B    C    D    E class.error
A 2778    9    2    0    1 0.004301075
B   16 1875    8    0    0 0.012638231
C    0   17 1682   12    0 0.016949153
D    0    1   23 1581    3 0.016791045
E    0    1    4    6 1793 0.006097561
```

Error rate obtained by cross vlaidation was 1.05 % (OOB estimate of error rate).

Then Figure 1 was prepared to illustrate the progress of Random Forest algorithm:

![Figure 1](https://cloud.githubusercontent.com/assets/8507616/10480659/bb6f5a10-726b-11e5-82dc-956b899b2da5.png)

The outcomes for the in-training validation set were predicted and the confusion matrix was calculated and ploted as Figure 2:

![Figure 2](https://cloud.githubusercontent.com/assets/8507616/10480661/bfbbf4e8-726b-11e5-90ed-2a64fb0b94e8.png)

Finally, the test dataset was loaded, unused columns and columns with missing data were removed and prediction was made:

```{R}
> second.pred <- predict(rfmod, testing.pure)
> second.pred
 [1] B A B A A E D B A A B C B A E E A B B B
Levels: A B C D E
```
