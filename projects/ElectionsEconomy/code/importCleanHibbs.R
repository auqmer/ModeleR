#************************************************************************
# Title: importCleanHibbs.R
# Author: William Murrah
# Description: Prepare the Hibbs data for ElectionEconomy examples.
#   This example is based on the data and other code from: 
#   https://avehtari.github.io/ROS-Examples/
# Created: Sunday, 23 August 2020
# R version: R version 4.0.2 (2020-06-22)
# Project(working) directory: /home/wmmurrah/Projects/QMER/ModeleR/projects/ElectionsEconomy
#************************************************************************

loc <- "https://raw.githubusercontent.com/avehtari/ROS-Examples/master/ElectionsEconomy/data/hibbs.dat"

hibbs <- read.table(loc, header = TRUE)
hibbs <- transform(hibbs,
                   inc_party_candidate = factor(inc_party_candidate),
                   other_candidate = factor(other_candidate))

# Save archival version of cleaned data.
# write.csv(hibbs, file = "data/hibbs.csv")

rm(loc)
