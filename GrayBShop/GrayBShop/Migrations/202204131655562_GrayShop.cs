namespace GrayBShop.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GrayShop : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.BlogCategory",
                c => new
                    {
                        BlogCategoryID = c.Int(nullable: false, identity: true),
                        BlogCategoryName = c.String(maxLength: 500),
                    })
                .PrimaryKey(t => t.BlogCategoryID);
            
            CreateTable(
                "dbo.Blog",
                c => new
                    {
                        BlogID = c.Int(nullable: false, identity: true),
                        BlogName = c.String(maxLength: 100),
                        DateCreate = c.DateTime(nullable: false),
                        Content = c.String(storeType: "ntext"),
                        Images = c.String(maxLength: 300),
                        BlogCategoryID = c.Int(),
                    })
                .PrimaryKey(t => t.BlogID)
                .ForeignKey("dbo.BlogCategory", t => t.BlogCategoryID, cascadeDelete: true)
                .Index(t => t.BlogCategoryID);
            
            CreateTable(
                "dbo.Category",
                c => new
                    {
                        CategoryID = c.String(nullable: false, maxLength: 128),
                        CategoryName = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.CategoryID);
            
            CreateTable(
                "dbo.Product",
                c => new
                    {
                        ProductID = c.String(nullable: false, maxLength: 128),
                        ProductName = c.String(nullable: false, maxLength: 200),
                        CategoryID = c.String(maxLength: 128),
                        Descriptions = c.String(maxLength: 500),
                        Price = c.Decimal(nullable: false, storeType: "money"),
                        DateCreate = c.DateTime(nullable: false),
                        DateUpdate = c.DateTime(nullable: false),
                        SLCo = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.ProductID)
                .ForeignKey("dbo.Category", t => t.CategoryID, cascadeDelete: true)
                .Index(t => t.CategoryID);
            
            CreateTable(
                "dbo.ImageProduct",
                c => new
                    {
                        ImageID = c.Int(nullable: false, identity: true),
                        Images = c.String(maxLength: 300),
                        ProductID = c.String(maxLength: 128),
                    })
                .PrimaryKey(t => t.ImageID)
                .ForeignKey("dbo.Product", t => t.ProductID, cascadeDelete: true)
                .Index(t => t.ProductID);
            
            CreateTable(
                "dbo.ProductDetail",
                c => new
                    {
                        ImageID = c.Int(nullable: false),
                        Size = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.ImageID, t.Size })
                .ForeignKey("dbo.ImageProduct", t => t.ImageID, cascadeDelete: true)
                .Index(t => t.ImageID);
            
            CreateTable(
                "dbo.OrderDetail",
                c => new
                    {
                        OrderID = c.Int(nullable: false),
                        ImageID = c.Int(nullable: false),
                        Size = c.Int(nullable: false),
                        Amount = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.OrderID, t.ImageID, t.Size })
                .ForeignKey("dbo.Orders", t => t.OrderID, cascadeDelete: true)
                .ForeignKey("dbo.ProductDetail", t => new { t.ImageID, t.Size }, cascadeDelete: true)
                .Index(t => t.OrderID)
                .Index(t => new { t.ImageID, t.Size });
            
            CreateTable(
                "dbo.Orders",
                c => new
                    {
                        OrderID = c.Int(nullable: false, identity: true),
                        UserID = c.Int(),
                        UserName = c.String(nullable: false, maxLength: 50),
                        Phone = c.String(nullable: false, maxLength: 20, unicode: false),
                        Address = c.String(nullable: false, maxLength: 100),
                        Email = c.String(maxLength: 50, unicode: false),
                        DateCreate = c.DateTime(nullable: false),
                        Status = c.String(maxLength: 50),
                        Note = c.String(maxLength: 50),
                    })
                .PrimaryKey(t => t.OrderID)
                .ForeignKey("dbo.Users", t => t.UserID, cascadeDelete: true)
                .Index(t => t.UserID);
            
            CreateTable(
                "dbo.Users",
                c => new
                    {
                        UserID = c.Int(nullable: false, identity: true),
                        UserName = c.String(nullable: false, maxLength: 50),
                        Password = c.String(nullable: false, maxLength: 50, unicode: false),
                        Name = c.String(nullable: false, maxLength: 100),
                        Phone = c.String(nullable: false, maxLength: 20, unicode: false),
                        Address = c.String(nullable: false, maxLength: 500),
                        Email = c.String(maxLength: 50, unicode: false),
                        Status = c.Boolean(nullable: false),
                        RoleID = c.Int(),
                    })
                .PrimaryKey(t => t.UserID)
                .ForeignKey("dbo.Roles", t => t.RoleID, cascadeDelete: true)
                .Index(t => t.RoleID);
            
            CreateTable(
                "dbo.Roles",
                c => new
                    {
                        RoleID = c.Int(nullable: false, identity: true),
                        RoleName = c.String(nullable: false, maxLength: 100),
                    })
                .PrimaryKey(t => t.RoleID);
            
            CreateTable(
                "dbo.Contact",
                c => new
                    {
                        ContactID = c.Int(nullable: false, identity: true),
                        CustomerName = c.String(maxLength: 100),
                        Subject = c.String(maxLength: 200),
                        Content = c.String(maxLength: 500),
                        Email = c.String(maxLength: 50, unicode: false),
                        Phone = c.String(maxLength: 20, unicode: false),
                        Status = c.Boolean(),
                        DateContact = c.DateTime(),
                    })
                .PrimaryKey(t => t.ContactID);
            
            CreateTable(
                "dbo.Introduce",
                c => new
                    {
                        Introduce = c.Int(nullable: false, identity: true),
                        Detail = c.String(storeType: "ntext"),
                    })
                .PrimaryKey(t => t.Introduce);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Product", "CategoryID", "dbo.Category");
            DropForeignKey("dbo.ImageProduct", "ProductID", "dbo.Product");
            DropForeignKey("dbo.OrderDetail", new[] { "ImageID", "Size" }, "dbo.ProductDetail");
            DropForeignKey("dbo.Users", "RoleID", "dbo.Roles");
            DropForeignKey("dbo.Orders", "UserID", "dbo.Users");
            DropForeignKey("dbo.OrderDetail", "OrderID", "dbo.Orders");
            DropForeignKey("dbo.ProductDetail", "ImageID", "dbo.ImageProduct");
            DropForeignKey("dbo.Blog", "BlogCategoryID", "dbo.BlogCategory");
            DropIndex("dbo.Users", new[] { "RoleID" });
            DropIndex("dbo.Orders", new[] { "UserID" });
            DropIndex("dbo.OrderDetail", new[] { "ImageID", "Size" });
            DropIndex("dbo.OrderDetail", new[] { "OrderID" });
            DropIndex("dbo.ProductDetail", new[] { "ImageID" });
            DropIndex("dbo.ImageProduct", new[] { "ProductID" });
            DropIndex("dbo.Product", new[] { "CategoryID" });
            DropIndex("dbo.Blog", new[] { "BlogCategoryID" });
            DropTable("dbo.Introduce");
            DropTable("dbo.Contact");
            DropTable("dbo.Roles");
            DropTable("dbo.Users");
            DropTable("dbo.Orders");
            DropTable("dbo.OrderDetail");
            DropTable("dbo.ProductDetail");
            DropTable("dbo.ImageProduct");
            DropTable("dbo.Product");
            DropTable("dbo.Category");
            DropTable("dbo.Blog");
            DropTable("dbo.BlogCategory");
        }
    }
}
