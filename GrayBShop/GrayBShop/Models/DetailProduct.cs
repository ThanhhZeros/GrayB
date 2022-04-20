using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace GrayBShop.Models
{
    public class DetailProduct
    {
        [DisplayName("Mã sản phẩm")]
        public string ProductID { get; set; }

        [Required(ErrorMessage = "Tên sản phẩm không được để trống!")]
        [StringLength(200)]
        [DisplayName("Tên sản phẩm")]
        public string ProductName { get; set; }

        [StringLength(20)]
        [DisplayName("Mã danh mục")]
        public string CategoryID { get; set; }


        [DisplayName("Khuyến mãi")]
        public int SaleID { get; set; }

        [StringLength(200)]
        [DisplayName("Tên danh mục")]
        public string CategoryName { get; set; }

        [DisplayName("Ngày tạo")]
        public DateTime DateCreate { get; set; }

        [DisplayName("Ngày sửa")]
        public DateTime DateUpdate { get; set; }

        [Required(ErrorMessage = "Mô tả sản phẩm không được để trống!")]
        [StringLength(500)]
        [DisplayName("Mô tả")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Giá bán không được để trống!")]
        [Column(TypeName = "money")]
        [DisplayName("Giá bán")]
        public decimal Price { get; set; }

        [StringLength(300)]
        [DisplayName("Ảnh sản phẩm")]
        public string Images { get; set; }

        [Required(ErrorMessage = "Size sản phẩm không được để trống!")]
        [StringLength(300)]
        [DisplayName("Các size sẵn có")]
        public string Size { get; set; }
        public int ImageID { get; set; }

        public virtual Category Category { get; set; }
        public virtual Sale Sale { get; set; }
    }
}