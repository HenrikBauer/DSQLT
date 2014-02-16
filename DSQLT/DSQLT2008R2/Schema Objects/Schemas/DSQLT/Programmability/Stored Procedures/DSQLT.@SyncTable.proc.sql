﻿
CREATE PROCEDURE [DSQLT].[@SyncTable] 
 @SourceSchema sysname = null
,@SourceTable sysname= null
,@TargetSchema sysname= null
,@TargetTable sysname= null
,@PrimaryKeySchema sysname=null
,@PrimaryKeyTable sysname=null
,@IgnoreColumnList varchar(max)=''
,@UseDefaultValues bit=0
,@Create varchar(max)=null
,@UseTransaction bit = 0
,@Print bit = 0
as
declare @1 varchar(max) -- Target
declare @2 varchar(max) -- Source
declare @3 varchar(max) -- InsertColumnList
declare @4 varchar(max) -- SelectValueList
declare @5 varchar(max) -- PrimaryKeyCompareExpression
declare @6 varchar(max) -- RecordCompareExpression
declare @7 varchar(max) -- UpdateColumnList
declare @8 varchar(max) -- Primärkeyfeld für Existenzprüfung
declare @PKTable varchar(max)   -- Tabelle mit Primärkeydefinition

IF @SourceSchema is not null
	set @SourceTable=@SourceSchema+'.'+@SourceTable
	
IF @TargetSchema is not null
	set @TargetTable=@TargetSchema+'.'+@TargetTable
	
IF @PrimaryKeySchema is not null
	set @PrimaryKeyTable=@PrimaryKeySchema+'.'+@PrimaryKeyTable
	
set @1 = DSQLT.QuoteNameSB(@TargetTable)
set @2 = DSQLT.QuoteNameSB(@SourceTable)
set @PKTable = DSQLT.QuoteNameSB(@PrimaryKeyTable)

-- Prüfen, wer einen PK definiert hat
if @PKTable is null 
	SET @PKTable=@1  -- vielleicht Target??

DECLARE @c int
SELECT @c=count(*) from [DSQLT].[Columns] (@PKTable) where is_primary_key=1
IF @c=0
	SET @PKTable=@2  -- vielleicht Source??
	
SELECT @c=count(*) from [DSQLT].[Columns] (@PKTable) where is_primary_key=1
IF @c=0
	RETURN -1 -- FEhler

set @3 = DSQLT.InsertColumnList(@1,'')
set @4 = DSQLT.SelectValueList(@2,@1,'S','')
set @5 = DSQLT.PrimaryKeyCompareExpression(@PKTable,'S','T')
set @6 = DSQLT.RecordCompareExpression(@2,@1,'S','T',@UseDefaultValues,@IgnoreColumnList)
set @7 = DSQLT.UpdateColumnList(@2,@1,'S',@IgnoreColumnList)
set @8 = (Select TOP 1 ColumnQ from [DSQLT].[Columns] (@PKTable) where is_primary_key=1 order by [Order])

exec DSQLT.[Execute] 'DSQLT.@SyncTable',@1,@2,@3,@4,@5,@6,@7,@8, @Create=@Create, @UseTransaction=@UseTransaction, @Print=@Print

RETURN -- Ab hier beginnt das eigentliche Template
BEGIN
DECLARE @TimeStamp datetime
SELECT @TimeStamp=GETDATE()

--MERGE [@1].[@1] T
--USING [@2].[@2] S 
--	on (@5=@5)
--WHEN MATCHED and (@6=@6 or T.DSQLT_SyncRowIsDeleted=1) THEN 
--    UPDATE SET @7=@7, DSQLT_SyncRowModified=@TimeStamp,DSQLT_SyncRowIsDeleted=0
--WHEN NOT MATCHED BY TARGET THEN
--    INSERT ("@3",DSQLT_SyncRowCreated,DSQLT_SyncRowModified,DSQLT_SyncRowIsDeleted)
--    VALUES ("@4",@TimeStamp,@TimeStamp,0)
--WHEN NOT MATCHED BY SOURCE THEN
--    UPDATE SET DSQLT_SyncRowModified=@TimeStamp,DSQLT_SyncRowIsDeleted=1
;

-- Löschungen
-- nicht mehr vorhandene Datensätze markieren
update [@1].[@1] 
set DSQLT_SyncRowModified=@TimeStamp
,	DSQLT_SyncRowIsDeleted = 1
from [@1].[@1] T
left outer join [@2].[@2] S 
	on (@5=@5)
where S.[@8] is null and T.DSQLT_SyncRowIsDeleted=0  

-- Änderungen 
-- entweder relevante Feldänderungen oder gelöschte Sätze wieder da
update [@1].[@1] 
set @7=@7, DSQLT_SyncRowModified=@TimeStamp,DSQLT_SyncRowIsDeleted=0 
from [@1].[@1] T
join [@2].[@2] S 
	on (@5=@5)
where (@6=@6) or T.DSQLT_SyncRowIsDeleted=1

-- Inserts
insert into [@1].[@1]
("@3",DSQLT_SyncRowCreated,DSQLT_SyncRowModified,DSQLT_SyncRowIsDeleted)
select @4 ,@TimeStamp,@TimeStamp,0
from [@1].[@1] T
right outer join [@2].[@2] S 
	on (@5=@5)
where T.[@8] is null

END