#************************************************************************
# Title: predictionBayesianInference
# Author: William Murrah
# Description: RAOS Chapter 9 examples
# Created: Saturday, 22 August 2020
# R version: R version 4.0.2 (2020-06-22)
# Project(working) directory: /home/wmmurrah/Projects/QMER/ModeleR/projects/ElectionsEconomy
#************************************************************************
library(arm)
library(psych)
library(car)
library(emmeans)
library(effects)
library(rstanarm)
library(boot)

loc <- "https://raw.githubusercontent.com/avehtari/ROS-Examples/master/ElectionsEconomy/data/hibbs.dat"

hibbs <- read.table(loc, header = TRUE)

hibbs <- transform(hibbs,
                   inc_party_candidate = factor(inc_party_candidate),
                   other_candidate = factor(other_candidate))

describe(hibbs)

plot(vote ~ growth, hibbs)

m1 <- lm(vote ~ growth, hibbs)
display(m1)


M1 <- stan_glm(vote ~ growth, data = hibbs)
M1
sims <- as.matrix(M1)

idx <- sample(1:nrow(sims), size = 100, replace = FALSE)
plot(vote ~ growth, hibbs)
for(i in idx) {
  abline(a = sims[i,1], b = sims[i,2], add = TRUE, col = "grey")
}
ctr <- function(x) scale(x, scale = FALSE)

plot(sims[, 1], sims[, 2], pch = 20, cex = .4)

new <- data.frame(growth = 2.0)

a_hat <- coef(m1)[1]
b_hat <- coef(m1)[2]

y_poiont_pred <- a_hat + b_hat*new

y_linpred <- posterior_linpred(M1, newdata = new)

hist(y_linpred)

a <- sims[ , 1]
b <- sims[ , 2]

y_linepred <- a + b*new
hist(y_linepred)

bstrap <- Boot(m1)
