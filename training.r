library(ranger)

fit <- ranger(winner ~ l1 + l2 + l3 + l4 + l5, data = train, importance = "impurity", num.trees = 300, verbose = TRUE)

result <- predict(fit,test)

test$result <- result$predictions