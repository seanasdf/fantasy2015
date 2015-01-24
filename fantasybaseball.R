setwd("C:\\Users\\Sean\\Documents\\Fantasy\\Fantasy Baseball 2015")

library(rvest)

standings13 <- "standings13.htm"
standings14 <- "Standings.htm"



# 
# # Setup File
#       for (x in numbercolumns) {
#             data <- as.character(standings[,x])
#             data2 <- as.numeric(gsub(",","",data))
#             standings[,x] <- data2
#       }
#       
#       
#       hitting <-  c("R","HR","RBI","SB","Avg","W","K","Sv")
#       pitching <- c("ERA","WHIP")
#       categories <- c(hitting, pitching)
#       
#       for (category in hitting) {
#             words <- paste(category,"points",sep="_")
#             standings[[words]] <- rank(standings[[category]], ties.method = "average")
#       }
#       for (category in pitching) {
#             words <- paste(category,"points",sep="_")
#             standings[[words]] <- 19-rank(standings[[category]], ties.method = "average")
#       }
# 
#       
# 
# 
#       
# #Import historical results
#       historicalresults <- read.xlsx("historicalresults.xlsx", sheetName = "Sheet1", header=TRUE)
#       
#       historicalresults <- historicalresults[,order(names(historicalresults))]
# 
#       fullresults <- historicalresults
# 
# # Run Regressions
# for (category in categories) {
#       outputname <- paste(category,"png", sep=".")
#       
#       x <- fullresults[[category]]
#       y <- fullresults[[paste(category,"_points",sep="")]]
#       
# 
#       #Launch PNG graphics device
#       png(file = outputname, width = 480, height = 480)
#       
#       #plot this shit
#       plot(x,y, xlab = "", ylab="")
#       title(main = paste(category," vs. points", sep=""), xlab =category, ylab = "Points")
#       #Close graphics device
#       dev.off()
#       
# }
# 
# 
# write.csv(fullresults, file = "historicalresults.csv")
# 
