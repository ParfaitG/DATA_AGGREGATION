
setwd("C:/Path/To/DATA_AGGREGATION")
bigcompaniesdf <- read.csv(paste0(getwd(), "/DATA/BigCompaniesData.csv"), stringsAsFactors=FALSE)

aggdf <- as.data.frame(list(Industry = unique(bigcompaniesdf$Industry)))

mergeaggs <- function(mdf){
                  aggdf <- merge(aggdf, mdf, by='Industry')  
                  return(aggdf)
              }

aggdf <- mergeaggs(aggregate(list(SumOfRevenues = bigcompaniesdf$X2014.Revenue), 
                             by=list(Industry = bigcompaniesdf$Industry), FUN=sum))
aggdf <- mergeaggs(aggregate(list(AvgOfAssets = bigcompaniesdf$X2014.Assets), 
                             by=list(Industry = bigcompaniesdf$Industry),FUN=mean))
aggdf <- mergeaggs(aggregate(list(AvgOfEquity = bigcompaniesdf$X2014.Equity), 
                             by=list(Industry = bigcompaniesdf$Industry),FUN=mean))
aggdf <- mergeaggs(aggregate(list(MaxOfNetIncome = bigcompaniesdf$X2014.Net.Income), 
                             by=list(Industry = bigcompaniesdf$Industry),FUN=max))
aggdf <- mergeaggs(aggregate(list(MinOfNetIncome = bigcompaniesdf$X2014.Net.Income), 
                             by=list(Industry = bigcompaniesdf$Industry),FUN=min))
aggdf <- mergeaggs(aggregate(list(AvgOfStockPrice = bigcompaniesdf$X2014.December.Stock.Price), 
                             by=list(Industry = bigcompaniesdf$Industry),FUN=mean))
aggdf <- mergeaggs(aggregate(list(SumOfEmployees = bigcompaniesdf$Number.of.Employees), 
                             by=list(Industry = bigcompaniesdf$Industry),FUN=sum))

write.csv(aggdf, "AggregatedData_r.csv", row.names=FALSE)

print("Successfully aggregated data and outputted to csv!")