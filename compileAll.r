
###############################################
# Bring in twitter, insta, gtrends, and quandl#
###############################################

library(here)
library(tidyr)
gtrends <- read.csv(here::here("UpdatedGtrends2.csv"))
#twitter <- read.csv(here::here("AlltwitterDaily.csv"))
#insta <- read.csv(here::here("instaDaily.csv"))
Quandl <- read.csv(here::here("tsQuandl.csv"))
FRED <- read.csv(here::here("FRED.csv"))




#Make Sure Dates are in correct format
gtrends$Date <- as.Date(as.character(gtrends$Date))
#twitter$Date <- as.Date(as.character(twitter$created_at.x))
#insta$Date <- as.Date(as.character(insta$Date))
Quandl$Date <- as.Date(as.character(Quandl$Date))
colnames(FRED)[2] <- "Date"
FRED$Date <- as.Date(as.character(FRED$Date))
#Get rid of index column
gtrends$X <- NULL
#twitter$X <- NULL
#insta$X <- NULL
Quandl$X <- NULL
FRED$X <- NULL

#Merge the files by Date, this may be mappable
#df <- merge(gtrends, twitter, by = "Date", all = T)
#df <- merge(df, insta, by = "Date", all = T)
df <- merge(gtrends, Quandl, by = "Date", all = T)
df <- merge(df, FRED, by = "Date", all = T)

#Fill all empty dates with the last filled dates results
df <- as.data.frame(df)
df <- df %>% fill(-Date)
#This makes the data more manageable by limiting it to only what matches up with bookings data
df <- df[4443:nrow(df),]

write.csv(df, "AllData.csv")
















