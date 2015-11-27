<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:exsl="http://exslt.org/common"
                              extension-element-prefixes="exsl">
 <xsl:output omit-xml-declaration="no" indent="yes"/>
 <xsl:strip-space elements="*"/> 
  
  <xsl:key name="indkey" match="bigcompany" use="industry"/>
 
  <xsl:template match="data">
   <data>        
    <xsl:for-each select="bigcompany[generate-id()    
                         = generate-id(key('indkey', industry)[1])]">
         
         <xsl:sort select="industry" data-type="text" order="ascending"/>
         <xsl:variable name="curr-group" select="key('indkey', industry)" />
         <xsl:variable name="income-sorted">
              <xsl:for-each select="$curr-group">
                  <xsl:sort select="netincome" data-type="number" order="ascending"/>
                  <xsl:copy-of select="netincome"/>
              </xsl:for-each>
          </xsl:variable>
          <xsl:variable name="income-sorted-set" select="exsl:node-set($income-sorted)/netincome" />

        <aggdata>
          <xsl:copy-of select="industry"/>        
          <SumOfRevenue><xsl:copy-of select="sum($curr-group/revenue)"/></SumOfRevenue>
          <AvgOfAssets><xsl:copy-of select="sum($curr-group/assets) div count($curr-group/assets)"/></AvgOfAssets>
          <AvgOfEquity><xsl:copy-of select="sum($curr-group//equity) div count($curr-group/equity)"/></AvgOfEquity>
          <MaxOfIncome><xsl:value-of select="$income-sorted-set[5]"/></MaxOfIncome>
          <MinOfIncome><xsl:value-of select="$income-sorted-set[1]"/></MinOfIncome>
          <AvgOfStockPrice><xsl:copy-of select="sum($curr-group/stockprice) div count($curr-group/stockprice)"/></AvgOfStockPrice>
          <SumOfEmployees><xsl:copy-of select="sum($curr-group/employees)"/></SumOfEmployees>
        </aggdata>
        
    </xsl:for-each>    
    </data>
  </xsl:template>
</xsl:stylesheet>
  