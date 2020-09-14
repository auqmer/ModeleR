##**********************************************************************
## Title: kidIQ.R
## Author: William Murrah
## Description: Using KidIQ data to demonstrate multiple regression
##**********************************************************************

data(mtcars)
n <- 1e3

set.seed(1234)
x = rnorm(n)
y = 1*x + rnorm(n, 0, 1)

dat <- data.frame(x,y)

pairs.panels(dat)
plot(y ~ x, dat)
abline(a = 0, b = 1)
