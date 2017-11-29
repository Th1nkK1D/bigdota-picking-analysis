library(jsonlite)
library(dplyr)
library(tidyr)

rawdata <- fromJSON(txt="matches.json")

# Drop unused column
data <- rawdata[,c('match_id','radiant_win','radiant_team','dire_team')]

# Group winner, loser
data <- mutate(data,
               winner = case_when(radiant_win ~ radiant_team, !radiant_win ~ dire_team), 
               loser = case_when(!radiant_win ~ radiant_team, radiant_win ~ dire_team))

# Split heroes in to each column
data <- separate(data, winner, c('w1', 'w2','w3','w4','w5'), ',')
data <- separate(data, loser, c('l1', 'l2','l3','l4','l5'), ',')

data <- data[,c('match_id','w1', 'w2','w3','w4','w5','l1', 'l2','l3','l4','l5')]
