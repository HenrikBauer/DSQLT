﻿
CREATE PROCEDURE [DSQLT].[@Print1Parameter]
	  @p1 NVARCHAR (MAX)=null
	, @Print bit = 0
AS
exec DSQLT.execDSQLTProc '@Print1Parameter' ,@p1,@Print=@Print
RETURN 0
BEGIN
	if '@1' = '"@1"' 	print '@1'
END
