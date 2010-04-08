CREATE PROCEDURE [Sample].[@@CopyTableContentTo]
	 @Cursor CURSOR VARYING OUTPUT 
	,@Database sysname=null
	,@Print bit = 0
AS
	Declare @Source nvarchar(max)
	set @Source = DB_NAME()
	exec DSQLT.iterateDSQLTProc '[Sample].[@CopyTableContentTo]',@Cursor,@Source,@Database=@Database,@Print=@Print
RETURN 0

