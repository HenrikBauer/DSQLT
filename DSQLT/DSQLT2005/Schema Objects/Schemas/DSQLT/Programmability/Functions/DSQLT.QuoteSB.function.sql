--
-- DSQLT by Henrik Bauer
-- OpenSource licensed under Ms-PL (http://www.microsoft.com/opensource/licenses.mspx#Ms-PL)
-- 
-- Description:	Quote text with square brackets.
--
--------------------------------------------------------
CREATE FUNCTION [DSQLT].[QuoteSB] (@Text nvarchar(max))
RETURNS nvarchar(max)
AS
BEGIN
	RETURN [DSQLT].[Quote] (@Text,'[')
END

