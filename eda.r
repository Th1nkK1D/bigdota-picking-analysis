library(jsonlite)
library(dplyr)
library(tidyr)

rawdata <- fromJSON(txt="matches.json")

# Drop unused column
data <- rawdata[,c('match_id','radiant_win','radiant_team','dire_team')]

# Group winner, loser
data %>% mutate(winner = case_when(radiant_win ~ radiant_team, !radiant_win ~ dire_team), 
               loser = case_when(!radiant_win ~ radiant_team, radiant_win ~ dire_team)) -> data

# Split heroes string
data %>% separate(loser, c('l1', 'l2','l3','l4','l5'), ',') -> data
data %>% transform(winner = strsplit(winner, ",")) %>% unnest(winner) -> data 

data <- data[,c('match_id','l1', 'l2','l3','l4','l5','winner')]
