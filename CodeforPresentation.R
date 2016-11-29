setwd('/Users/mariorodriguez/Desktop/Assignment4')
library(WDI)
library(countrycode)
library(rio)
library(stargazer)
library(ggplot2)
library(tidyr)
library(plotly)

GINI <- WDI(country = 'all', start = '2002', end = '2012', indicator = c('SI.POV.GINI', 'NY.GDP.PCAP.CD', 'EN.ATM.CO2E.PC'), extra = TRUE)

EPI <- import('http://epi.yale.edu/sites/default/files/2016EPI_Raw_Data.xls')

EPI <- system.file("tests", "2014epi_backcasted_scores.xls", package = "xlsx")

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
names(Combined)[names(Combined)=="NY.GDP.PCAP.CD"] <- "GDPperCapita"
names(Combined)[names(Combined)=="EN.ATM.CO2E.PC"] <- "CO2emissions"

plottest <- ggplot(data = Combined, aes(x = EPIValue,
                                             y = GiniCoeff)) + geom_point()
ggplotly(plottest)
plot_ly(Combined, x = ~EPIValue, y = ~GiniCoeff,
        mode = 'markers')


