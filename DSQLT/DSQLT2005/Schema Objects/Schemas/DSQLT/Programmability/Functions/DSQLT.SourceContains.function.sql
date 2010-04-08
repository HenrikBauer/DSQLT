﻿--
-- DSQLT by Henrik Bauer
-- OpenSource licensed under Ms-PL (http://www.microsoft.com/opensource/licenses.mspx#Ms-PL)
-- 
-- Description:	List of Objects (system objects included) where Sourcecode contains @Pattern
--
--------------------------------------------------------
CREATE FUNCTION [DSQLT].[SourceContains]
(@Pattern nvarchar(max)='')
RETURNS TABLE 
AS
RETURN 
(
select 
S.name+'.'+O.name as SchemaProgram
,QUOTENAME(S.name)+'.'+QUOTENAME(O.name) as SchemaProgramQ
,s.name as [Schema]
,QUOTENAME(S.name) as [SchemaQ]
,o.name as [Program] 
,QUOTENAME(O.name) as [ProgramQ] 
,o.[type] 
,o.type_desc 
,m.definition
from sys.sql_modules m
join sys.objects o on m.object_id=o.object_id
join sys.schemas s on o.schema_id=s.schema_id
where m.definition like '%'+@Pattern+'%'
)