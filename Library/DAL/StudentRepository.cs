using Library.Models;
using System;
using System.Collections.Generic;
using Dapper;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Library.DAL
{
    public class StudentRepository : IStudentRepository
    {
        private readonly string _connString;
        public StudentRepository(string connString)
        {
            _connString = connString;
        }

        #region SQL constants

        private const string SQL_SELECT = @"
            SELECT Id, FirstName, LastName, DateOfBirth, IsMarried, Phone, Address from Student
        ";

        private const string SQL_INSERT = @"
            INSERT INTO Student(
                FirstName, 
                LastName, 
                DateOfBirth, 
                IsMarried,
                Phone, 
                Address
            ) 
            OUTPUT INSERTED.Id
            values (
                @FirstName,
                @LastName,
                @DateOfBirth,
                @IsMarried,
                @Phone, 
                @Address
            )
        ";

        private const string SQL_UPDATE = @"
            UPDATE Student SET 
                FirstName = @FirstName, 
                LastName = @LastName, 
                DateOfBirth = @DateOfBirth, 
                IsMarried = @IsMarried,
                Phone = @Phone, 
                Address = @Address
            WHERE Id = @Id
        ";

        private const string SQL_SELECT_BY_ID = @"
            SELECT 
                Id, 
                FirstName, 
                LastName, 
                DateOfBirth, 
                IsMarried,
                Phone, 
                Address
            FROM Student
            WHERE Id = @StudentId
        ";

        private const string SQL_DELETE = @"
            DELETE FROM Student where Id = @StudentId
        ";
        private const string SQL_DELTE_STUDENT_FROM_BOOKS = @"
            UPDATE Book
            SET StudentId=NULL, IsAvailable=1
            WHERE Book.StudentId = @Id
        ";
        #endregion SQL constants

        public IEnumerable<Student> GetAll()
        {
            using (var conn = new SqlConnection(_connString))
            {
                return conn.Query<Student>(SQL_SELECT).AsList();
            }
        }

        public Student GetById(int id)
        {
            using (var conn = new SqlConnection(_connString))
            {
                return conn.QueryFirstOrDefault<Student>(SQL_SELECT_BY_ID, new { StudentId = id});
            }
        }

        public int Insert(Student student)
        {
            using (var conn = new SqlConnection(_connString))
            {
                return conn.QueryFirstOrDefault<int>(SQL_INSERT, student);
            }
        }

        public void Update(Student student)
        {
            using (var conn = new SqlConnection(_connString))
            {
                conn.Execute(SQL_UPDATE, student);
            }
        }

        public void Delete(int id)
        {
            using (var conn = new SqlConnection(_connString))
            {
                conn.Execute(SQL_DELTE_STUDENT_FROM_BOOKS, new { Id = id });
                conn.Execute(SQL_DELETE, new { StudentId = id });
            }
        }
    }
}
