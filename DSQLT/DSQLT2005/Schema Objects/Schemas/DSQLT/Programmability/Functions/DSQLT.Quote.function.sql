--
-- DSQLT by Henrik Bauer
-- OpenSource licensed under Ms-PL (http://www.microsoft.com/opensource/licenses.mspx#Ms-PL)
-- 
-- Description:	Embrace text with quotes. Quotes within text get doubled. Special support for braces as quotes.
--
--------------------------------------------------------
CREATE FUNCTION [DSQLT].[Quote] (@Text nvarchar(max) ,@Quote nvarchar(1)='[')
RETURNS nvarchar(max)
AS
BEGIN
	DECLARE @Prefix nchar(1) 
	DECLARE @Postfix nchar(1) 
	
	-- Wollen wir null oder einen Leerstring wirklich Quoten??
	IF len(isnull(@Text,''))=0
		RETURN ''  -- Nein, wir geben lieber Leeren String zurück.
		
	-- Klammerung richtig abarbeiten
	IF @Quote='['
		SET @Quote=']'
	SET @Prefix=@Quote
	SET @Postfix=@Quote
	IF @Quote=']'
		SET @Prefix='['
	-- Nur, wenn nicht bereits gequoted
	IF DSQLT.isQuoted(@Text,@Quote)=0
		SET @Text=@Prefix+REPLACE(@Text,@Quote,@Quote+@Quote)+@Postfix
	
	RETURN @Text
END

