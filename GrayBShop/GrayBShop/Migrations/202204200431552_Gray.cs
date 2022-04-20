namespace GrayBShop.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Gray : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Sale",
                c => new
                    {
                        SaleID = c.String(nullable: false, maxLength: 128),
                        SalePercent = c.Int(nullable: false),
                        DateStart = c.DateTime(nullable: false),
                        DateFinish = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.SaleID);
            
            AddColumn("dbo.Product", "AmountInput", c => c.Int(nullable: false));
            AddColumn("dbo.Product", "Sale_SaleID", c => c.String(maxLength: 128));
            CreateIndex("dbo.Product", "Sale_SaleID");
            AddForeignKey("dbo.Product", "Sale_SaleID", "dbo.Sale", "SaleID", cascadeDelete: true);
            DropColumn("dbo.Product", "SLCo");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Product", "SLCo", c => c.Int(nullable: false));
            DropForeignKey("dbo.Product", "Sale_SaleID", "dbo.Sale");
            DropIndex("dbo.Product", new[] { "Sale_SaleID" });
            DropColumn("dbo.Product", "Sale_SaleID");
            DropColumn("dbo.Product", "AmountInput");
            DropTable("dbo.Sale");
        }
    }
}
