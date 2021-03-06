USE WideWorldImportersDW
GO

/* Report 02-01 Tabular Demo */
SELECT c.[Customer]
     , s.[Description]
     , s.[Invoice Date Key]
     , s.[Total Including Tax]
  FROM [Fact].[Sale] s
  JOIN [Dimension].[Customer] c 
    ON s.[Customer Key] = c.[Customer Key]
 WHERE s.[Invoice Date Key] >= '2016-05-01'
   AND s.[Invoice Date Key] <= '2016-05-31'

/* Report 02-02 Matrix Demo */
SELECT c.[Customer]
     , YEAR(s.[Invoice Date Key])   AS InvoiceYear
     , SUM(s.[Total Including Tax]) AS TotalSalesWithTax
  FROM [Fact].[Sale] s
  JOIN [Dimension].[Customer] c 
    ON s.[Customer Key] = c.[Customer Key]
 GROUP BY c.[Customer], YEAR(s.[Invoice Date Key])

/* Report 02-03 Chart Demo */
SELECT s.[Invoice Date Key]
     , SUM(s.[Total Including Tax]) AS TotalSalesWithTax
  FROM [Fact].[Sale] s
 GROUP BY s.[Invoice Date Key]

/* Report 02-04 Parameter Demo */
SELECT c.[Customer]
     , s.[Description]
     , s.[Invoice Date Key]
     , s.[Total Including Tax]
  FROM [Fact].[Sale] s
  JOIN [Dimension].[Customer] c 
    ON s.[Customer Key] = c.[Customer Key]
 WHERE s.[Invoice Date Key] BETWEEN @FromDate AND @ThruDate
