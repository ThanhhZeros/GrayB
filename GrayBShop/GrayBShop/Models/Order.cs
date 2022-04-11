namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Order
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Order()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        public int OrderID { get; set; }

        public int? UserID { get; set; }

        [Required]
        [StringLength(50)]
        public string UserName { get; set; }

        [Required]
        [StringLength(20)]
        public string Phone { get; set; }

        [Required]
        [StringLength(100)]
        public string Address { get; set; }

        [StringLength(50)]
        public string Email { get; set; }

        public DateTime DateCreate { get; set; }

        public bool? Status { get; set; }

        [StringLength(50)]
        public string Note { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }

        public virtual User User { get; set; }
    }
}
