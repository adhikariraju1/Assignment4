setwd('C:/RajuPC/CollaborativeSSDA/Assignments/Assignment4')
library(WDI)
library(countrycode)
library(rio)
library(stargazer)
library(ggplot2)
library(tidyr)
library(plotly)
library(plm)

Combined <- read.csv('EPIGINI.csv')

Combined2012 <- read.csv('EPIGINI2012.csv')


plottest <- ggplot(data = Combined2012, aes(x = GINI,
                                            y = EPI.2012)) + geom_point()

ggplotly(plottest)

plot_ly(Combined2012, x = ~GINI, y = ~EPI.2012,
        mode = 'markers')

m1 <- lm(EPI.2012 ~ GINI, Combined2012)

summary(m1)

m2 <- lm(EPI.2012 ~ GINI + GDPPerCapPPP, Combined2012)

summary(m2)

#Pooled OLS on the dataset combined.
m3 <- lm(EPIValue ~ GiniCoeff + GDPperCapPPP, combined)

summary(m3)

#Fixed Effects on the same dataset.

m4 <- plm(EPIValue ~ GiniCoeff + GDPperCapPPP, data=combined, index= c('country', 'year'), model = 'within')

summary(m4)

#Random Effects now.

m5 <- plm(EPIValue ~ GiniCoeff + GDPperCapPPP, data=combined, index= c('country', 'year'), model = 'random')

summary(m5)

#Check between fixed effects or random effects.
phtest(m4, m5)



#### A simple regression shows that it is statistically significant and is in the direction that we wanted. Even when controlling for GDP per capita with Purchasing Power Parity, the problem is that the coefficients decrease a lot because the variable is in USD, maybe we can introduce a dummy by category


