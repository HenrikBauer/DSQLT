









CREATE Proc [DSQLT].[_generateSchema]
	@Database sysname
	, @Schema sysname
	, @Print bit=0
as
BEGIN
-- Schema erzeugen, falls noch nicht existiert
exec DSQLT.[@CreateSchema] @Database,@Schema,@Print
-- alle Tabellen erzeugen
declare @Cursor CURSOR ; SET @Cursor= CURSOR LOCAL STATIC FOR 
	select @Schema,ParameterQ from [DSQLT].[Digits] (1,9)
exec DSQLT.[@@GenerateTable] @Cursor,@Database=@Database,@Print=@Print
	
END










