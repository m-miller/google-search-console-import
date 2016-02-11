## A script to download and archive Google search console analytics (formerly webmaster tools)
##
## searchConsoleR R package created by Mark Edmondson (http://markedmondson.me)
##
## This script downloads and writes data to .csv for the most recent day of search console data (3 days ago)

## load the required libraries 
## (Download them with install.packages("googleAuthR") and install.packages("searchConsoleR") if necessary
library(googleAuthR)
library(searchConsoleR)


## data is in search console reliable for 3 days ago so set that to start date = today - 3
## this is a single day pull so end to start
start <- Sys.Date() - 3
end <- start

## set website to your URL including http://
website <- "http://www.ryanpraski.com"

## Authorize script with Search Console.  
## First time you will need to login to Google,
## but should auto-refresh after that so can be put in 
## Authorize script with an account that has access to website.
gar_auth()

## first time stop here and wait for authorization

## this is the query to the search console API

searchquery <- search_analytics(siteURL = website,
                                startDate = start, 
                                endDate = end, 
                                dimensions = c('date','page','query'),
                                searchType = c('web'), 
                                rowLimit = 5000)



## Specify Output filepath
filepath <-"C:/Users/praskry/Desktop/rdata/"

## filename will be set like searchconsoledata_2015-11-13_to_2016-02-08 (.csv will be added in next step)
filename <- paste("searchconsoledata", start, sep = "_")

## the is the full filepath + filename with .csv
output <- paste(filepath, filename, ".csv", sep = "")

## this writes the sorted search query report to full filepath and filename row.names=FALSE does not write row numbers to the 
write.csv(searchquery, output, row.names = FALSE)

## Complete