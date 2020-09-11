library(arm)
galton <- Galton[!duplicated(Galton$family), ]

ctr <- function(x) scale(x, scale = FALSE)
mod.father <- lm(height ~ ctr(father), galton)
display(mod.father)

mod.mother <- lm(height ~ mother, galton)
display(mod.mother)


mod.mf <- lm(height ~ father + mother, galton)
display(mod.mf)
with(galton, cor(mother, father))

mod.full <- lm(height ~ mother + father + sex, galton)
display(mod.full)

summary(mod.full)

library(ggplot2)

ggplot(galton(y = height, x = father, ))

library(emmeans)
library(effects)

plot(allEffects(mod.full))


mathmod <- lm(math ~ read + income + educ +  antisoc + hyperact, NLSY)
display(mathmod)
summary(mathmod)
