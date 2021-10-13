# Title :  Reddit Pulling
# Author: Ellie Yang

library(RedditExtractoR)
library(dplyr)
library(hash)

dict = hash()
search_list = list("opioid", "heroin")

for (item in search_list){
  dict[[item]] = get_reddit(search_terms = item)}

opioid = dict[["opioid"]]
heroin = dict[["heroin"]]

df3 <- rbind(opioid, heroin)

write.csv(df, "RedditData.csv")