USE [WideWorldImportersDW]

/* Report 03-01 Multi Axis Charts */
SELECT YEAR([Invoice Date Key])   AS InvoiceYear
     , SUM([Total Excluding Tax]) AS TotalExcludingTax
     , SUM([Tax Amount])          AS TotalTaxAmount
  FROM [Fact].[Sale]
 GROUP BY YEAR([Invoice Date Key])

/* Report 03-02 Multi Data Regions */
/* Main Dataset */
SELECT c.[Sales Territory]
     , YEAR(s.[Invoice Date Key])   AS [Invoice Year]
     , SUM(s.[Total Excluding Tax]) AS [Total Sales]
  FROM [Fact].[Sale] s
  JOIN [Dimension].[City] c
    ON s.[City Key] = c.[City Key]
 WHERE c.[Sales Territory] IN (@Territory)
 GROUP BY c.[Sales Territory], YEAR(s.[Invoice Date Key])
 ORDER BY c.[Sales Territory], YEAR(s.[Invoice Date Key])

 /* Territory Parameter */
SELECT DISTINCT [Sales Territory]
  FROM [Dimension].[City]
 ORDER BY [Sales Territory]

/* Report 03-03 Nested Data Region */
SELECT c.[Sales Territory]
     , YEAR(s.[Invoice Date Key]) AS [Invoice Year]
     , SUM(s.[Total Excluding Tax]) AS [Total Sales]
  FROM [Fact].[Sale] s
  JOIN [Dimension].[City] c
    ON s.[City Key] = c.[City Key]
 GROUP BY YEAR(s.[Invoice Date Key]), c.[Sales Territory]
 ORDER BY YEAR(s.[Invoice Date Key]), c.[Sales Territory]

/* Report 03-04 Maps */
SELECT c.[State Province]
     , SUM(s.[Total Excluding Tax]) AS [Total Sales]
  FROM [Fact].[Sale] s
  JOIN [Dimension].[City] c
    ON s.[City Key] = c.[City Key]
 GROUP BY c.[State Province]
 ORDER BY c.[State Province]

/* Report 03-05 Cascading Params and Dynamic Datasets */
/*
This is an expression used for the main dataset

= Switch(Parameters!ReportSource.Value = "Order",
  "SELECT c.[State Province], c.[City], f.[City Key], f.[Customer Key]" &
     ", f.[Stock Item Key], f.[Salesperson Key], f.[Description], f.[Package]" &
     ", f.[Quantity], f.[Unit Price], f.[Tax Rate], f.[Total Excluding Tax]" &
     ", f.[Tax Amount], f.[Total Including Tax]" &
  "  FROM [Fact].[Order] f" &
  "  JOIN [Dimension].[City] c" &
  "    ON f.[City Key] = c.[City Key]" &
  " WHERE c.[City] = '" & Parameters!City.Value & "' " &
  "   AND c.[State Province] = '" & Parameters!State.Value & "' " 
  , Parameters!ReportSource.Value = "Sale",
  "SELECT c.[State Province], c.[City], f.[City Key], f.[Customer Key]" &
     ", f.[Stock Item Key], f.[Salesperson Key], f.[Description], f.[Package]" &
     ", f.[Quantity], f.[Unit Price], f.[Tax Rate], f.[Total Excluding Tax]" &
     ", f.[Tax Amount], f.[Total Including Tax]" &
  "  FROM [Fact].[Sale] f" &
  "  JOIN [Dimension].[City] c" &
  "    ON f.[City Key] = c.[City Key]" &
  " WHERE c.[City] = '" & Parameters!City.Value & "' " &
  "   AND c.[State Province] = '" & Parameters!State.Value & "' " 
  )
*/

/* State Parameter */
SELECT DISTINCT 
       [State Province]
  FROM [Dimension].[City]
 ORDER BY [State Province]

/* City Parameter */
SELECT DISTINCT 
       [City]
  FROM [Dimension].[City]
 WHERE [State Province] = @State
 ORDER BY [City]

