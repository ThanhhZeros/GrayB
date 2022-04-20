namespace GrayBShop.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Grayy : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Product", "Sale_SaleID", "dbo.Sale");
            DropIndex("dbo.Product", new[] { "Sale_SaleID" });
            DropPrimaryKey("dbo.Sale");
            AddColumn("dbo.Sale", "SaleName", c => c.String());
            AlterColumn("dbo.Product", "Sale_SaleID", c => c.Int());
            AlterColumn("dbo.Sale", "SaleID", c => c.Int(nullable: false, identity: true));
            AddPrimaryKey("dbo.Sale", "SaleID");
            CreateIndex("dbo.Product", "Sale_SaleID");
            AddForeignKey("dbo.Product", "Sale_SaleID", "dbo.Sale", "SaleID", cascadeDelete: true);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Product", "Sale_SaleID", "dbo.Sale");
            DropIndex("dbo.Product", new[] { "Sale_SaleID" });
            DropPrimaryKey("dbo.Sale");
            AlterColumn("dbo.Sale", "SaleID", c => c.String(nullable: false, maxLength: 128));
            AlterColumn("dbo.Product", "Sale_SaleID", c => c.String(maxLength: 128));
            DropColumn("dbo.Sale", "SaleName");
            AddPrimaryKey("dbo.Sale", "SaleID");
            CreateIndex("dbo.Product", "Sale_SaleID");
            AddForeignKey("dbo.Product", "Sale_SaleID", "dbo.Sale", "SaleID", cascadeDelete: true);
        }
    }
}
