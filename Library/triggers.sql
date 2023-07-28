----------- TRIGGER: Checking maximum number of books on updating student ----------------
create trigger max_books_per_student_limit_check
on Book
after update, insert
as
begin
  declare @cnt int
  select @cnt = count(*) from Book where StudentId = (select StudentId from inserted)
  if @cnt > 5
  begin
	rollback transaction;
	throw 50001, 'Max number of books per student is 5!', 1;
  end
end
----------- TRIGGER: DELETE BOOK ----------------
CREATE TRIGGER book_delete_check
	ON [dbo].book AFTER DELETE
	AS 
	BEGIN 
	IF datepart(hour, getdate()) >= 17
	BEGIN
	  ROLLBACK TRANSACTION;
	  THROW 51000, N'Operation not allowed! Deleting from 17:00 is not allowed', 1;              
	END
END
GO