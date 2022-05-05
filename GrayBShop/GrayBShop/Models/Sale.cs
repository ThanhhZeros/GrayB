namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Sale")]
    public partial class Sale
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Sale()
        {
            Products = new HashSet<Product>();
        }

        [DisplayName("Mã khuyến mãi")]
        public int SaleID { get; set; }

        [StringLength(200)]
        [DisplayName("Tên khuyến mãi")]
        public string SaleName { get; set; }

        [DisplayName("Phần trăm khuyến mãi")]
        public int SalePercent { get; set; }

        [DisplayName("Ngày bắt đầu")]
        public DateTime DateStart { get; set; }

        [DisplayName("Ngày kết thúc")]
        public DateTime DateFinish { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Product> Products { get; set; }
    }
}
