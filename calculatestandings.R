standings <- data.frame()

#Calculate current standings
for (team in teams) {
      
      temp <- get(team)
      
      #get team's stats
      team_ERA <- sum(temp$ERA * temp$IP, na.rm=TRUE) /sum(temp$IP, na.rm=TRUE) 
      team_WHIP <- sum(temp$WHIP * temp$IP, na.rm=TRUE) /sum(temp$IP, na.rm=TRUE) 
      team_K <- sum(temp$K, na.rm=TRUE)
      team_SV <- sum(temp$SV, na.rm=TRUE)
      team_W <- sum(temp$W, na.rm=TRUE)
      
      #merge team's stats in to standings
      standings <- data.frame(
                  team_name = c(standings$team_name, team),
                  ERA = round(c(standings$ERA, team_ERA),2),
                  WHIP = round(c(standings$WHIP, team_WHIP),2),
                  K = c(standings$K, team_K),
                  SV = c(standings$SV, team_SV),
                  W = c(standings$W, team_W),
                  stringsAsFactors = FALSE
            )
}

#calculate points
standings$ERA_points <- 19-rank(standings$ERA)
standings$WHIP_points <- 19-rank(standings$ERA)
standings$K_points <- rank(standings$K)
standings$SV_points <- rank(standings$SV)
standings$W_points <- rank(standings$W)
standings$total_points <-     standings$ERA_points +
                              standings$WHIP_points + 
                              standings$K_points +
                              standings$SV_points +
                              standings$W_points

#Sort by total points
standings <- standings[order(-standings$total_points),]
