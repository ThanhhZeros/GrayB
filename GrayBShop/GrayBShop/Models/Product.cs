namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
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

        public string ProductID { get; set; }

        [Required]
        [StringLength(200)]
        public string ProductName { get; set; }

        public string CategoryID { get; set; }

        [StringLength(500)]
        public string Descriptions { get; set; }

        [Column(TypeName = "money")]
        public decimal Price { get; set; }

        public DateTime DateCreate { get; set; }

        public DateTime DateUpdate { get; set; }
        public int AmountInput { get; set; }

        public virtual Category Category { get; set; }
        public virtual Sale Sale { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ImageProduct> ImageProducts { get; set; }
    }
}
