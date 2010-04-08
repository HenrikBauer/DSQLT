CREATE PROCEDURE [Sample].[@@CopyTableContentFrom]
	 @Cursor CURSOR VARYING OUTPUT 
	,@Database sysname=null
	,@Print bit = 0
AS
	if @Database is null SET @Database=DB_NAME()
	exec DSQLT.iterateDSQLTProc '[Sample].[@CopyTableContentFrom]',@Cursor,@Database,@Print=@Print
RETURN 0

