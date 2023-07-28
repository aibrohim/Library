using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Library.Models
{
    public class Book
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string ISBN { get; set; }
        public int PagesCount { get; set; }
        public bool IsAvailable { get; set; }
        public DateTime PublishedDate { get; set; }
        public string ShelfNum { get; set; }
        public int? PublisherId { get; set; }
        public string PublisherName { get; set; }
        public int? StudentId { get; set; }
        public string StudentFirstName { get; set; }
        public string StudentLastName { get; set; }
        public int? RoomId { get; set; }
        public string RoomName { get; set; }
        public int? CategoryId { get; set; }
        public string CategoryName { get; set; }
        public int TotalRowsCount { get; set; }
    }
}

