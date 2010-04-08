
CREATE PROCEDURE [DSQLT].[execDSQLTProc]
	 @DSQLTProc sysname
	, @p1 NVARCHAR (MAX)=null
	, @p2 NVARCHAR (MAX)=null
	, @p3 NVARCHAR (MAX)=null
	, @p4 NVARCHAR (MAX)=null
	, @p5 NVARCHAR (MAX)=null
	, @p6 NVARCHAR (MAX)=null
	, @p7 NVARCHAR (MAX)=null
	, @p8 NVARCHAR (MAX)=null
	, @p9 NVARCHAR (MAX)=null
	, @Database sysname =null
	, @Template NVARCHAR (MAX) =null OUTPUT
	, @Create sysname =null
	, @Print bit = 0
AS
BEGIN
SET NOCOUNT ON
if @Database is null
	SET @Database=DB_NAME()
	
-- Template holen	
if @DSQLTProc is not null  -- es kann auch ein Template direkt übergeben werden
	exec DSQLT._getTemplate @DSQLTProc, @Template OUTPUT
	
-- falls Create , dann mit DDL umfassen
if @Create is not null
	exec DSQLT._addCreateStub @Template OUTPUT,@Database,@Create

-- Parameter ersetzen
exec DSQLT._fillTemplate @p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@Database,@Template=@Template OUTPUT

-- ausführen/drucken
exec DSQLT._doTemplate @Database,@Template,@Print
RETURN 0
END








