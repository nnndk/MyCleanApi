using Microsoft.EntityFrameworkCore;
using MyCleanApi.Core.Entities;

namespace MyCleanApi.Infrastructure
{
    public class AppDbContext : DbContext
    {
        public DbSet<Product> Products { get; set; }

        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
    }
}