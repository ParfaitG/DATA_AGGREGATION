
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.Collections;

import java.lang.Math;
 
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.BufferedReader;
import java.io.IOException;

class DataObj {
      
    String compfld; String indfld; 
    float revfld; float assetfld; float equityfld;
    float netincfld; float stockfld; float empfld;    
  
    public DataObj(String compfld, String indfld, float revfld, float assetfld,
                        float equityfld, float netincfld, float stockfld, float empfld) {
      
            this.compfld = compfld;
	    this.indfld = indfld;
	    this.revfld = revfld;
	    this.assetfld = assetfld;
	    this.equityfld = equityfld;
	    this.netincfld = netincfld;
            this.stockfld = stockfld;
            this.empfld = empfld;
    }
  
}

public class Aggregate {

      public static void main(String[] args) {
	
            String currentDir = new File("").getAbsolutePath();
            ArrayList<String> industrylist = new ArrayList<String>();
            Set<String> hs = new HashSet<>();            
            ArrayList<DataObj> datalist = new ArrayList<DataObj>();            
                        
            String csvFile = currentDir + "\\Data\\" + "BigCompaniesData.csv";
            BufferedReader br = null;
            String line = "";
            String csvSplitBy = ",";
                
            int row = 0;
            try {
                  br = new BufferedReader(new FileReader(csvFile));
                  while ((line = br.readLine()) != null) {
                        // Skip column headers
                        if (row==0){ row++; continue;}                        	   
                        
                        // Split by comma separator
                        line = line.replace(", Inc.", " Inc.");
                        String[] doodle = line.split(csvSplitBy);
                        
                        // Add into Aggregate Object
                        datalist.add(new DataObj(doodle[0], doodle[1],
                                                Float.valueOf(doodle[2]), Float.valueOf(doodle[3]), Float.valueOf(doodle[4]),
                                                Float.valueOf(doodle[5]), Float.valueOf(doodle[6]), Float.valueOf(doodle[7])));
                        
                        industrylist.add(doodle[1]);
                  }
                
                  // remove duplicates and alpha order
                  hs.addAll(industrylist);
                  industrylist.clear();
                  industrylist.addAll(hs);
                  Collections.sort(industrylist);
                
                  FileWriter writer = new FileWriter(currentDir + "\\AggregatedData_java.csv");
                  writer.append("Industry,SumOfRevenues,AvgOfAssets,AvgOfEquity,MaxOfNetIncome,MinOfNetIncome,AvgOfStockPrice,SumOfEmployees\n");
          
                  for(String ind: industrylist) {                        
                        String csvline = industryAggergation(ind, datalist);
                        writer.append(csvline);
                  }
                  writer.flush();
                  writer.close();
                  System.out.println("Successfully aggregated data and outputted to CSV!");
    
            } catch (FileNotFoundException e) {
                    e.printStackTrace();
            } catch (IOException e) {
                    e.printStackTrace();	
            }
        
      }
      
      public static String industryAggergation(String indtype, ArrayList<DataObj> rawdata) {
            
            String Industry = ""; 
            float SumOfRevenues = 0; float AvgOfAssets = 0; float AvgOfEquity = 0; float MaxOfNetIncome = 0;
            double MinOfNetIncome = 1000000000000L; float AvgOfStockPrice =0; float SumOfEmployees = 0;
            int cnt = 0;  
            
            cnt = 0;                       
            for(DataObj a : rawdata) {
                  
                  if (a.indfld.equals(indtype)) {                                  
                        Industry = indtype;
                        SumOfRevenues = SumOfRevenues + a.revfld;
                        AvgOfAssets = AvgOfAssets + a.assetfld;
                        AvgOfEquity = AvgOfEquity + a.equityfld;
                        MaxOfNetIncome = Math.max(MaxOfNetIncome, a.netincfld);
                        MinOfNetIncome = Math.min(MinOfNetIncome, a.netincfld);
                        AvgOfStockPrice = AvgOfStockPrice + a.stockfld;
                        SumOfEmployees  = SumOfEmployees + a.empfld;
                        cnt = cnt + 1;
                  } else {                                    
                        continue;
                  }
                  
            }
            return Industry + "," + SumOfRevenues + "," + AvgOfAssets/cnt + "," + AvgOfEquity/cnt + "," +
                   MaxOfNetIncome + "," + MinOfNetIncome + "," + AvgOfStockPrice/cnt + "," + SumOfEmployees + "\n";
      }

}
