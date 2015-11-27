<?php

// Set current directory
$cd = dirname(__FILE__);

$handle = fopen($cd."/DATA/BigCompaniesData.csv", "r");    
    
$row = 0;
$values = [];

// READ CSV DATA
while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {        
    /* SKIP HEADER */
    if($row == 0) { $row++; continue; }
    
    /* OBTAIN VALUES */
    $values[$row]['Company'] = $data[0];
    $values[$row]['Industry'] = $data[1];
    $values[$row]['Revenues'] = $data[2];
    $values[$row]['Assets'] = $data[3];
    $values[$row]['Equity'] = $data[4];
    $values[$row]['NetIncome'] = $data[5];
    $values[$row]['StockPrice'] = $data[6];
    $values[$row]['Employees'] = $data[7];
    
    $row++;
}

// DEFINE DISTINCT INDUSTRIES ARRAY
$industries = [];
for ($i=1; $i<=sizeof($values); $i++) {
    $industries[]  = $values[$i]['Industry'];
}
$industries = array_unique($industries, SORT_REGULAR);
sort($industries);


// DEFINE AGGREGATE DATA ARRAY
$aggdata = [];
foreach ($industries as $i) {
    $ind = str_replace(' ', '', $i);
    $aggdata[$ind]['Industry'] = 0;
    $aggdata[$ind]['SumOfRevenues'] = 0;
    $aggdata[$ind]['AvgOfAssets'] = 0;
    $aggdata[$ind]['AvgOfEquity'] = 0;
    $aggdata[$ind]['MaxOfNetIncome'] = 0;
    $aggdata[$ind]['MinOfNetIncome'] = 1000000000000;
    $aggdata[$ind]['AvgOfStockPrice'] = 0;
    $aggdata[$ind]['SumOfEmployees'] = 0;
}


// LOOP THROUGH DATA CONDITIONAL ON INDUSTRY
foreach ($industries as $i) {
    $cnt = 0;
    $ind = str_replace(' ', '', $i);    
    for ($j=1; $j<=sizeof($values); $j++) {        
           
        if ($values[$j]['Industry'] == $i) {
            
            $aggdata[$ind]['Industry'] = $i;
            $aggdata[$ind]['SumOfRevenues'] = $aggdata[$ind]['SumOfRevenues'] + $values[$j]['Revenues'];              
            $aggdata[$ind]['AvgOfAssets'] = $aggdata[$ind]['AvgOfAssets'] + $values[$j]['Assets'];                
            $aggdata[$ind]['AvgOfEquity'] = $aggdata[$ind]['AvgOfEquity'] + $values[$j]['Equity'];            
            $aggdata[$ind]['MaxOfNetIncome'] = floatval(max($aggdata[$ind]['MaxOfNetIncome'], $values[$j]['NetIncome']));            
            $aggdata[$ind]['MinOfNetIncome'] = floatval(min($aggdata[$ind]['MinOfNetIncome'], $values[$j]['NetIncome']));            
            $aggdata[$ind]['AvgOfStockPrice'] = $aggdata[$ind]['AvgOfStockPrice'] + $values[$j]['StockPrice'];            
            $aggdata[$ind]['SumOfEmployees'] = $aggdata[$ind]['SumOfEmployees'] + $values[$j]['Employees'];           
            $cnt++;
            
        }

    }
    $aggdata[$ind]['AvgOfAssets'] = $aggdata[$ind]['AvgOfAssets'] / ($cnt);
    $aggdata[$ind]['AvgOfEquity'] = $aggdata[$ind]['AvgOfEquity'] / ($cnt);
    $aggdata[$ind]['AvgOfStockPrice'] = $aggdata[$ind]['AvgOfStockPrice'] / ($cnt);
}


// OUTPUT TO CSV
$fp = fopen($cd.'/AggregatedData_php.csv', 'w');

/* COLUMN HEADERS */
fputcsv($fp, array_keys($aggdata['Banks']));

/* DATA ROWS */
foreach ($industries as $i) {
    $ind = str_replace(' ', '', $i);
    fputcsv($fp, $aggdata[$ind]);
}
fclose($fp);

echo "Successfully aggregated data and outputted to CSV file!\n";

?>