﻿CREATE PROCEDURE [DSQLT].[_error]
@Msg NVARCHAR (MAX)=''
AS
BEGIN
SET @Msg='DSQLT ERROR : '+@Msg
print @Msg
END
