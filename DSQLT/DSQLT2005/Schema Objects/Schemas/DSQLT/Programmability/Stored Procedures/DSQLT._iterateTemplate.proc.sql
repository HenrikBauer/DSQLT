
CREATE PROCEDURE [DSQLT].[_iterateTemplate]
	  @Cursor CURSOR VARYING OUTPUT
	, @p1 NVARCHAR (MAX)=null
	, @p2 NVARCHAR (MAX)=null
	, @p3 NVARCHAR (MAX)=null
	, @p4 NVARCHAR (MAX)=null
	, @p5 NVARCHAR (MAX)=null
	, @p6 NVARCHAR (MAX)=null
	, @p7 NVARCHAR (MAX)=null
	, @p8 NVARCHAR (MAX)=null
	, @p9 NVARCHAR (MAX)=null
	, @Database NVARCHAR (MAX)=null
	, @Template NVARCHAR (MAX)=null OUTPUT
	, @Once bit = 0  -- 0=ausführen, 1 = verketten
	, @Print bit = 0
AS
Begin
DECLARE @TemplateConcat nvarchar(max)
DECLARE @Temp nvarchar(max)
DECLARE @c1 nvarchar(max)
DECLARE @c2 nvarchar(max)
DECLARE @c3 nvarchar(max) 
DECLARE @c4 nvarchar(max)
DECLARE @c5 nvarchar(max)
DECLARE @c6 nvarchar(max)
DECLARE @c7 nvarchar(max)
DECLARE @c8 nvarchar(max)
DECLARE @c9 nvarchar(max)
DECLARE	@Count int

set @TemplateConcat ='' 
set @Temp  ='' 
set	@Count = 0

open @Cursor
while (1=1)
begin
	if @count=0
	BEGIN  -- feststellen der Anzahl Spalten, die vom Cursor zurückgeliefert werden
		begin try 
			set @count=1
			fetch first from @Cursor into @c1
			continue
		end try 
		begin catch
			set @count=2
		end catch
		begin try 
			fetch first from @Cursor into @c1,@c2
			continue
		end try 
		begin catch
			set @count=3
		end catch
		begin try 
			fetch first from @Cursor into @c1,@c2,@c3
			continue
		end try 
		begin catch
			set @count=4
		end catch
		begin try 
			fetch first from @Cursor into @c1,@c2,@c3,@c4
			continue
		end try 
		begin catch
			set @count=5
		end catch
		begin try 
			fetch first from @Cursor into @c1,@c2,@c3,@c4,@c5
			continue
		end try 
		begin catch
			set @count=6
		end catch
		begin try 
			fetch first from @Cursor into @c1,@c2,@c3,@c4,@c5,@c6
			continue
		end try 
		begin catch
			set @count=7
		end catch
		begin try 
			fetch first from @Cursor into @c1,@c2,@c3,@c4,@c5,@c6,@c7
			continue
		end try 
		begin catch
			set @count=8
		end catch
		begin try 
			fetch first from @Cursor into @c1,@c2,@c3,@c4,@c5,@c6,@c7,@c8
			continue
		end try 
		begin catch
			set @count=9
		end catch
		begin try 
			fetch first from @Cursor into @c1,@c2,@c3,@c4,@c5,@c6,@c7,@c8,@c9
			continue
		end try 
		begin catch
		print @count
			-- Spaltenanzahl nicht zwischen 1 und 9
		end catch
		Break  -- erfolglos
	END
	IF (@@FETCH_STATUS <> 0) break  -- alle Datensätze geholt
	SET @Temp=@Template 
	
	IF @Count = 1 exec DSQLT._fillTemplate @c1, @p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@Database,@Template=@Temp OUTPUT
	IF @Count = 2 exec DSQLT._fillTemplate @c1,@c2, @p1,@p2,@p3,@p4,@p5,@p6,@p7,@Database,@Template=@Temp OUTPUT
	IF @Count = 3 exec DSQLT._fillTemplate @c1,@c2,@c3, @p1,@p2,@p3,@p4,@p5,@p6,@Database,@Template=@Temp OUTPUT
	IF @Count = 4 exec DSQLT._fillTemplate @c1,@c2,@c3,@c4, @p1,@p2,@p3,@p4,@p5,@Database,@Template=@Temp OUTPUT
	IF @Count = 5 exec DSQLT._fillTemplate @c1,@c2,@c3,@c4,@c5, @p1,@p2,@p3,@p4,@Database,@Template=@Temp OUTPUT
	IF @Count = 6 exec DSQLT._fillTemplate @c1,@c2,@c3,@c4,@c5,@c6, @p1,@p2,@p3,@Database,@Template=@Temp OUTPUT
	IF @Count = 7 exec DSQLT._fillTemplate @c1,@c2,@c3,@c4,@c5,@c6,@c7, @p1,@p2,@Database,@Template=@Temp OUTPUT
	IF @Count = 8 exec DSQLT._fillTemplate @c1,@c2,@c3,@c4,@c5,@c6,@c7,@c8, @p1,@Database,@Template=@Temp OUTPUT
	IF @Count = 9 exec DSQLT._fillTemplate @c1,@c2,@c3,@c4,@c5,@c6,@c7,@c8,@c9 ,@Database,@Template=@Temp OUTPUT

	-- ausführen oder verketten
	IF @Once=0  -- ausführen / drucken
		exec DSQLT._doTemplate @Database,@Temp,@Print
	-- immer verketten, stört nicht
	SET @TemplateConcat=@TemplateConcat+@Temp+DSQLT.CRLF()

	IF @Count = 1 fetch next from @Cursor into @c1
	IF @Count = 2 fetch next from @Cursor into @c1,@c2
	IF @Count = 3 fetch next from @Cursor into @c1,@c2,@c3
	IF @Count = 4 fetch next from @Cursor into @c1,@c2,@c3,@c4
	IF @Count = 5 fetch next from @Cursor into @c1,@c2,@c3,@c4,@c5
	IF @Count = 6 fetch next from @Cursor into @c1,@c2,@c3,@c4,@c5,@c6
	IF @Count = 7 fetch next from @Cursor into @c1,@c2,@c3,@c4,@c5,@c6,@c7
	IF @Count = 8 fetch next from @Cursor into @c1,@c2,@c3,@c4,@c5,@c6,@c7,@c8
	IF @Count = 9 fetch next from @Cursor into @c1,@c2,@c3,@c4,@c5,@c6,@c7,@c8,@c9
end
close @Cursor
deallocate @Cursor
-- Rückgabe der Verkettung
--IF @Once=1  -- verketten
	SET @Template =@TemplateConcat
	
end
