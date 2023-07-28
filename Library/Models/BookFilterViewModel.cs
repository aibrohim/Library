using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Library.Models
{
    public class BookFilterViewModel
    {
        public IList<Book> Books;
        public int TotalRows { get; set; }
        public int Page { get; set; } = 1;
        public int PageSize { get; set; } = 2;
        public string SortColumn { get; set; } = "BookId";
        public bool SortDesc { get; set; } = false;

        public string Title { get; set; }
        public int? PublisherId { get; set; }
        public int? CategoryId { get; set; }
        public int? RoomId { get; set; }
    }
}
