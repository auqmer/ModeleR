#************************************************************************
# Title: importClean_PearsonLee.R
# Author: William Murrah
# Description: Prepare data for Height example of simple regression.
#  Taken from ROS website at: 
#  https://github.com/avehtari/ROS-Examples/tree/master/PearsonLee/
# Created: Sunday, 23 August 2020
# R version: R version 4.0.2 (2020-06-22)
# Project(working) directory: /home/wmmurrah/Projects/QMER/ModeleR/projects/simpleRegression
#************************************************************************
loc <- "https://raw.githubusercontent.com/avehtari/ROS-Examples/master/PearsonLee/data/Heights.txt"

heights <- read.table(loc, header = TRUE)

write.csv(heights, "data/heights.csv")
