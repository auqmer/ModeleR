#************************************************************************
# Title: electionEconomy_simpleRegression.R
# Author: William Murrah
# Description: Using ElectionEconomy example for ROS to demonstrate full simple regression workflow
# Created: Sunday, 23 August 2020
# R version: R version 4.0.2 (2020-06-22)
# Project(working) directory: /home/wmmurrah/Projects/QMER/ModeleR
#************************************************************************
# packages used -----------------------------------------------------------
library(car)
library(effects)
library(emmeans)
library(psych)
library(arm)

# import cleaned data -----------------------------------------------------
source("code/importCleanHibbs.R")

# Explore and describe data -----------------------------------------------
scatterplotMatrix(hibbs[2:3])

scatterHist(hibbs[2:3], xlim = c(-5, 8), ylim = c(35, 70))

describe(hibbs[2:3], fast = TRUE)

boxplot(hibbs$growth)
boxplot(hibbs$vote)

# model -------------------------------------------------------------------

mod <- lm(vote ~ growth, data = hibbs)
display(mod)

# simulate model ----------------------------------------------------------
simHibbs <- function(model) {
  a <- coef(model)[1]
  b <- coef(model)[2]
  x <- model$model[[2]]
  n <- length(x)
  sigma <- summary(mod)$sigma
  simvote <- a + b*x + rnorm(n, 0, sigma)
  simmod <- lm(simvote ~ x)
  return(c(a = coef(simmod)[1], b = coef(simmod)[2], sigma = summary(simmod)$sigma))
  }

sims <- replicate(10000, simHibbs(mod))
sims <- t(sims)


plot(vote ~ growth, data = hibbs, xlim = c(-2, 6), ylim = c(40, 70), type = "n")
#idx <- sample(1:nrow(sims), 100)
for(i in 1:nrow(sims)) {
  abline(a = sims[i, 1], b = sims[i, 2], col = "grey")
}
points(x = hibbs$growth, y = hibbs$vote)
abline(coef(mod), col = "black")
abline(h = 50, lty = 2, col = "darkblue")
library(ggplot2)

# ggplot2 will give the 95% uncertainty intervals for the regression lines.
ggplot(hibbs, aes(x = growth, y = vote)) + geom_point() + 
  geom_smooth(method = "lm")

# Visualize the correlation between intercepts and slopes.
plot(sims[2, ], sims[1, ], xlab = "slopes (b)", ylab = "intercepts (a)")

# Quantify this correlation
cor(sims[1, ], sims[2, ])

# Predictive intervals
set.seed(20200823)
newdat <- data.frame(growth = seq(-.5, 4.5, length.out = 10000))

preds <- predict(mod, newdata = newdat)

newdat$vote <- preds + rnorm(10000, 0, sigma)


plot(vote ~ growth, newdat, type = "n")
for(i in 1:nrow(sims)) {
  abline(a = sims[i, 1], b = sims[i, 2], col = "skyblue")
}
points(x = newdat$growth, newdat$vote, col = rgb(.2, .2, .2, alpha = .4))
points(x = hibbs$growth, hibbs$vote, pch = 20)
abline(coef(mod))
# Plot prediction give 2% growth ------------------------------------------

# Get probability of Clinton with with 2% growth
pnorm(50, mu, sigma, lower.tail = FALSE)


par(mar=c(3,3,3,1), mgp=c(1.7,.5,0), tck=-.01)
mu <- predict(mod, newdata = data.frame(growth = 2.0))
sigma <- summary(mod)$sigma
curve (dnorm(x,mu,sigma), ylim=c(0,.11), from=35, to=70, bty="n",
  xaxt="n", yaxt="n", yaxs="i",
  xlab="Clinton share of the two-party vote", ylab="",
  main="Probability forecast of Hillary Clinton vote share in 2016,\nbased on 2% rate of economic growth", cex.main=.9)
x <- seq (50,65,.1)
polygon(c(min(x),x,max(x)), c(0,dnorm(x,mu,sigma),0),
  col="darkgray", border="black")
axis(1, seq(40,65,5), paste(seq(40,65,5),"%",sep=""))
text(50.7, .025, "Predicted\n74% chance\nof Clinton victory", adj=0)
