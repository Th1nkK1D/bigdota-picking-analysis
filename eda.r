library(jsonlite)
library(dplyr)
library(tidyr)
library(caTools)

rawdata <- fromJSON(txt="matches.json")

# Drop unused column
data <- rawdata[,c('match_id','radiant_win','radiant_team','dire_team')]

# Group winner, loser
data %>% mutate(winner = case_when(radiant_win ~ radiant_team, !radiant_win ~ dire_team), 
               loser = case_when(!radiant_win ~ radiant_team, radiant_win ~ dire_team)) -> data

# Split heroes string
data %>% separate(loser, c('l1', 'l2','l3','l4','l5'), ',') -> data

#Split sample
sample <- sample.split(data$match_id, SplitRatio = 0.7)
train <- subset(data, sample == TRUE)
test <- subset(data, sample == FALSE)

# Unnest winner
train %>% transform(winner = strsplit(winner, ",")) %>% unnest(winner) -> train 

# Drop unused data
train <- train[,c('match_id','l1', 'l2','l3','l4','l5','winner')]
test <- test[,c('match_id','l1', 'l2','l3','l4','l5','winner')]

