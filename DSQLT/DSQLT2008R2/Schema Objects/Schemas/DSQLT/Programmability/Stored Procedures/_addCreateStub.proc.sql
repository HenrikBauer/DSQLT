﻿CREATE PROCEDURE [DSQLT].[_addCreateStub]
@Template NVARCHAR (MAX) OUTPUT, @Database NVARCHAR (MAX), @Create NVARCHAR (MAX), @CreateParam NVARCHAR (MAX)=''
AS
BEGIN
declare	@Command NVARCHAR (max)
declare	@Schema NVARCHAR (max) 
declare	@Object NVARCHAR (max)
declare @rc int
-- Namen in Schema und Objekt zerlegen
set	@Command ='CREATE'
set @Schema=isnull(PARSENAME(@Create,2),'dbo')
set @Object=PARSENAME(@Create,1)
-- Prüfen, ob Zielobjekt existiert
exec @rc=DSQLT.[@isProc] @Database,@Schema,@Object
if @rc=1  
	SET @Command='ALTER'

-- DDL Vorspann + Name
SET @Command=@Command+' PROCEDURE ' + @Create+[DSQLT].[CRLF]()
-- Parameter
IF LEN(@CreateParam) > 0
	SET @Command=@Command+@CreateParam+[DSQLT].[CRLF]()
-- Body
SET @Template=@Command+
 + 'AS'+[DSQLT].[CRLF]()
 + 'BEGIN'+[DSQLT].[CRLF]()
 + @Template+[DSQLT].[CRLF]()
 + 'END'+[DSQLT].[CRLF]()
RETURN
END
