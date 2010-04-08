﻿--
-- DSQLT by Henrik Bauer
-- OpenSource licensed under Ms-PL (http://www.microsoft.com/opensource/licenses.mspx#Ms-PL)
-- 
-- Description:	List of Tables
--
--------------------------------------------------------
CREATE FUNCTION [DSQLT].[Views]
(@Pattern nvarchar(max)='')
RETURNS TABLE 
AS
RETURN 
(
select 
S.[Name]+'.'+O.[Name] as SchemaView
,QUOTENAME(S.[Name])+'.'+QUOTENAME(O.[Name]) as SchemaViewQ
,S.[Name] as [Schema]
,QUOTENAME(S.[Name]) as [SchemaQ]
,O.[Name] as [View] 
,QUOTENAME(O.name) as [ViewQ] 
from sys.views O
join sys.schemas S on O.schema_id=S.schema_id
WHERE (	S.[Name]+'.'+O.[Name] LIKE '%'+@Pattern+'%'
	or  QUOTENAME(S.[Name])+'.'+QUOTENAME(O.[Name]) LIKE '%'+@Pattern+'%')
)
