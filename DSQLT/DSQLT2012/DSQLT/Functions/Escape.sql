﻿CREATE FUNCTION [DSQLT].[Escape]
(@Text NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
BEGIN
	RETURN REPLACE(REPLACE(REPLACE(@Text,'[','[[]'),'%','[%]'),'_','[_]')
END
