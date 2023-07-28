using Library.Models;
using Microsoft.AspNetCore.Mvc.ApplicationModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Library.DAL
{
    public interface IBookRepository
    {
        IList<Book> GetAll();
        IList<Book> Filter(string Title, int? PublisherId, int? CategoryId, int? RoomId,
            out int totalRows, int Page = 1, int PageSize = 10,
            string SortColumn = "BookId", bool SortDesc = false);
        int Insert(Book book);
        void Update(Book book);
        void Delete(int id);
        Book GetById(int id);
        IList<Publisher> GetAllPublishers();
        IList<Student> GetAllStudents();
        IList<Room> GetAllRooms();
        IList<Category> GetAllCategories();
        string ExportXML(string title, int? publisherId, int? categoryId, int? roomId,
            int page = 1, int pageSize = 10,
            string sortColumn = "BookId", bool sortDesc = false);
        string ExportJSON(string title, int? publisherId, int? categoryId, int? roomId,
            int page = 1, int pageSize = 10,
            string sortColumn = "BookId", bool sortDesc = false);
    }
}
