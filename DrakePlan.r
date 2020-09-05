#.libPaths("C:/Users/yjames/NetApp Inc/Forecast bookings core - Documents/renv/library/R-3.5/x86_64-w64-mingw32")
install.packages("tidyquant")

library(drake)
library(here)
library(downloader)
library(tidyverse)
library(tidyquant)
library(here)
library(tidyr)
library(Quandl)
library(foreach)
library(plyr)
library(gtrendsR)
library(reshape2)
library(parallel)
library(doParallel)
library(data.table)


drake_example("main")



gtrendscode <- code_to_function(here::here("GoogleTrends/googletrends2.r"))
QuandlData <- code_to_function(here::here("QuandlData/Quandl.r"))
FRED <- code_to_function("Fred/FredPrep.r")
gtrendsRectified <- code_to_function("rectifyGtrends.r")
compileData <- code_to_function("compileAll.r")




plan <- drake_plan(
  quandlDataPulled = QuandlData(),
  gtrendsDataPulled = gtrendscode(),
  fredDataPulled = FRED(),
  gtrendsrect = gtrendsRectified(gtrendsDataPulled),
  compile = compileData(quandlDataPulled, gtrendsrect, fredDataPulled)
  
  
)


make(plan, force = T)


library(visNetwork)
vis_drake_graph(plan)








