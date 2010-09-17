CREATE PROCEDURE [DSQLT].[@MergeTableWithStatus] 
 @SourceSchema sysname = null
,@SourceTable sysname= null
,@TargetSchema sysname= null
,@TargetTable sysname= null
,@IgnoreColumnList varchar(max)=''
,@UseDefaultValues bit=0
,@Create varchar(max)=null
,@Print bit = 0
as
declare @1 varchar(max) -- Target
declare @2 varchar(max) -- Source
declare @3 varchar(max) -- InsertColumnList
declare @4 varchar(max) -- SelectValueList
declare @5 varchar(max) -- PrimaryKeyCompareExpression
declare @6 varchar(max) -- RecordCompareExpression

set @1 = DSQLT.QuoteNameSB(@TargetSchema+'.'+@TargetTable)
set @2 = DSQLT.QuoteNameSB(@SourceSchema+'.'+@SourceTable)
set @3 = DSQLT.InsertColumnList(@1,'')
set @4 = DSQLT.SelectValueList(@2,@1,'S','')
set @5 = DSQLT.PrimaryKeyCompareExpression(@1,'S','T')
set @6 = DSQLT.RecordCompareExpression(@2,@1,'S','T'
,@UseDefaultValues,@IgnoreColumnList)
exec DSQLT.[Execute] 'DSQLT.@MergeTableWithStatus',@1,@2,@3,@4,@5,@6, @Create=@Create, @Print=@Print
RETURN -- Ab hier beginnt das eigentliche Template
BEGIN
MERGE [@1].[@1] T
USING [@2].[@2] S 
	on (@5=@5)
WHEN MATCHED THEN 
    UPDATE SET DSQLT_SyncRowStatus=case when (@6=@6) then 2 else 0 end
WHEN NOT MATCHED BY TARGET THEN
    INSERT ("@3",DSQLT_SyncRowStatus)
    VALUES ("@4",4)
WHEN NOT MATCHED BY SOURCE THEN
    UPDATE SET DSQLT_SyncRowStatus=1
;
END