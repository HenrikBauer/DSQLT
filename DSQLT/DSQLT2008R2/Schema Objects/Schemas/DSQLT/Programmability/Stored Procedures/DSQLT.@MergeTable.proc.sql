﻿
CREATE PROCEDURE [DSQLT].[@MergeTable] 
 @SourceSchema sysname = null
,@SourceTable sysname= null
,@TargetSchema sysname= null
,@TargetTable sysname= null
,@PrimaryKeySchema sysname=null
,@PrimaryKeyTable sysname=null
,@IgnoreColumnList varchar(max)=null
,@UseDefaultValues bit=0
,@Create varchar(max)=null
,@Print bit = 0
as
declare @1 varchar(max) -- Target
declare @2 varchar(max) -- Source
declare @3 varchar(max) -- TargetColumnList
declare @4 varchar(max) -- SourceValueList
declare @5 varchar(max) -- PrimaryKeyComparison
declare @6 varchar(max) -- DifferenceComparison
declare @7 varchar(max) -- TargetUpdateList
declare @PKTable varchar(max)   -- Tabelle mit Primärkeydefinition

set @1 = DSQLT.QuoteNameSB(@TargetSchema+'.'+@TargetTable)
set @2 = DSQLT.QuoteNameSB(@SourceSchema+'.'+@SourceTable)
set @PKTable = DSQLT.QuoteNameSB(@PrimaryKeySchema+'.'+@PrimaryKeyTable)
if @PKTable is null SET @PKTable=@1
set @3 = DSQLT.InsertColumnList(@1,'')
set @4 = DSQLT.SelectValueList(@2,@1,'S','')
set @5 = DSQLT.PrimaryKeyCompareExpression(@PKTable,'S','T')
set @6 = DSQLT.RecordCompareExpression(@2,@1,'S','T',@UseDefaultValues,@IgnoreColumnList)
set @7 = DSQLT.UpdateColumnList(@2,@1,'S',@IgnoreColumnList)
exec DSQLT.[Execute] 'DSQLT.@MergeTable',@1,@2,@3,@4,@5,@6,@7, @Create=@Create, @Print=@Print
RETURN -- Ab hier beginnt das eigentliche Template
BEGIN
MERGE [@1].[@1] T
USING [@2].[@2] S 
	on (@5=@5)
WHEN MATCHED and (@6=@6) THEN 
    UPDATE SET @7=@7  
WHEN NOT MATCHED BY TARGET THEN
    INSERT ("@3")
    VALUES ("@4")
WHEN NOT MATCHED BY SOURCE THEN
    DELETE
;
END