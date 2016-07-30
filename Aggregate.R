
# SET CURRENT DIRECTORY
setwd("C:/Path/To/DATA_AGGREGATION")

# READ SOURCE DATA
bigcompaniesdf <- read.csv(paste0(getwd(), "/DATA/BigCompaniesData.csv"), stringsAsFactors=FALSE)

# BASE R AGGREGATION
aggdf <- cbind(aggregate(list(SumOfRevenues = bigcompaniesdf$X2014.Revenue), 
                          by=list(Industry = bigcompaniesdf$Industry), FUN=sum),
                aggregate(list(AvgOfAssets = bigcompaniesdf$X2014.Assets), 
                          by=list(Industry = bigcompaniesdf$Industry),FUN=mean),
                aggregate(list(AvgOfEquity = bigcompaniesdf$X2014.Equity), 
                          by=list(Industry = bigcompaniesdf$Industry),FUN=mean),
                aggregate(list(MaxOfNetIncome = bigcompaniesdf$X2014.Net.Income), 
                          by=list(Industry = bigcompaniesdf$Industry),FUN=max),
                aggregate(list(MinOfNetIncome = bigcompaniesdf$X2014.Net.Income), 
                          by=list(Industry = bigcompaniesdf$Industry),FUN=min),
                aggregate(list(AvgOfStockPrice = bigcompaniesdf$X2014.December.Stock.Price), 
                          by=list(Industry = bigcompaniesdf$Industry),FUN=mean),
                aggregate(list(SumOfEmployees = bigcompaniesdf$Number.of.Employees), 
                          by=list(Industry = bigcompaniesdf$Industry),FUN=sum))

aggdf <- aggdf[,c(1,2,4,6,8,10,12,14)]  # RE-ORDER COLUMNS


# DPLYR AGGREGATION
library(dplyr)
aggdf <- bigcompaniesdf %>% 
  group_by(Industry) %>% 
  summarise(SumOfRevenues = sum(X2014.Revenue), 
            AvgOfAssets = mean(X2014.Assets), 
            AvgOfEquity = mean(X2014.Equity),
            MaxOfNetIncome = max(X2014.Net.Income),
            MinOfNetIncome = min(X2014.Net.Income),
            AvgOfStockPrice = max(X2014.December.Stock.Price),
            SumOfEmployees = sum(Number.of.Employees))

# OUTPUT TO FILE
write.csv(aggdf, "AggregatedData_r.csv", row.names=FALSE)

print("Successfully aggregated data and outputted to csv!")