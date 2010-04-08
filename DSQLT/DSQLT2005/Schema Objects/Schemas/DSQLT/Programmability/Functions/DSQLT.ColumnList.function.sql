--
-- DSQLT by Henrik Bauer
-- OpenSource licensed under Ms-PL (http://www.microsoft.com/opensource/licenses.mspx#Ms-PL)
-- 
-- Description:	Commaseparated List of Columns
--
--------------------------------------------------------
CREATE FUNCTION [DSQLT].[ColumnList]
(@Table NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
BEGIN
	DECLARE @Result nvarchar(max)
	SET @Result=''
	-- mit Order by funktioniert das rekursive String-verketten nicht => 
	select @Result=DSQLT.Concat(ColumnQ,' , ',@Result)
	from (select Top 100 PERCENT * from DSQLT.Columns(@Table) order by [Order]) X

	RETURN @Result
END









