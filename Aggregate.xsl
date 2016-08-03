<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:exsl="http://exslt.org/common"
                              extension-element-prefixes="exsl">
 <xsl:output method="text" omit-xml-declaration="no" indent="yes"/>
 <xsl:strip-space elements="*"/>
 
 <!-- CREDIT: @michael.hor257k user on StackOverflow -->
    
  <xsl:key name="indkey" match="bigcompany" use="industry"/>
 
  <xsl:template match="data">
    <!-- COLUMN HEADERS -->
    <xsl:text>Industry,SumOfRevenues,AvgOfAssets,AvgOfEquity,MaxOfIncome,MinOfIncome,AvgOfStockPrices,SumOfEmployees&#xa;</xsl:text>
    
    <xsl:for-each select="bigcompany[generate-id() = generate-id(key('indkey', industry)[1])]">     
       <xsl:sort select="industry" data-type="text" order="ascending"/>
       <xsl:variable name="curr-group" select="key('indkey', industry)" />
       <xsl:variable name="income-sorted">
            <xsl:for-each select="$curr-group">
                <xsl:sort select="netincome" data-type="number" order="ascending"/>
                <xsl:copy-of select="netincome"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="income-sorted-set" select="exsl:node-set($income-sorted)/netincome" />
        
        <!-- DATA ROWS -->
        <xsl:value-of select="industry"/><xsl:text>,</xsl:text>
        <xsl:value-of select="sum($curr-group/revenue)"/><xsl:text>,</xsl:text>
        <xsl:value-of select="sum($curr-group/assets) div count($curr-group/assets)"/><xsl:text>,</xsl:text>
        <xsl:value-of select="sum($curr-group//equity) div count($curr-group/equity)"/><xsl:text>,</xsl:text>
        <xsl:value-of select="$income-sorted-set[5]"/><xsl:text>,</xsl:text>
        <xsl:value-of select="$income-sorted-set[1]"/><xsl:text>,</xsl:text>
        <xsl:value-of select="sum($curr-group/stockprice) div count($curr-group/stockprice)"/><xsl:text>,</xsl:text>
        <xsl:value-of select="sum($curr-group/employees)"/><xsl:text>,</xsl:text><xsl:text>&#xa;</xsl:text>
    </xsl:for-each>    
   
  </xsl:template>
</xsl:stylesheet>
  