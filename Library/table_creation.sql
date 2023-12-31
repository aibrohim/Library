USE [master]
GO
/****** Object:  Database [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF]    Script Date: 4/5/2023 8:52:19 PM ******/
CREATE DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library', FILENAME = N'E:\Users\00012460\Downloads\Library\Library\AppData\Library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'E:\Users\00012460\Downloads\Library\Library\AppData\Library.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET ANSI_NULLS ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET ANSI_PADDING ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET ARITHABORT ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET  DISABLE_BROKER 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET RECOVERY FULL 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET  MULTI_USER 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET DB_CHAINING OFF 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET DELAYED_DURABILITY = DISABLED 
GO
USE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[img] [varbinary](max) NULL,
	[title] [nvarchar](255) NOT NULL,
	[isbn] [nvarchar](255) NOT NULL,
	[PagesCount] [int] NOT NULL,
	[PublishedDate] [date] NOT NULL,
	[StudentId] [int] NULL,
	[IsAvailable] [bit] NOT NULL,
	[ShelfNum] [nvarchar](5) NOT NULL,
	[CategoryId] [int] NULL,
	[RoomId] [int] NULL,
	[PublisherId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookAuthor]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookAuthor](
	[BookId] [int] NOT NULL,
	[AuthorId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NOT NULL,
	[DateOfBirth] [date] NULL,
	[IsMarried] [bit] NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Img] [varbinary](255) NULL,
	[Phone] [nvarchar](13) NULL,
	[Address] [nvarchar](13) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY([PublisherId])
REFERENCES [dbo].[Publisher] ([Id])
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([Id])
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[BookAuthor]  WITH CHECK ADD FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Author] ([id])
GO
ALTER TABLE [dbo].[BookAuthor]  WITH CHECK ADD FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([id])
GO
/****** Object:  StoredProcedure [dbo].[DeleteBook]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------
create proc [dbo].[DeleteBook]
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
/****** Object:  StoredProcedure [dbo].[exportBookToJSON]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------
create   proc [dbo].[exportBookToJSON]
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
GO
/****** Object:  StoredProcedure [dbo].[exportBookToXML]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
create   proc [dbo].[exportBookToXML]
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
GO
/****** Object:  StoredProcedure [dbo].[GetBookById]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetBookById] @Id int
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
/****** Object:  StoredProcedure [dbo].[GetBooks]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetBooks]
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
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------
create proc [dbo].[GetCategories]
as 
begin
	SELECT
		Id,
		Name
	FROM Category
end
GO
/****** Object:  StoredProcedure [dbo].[GetFiltredBooks]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------
--drop proc GetFiltredBooks
create proc [dbo].[GetFiltredBooks]
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
/****** Object:  StoredProcedure [dbo].[GetPublishers]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*DROP PROCEDURE [dbo].[GetRooms];
DROP PROCEDURE [dbo].[GetBooks];
DROP PROCEDURE [dbo].[GetCategories];
DROP PROCEDURE [dbo].[GetPublishers];
DROP PROCEDURE [dbo].[GetStudents];
DROP PROCEDURE [dbo].[GetBooks];
DROP PROCEDURE [dbo].[DeleteBook];
DROP PROCEDURE [dbo].[InsertBook];
DROP PROCEDURE [dbo].[UpdateBook];
DROP PROCEDURE [dbo].[GetBookById]; */
 
create proc [dbo].[GetPublishers]
as 
begin
	SELECT
		Id,
		Name
	FROM Publisher
end
GO
/****** Object:  StoredProcedure [dbo].[GetRooms]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------
create proc [dbo].[GetRooms]
as 
begin
	SELECT
		Id,
		Name
	FROM Room
end
GO
/****** Object:  StoredProcedure [dbo].[GetStudents]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------
create proc [dbo].[GetStudents]
as 
begin
	SELECT
		Id,
		FirstName,
		LastName
	FROM Student
end
GO
/****** Object:  StoredProcedure [dbo].[importCSV]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------IMPORT CSV---------------------
create   procedure [dbo].[importCSV](@csvStr nvarchar(max)) 
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
----------Trigger to store book changes dates ---------------------
GO
/****** Object:  StoredProcedure [dbo].[importJSON]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------IMPORT JSON---------------------
create   procedure [dbo].[importJSON](@jsonStr nvarchar(max), @generatePKs bit)
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
/****** Object:  StoredProcedure [dbo].[importXml]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   procedure [dbo].[importXml](@xmlStr nvarchar(max), @generatePKs bit)
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
/****** Object:  StoredProcedure [dbo].[InsertBook]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[InsertBook]
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
/****** Object:  StoredProcedure [dbo].[UpdateBook]    Script Date: 4/5/2023 8:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------
create proc [dbo].[UpdateBook]
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
USE [master]
GO
ALTER DATABASE [E:\USERS\00012460\DOWNLOADS\LIBRARY\LIBRARY\APPDATA\LIBRARY.MDF] SET  READ_WRITE 
GO
