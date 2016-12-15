library(WDI)
library(countrycode)
library(rio)
library(stargazer)
library(ggplot2)
library(tidyr)
library(plotly)
library(plm)
library(googleVis)
library(repmis)
library(reshape2)

possible_dir <- c('C:/RajuPC/CollaborativeSSDA/Assignments/Assignment4', '/Users/mariorodriguez/Desktop/Assignment4')
repmis::set_valid_wd(possible_dir)

Combinedmaps <- read.csv('EPIGINI2016.csv')

Combinedmaps <- Combinedmaps[, -c(1)]

Combinedmaps <- Combinedmaps[, c('country', 'iso2c', 'year', 'Gini', 'EPI', 'CO2emissions')]

Combinedmaps <- Combinedmaps[complete.cases(Combinedmaps),]

Combinedmaps <- Combinedmaps[order(Combinedmaps$year, decreasing=TRUE),]

Combinedmaps <- Combinedmaps[!duplicated(Combinedmaps$country),]

Combinedmaps <- Combinedmaps[order(Combinedmaps$country, decreasing=FALSE),]

GINImap <- gvisGeoChart(Combinedmaps, locationvar = 'iso2c',
                        colorvar = 'GiniCoeff',
                        options = list(
                          colors = "['lightblue', 'blue']"
                        ))

EPImap <- gvisGeoChart(Combined, locationvar = 'iso2c',
                       colorvar = 'EPIValue',
                       options = list(
                         colors = "['red', 'yellow']"
                       ))

EPImap <- gvisGeoChart(Combined2010, locationvar = 'iso2c',
                       colorvar = 'EPIValue',
                       options = list(
                         colors = "['red', 'yellow']"
                       ))

print(GINImap, tag = 'chart')

names(Combinedmaps)[names(Combinedmaps)=="GiniCoeff"] <- "Gini"

names(Combinedmaps)[names(Combinedmaps)=="EPIValue"] <- "EPI"

write.csv(Combinedmaps, 'Maps.csv')

sapply(Combinedmaps, class)

## http://scholarworks.umass.edu/cgi/viewcontent.cgi?article=1039&context=peri_workingpapers

## http://www.un.org/esa/desa/papers/2015/wp145_2015.pdf

