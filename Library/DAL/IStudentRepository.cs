using Library.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Library.DAL
{
    public interface IStudentRepository
    {
        IEnumerable<Student> GetAll();
        int Insert(Student student);
        void Update(Student student);
        void Delete(int id);
        Student GetById(int id);
    }
}
