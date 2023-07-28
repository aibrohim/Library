----- GET PUBLISHERS ------
create proc GetPublishers
as 
begin
	SELECT
		Id,
		Name
	FROM Publisher
end
GO
----- GET STUDENTS ------
create proc GetStudents
as 
begin
	SELECT
		Id,
		FirstName,
		LastName
	FROM Student
end
GO
----- GET ROOMS ------
create proc GetRooms
as 
begin
	SELECT
		Id,
		Name
	FROM Room
end
GO
----- GET CATEGORIES ------
create proc GetCategories
as 
begin
	SELECT
		Id,
		Name
	FROM Category
end
GO
---------- CRUD -----------
----- GET BOOKS ------
create proc GetBooks
as 
begin
	SELECT
		Book.Id as Id,
		Book.Title as Title,
		Book.ISBN as ISBN,
		Book.PagesCount as PagesCount,
		Book.ShelfNum as ShelfNum,
		Book.IsAvailable as IsAvailable,
		Book.PublishedDate as PublishedDate,
		Publisher.Id as PublisherId,
		Publisher.Name as PublisherName,
		Category.Id as CategoryId,
		Category.Name as CategoryName,
		Room.Id as RoomId,
		Room.Name as RoomName,
		Student.Id as StudentId,
		Student.FirstName as StudentFirstName,
		Student.LastName as StudentLastName
	FROM Book
	LEFT JOIN Publisher 
		On Book.PublisherId = Publisher.Id
	LEFT JOIN Category
		on Book.CategoryId = Category.Id
	LEFT JOIN Room
		on Book.RoomId = Room.Id
	LEFT JOIN Student On Book.StudentId = Student.Id
end
GO
----- GET BOOK BY ID ------
create proc GetBookById @Id int
as 
begin
	SELECT
		Book.Id as Id,
		Book.Title as Title,
		Book.ISBN as ISBN , 
		Book.PagesCount as PagesCount,
		Book.ShelfNum as ShelfNum,
		Book.IsAvailable as IsAvailable,
		Book.PublishedDate as PublishedDate,
		Publisher.Id as PublisherId,
		Publisher.Name as PublisherName,
		Student.Id as StudentId,
		Student.FirstName as StudentFirstName,
		Student.LastName as StudentLastName,
		Category.Id as CategoryId,
		Category.Name as CategoryName,
		Room.Id as RoomId,
		Room.Name as RoomName
	FROM Book
	LEFT JOIN Publisher
		On Book.PublisherId = Publisher.Id
	LEFT JOIN Category
		on Book.CategoryId = Category.Id
	LEFT JOIN Room
		on Book.RoomId = Room.Id
	LEFT JOIN Student
		On Book.StudentId = Student.Id
	Where Book.Id = @Id
end
GO
----- FILTER BOOKS ------
--drop proc GetFiltredBooks
-- CREATE INDEX index_book ON Book 
/* 
	Creates an index for book to optimize search engines. 
	Especially, in the case of many filters
*/
create proc GetFiltredBooks
	@Title nvarchar(50),
	@Room int,
	@Publisher int,
	@Category int,
	@SortColumn varchar(300),
	@SortDesc bit,
	@Page int,
	@PageSize int 
as 
	declare @sqlTemplate nvarchar(2000) = 'SELECT
												Book.Id as Id,
												Book.Title as Title,
												Book.ISBN as ISBN,
												Book.PagesCount as PagesCount,
												Book.ShelfNum as ShelfNum,
												Book.IsAvailable as IsAvailable,
												Book.PublishedDate as PublishedDate,
												Publisher.Id as PublisherId,
												Publisher.Name as PublisherName,
												Category.Id as CategoryId,
												Category.Name as CategoryName,
												Room.Id as RoomId,
												Room.Name as RoomName,
												Student.Id as StudentId,
												Student.FirstName as StudentFirstName,
												Student.LastName as StudentLastName,
												count(*) over() TotalRowsCount
											FROM Book
											LEFT JOIN Publisher 
												On Book.PublisherId = Publisher.Id
											LEFT JOIN Category
												on Book.CategoryId = Category.Id
											LEFT JOIN Room
												on Book.RoomId = Room.Id
											LEFT JOIN Student On Book.StudentId = Student.Id
											WHERE
												Book.Title like coalesce(@Title, '''') + ''%''
												AND
												(@Publisher is null OR book.PublisherId = coalesce(@Publisher,0))
												AND
												(@Category is null OR book.CategoryId = coalesce(@Category,0))
												AND
												(@Room is null OR book.RoomId = coalesce(@Room,0))
											ORDER BY {0}
											offset @OffsetRows rows
											fetch next @PageSize rows only'
	declare @sqlParams nvarchar(1000) = ' @Title nvarchar(50), 
										@Room int,
										@Publisher int,
										@Category int,
										@OffsetRows int,
										@PageSize int'
begin
	declare @sqlOrderBy nvarchar(300) 
	if @SortColumn = 'BookId'
	  set @sqlOrderBy = 'Book.Id'
	else if @SortColumn = 'Title'
	  set @sqlOrderBy = 'Book.Title'
	else if @SortColumn = 'PublishedDate'
	  set @sqlOrderBy = 'Book.PublishedDate'
	else 
	  set @sqlOrderBy = 'Book.Id'
	
	if @SortDesc = 1
		set @sqlOrderBy = @sqlOrderBy + ' DESC '

	declare @sql nvarchar(2000) = replace(@sqlTemplate, '{0}', @sqlOrderBy)
	
	declare @Offset int = (@Page-1)*@PageSize
	exec sp_executesql @sql, @sqlParams,
			@Title = @Title,
			@Room = @Room,
			@Publisher = @Publisher,
			@Category = @Category,
			@OffsetRows = @Offset,
			@PageSize = @PageSize
	
end
GO
----- INSERT BOOKS ------
create proc InsertBook
	@Title nvarchar(255),
	@ISBN nvarchar(255),
	@PagesCount int,
	@ShelfNum nvarchar(5),
	@PublishedDate date,
	@PublisherId int,
	@CategoryId int,
	@RoomId int,
	@IsAvailable bit,
	@BookId int OUT,
	@Errors varchar(1000) OUT
as 
begin
	begin try
		INSERT INTO Book (
			Title,
			ISBN,
			PagesCount,
			ShelfNum,
			PublishedDate,
			PublisherId,
			CategoryId,
			RoomId,
			IsAvailable
		) 
		VALUES (
			@Title,
			@ISBN,
			@PagesCount,
			@ShelfNum,
			@PublishedDate,
			@PublisherId,
			@CategoryId,
			@RoomId,
			@IsAvailable
		)
		SELECT @BookId = SCOPE_IDENTITY()
	end try
	begin catch
		select @Errors = ERROR_MESSAGE()
		return (1)
	  end catch
	  return (0)
end
GO
----- UPDATE BOOKS ------
create proc UpdateBook
	@Id int OUT,
	@Title nvarchar(255),
	@ISBN nvarchar(255),
	@PagesCount int,
	@ShelfNum nvarchar(20),
	@PublishedDate date,
	@PublisherId int,
	@StudentId int,
	@CategoryId int,
	@RoomId int,
	@IsAvailable bit,
	@Errors varchar(1000) OUT
as 
begin
	begin try
		UPDATE Book SET 
			Title = @Title,
			ISBN = @ISBN,
			PagesCount = @PagesCount,
			ShelfNum = @ShelfNum,
			PublishedDate = @PublishedDate,
			PublisherId = @PublisherId,
			RoomId = @RoomId,
			CategoryId = @CategoryId,
			StudentId = @StudentId,
			IsAvailable = @IsAvailable
		WHERE Id = @Id
	end try
	begin catch
		SET @Errors = ERROR_MESSAGE()
		return (1)
	end catch
	return (0)
end
GO
----- DELETE BOOKS ------
GO
create proc DeleteBook
	@Id int,
	@Errors varchar(1000) OUT
as 
begin
	begin try
		DELETE FROM BOOK WHERE Id = @Id 
	end try
		begin catch
			SET @Errors = ERROR_MESSAGE()
			return (1)
		end catch
		return (0)
end
GO


---------- EXPORT ------------
----- EXPORT TO JSON ------
/* 
	Creates an index for book to optimize search engines. 
	Especially, in the case of many filters
*/
create or alter proc exportBookToJSON
	@Title nvarchar(50),
	@Room int,
	@Publisher int,
	@Category int,
	@SortColumn varchar(300),
	@SortDesc bit,
	@Page int,
	@PageSize int 
as
declare @tab as table (
	Id int,
	Title nvarchar(255),
	ISBN nvarchar(255),
	PagesCount int,
	ShelfNum nvarchar(5),
	IsAvailable bit,
	PublishedDate date,
	PublisherId int,
	PublisherName nvarchar(255),
	CategoryId int,
	CategoryName nvarchar(255),
	RoomId int,
	RoomName nvarchar(255),
	StudentId int,
	StudentFirstName nvarchar(255),
	StudentLastName nvarchar(255),
	TotalRowsCount int
)
begin
  insert into @tab
  exec GetFiltredBooks @Title=@Title, @Room=@Room,@Publisher=@Publisher,@Category=@Category,
									@SortColumn=@SortColumn , @SortDesc = @SortDesc,
									@Page=@Page, @PageSize=@PageSize
   select Id, Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable from @tab
   for json auto
end
go
----- EXPORT TO XML ------
create or alter proc exportBookToXML
	@Title nvarchar(50),
	@Room int,
	@Publisher int,
	@Category int,
	@SortColumn varchar(300),
	@SortDesc bit,
	@Page int,
	@PageSize int 
as
declare @tab as table (
	Id int,
	Title nvarchar(255),
	ISBN nvarchar(255),
	PagesCount int,
	ShelfNum nvarchar(5),
	IsAvailable bit,
	PublishedDate date,
	PublisherId int,
	PublisherName nvarchar(255),
	CategoryId int,
	CategoryName nvarchar(255),
	RoomId int,
	RoomName nvarchar(255),
	StudentId int,
	StudentFirstName nvarchar(255),
	StudentLastName nvarchar(255),
	TotalRowsCount int
)
begin
  insert into @tab
  exec GetFiltredBooks @Title=@Title, @Room=@Room,@Publisher=@Publisher,@Category=@Category,
									@SortColumn=@SortColumn , @SortDesc = @SortDesc,
									@Page=@Page, @PageSize=@PageSize
   select Id, Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable from @tab
   for xml path('BookRow'), root('Books')
end
go

---------- IMPORT ------------
----- IMPORT FROM XML ------
create or alter procedure importXml(@xmlStr nvarchar(max), @generatePKs bit)
as 
begin
	declare @xmlDoc int
	exec sp_xml_preparedocument @xmlDoc OUT, @xmlStr

	if @generatePKs = 0
	 begin
	    --use PK values from the XML
		set identity_insert Book on
		insert into Book (Id, Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable)
		select Id, Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable
		from OPENXML(@xmlDoc, N'/Books/BookRow', 2/*tag-centic mapping*/) 
			 WITH (
			   Id int,
			   Title varchar(255),
			   ISBN varchar(255),
			   PagesCount int,
			   PublishedDate date,
			   ShelfNum nvarchar(5),
			   IsAvailable bit
			 )
		set identity_insert book off
	 end
	else
	 begin
	    	insert into book (Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable)
		select Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable
		from OPENXML(@xmlDoc, N'/Books/BookRow', 2/*tag-centic mapping*/) 
		     WITH (
				Title varchar(255),
			   ISBN varchar(255),
			   PagesCount int,
			   PublishedDate date,
			   ShelfNum nvarchar(5),
			   IsAvailable bit
			 )
	 end	

	 exec sp_xml_removedocument @xmlDoc  
end
GO
----- IMPORT FROM JSON ------
create or alter procedure importJSON(@jsonStr nvarchar(max), @generatePKs bit)
as
begin 
    if @generatePKs = 0
	 begin
	    --use PK values from the JSON
		set identity_insert Book on
		insert into Book (Id, Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable)
		select Id, Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable
		from OPENJSON(@jsonStr, '$.Books') 
			 WITH (
			   Id int,
			   Title varchar(255),
			   ISBN varchar(255),
			   PagesCount int,
			   PublishedDate date,
			   ShelfNum nvarchar(5),
			   IsAvailable bit
			 )
		set identity_insert book off
	 end
	else
	 begin
	    	insert into book (Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable)
		select Title, ISBN, PagesCount, PublishedDate, ShelfNum, IsAvailable
		from OPENJSON(@jsonStr, '$.Books') 
		     WITH (
				Title varchar(255),
				ISBN varchar(255),
				PagesCount int,
				PublishedDate date,
				ShelfNum nvarchar(5),
				IsAvailable bit
			 )
	 end
end
GO
----- IMPORT FROM CSV ------
create or alter procedure importCSV(@csvStr nvarchar(max)) 
as
begin
	set identity_insert book on;
	with r as (
		select trim(value) csvLine
		from string_split(@csvStr, char(13))
		where trim(value) <> ''
	)
	,splitted as  (
		select *
			, value as id
			, lead(value, 1) over(partition by csvLine order by csvLine) as Title
			, lead(value, 2) over(partition by csvLine order by csvLine) as ISBN
			, lead(value, 3) over(partition by csvLine order by csvLine) as PagesCount
			, lead(value, 4) over(partition by csvLine order by csvLine) as IsAvailable
			, lead(value, 5) over(partition by csvLine order by csvLine) as PublishedDate
			, lead(value, 6) over(partition by csvLine order by csvLine) as ShelfNum
			, row_number() over(partition by csvLine order by csvLine) as idx 
		from r cross apply string_split(csvLine, ',')
	)
	insert into Book(id, Title, ISBN, PagesCount, IsAvailable, PublishedDate, ShelfNum)
	select convert(int,id), Title, ISBN, convert(int,PagesCount), IsAvailable, convert(date, PublishedDate), ShelfNum
	from splitted
	where idx = 1

	set identity_insert book off;
end
