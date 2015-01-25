batter_positions <- c("C1","C2","1B","2B","SS","3B","CI","MI","OF1","OF2","OF3","OF4","OF5","OF6","DH")
pitcher_positions <- c("P1","P2","P3","P4","P5","P6","P7","P8","P9","P10")

for (team in teams) {
      
      temp <- get(team)
            
      #separate hitters and pitchers
      hitters <- temp[batter_positions,]
      pitchers <- temp[pitcher_positions,]
      
      #merge in projections
      hitters <- merge(hitters, hitter_projections, by = "Name", all.x = TRUE)
      pitchers <- merge(pitchers, pitcher_projections, by = "Name", all.x = TRUE)
      
      #reassign rownames to merged projections
      rownames(hitters) <- hitters$roster_spot
      rownames(pitchers) <- pitchers$roster_spot
            
      #add columns for stats to team
      temp[c("playerid","roster_spot", "AB","R","HR","RBI","SB","AVG","IP","ERA","WHIP","SV","W","K")] <- NA
      
      #add hitter projections to team 
      for (position in batter_positions) {
            temp[position, c("playerid","AB","R","HR","RBI","SB","AVG")] <- 
                  hitters[position, c("playerid","AB","R","HR","RBI","SB","AVG")]
      }
      
      #add pitcher projections to team
      for (position in pitcher_positions) {
            temp[position, c("playerid","IP","ERA","WHIP","SV","W","K")] <- 
                  pitchers[position, c("playerid","IP","ERA","WHIP","SV","W","K")]
      }
      
      assign(team, temp)
      
      remove(hitters)
      remove(pitchers)
      remove(temp)
      
}


#reorder rows.
for (team in teams) {
      
      temp <- get(team)
      
      temp <- temp[positions,]
      
      assign(team,temp)
}