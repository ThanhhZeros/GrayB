namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Blog")]
    public partial class Blog
    {
        [DisplayName("Mã tin tức")]
        public int BlogID { get; set; }

        [StringLength(100)]
        [DisplayName("Tên tin tức")]
        public string BlogName { get; set; }

        [DisplayName("Ngày tạo")]
        public DateTime DateCreate { get; set; }

        [Column(TypeName = "ntext")]
        [DisplayName("Nội dung")]
        public string Content { get; set; }

        [StringLength(300)]
        [DisplayName("Ảnh")]
        public string Images { get; set; }

        [DisplayName("Danh mục")]
        public int? BlogCategoryID { get; set; }

        public virtual BlogCategory BlogCategory { get; set; }
    }
}
