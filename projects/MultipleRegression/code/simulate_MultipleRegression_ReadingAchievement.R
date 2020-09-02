#************************************************************************
# Title: simulate_MultipleRegression_ReadingAchievment
# Author: William Murrah
# Description: Simulate data for Pedhazur Table 5.1 MR example.
# Created: Monday, 31 August 2020
# R version: R version 4.0.2 (2020-06-22)
# Project(working) directory: /home/wmmurrah/Projects/QMER/ModeleR/projects/MultipleRegression
#************************************************************************


desc <- data.frame(Variable = c("ReadAch", "VerbalApt", "AchMot"),
                  Mean = c(5.85, 4.35, 5.50),
                  SD = c(2.72, 2.32, 1.67))
cors <- matrix(c(1, .79, .68,
                 .79, 1, .52,
                 .68, .52, 1), nrow = 3)
cors[upper.tri(cors, diag = TRUE)] <- " "
cors <- cors[ ,-3]
tab <- cbind(desc, cors)
tab

describe(simdat, fast = TRUE)
print(cor(simdat), 2)

## Simulate data
samplesize <- 1e3
set.seed(20200831)
AchMot <- rnorm(n = samplesize, mean = 5.50, sd = 1.67)
VerbalApt <- rnorm(n = samplesize, mean = .35 + .73*AchMot, sd = 2.04)
ReadAch <- rnorm(n = samplesize, mean = -0.47 + .70*VerbalApt + .59*AchMot, 1.51)

simdat <- data.frame(ReadAch, VerbalApt, AchMot)

mody.1 <- lm(ReadAch ~ VerbalApt, data = simdat)
display(mody.1)

mody.2 <- lm(ReadAch ~ AchMot, data = simdat)
display(mody.2)

mody.12 <- lm(ReadAch ~ VerbalApt + AchMot, data = simdat)
display(mody.12)