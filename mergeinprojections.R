
#merge in hitter projections
for (team in teams) {
      temp <- merge(get(team), hitter_projections, by = "Name", all.x = TRUE)
      assign(team, temp)
      remove(temp)
}



#Merge in pitcher projections
for (team in teams) {
      temp <- merge(get(team), pitcher_projections, by = "Name", all.x = TRUE)
      
      assign(team, temp)
      remove(temp)
}

#delete duplicate columns and rename everything
for (team in teams) {
      temp <- get(team)
      
      #replace duplicates for hitters
      temp$position <- temp$position.x
      temp$playerid <- temp$playerid.x
      temp$adjusted_points <- temp$adjusted_points.x
      temp$dollar_value <- temp$dollar_value.x
      
      
      #replace duplicates for pitchers
      temp[which(temp$position.y=="pitcher"),"position"] <- temp[which(temp$position.y=="pitcher"),"position.y"]
      temp[which(temp$position.y=="pitcher"),"playerid"] <- temp[which(temp$position.y=="pitcher"),"playerid.y"]
      temp[which(temp$position.y=="pitcher"),"adjusted_points"] <- temp[which(temp$position.y=="pitcher"),"adjusted_points.y"]
      temp[which(temp$position.y=="pitcher"),"dollar_value"] <- temp[which(temp$position.y=="pitcher"),"dollar_value.y"]
      
      #delete duplicate columns
      temp$position.x <- NULL
      temp$playerid.x <- NULL
      temp$adjusted_points.x <- NULL
      temp$dollar_value.x <- NULL
      temp$position.y <- NULL
      temp$playerid.y <- NULL
      temp$adjusted_points.y <- NULL
      temp$dollar_value.y <- NULL

      assign(team, temp)
      
      remove(temp)
}


#reorder rows.
for (team in teams) {
      
      temp <- get(team)
      
      temp <- temp[match(positions,temp$roster_spot),c(1:15,18:19)]
      
      assign(team,temp)
}