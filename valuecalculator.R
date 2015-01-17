
#set up file
setwd("C:\\Users\\Sean\\Documents\\Fantasy\\Fantasy Baseball 2015")
library(dplyr)
library(plyr)


################################################################
################HITTER STUFF LIVES HERE#########################
################################################################


#Create string of hitter positions.
hitter_positions <- c("catcher",
                      "first_base",
                      "second_base",
                      "shortstop",
                      "third_base",
                      "outfield",
                      "dh"
                  )

#Import and clean data on replacement levels
      
      #read in league wide csv
      replacement_hitters <- read.csv("replacement_hitters.csv")
      
      #convert factor variable to a string
      replacement_hitters[,1] <- toString(replacement_hitters[,1])
      
      #rename position values
      replacement_hitters[1,1] <- "catcher" 
      replacement_hitters[2,1] <- "first_base" 
      replacement_hitters[3,1] <- "second_base" 
      replacement_hitters[4,1] <- "shortstop" 
      replacement_hitters[5,1] <- "third_base" 
      replacement_hitters[6,1] <- "middle_infield" 
      replacement_hitters[7,1] <- "corner_infield"       
      replacement_hitters[8,1] <- "outfield" 
      replacement_hitters[9,1] <- "dh" 
      
      #rename columns
      names(replacement_hitters) <- c("position",
                                      "replacement_runs",
                                      "replacement_HR",
                                      "replacement_RBI",
                                      "replacement_SB",
                                      "replacement_AVG")

#create separate data frame for each position
for (i in hitter_positions) {
      
      #create temporary data frame based on position
      temp_data_frame <- data.frame(read.csv(paste(i,".csv",sep=""))[,c(1:3,7:9,13,16:17,29)])
      
      #get replacement level projections for each position
      for (column in 11:15) {
            temp_data_frame[,column] <- replacement_hitters[replacement_hitters$position == i,column-9]
            names(temp_data_frame)[column] <- names(replacement_hitters)[column-9]
      }
      
      #assign temporary data frame to a new data frame 
      blah <- paste(i,"_projections", sep = "")
      assign(blah, temp_data_frame, env=.GlobalEnv)
      
      #drop temporary variable
      remove(temp_data_frame)
}

projection_dfs <- c("catcher_projections",
                    "dh_projections",
                    "first_base_projections",
                    "outfield_projections",
                    "second_base_projections",
                    "shortstop_projections",
                    "third_base_projections")


#calculate marginal value of each position
for (position in projection_dfs) {
      temp <- get(position)
      
      #get clean frame with only relevant info
      names(temp)[1] <- "Name"
      
      temp$position <- gsub("_projections","",position)
      
      temp <- temp[c("Name","position","playerid", "PA",
                     "R","HR","RBI","SB","AVG",
                     "replacement_runs", "replacement_HR", "replacement_RBI", "replacement_SB","replacement_AVG" )]
      
      #calculate statistics over replacement
      temp$marginal_runs <- temp[,5] - temp[,10]
      temp$marginal_hr <- temp[,6] - temp[,11]
      temp$marginal_rbi <- temp[,7] - temp[,12]
      temp$marginal_sb <- temp[,8] - temp[,13]
      temp$marginal_avg <- temp[,9] - temp[,14]
      
      #calculate marginal points in the league
      temp$marginal_runs_points <- temp$marginal_runs * .035181
      temp$marginal_hr_points <- temp$marginal_hr * 0.112885207 
      temp$marginal_rbi_points <- temp$marginal_runs * 0.037956355      
      temp$marginal_sb_points <- temp$marginal_runs * 0.143642896
      temp$marginal_avg_points <- temp$marginal_avg * 43.82487061      
      temp$marginal_total_points <- temp$marginal_runs_points +
                                    temp$marginal_hr_points +
                                    temp$marginal_rbi_points +
                                    temp$marginal_sb_points +
                                    temp$marginal_avg_points
      
      temp$adjusted_points <- temp$marginal_total_points - 2.2
      temp$dollar_value <- (temp$adjusted_points/893.5)*2925+2
      
      
      temp <- temp[order(-temp$marginal_total_points),]
      
      assign(position, temp)
      
      remove(temp)
}

#merge projections for different positions together.
for (position in projection_dfs) {
      
      if (!exists("hitter_projections")) {
            hitter_projections <- get(position)
      }
      
      else {
            hitter_projections <- rbind(hitter_projections, get(position))
      }

}

#get how many times a player appears in projection list, what the strongest position is.
hitter_level <- hitter_projections %>%
       group_by(playerid) %>%
       summarise(times_appears = n(), max_points = max(dollar_value))

#Merge in numbers calculated above
hitter_projections <- merge(x = hitter_projections, y = hitter_level, by = "playerid", all.x = TRUE)

#delete any "DH" positions where someone is eligible for another position.
hitter_projections <- filter(hitter_projections, 
                             position != "dh" | times_appears == 1)

#keep only a player's strongest position
hitter_projections <- filter(hitter_projections,
                             dollar_value == max_points)

#Sort by dollar value in descending order
hitter_projections <- hitter_projections[order(-hitter_projections$marginal_total_points),]

#drop any players worth less than $5
hitter_projections <- filter(hitter_projections, dollar_value >= -5)

#keep only relevant columns
hitter_projections <- select(hitter_projections, Name, position, R, HR, RBI, SB, AVG, adjusted_points, dollar_value)

#round dollar values and adjusted points
hitter_projections$adjusted_points <- round(hitter_projections$adjusted_points, digits = 2)
hitter_projections$dollar_value <- round(hitter_projections$dollar_value, digits = 2)

#output to a csv
write.csv(hitter_projections, file = "hitter_projections.csv")

################################################################
################PITCHER STUFF LIVES HERE########################
################################################################

#read in projections
pitcher_projections <- read.csv("pitchers.csv", stringsAsFactors=FALSE)

#keep only relevant columns
pitcher_projections <- pitcher_projections[,c(1:2,4,7,8,12,14,20)]

#rename columns
names(pitcher_projections)[1] <- "Name"
names(pitcher_projections)[6] <- "K"

#reorder columns
pitcher_projections <- pitcher_projections[c("Name","playerid","IP","ERA","WHIP","W","SV","K")]

#create replacement pitcher values
replacement_pitcher <- c(4.47,1.4,4,1,102)
names(replacement_pitcher) <- c("ERA","WHIP","W","SV","K")

#calcualte marginal stats
for (stat in names(replacement_pitcher)) {
      pitcher_projections[paste("marginal_",stat,sep="")] <- pitcher_projections[stat]-replacement_pitcher[stat]
}

#calculate marginal points for each category

#marginal era points
pitcher_projections$marginal_era_points <-      (pitcher_projections$marginal_ERA*-12.4)*
                                                (pitcher_projections$IP/1464)

#marginal whip points
pitcher_projections$marginal_whip_points <-     (pitcher_projections$marginal_WHIP*-75)*
                                                (pitcher_projections$IP/1464)

#marginal win points
pitcher_projections$marginal_win_points <-  pitcher_projections$marginal_W*.25

#marginal save points
pitcher_projections$marginal_save_points <- pitcher_projections$marginal_SV*.14

#marginal strikeout points
pitcher_projections$marginal_strikeout_points <- pitcher_projections$marginal_K*.02

#calculate total marginal points
pitcher_projections$total_marginal_points <-    pitcher_projections$marginal_era_points +
                                                pitcher_projections$marginal_whip_points +
                                                pitcher_projections$marginal_win_points +
                                                pitcher_projections$marginal_save_points +
                                                pitcher_projections$marginal_strikeout_points             

#calculate adjusted points
pitcher_projections$adjusted_points <- pitcher_projections$total_marginal_points - 1.61

#calculate dollar value
pitcher_projections$dollar_value <- (pitcher_projections$adjusted_points/664.4132)*1872

#sort by dollar value
pitcher_projections <- pitcher_projections[order(-pitcher_projections$dollar_value),]

#drop superfluous variables
pitcher_projections <- pitcher_projections[c("Name","playerid","IP","ERA","WHIP","SV","W","SV","K","adjusted_points","dollar_value")]

#drop players worth less than -$5
pitcher_projections <- filter(pitcher_projections,dollar_value >= -5)

#round dollars and adjusted_points
pitcher_projections[,10:11] <- round(pitcher_projections[,10:11],2)

#write out to a csv
write.csv(pitcher_projections, file = "pitcher_projections.csv")

################################################################
#################LEAGUE STUFF LIVES HERE########################
################################################################

#Merge hitter and pitcher projections
player_projections <- rbind.fill(hitter_projections, pitcher_projections)

write.csv(player_projections, file = "player_projections.csv")