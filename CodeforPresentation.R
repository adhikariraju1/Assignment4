library(WDI)
library(countrycode)
library(rio)
library(stargazer)
library(ggplot2)
library(tidyr)
library(plotly)
library(rJava)
library(xlsx)
library(repmis)

possible_dir <- c('C:/RajuPC/CollaborativeSSDA/Assignments/Assignment4', '/Users/mariorodriguez/Desktop/Assignment4')
repmis::set_valid_wd(possible_dir)

GINI <- WDI(country = 'all', start = '2002', end = '2012', indicator = c('SI.POV.GINI', 'NY.GDP.PCAP.PP.CD', 'EN.ATM.CO2E.PC'), extra = TRUE)

EPI2012 <- read.xlsx("2014epi_backcasted_scores.xls", 3)
EPI2011 <- read.xlsx("2014epi_backcasted_scores.xls", 4)
EPI2010 <- read.xlsx("2014epi_backcasted_scores.xls", 5)
EPI2009 <- read.xlsx("2014epi_backcasted_scores.xls", 6)
EPI2008 <- read.xlsx("2014epi_backcasted_scores.xls", 7)
EPI2007 <- read.xlsx("2014epi_backcasted_scores.xls", 8)
EPI2006 <- read.xlsx("2014epi_backcasted_scores.xls", 9)
EPI2005 <- read.xlsx("2014epi_backcasted_scores.xls", 10)
EPI2004 <- read.xlsx("2014epi_backcasted_scores.xls", 11)
EPI2003 <- read.xlsx("2014epi_backcasted_scores.xls", 12)
EPI2002 <- read.xlsx("2014epi_backcasted_scores.xls", 13)
EPI2012 <- EPI2012[, c('iso', 'EPI.2012')]
EPI2011 <- EPI2011[, c('iso', 'EPI.2011')]
EPI2010 <- EPI2010[, c('iso', 'EPI.2010')]
EPI2009 <- EPI2009[, c('iso', 'EPI.2009')]
EPI2008 <- EPI2008[, c('iso', 'EPI.2008')]
EPI2007 <- EPI2007[, c('iso', 'EPI.2007')]
EPI2006 <- EPI2006[, c('iso', 'EPI.2006')]
EPI2005 <- EPI2005[, c('iso', 'EPI.2005')]
EPI2004 <- EPI2004[, c('iso', 'EPI.2004')]
EPI2003 <- EPI2003[, c('iso', 'EPI.2003')]
EPI2002 <- EPI2002[, c('iso', 'EPI.2002')]
EPI <- merge(EPI2002, EPI2003, by = c('iso'))
EPI <- merge(EPI, EPI2004, by = c('iso'))
EPI <- merge(EPI, EPI2005, by = c('iso'))
EPI <- merge(EPI, EPI2006, by = c('iso'))
EPI <- merge(EPI, EPI2007, by = c('iso'))
EPI <- merge(EPI, EPI2008, by = c('iso'))
EPI <- merge(EPI, EPI2009, by = c('iso'))
EPI <- merge(EPI, EPI2010, by = c('iso'))
EPI <- merge(EPI, EPI2011, by = c('iso'))
EPI <- merge(EPI, EPI2012, by = c('iso'))

names(EPI)[names(EPI)=="EPI.2002"] <- "2002"
names(EPI)[names(EPI)=="EPI.2003"] <- "2003"
names(EPI)[names(EPI)=="EPI.2004"] <- "2004"
names(EPI)[names(EPI)=="EPI.2005"] <- "2005"
names(EPI)[names(EPI)=="EPI.2006"] <- "2006"
names(EPI)[names(EPI)=="EPI.2007"] <- "2007"
names(EPI)[names(EPI)=="EPI.2008"] <- "2008"
names(EPI)[names(EPI)=="EPI.2009"] <- "2009"
names(EPI)[names(EPI)=="EPI.2010"] <- "2010"
names(EPI)[names(EPI)=="EPI.2011"] <- "2011"
names(EPI)[names(EPI)=="EPI.2012"] <- "2012"


EPITest <- gather(EPI, year, EPIValue, 2:12)
names(EPITest)[names(EPITest)=="iso"] <- "iso3c"

Combined <- merge(GINI, EPITest, by = c('iso3c', 'year'))

names(Combined)
names(Combined)[names(Combined)=="SI.POV.GINI"] <- "GiniCoeff"
names(Combined)[names(Combined)=="NY.GDP.PCAP.PP.CD"] <- "GDPperCapPPP"
names(Combined)[names(Combined)=="EN.ATM.CO2E.PC"] <- "CO2emissions"

Combined$EPIValue <- as.numeric(as.character(Combined$EPIValue))

####This is just for the data of 2012, to make the graphs and the maps

GINI2012 <- WDI(country = 'all', start = '2012', end = '2012', indicator = c('SI.POV.GINI', 'NY.GDP.PCAP.PP.CD', 'EN.ATM.CO2E.PC'), extra = TRUE)

names(EPI2012)[names(EPI2012)=="iso"] <- "iso3c"


names(GINI2012)[names(GINI2012)=="SI.POV.GINI"] <- "GINI"
names(GINI2012)[names(GINI2012)=="NY.GDP.PCAP.PP.CD"] <- "GDPPerCapPPP"
names(GINI2012)[names(GINI2012)=="EN.ATM.CO2E.PC"] <- "CO2EmPerCap"

 
Combined2012 <- merge(GINI2012, EPI2012, by = c('iso3c'))

Combined2012 <- Combined2012[complete.cases(Combined2012),]

sapply(Combined2012, class)
sapply(EPI2012, class)
Combined2012$EPI.2012 <- as.numeric(as.character(Combined2012$EPI.2012))

plottest <- ggplot(data = Combined2012, aes(x = GINI,
                                        y = EPI.2012)) + geom_point()

ggplotly(plottest)

plot_ly(Combined2012, x = ~EPI.2012, y = ~GINI,
        mode = 'markers')

m1 <- lm(EPI.2012 ~ GINI, Combined2012)

summary(m1)

m2 <- lm(EPI.2012 ~ GINI + GDPPerCapPPP, Combined2012)

summary(m2)

#### A simple regression shows that it is statistically significant and is in the direction that we wanted. Even when controlling for GDP per capita with Purchasing Power Parity, the problem is that the coefficients decrease a lot because the variable is in USD, maybe we can introduce a dummy by category

