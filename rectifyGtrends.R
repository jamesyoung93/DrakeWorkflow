library(here)
Older <- read.csv(here::here("tsGtrendsOlder.csv"))
Newer <- read.csv(here::here("tsGtrendsWeekly.csv"))
Older$X <- NULL
Newer$X <- NULL

#Get the oldest date of the newest data
old_date <- as.numeric(as.Date(as.character(Newer$Date)))
min(old_date)

#Find the row in the older data that matches the above date

match_old <- subset(Older, as.numeric(as.Date(as.character(Date))) == min(old_date))
match_new <- subset(Newer, as.numeric(as.Date(as.character(Date))) == min(old_date))

#Going for speed (of coding, probs doesn't matter for computation at this size) need to convert to tidy later
Older2 = NULL
for (i in 2:ncol(Older)) {
  a <- colnames(match_old)[i]
  ratio =  as.double(match_new[a] / match_old[a]) 
  Older[a] <- Older[a]*ratio
  
}

library(plyr)
new <- rbind.fill(Older, Newer)
new$Date <- as.Date(as.character(new$Date))
new <- as.data.frame(new)
write.csv(new, file = "UpdatedGtrends2.csv")


