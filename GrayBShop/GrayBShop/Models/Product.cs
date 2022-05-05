namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Product")]
    public partial class Product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Product()
        {
            ImageProducts = new HashSet<ImageProduct>();
        }

        [StringLength(20)]
        [DisplayName("Mã sản phẩm")]
        public string ProductID { get; set; }

        [Required]
        [StringLength(200)]
        [DisplayName("Tên sản phẩm")]
        public string ProductName { get; set; }

        [StringLength(20)]
        [DisplayName("Danh mục")]
        public string CategoryID { get; set; }
        [DisplayName("Danh mục KM")]
        public int? SaleID { get; set; }

        [StringLength(500)]
        [DisplayName("Mô tả")]
        public string Descriptions { get; set; }

        [Column(TypeName = "money")]
        [DisplayName("Giá bán")]
        public decimal Price { get; set; }

        [DisplayName("Ngày tạo")]
        public DateTime DateCreate { get; set; }

        [DisplayName("Ngày sửa")]
        public DateTime DateUpdate { get; set; }

        [DisplayName("Số lượng nhập")]
        public int AmountInput { get; set; }

        public virtual Category Category { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ImageProduct> ImageProducts { get; set; }

        public virtual Sale Sale { get; set; }
    }
}
