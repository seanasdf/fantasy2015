standings <- data.frame()

#Calculate current standings
for (team in teams) {
      
      temp <- get(team)
      
      #get team's stats
      team_R <- sum(temp$R, na.rm=TRUE)
      team_HR <- sum(temp$HR, na.rm=TRUE)
      team_RBI <- sum(temp$RBI, na.rm=TRUE)
      team_SB <- sum(temp$SB, na.rm=TRUE)
      team_AVG <- sum(temp$AVG*temp$AB, na.rm=TRUE) / sum(temp$AB, na.rm =TRUE)
      
      team_ERA <- sum(temp$ERA * temp$IP, na.rm=TRUE) /sum(temp$IP, na.rm=TRUE) 
      team_WHIP <- sum(temp$WHIP * temp$IP, na.rm=TRUE) /sum(temp$IP, na.rm=TRUE) 
      team_K <- sum(temp$K, na.rm=TRUE)
      team_SV <- sum(temp$SV, na.rm=TRUE)
      team_W <- sum(temp$W, na.rm=TRUE)
      
      #merge team's stats in to standings
      standings <- data.frame(
                  team_name = c(standings$team_name, team),
                  R =  c(standings$R, team_R),
                  HR = c(standings$HR,team_HR),
                  RBI = c(standings$RBI,team_RBI),
                  SB = c(standings$SB, team_SB),
                  AVG = round(c(standings$AVG,team_AVG),3),
                  ERA = round(c(standings$ERA, team_ERA),2),
                  WHIP = round(c(standings$WHIP, team_WHIP),2),
                  K = c(standings$K, team_K),
                  SV = c(standings$SV, team_SV),
                  W = c(standings$W, team_W),
                  stringsAsFactors = FALSE
            )
}

#calculate points
standings$R_points <- rank(standings$R)
standings$HR_points <- rank(standings$HR)
standings$RBI_points <- rank(standings$RBI)
standings$SB_points <- rank(standings$SB)
standings$AVG_points <- rank(standings$AVG)

standings$ERA_points <- 19-rank(standings$ERA)
standings$WHIP_points <- 19-rank(standings$ERA)
standings$K_points <- rank(standings$K)
standings$SV_points <- rank(standings$SV)
standings$W_points <- rank(standings$W)


standings$total_points <-     standings$ERA_points +
                              standings$WHIP_points + 
                              standings$K_points +
                              standings$SV_points +
                              standings$W_points +
                              standings$R_points +
                              standings$HR_points +
                              standings$RBI_points +      
                              standings$SB_points +
                              standings$AVG_points 
#Rownames
rownames(standings) <- standings$team_name

#Sort by total points
standings <- standings[order(-standings$total_points),]
