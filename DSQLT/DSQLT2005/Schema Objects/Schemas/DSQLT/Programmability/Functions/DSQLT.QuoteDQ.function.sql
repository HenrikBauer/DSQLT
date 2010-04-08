--
-- DSQLT by Henrik Bauer
-- OpenSource licensed under Ms-PL (http://www.microsoft.com/opensource/licenses.mspx#Ms-PL)
-- 
-- Description:	Embrace text with double quote.
--
--------------------------------------------------------
create FUNCTION [DSQLT].[QuoteDQ] (@Text nvarchar(max))
RETURNS nvarchar(max)
AS
BEGIN
	RETURN [DSQLT].[Quote] (@Text,'"')
END





