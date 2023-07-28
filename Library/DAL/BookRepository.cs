using Dapper;
using Library.Models;
using Microsoft.AspNetCore.Mvc.ApplicationModels;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.Security.Policy;
using System.Threading.Tasks;

namespace Library.DAL
{
    public class BookRepository : IBookRepository
    {
        private readonly string _connString;
        public BookRepository(string connString)
        {
            _connString = connString;
        }

        public void Delete(int id)
        {
            using var conn = new SqlConnection(_connString);
            var p = new DynamicParameters();

            p.Add("Id", id);
            p.Add("Errors", direction: System.Data.ParameterDirection.Output,
                dbType: System.Data.DbType.String, size: 1000);
            conn
                .Execute("DeleteBook",
                                 commandType: System.Data.CommandType.StoredProcedure, param: p);
            string errors = p.Get<string>("Errors");
        }

        public IList<Book> GetAll()
        {
            using var conn = new SqlConnection(_connString);
            return conn
                .Query<Book>("GetBooks",
                                 commandType: System.Data.CommandType.StoredProcedure)
                .AsList();
        }
        public IList<Book> Filter(
            string title, int? publisherId, int? categoryId, int? roomId,
            out int totalRows, int page = 1, int pageSize = 10,
            string sortColumn = "BookId", bool sortDesc = false
        )
        {
            if (page <= 0)
                page = 1;

            using var conn = new SqlConnection(_connString);
            var books = conn
                .Query<Book>("GetFiltredBooks",
                                 commandType: System.Data.CommandType.StoredProcedure, param: new {
                                    Title = title,
                                    Room = roomId,
                                    Publisher = publisherId,
                                    Category = categoryId,
                                    SortColumn = sortColumn,
                                    SortDesc = sortDesc,
                                    Page = page,
                                    PageSize = pageSize
                                 });
            totalRows = books.FirstOrDefault()?.TotalRowsCount ?? 0;
            
            return books.AsList();
        }

        public Book GetById(int id)
        {
            using var conn = new SqlConnection(_connString);
            return conn
                .QueryFirstOrDefault<Book>("GetBookById",
                                new { Id = id},
                                 commandType: System.Data.CommandType.StoredProcedure);
        }

        public int Insert(Book book)
        {
            using var conn = new SqlConnection(_connString);
            var p = new DynamicParameters();

            p.Add("Title", book.Title);
            p.Add("ISBN", book.ISBN);
            p.Add("PagesCount", book.PagesCount);
            p.Add("ShelfNum", book.ShelfNum);
            p.Add("PublishedDate", book.PublishedDate);
            p.Add("PublisherId", book.PublisherId);
            p.Add("CategoryId", book.CategoryId);
            p.Add("RoomId", book.RoomId);
            p.Add("IsAvailable", true);

            p.Add("BookId", book.Id,
                direction: System.Data.ParameterDirection.Output,
                dbType: System.Data.DbType.Int32);
            p.Add("Errors",
                direction: System.Data.ParameterDirection.Output,
                dbType: System.Data.DbType.String, size: 1000);
            p.Add("RetVal", direction: System.Data.ParameterDirection.ReturnValue, dbType: System.Data.DbType.Int32);

            conn
                .ExecuteScalar<int>("InsertBook",
                                 commandType: System.Data.CommandType.StoredProcedure, param: p);
            int retVal = p.Get<int>("RetVal");
            string errors = p.Get<string>("Errors");

            return retVal;
        }

        public void Update(Book book)
        {
            using var conn = new SqlConnection(_connString);
            var p = new DynamicParameters();

            p.Add("Id", book.Id);
            p.Add("Title", book.Title);
            p.Add("ISBN", book.ISBN);
            p.Add("PagesCount", book.PagesCount);
            p.Add("ShelfNum", book.ShelfNum);
            p.Add("PublishedDate", book.PublishedDate);
            p.Add("PublisherId", book.PublisherId);
            p.Add("StudentId", book.StudentId);
            p.Add("CategoryId", book.CategoryId);
            p.Add("RoomId", book.RoomId);
            p.Add("IsAvailable", !Convert.ToBoolean(book.StudentId));

            p.Add("Errors",
                direction: System.Data.ParameterDirection.Output,
                dbType: System.Data.DbType.String, size: 1000);

            conn
                .ExecuteScalar<int>("UpdateBook",
                                 commandType: System.Data.CommandType.StoredProcedure, param: p);
            string errors = p.Get<string>("Errors");
        }

        public IList<Library.Models.Publisher> GetAllPublishers()
        {
            using var conn = new SqlConnection(_connString);
            return conn
                .Query<Library.Models.Publisher>("GetPublishers",
                                 commandType: System.Data.CommandType.StoredProcedure)
                .AsList();
        }

        public IList<Student> GetAllStudents()
        {
            using var conn = new SqlConnection(_connString);
            return conn
                .Query<Student>("GetStudents",
                                 commandType: System.Data.CommandType.StoredProcedure)
                .AsList();
        }
        public IList<Room> GetAllRooms()
        {
            using var conn = new SqlConnection(_connString);
            return conn
                .Query<Room>("GetRooms",
                                 commandType: System.Data.CommandType.StoredProcedure)
                .AsList();
        }
        public IList<Category> GetAllCategories()
        {
            using var conn = new SqlConnection(_connString);
            return conn
                .Query<Category>("GetCategories",
                                 commandType: System.Data.CommandType.StoredProcedure)
                .AsList();
        }

        public string ExportXML(string title, int? publisherId, int? categoryId, int? roomId,
            int page = 1, int pageSize = 10,
            string sortColumn = "BookId", bool sortDesc = false)
        {
            using var conn = new SqlConnection(_connString);
            return conn
                .QueryFirstOrDefault<string>("exportBookToXML",
                                 commandType: System.Data.CommandType.StoredProcedure, param: new
                                 {
                                     Title = title,
                                     Room = roomId,
                                     Publisher = publisherId,
                                     Category = categoryId,
                                     SortColumn = sortColumn,
                                     SortDesc = sortDesc,
                                     Page = page,
                                     PageSize = pageSize
                                 });

        }

        public string ExportJSON(string title, int? publisherId, int? categoryId, int? roomId,
            int page = 1, int pageSize = 10,
            string sortColumn = "BookId", bool sortDesc = false)
        {
            using var conn = new SqlConnection(_connString);
            return conn
                .QueryFirstOrDefault<string>("exportBookToJSON",
                                 commandType: System.Data.CommandType.StoredProcedure, param: new
                                 {
                                     Title = title,
                                     Room = roomId,
                                     Publisher = publisherId,
                                     Category = categoryId,
                                     SortColumn = sortColumn,
                                     SortDesc = sortDesc,
                                     Page = page,
                                     PageSize = pageSize
                                 });
        }
    }
}
