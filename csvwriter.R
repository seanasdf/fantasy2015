hitter_projections$status <- ""
pitcher_projections$status <- ""

#Mark drafted hitters as drafted.
for (player in hitter_projections$Name) {
      if (player %in% draftpicks$player) {
            hitter_projections[which(hitter_projections$Name == player),"status"] <- "drafted"
      }
}

#Mark drafted pitchers as drafted.
for (player in pitcher_projections$Name) {
      if (player %in% draftpicks$player) {
            pitcher_projections[which(pitcher_projections$Name == player),"status"] <- "drafted"
      }
}


#WRITE PLAYER PROJECTIONS TO CSV
detach("package:dplyr",unload = TRUE)
library("plyr")

#Merge hitter and pitcher projections
player_projections <- rbind.fill(hitter_projections, pitcher_projections)
player_projections <- player_projections[order(-player_projections$dollar_value),]

detach("package:plyr",unload = TRUE)

#write player projections to csv
write.csv(player_projections, file = "player_projections.csv")


