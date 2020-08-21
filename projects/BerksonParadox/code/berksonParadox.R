#************************************************************************
# Title: berksonsParadox.R
# Author: William Murrah
# Description: Illustration of Berkson's paradox with GRE scores
# Created: Thursday, 20 August 2020
# R version: R version 4.0.2 (2020-06-22)
# Project(working) directory: /home/wmmurrah/Projects/QMER/ModeleR/projects/simpleRegression
#************************************************************************

library(arm)
set.seed(1234)
N <- 200
p <- 0.1
gre <- rnorm(N)
ugpa <- rnorm(N)

ggpa <- .5*gre + .5*ugpa + rnorm(N)
tot_score <- gre + ugpa
q <- quantile(tot_score, 1-p)
admitted <- ifelse(tot_score >= q, TRUE, FALSE)
cor(gre, ugpa)
cor(gre[admitted], ugpa[admitted])

plot(gre ~ ugpa)
plot(gre ~ ugpa, type = "n")
points(gre[admitted], ugpa[admitted], col = "red", pch = 20)
points(gre[!admitted], ugpa[!admitted], col = "black")

mod <- lm(ggpa ~ ugpa + gre)
display(mod)

moda <- lm(ggpa[admitted] ~ ugpa[admitted] + gre[admitted])
display(moda)

summary(mod)
summary(moda)

modgre <- lm(ggpa ~ gre)
modgre_a <- lm(ggpa[admitted] ~ gre[admitted])
summary(modgre)
summary(modgre_a)
