






CREATE PROCEDURE [DSQLT].[@@CopyTable]
	 @Cursor CURSOR VARYING OUTPUT 
	,@Database sysname
	,@Print bit = 0
AS
DECLARE @SourceDB sysname
SET @SourceDB =DB_NAME()
	exec DSQLT.iterateDSQLTProc '@CopyTable',@Cursor,@SourceDB,@Database=@Database,@Print=@Print
RETURN 0







