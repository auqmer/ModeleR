hist_norm <- function(x, xlabel = deparse(substitute(x)), ...) {
  h <- hist(x, plot = FALSE, ...)
  s <- sd(x, na.rm = TRUE)
  m <- mean(x, na.rm = TRUE)
  yl <- range(0, h$density, dnorm(0, sd = s))
  hist(x, freq = FALSE, ylim = yl, xlab = xlabel, ...)
  curve(dnorm(x, m, s), add = TRUE, col = "red", lwd = 2)
}
