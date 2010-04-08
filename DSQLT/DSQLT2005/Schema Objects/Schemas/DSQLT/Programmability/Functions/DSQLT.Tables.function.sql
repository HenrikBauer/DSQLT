﻿--
-- DSQLT by Henrik Bauer
-- OpenSource licensed under Ms-PL (http://www.microsoft.com/opensource/licenses.mspx#Ms-PL)
-- 
-- Description:	List of Tables
--
--------------------------------------------------------
CREATE FUNCTION [DSQLT].[Tables]
(@Pattern nvarchar(max)='')
RETURNS TABLE 
AS
RETURN 
(
select 
S.[Name]+'.'+O.[Name] as SchemaTable
,QUOTENAME(S.[Name])+'.'+QUOTENAME(O.[Name]) as SchemaTableQ
,S.[Name] as [Schema]
,QUOTENAME(S.[Name]) as [SchemaQ]
,O.[Name] as [Table] 
,QUOTENAME(O.[Name]) as [TableQ] 
from sys.tables O
join sys.schemas S on O.schema_id=S.schema_id
WHERE (	S.[Name]+'.'+O.[Name] LIKE '%'+@Pattern+'%'
	or  QUOTENAME(S.[Name])+'.'+QUOTENAME(O.[Name]) LIKE '%'+@Pattern+'%')
)

