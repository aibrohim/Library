using CsvHelper;
using Library.DAL;
using Library.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Xml;

namespace Library.Controllers
{
    public class BookController : Controller
    {
        private IBookRepository _repository;

        public BookController(IBookRepository repository)
        {
            _repository = repository;
        }
        // GET: BookController
        public ActionResult Index(BookFilterViewModel filterModel)
        {
            ViewBag.PublishersList = _repository.GetAllPublishers();
            ViewBag.Rooms = _repository.GetAllRooms();
            ViewBag.Categories = _repository.GetAllCategories();

            int totalRows;
            var books = _repository.Filter(
                filterModel.Title, filterModel.PublisherId, filterModel.CategoryId, filterModel.RoomId,
                out totalRows, filterModel.Page, 11,
                filterModel.SortColumn, filterModel.SortDesc
                );
            filterModel.Books = books;
            return View(filterModel);
        }

        // GET: BookController/Details/5
        public ActionResult Details(int id)
        {
            var book = _repository.GetById(id);
            return View(book);
        }

        // GET: BookController/Create
        public ActionResult Create()
        {
            ViewBag.PublishersList = _repository.GetAllPublishers();
            ViewBag.StudentsList = _repository.GetAllStudents();
            ViewBag.Rooms = _repository.GetAllRooms();
            ViewBag.Categories = _repository.GetAllCategories();

            return View();
        }

        // POST: BookController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Book book)
        {
            try
            {
                int id = _repository.Insert(book);

                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                return View();
            }
        }

        // GET: BookController/Edit/5
        public ActionResult Edit(int id)
        {
            ViewBag.PublishersList = _repository.GetAllPublishers();
            ViewBag.StudentsList = _repository.GetAllStudents();
            ViewBag.Rooms = _repository.GetAllRooms();
            ViewBag.Categories = _repository.GetAllCategories();

            return View(_repository.GetById(id));
        }

        // POST: BookController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, Book book)
        {
            try
            {
                book.Id = id;
                _repository.Update(book);

                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                return View();
            }
        }

        // GET: BookController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: BookController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                _repository.Delete(id);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        public ActionResult ExportCsv(BookFilterViewModel filterModel)
        {
            int totalRows;
            var books = _repository.Filter(
                filterModel.Title, filterModel.PublisherId, filterModel.CategoryId, filterModel.RoomId,
                out totalRows, filterModel.Page, filterModel.PageSize,
                filterModel.SortColumn, filterModel.SortDesc
                ).Select(b => new Book() {
                    Id = b.Id, 
                    Title = b.Title, 
                    ISBN = b.ISBN, 
                    PagesCount = b.PagesCount, 
                    PublishedDate = b.PublishedDate, 
                    ShelfNum = b.ShelfNum,
                    IsAvailable = b.IsAvailable
                });


            var memory = new MemoryStream();
            var writer = new StreamWriter(memory);
            var csvWriter = new CsvWriter(writer, CultureInfo.InvariantCulture);
            csvWriter.WriteRecords(books);
            writer.Flush();

            memory.Position = 0;
            if (memory != Stream.Null)
                return File(memory, "text/csv", $"Export_{DateTime.Now}.csv");

            return NotFound();
        }

        public ActionResult ExportXML(BookFilterViewModel filterModel)
        {
            var file = _repository.ExportXML(filterModel.Title, filterModel.PublisherId, filterModel.CategoryId, filterModel.RoomId,
                filterModel.Page, 11,
                filterModel.SortColumn, filterModel.SortDesc);

            var newStream = new System.IO.MemoryStream();
            var writer = new System.IO.StreamWriter(newStream);
            writer.Write(file);
            writer.Flush();
            newStream.Position = 0;

            return File(newStream, "text/xml", $"Export_{DateTime.Now}.xml");

        }
        public ActionResult ExportJSON(BookFilterViewModel filterModel)
        {
            var file = _repository.ExportJSON(filterModel.Title, filterModel.PublisherId, filterModel.CategoryId, filterModel.RoomId,
                filterModel.Page, 11,
                filterModel.SortColumn, filterModel.SortDesc);

            var newStream = new System.IO.MemoryStream();
            var writer = new System.IO.StreamWriter(newStream);
            writer.Write(file);
            writer.Flush();
            newStream.Position = 0;

            return File(newStream, "text/json", $"Export_{DateTime.Now}.json");

        }
    }
}
