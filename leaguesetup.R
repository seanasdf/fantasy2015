################################################################
#################LEAGUE STUFF LIVES HERE########################
################################################################
library("dplyr")

#list of teams
teams <- c("marmaduke",
           "pk dodgers",
           "ottawa",
           "isotopes",
           "jobu",
           "d&s",
           "virginia",
           "deano",
           "dembums",
           "bellevegas",
           "baycity",
           "balco",
           "sturgeon",
           "rippe",
           "pasadena",
           "deener",
           "counsel",
           "bears")

positions <- c("C1","C2","1B","2B","SS","3B","CI","MI","OF1","OF2","OF3","OF4","OF5","OF6","DH",
               "P1","P2","P3","P4","P5","P6","P7","P8","P9","P10",
               "B1","B2","B3","B4","B5","B6","B7","B8","B9","B10")


#create data frame for each team.
for (team in teams) {
      
      assign(team,
             data.frame(roster_spot = positions,
                        salary = 0,
                        Name = "",
                        row.names = positions,
                        stringsAsFactors = FALSE
             ),
             env = .GlobalEnv
      )
}


## Create draft function to add a player to the team in the draft.
draft <- function(team, player, salary, pos) {
            
      #create vector of repetitive positions
      specialcases <- c("OF1","OF2","OF3","OF4","OF5","OF6",
                        "P1","P2","P3","P4","P5","P6","P7","P8","P9","P10",
                        "B1","B2","B3","B4","B5","B6","B7","B8","B9","B10")
      
      #Create temporary vector for team name
      temp <- get(team)
      
      #assign values to relevant positions
      if (!(pos == "OF" | pos == "P" | pos == "B" | pos =="C")) {
            temp[pos,"salary"] <- salary
            temp[pos,"Name"] <- player
      }
      
      #Handle pitchers, outfielders, bench players
      else {
            if (pos == "OF") {
                  for (i in 1:6) {
                        outfield_number <- paste(pos, i, sep = "")
                        if (temp[outfield_number,"Name"] == "") {
                              temp[outfield_number,"salary"] <- salary
                              temp[outfield_number,"Name"] <- player
                              break
                        }
                  }
            }
            
            else if (pos == "P") {
                  for (i in 1:10) {
                        pitcher_number <- paste(pos, i, sep = "")
                        if (temp[pitcher_number,"Name"] == "") {
                              temp[pitcher_number,"salary"] <- salary
                              temp[pitcher_number,"Name"] <- player
                              break
                        }
                  }
            }
            
            else if (pos == "B") {
                  for (i in 1:10) {
                        bench_number <- paste(pos, i, sep = "")
                        if (temp[bench_number,"Name"] == "") {
                              temp[bench_number,"salary"] <- salary
                              temp[bench_number,"Name"] <- player
                              break
                        }
                  }
            }
            
            else if (pos == "C") {
                  for (i in 1:2) {
                        catcher_number <- paste(pos, i, sep = "")
                        if (temp[catcher_number,"Name"] == "") {
                              temp[catcher_number,"salary"] <- salary
                              temp[catcher_number,"Name"] <- player
                              break
                        }
                  }
            }
      } 
      
      #temp <- temp[positions,]
      assign(team, temp, env = .GlobalEnv)      
}
