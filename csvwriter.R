
#WRITE HITTERS TO CSV

#drop any players worth less than $5
hitter_projections <- filter(hitter_projections, dollar_value >= -5)

#output to a csv
write.csv(hitter_projections, file = "hitter_projections.csv")

#WRITE PITCHERS TO CSV

#drop players worth less than -$5
pitcher_projections <- filter(pitcher_projections,dollar_value >= -5)

#write out to a csv
write.csv(pitcher_projections, file = "pitcher_projections.csv")

#WRITE PLAYER PROJECTIONS TO CSV
detach("package:dplyr",unload = TRUE)

library("plyr")

#Merge hitter and pitcher projections
player_projections <- rbind.fill(hitter_projections, pitcher_projections)
player_projections <- player_projections[order(-player_projections$dollar_value),]

detach("package:plyr",unload = TRUE)

#write player projections to csv
write.csv(player_projections, file = "player_projections.csv")


#write player projections to csv
write.csv(player_projections, file = "player_projections.csv")
