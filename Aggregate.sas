**%Let fpath = C:\Path\to\DATA_AGGREGATION;
%Let fpath = D:\Freelance Work\Sandbox\DATA_AGGREGATION;

** READING IN CSV FILES;
proc import	datafile = "&fpath\DATA\BigCompaniesData.csv"
	out = BigCompanies dbms = csv;
run;

proc means data=BigCompanies nway ;
  class Industry ;
  var _2014_Revenue ;
  output out=Revenue sum=SumOfRevenues;  
run;

proc means data=BigCompanies nway ;
  class Industry ;
  var _2014_Assets;
  output out=Assets mean=AvgOfAssets;
run;

proc means data=BigCompanies nway ;
  class Industry ;
  var _2014_Equity;
  output out=Equity mean=AvgOfEquity;  
run;

proc means data=BigCompanies nway ;
  class Industry ;
  var _2014_Net_Income;
  output out=NetIncome max=MaxOfNetIncome min=MinOfNetIncome;  
run;

proc means data=BigCompanies nway ;
  class Industry ;
  var _2014_December_Stock_Price;
  output out=StockPrice mean=AvgStockPrice;  
run;

proc means data=BigCompanies nway ;
  class Industry ;
  var Number_of_Employees;
  output out=Employees sum=SumOfEmployees;
run;

data AggDataset;
   merge Revenue Assets Equity Netincome Revenue Stockprice Employees;
   by Industry;
   drop _type_ _freq_;
run;

** EXPORT DATASET TO CSV FILE;
proc export 
	data = Work.AggDataset
	outfile = "&fpath\AggregatedData_sas.csv"
	dbms = csv replace;
run;
