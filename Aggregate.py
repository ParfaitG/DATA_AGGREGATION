import os
import pandas as pd

cd = os.path.dirname(os.path.abspath(__file__))

bigcompaniesdf = pd.read_csv(os.path.join(cd, 'DATA', 'BigCompaniesData.csv'))

def aggdata(row):
    row['SumOfRevenues'] = row['2014 Revenue'].sum()
    row['AvgOfAssets'] = row['2014 Assets'].mean()
    row['AvgOfEquity'] = row['2014 Equity'].mean()
    row['MaxOfNetIncome'] = row['2014 Net Income'].max()
    row['MinOfNetIncome'] = row['2014 Net Income'].min()
    row['AvgOfStockPrice'] = row['2014 December Stock Price'].mean()
    row['SumOfEmployees'] = row['Number of Employees'].sum()
    return row

aggdf = bigcompaniesdf.groupby(['Industry']).apply(aggdata)
aggdf = aggdf[['Industry','SumOfRevenues','AvgOfAssets','AvgOfEquity',
               'MaxOfNetIncome','MinOfNetIncome','AvgOfStockPrice','SumOfEmployees']].drop_duplicates().sort(['Industry'])

aggdf.to_csv(os.path.join(cd, 'AggregatedData_py.csv'),index=False)

print("Successfully aggregated data and outputted to csv!")
