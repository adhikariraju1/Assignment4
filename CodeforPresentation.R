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

GINI <- WDI(country = 'all', start = '2002', end = '2016', indicator = c('SI.POV.GINI', 'NY.GDP.PCAP.PP.CD', 'EN.ATM.CO2E.PC', 'EN.POP.DNST', 'SP.URB.TOTL.IN.ZS'), extra = TRUE)

EPI2016 <- read.xlsx("2016_epi_framework_indicator_scores_friendly_0.xls", 3)
EPI2014 <- read.xlsx("2014_epi_framework_indicator_scores_friendly_0.xls", 3)
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
names(EPI2016)[names(EPI2016)=="Country"] <- "country"
names(EPI2014)[names(EPI2014)=="Country"] <- "country"
EPI2016 <- EPI2016[, c('country', 'X2016.EPI.Score')]
EPI2014 <- EPI2014[, c('country', 'EPI.Score')]
EPI2012 <- EPI2012[, c('country', 'EPI.2012')]
EPI2011 <- EPI2011[, c('country', 'EPI.2011')]
EPI2010 <- EPI2010[, c('country', 'EPI.2010')]
EPI2009 <- EPI2009[, c('country', 'EPI.2009')]
EPI2008 <- EPI2008[, c('country', 'EPI.2008')]
EPI2007 <- EPI2007[, c('country', 'EPI.2007')]
EPI2006 <- EPI2006[, c('country', 'EPI.2006')]
EPI2005 <- EPI2005[, c('country', 'EPI.2005')]
EPI2004 <- EPI2004[, c('country', 'EPI.2004')]
EPI2003 <- EPI2003[, c('country', 'EPI.2003')]
EPI2002 <- EPI2002[, c('country', 'EPI.2002')]
EPI <- merge(EPI2002, EPI2003, by = c('country'))
EPI <- merge(EPI, EPI2004, by = c('country'))
EPI <- merge(EPI, EPI2005, by = c('country'))
EPI <- merge(EPI, EPI2006, by = c('country'))
EPI <- merge(EPI, EPI2007, by = c('country'))
EPI <- merge(EPI, EPI2008, by = c('country'))
EPI <- merge(EPI, EPI2009, by = c('country'))
EPI <- merge(EPI, EPI2010, by = c('country'))
EPI <- merge(EPI, EPI2011, by = c('country'))
EPI <- merge(EPI, EPI2012, by = c('country'))
EPI <- merge(EPI, EPI2014, by = c('country'))
EPI <- merge(EPI, EPI2016, by = c('country'))

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
names(EPI)[names(EPI)=="EPI.Score"] <- "2014"
names(EPI)[names(EPI)=="X2016.EPI.Score"] <- "2016"

names(EPI2016)[names(EPI2016)=="X2016.EPI.Score"] <- "EPI2016"


EPITest <- gather(EPI, year, EPI, 2:14)
names(EPITest)[names(EPITest)=="iso"] <- "iso3c"

Combined <- merge(GINI, EPITest, by = c('country', 'year'))

names(Combined)
names(Combined)[names(Combined)=="SI.POV.GINI"] <- "Gini"
names(Combined)[names(Combined)=="NY.GDP.PCAP.PP.CD"] <- "GDPperCapPPP"
names(Combined)[names(Combined)=="EN.ATM.CO2E.PC"] <- "CO2emissions"
names(Combined)[names(Combined)=="EN.POP.DNST"] <- "PopulationDens"
names(Combined)[names(Combined)=="SP.URB.TOTL.IN.ZS"] <- "UrbanPop"

Combined$EPI <- as.numeric(as.character(Combined$EPI))

####This is just for the data of 2012, to make the graphs and the maps

GINI2012 <- WDI(country = 'all', start = '2012', end = '2012', indicator = c('SI.POV.GINI', 'NY.GDP.PCAP.PP.CD', 'EN.ATM.CO2E.PC'), extra = TRUE)

names(EPI2012)[names(EPI2012)=="iso"] <- "iso3c"


names(GINI2012)[names(GINI2012)=="SI.POV.GINI"] <- "GINI"
names(GINI2012)[names(GINI2012)=="NY.GDP.PCAP.PP.CD"] <- "GDPPerCapPPP"
names(GINI2012)[names(GINI2012)=="EN.ATM.CO2E.PC"] <- "CO2EmPerCap"

 
Combined2012 <- merge(GINI2012, EPI2012, by = c('iso3c'))

Combined2012 <- Combined2012[!is.na(Combined2012$EPI.2012),]

Combined2012 <- Combined2012[complete.cases(Combined2012$EPI.2012),]

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

#### Data from 2010, the last year with the US' GINI

GINI2010 <- WDI(country = 'all', start = '2010', end = '2010', indicator = c('SI.POV.GINI', 'NY.GDP.PCAP.PP.CD', 'EN.ATM.CO2E.PC'), extra = TRUE)

names(EPI2010)[names(EPI2010)=="iso"] <- "iso3c"


names(GINI2010)[names(GINI2010)=="SI.POV.GINI"] <- "GINI"
names(GINI2010)[names(GINI2010)=="NY.GDP.PCAP.PP.CD"] <- "GDPPerCapPPP"
names(GINI2010)[names(GINI2010)=="EN.ATM.CO2E.PC"] <- "CO2EmPerCap"


Combined2010 <- merge(GINI2010, EPI2010, by = c('iso3c'))

Combined2010 <- Combined2010[complete.cases(Combined2010),]

Combined2010$EPI.2010 <- as.numeric(as.character(Combined2010$EPI.2010))

write.csv(Combined2010, file = "EPIGINI2010.csv")

write.csv(Combined2012, file = "EPIGINI2012.csv")

write.csv(Combined, file = "EPIGINI2016.csv")

write.csv(EPI2016, file = "EPI2016.csv")
