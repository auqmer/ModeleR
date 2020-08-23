#************************************************************************
# Title: breadPeaceModelPlot.R
# Author: William Murrah
# Description: Bread and Peace Model plot from ROS Chapter 9 code. This
#   is an example of using base R graphics to create a publication
#   quality graphic. It also demonstrates the tremendous flexibility of
#   R graphics.
#   This graphic was created by Gelman, Hill and Vehtari (2021) and can be 
#   found on their website at:
#   https://avehtari.github.io/ROS-Examples/ElectionsEconomy/hibbs.html.
# Created: Sunday, 23 August 2020
# R version: R version 4.0.2 (2020-06-22)
# Project(working) directory: /home/wmmurrah/Projects/QMER/ModeleR
#************************************************************************

# import and clean data ---------------------------------------------------

source("code/importCleanHibbs.R")
                   
n <- nrow(hibbs)
par(mar=c(0,0,1.2,0))
left <- -.3
right <- -.28
center <- -.07
f <- .17
plot(c(left-.31,center+.23), c(-3.3,n+3), type="n", bty="n", xaxt="n", yaxt="n", xlab="", ylab="", xaxs="i", yaxs="i")
mtext("Forecasting elections from the economy", 3, 0, cex=1.2)
with(hibbs, {
  for (i in 1:n){
    ii <- order(growth)[i]
    text(left-.3, i, paste (inc_party_candidate[ii], " vs. ", other_candidate[ii], " (", year[ii], ")", sep=""), adj=0, cex=.8)
    points(center+f*(vote[ii]-50)/10, i, pch=20)
    if (i>1){
      if (floor(growth[ii]) != floor(growth[order(growth)[i-1]])){
        lines(c(left-.3,center+.22), rep(i-.5,2), lwd=.5, col="darkgray")
      }
    }
  }
})
lines(center+f*c(-.65,1.3), rep(0,2), lwd=.5)
for (tick in seq(-.5,1,.5)){
  lines(center + f*rep(tick,2), c(0,-.2), lwd=.5)
  text(center + f*tick, -.5, paste(50+10*tick,"%",sep=""), cex=.8)
}
lines(rep(center,2), c(0,n+.5), lty=2, lwd=.5)
text(center+.05, n+1.5, "Incumbent party's share of the popular vote", cex=.8)
lines(c(center-.088,center+.19), rep(n+1,2), lwd=.5)
text(right, n+1.5, "Income growth", adj=.5, cex=.8)
lines(c(right-.05,right+.05), rep(n+1,2), lwd=.5)
text(right, 16.15, "more than 4%", cex=.8)
text(right, 14, "3% to 4%", cex=.8)
text(right, 10.5, "2% to 3%", cex=.8)
text(right, 7, "1% to 2%", cex=.8)
text(right, 3.5, "0% to 1%", cex=.8)
text(right, .85, "negative", cex=.8)
text(left-.3, -2.3, "Above matchups are all listed as incumbent party's candidate vs.\ other party's candidate.\nIncome growth is a weighted measure over the four years preceding the election.  Vote share excludes third parties.", adj=0, cex=.7)                   