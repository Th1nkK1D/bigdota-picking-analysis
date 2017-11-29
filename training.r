library(ranger)
library(stringr)

fit <- ranger(winner ~ l1 + l2 + l3 + l4 + l5, data = train, importance = "impurity", num.trees = 300, verbose = TRUE)

result <- predict(fit,test)

test$prediction <- result$predictions

test %>% transform(result = (prediction == w1 | prediction == w2 | prediction == w3 | prediction == w4 | prediction == w5)) -> test

cat('Accuracy',as.numeric(count(filter(test,result))),'/',as.numeric(count(test)),'=',as.numeric(count(filter(test,result)))*100/as.numeric(count(test)),'%')
filter(test,result)

summary(filter(test,result)$prediction)
