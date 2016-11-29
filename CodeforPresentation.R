setwd('/Users/mariorodriguez/Desktop/Assignment4')
library(WDI)
library(countrycode)
library(rio)
library(stargazer)
library(ggplot2)


GINI <- WDI(country = 'all', start = '2010', end = '2013', indicator = c('SI.POV.GINI', 'NY.GDP.PCAP.CD', 'EN.ATM.CO2E.PC'), extra = TRUE)

EPI <- import('http://epi.yale.edu/sites/default/files/2016EPI_Raw_Data.xls')

EPI <- system.file("tests", "2014epi_backcasted_scores.xls", package = "xlsx")

res <- read.xlsx(EPI, 2)

