#************************************************************************
# Title: simpleRegression_MotherDaughterHeightsExample.R
# Author: William Murrah
# Description: Using mother daughter heights to demonstrate simple 
#              regression.
# Created: Thursday, 03 September 2020
# R version: R version 4.0.2 (2020-06-22)
# Project(working) directory: /home/wmmurrah/Projects/QMER/ModeleR/projects/simpleRegression
#************************************************************************
library(psych)
library(arm)
heights <- read.csv("data/heights.csv", header = TRUE)

# Remove X variable which duplicates the row numbers.
heights$X <- NULL

# Load a function I created to plot histograms with normal curves.
source("code/hist_norm.R")

# Look for normality and outliers
hist_norm(heights$daughter_height)
hist_norm(heights$mother_height)

plot(daughter_height ~ mother_height, data = heights)

describe(heights, fast = TRUE)
# Model -------------------------------------------------------------------

mod <- lm(daughter_height ~ mother_height, data = heights)
display(mod)

# Plot the variables again, now with regression line.
plot(daughter_height ~ mother_height, data = heights)
abline(coef(mod))

# Plot again, this time visualizing the intercepts.
plot(daughter_height ~ mother_height, data = heights, 
     xlim = c(0, 75), ylim = c(29, 80))
abline(coef(mod))
