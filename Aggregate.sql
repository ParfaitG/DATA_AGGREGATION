SELECT BigCompaniesData.Industry,
       Sum(BigCompaniesData.[2014 Revenue]) AS SumOfRevenues,
       Avg(BigCompaniesData.[2014 Assets]) AS AvgOfAssets,
       Avg(BigCompaniesData.[2014 Equity]) AS AvgOfEquity,
       Max(BigCompaniesData.[2014 Net Income]) AS MaxOfNetIncome,
       Min(BigCompaniesData.[2014 Net Income]) AS MinOfNetIncome,
       Avg(BigCompaniesData.[2014 December Stock Price]) AS AvgOfStockPrice,
       Sum(BigCompaniesData.[Number of Employees]) AS SumOfEmployees
FROM BigCompaniesData
GROUP BY BigCompaniesData.Industry;
