--
-- DSQLT by Henrik Bauer
-- OpenSource licensed under Ms-PL (http://www.microsoft.com/opensource/licenses.mspx#Ms-PL)
-- 
-- Description:	List of Databases, filtered by @Pattern
--
--------------------------------------------------------
CREATE FUNCTION [DSQLT].[Databases]
(@Pattern nvarchar(max)='')
RETURNS TABLE 
AS
RETURN 
(
select 
S.name as [Database]
,QUOTENAME(S.name) as DatabaseQ
from sys.databases S 
where S.name LIKE '%'+@Pattern+'%'
or  QUOTENAME(S.name) LIKE '%'+@Pattern+'%')









