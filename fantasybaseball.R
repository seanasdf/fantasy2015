setwd("C:\\Users\\Sean\\Documents\\Fantasy\\Fantasy Baseball 2015")

require(RCurl)
require(XML)
require(dplyr)
require(xlsx)
require(gtools)

# Import Standings from 2014 from HTML Document

standings <- "standings.htm"

standings <- readHTMLTable(standings)

standings <- data.frame(standings$standingsHeadTable0)

standings <- tbl_df(standings)

numbercolumns <- c(1:2,5:ncol(standings))

for (x in numbercolumns) {
      data <- as.character(standings[,x])
      data2 <- as.numeric(gsub(",","",data))
      standings[,x] <- data2
}


hitting <-  c("R","HR","RBI","SB","Avg","W","K","Sv")
pitching <- c("ERA","WHIP")
categories <- c(hitting, pitching)

for (category in hitting) {
      words <- paste(category,"points",sep="_")
      standings[[words]] <- rank(standings[[category]], ties.method = "average")
}
for (category in pitching) {
      words <- paste(category,"points",sep="_")
      standings[[words]] <- 19-rank(standings[[category]], ties.method = "average")
}

standings$total_points <- (standings$R_points+standings$HR_points+standings$RBI_points+standings$SB_points+standings$Avg_points+standings$W_points+standings$K_points+standings$Sv_points+standings$ERA_points+standings$WHIP_points)


# Import standings from 2013 from html document
standings13 <- "standings13.htm"

standings13 <- readHTMLTable(standings13)
standings13 <- data.frame(standings13)
standings13 <- tbl_df(standings13)

st13 <- standings13[3:20,2:3]

st13 <- cbind(st13, standings13[22:39, 2:3])
st13 <- cbind(st13, standings13[41:58, 2:3])
st13 <- cbind(st13, standings13[60:77, 2:3])
st13 <- cbind(st13, standings13[79:96, 2:3])

names(st13) <- c("ERA", "ERA_points")


historicalresults <- read.xlsx("historicalresults.xlsx", sheetName = "Sheet1", header=TRUE)

historicalresults <- historicalresults[,order(names(historicalresults))]

results14 <- standings[,6:25]
results14 <- results14[,order(names(results14))]
fullresults <- rbind(historicalresults, results14)

for (category in categories) {
      outputname <- paste(category,"png", sep=".")
      
      x <- fullresults[[category]]
      y <- fullresults[[paste(category,"_points",sep="")]]
      

      #Launch PNG graphics device
      png(file = outputname, width = 480, height = 480)
      
      #plot this shit
      plot(x,y, xlab = "", ylab="")
      title(main = paste(category," vs. points", sep=""), xlab =category, ylab = "Points")
      #Close graphics device
      dev.off()
      
}




