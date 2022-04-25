using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace GrayBShop.Models
{
    public partial class GrayShop : DbContext
    {
        public GrayShop()
            : base("name=GrayShop")
        {
        }

        public virtual DbSet<Blog> Blogs { get; set; }
        public virtual DbSet<BlogCategory> BlogCategories { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Contact> Contacts { get; set; }
        public virtual DbSet<ImageProduct> ImageProducts { get; set; }
        public virtual DbSet<Introduce> Introduces { get; set; }
        public virtual DbSet<OrderDetail> OrderDetails { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<ProductDetail> ProductDetails { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<Sale> Sales { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BlogCategory>()
                .HasMany(e => e.Blogs)
                .WithOptional(e => e.BlogCategory);

            modelBuilder.Entity<Category>()
                .Property(e => e.CategoryID)
                .IsUnicode(false);

            modelBuilder.Entity<Contact>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<Contact>()
                .Property(e => e.Phone)
                .IsUnicode(false);

            modelBuilder.Entity<ImageProduct>()
                .Property(e => e.ProductID)
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.Phone)
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<Product>()
                .Property(e => e.ProductID)
                .IsUnicode(false);

            modelBuilder.Entity<Product>()
                .Property(e => e.CategoryID)
                .IsUnicode(false);

            modelBuilder.Entity<Product>()
                .Property(e => e.Price)
                .HasPrecision(19, 4);

            modelBuilder.Entity<Product>()
                .HasMany(e => e.ImageProducts)
                .WithOptional(e => e.Product);

            modelBuilder.Entity<ProductDetail>()
                .HasMany(e => e.OrderDetails)
                .WithRequired(e => e.ProductDetail)
                .HasForeignKey(e => new { e.ImageID, e.Size });

            modelBuilder.Entity<Role>()
                .HasMany(e => e.Users)
                .WithOptional(e => e.Role);

            modelBuilder.Entity<Sale>()
                .HasMany(e => e.Products)
                .WithOptional(e => e.Sale);

            modelBuilder.Entity<User>()
                .Property(e => e.Password)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.Phone)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.Orders)
                .WithOptional(e => e.User);
            base.OnModelCreating(modelBuilder);
        }
    }
}
