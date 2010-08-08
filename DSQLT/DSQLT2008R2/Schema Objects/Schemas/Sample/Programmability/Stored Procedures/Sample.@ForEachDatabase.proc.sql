﻿

CREATE proc [Sample].[@ForEachDatabase] as
declare @Cursor CURSOR ; SET @Cursor= CURSOR LOCAL STATIC FOR 
	select * from dsqlt.databases('%')
exec DSQLT.iterate 'Sample.[@ForEachDatabase]',@Cursor=@Cursor,@Database='@1'
RETURN 
BEGIN
print '@0'
END