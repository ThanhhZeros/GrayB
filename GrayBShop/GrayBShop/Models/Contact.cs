namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Contact")]
    public partial class Contact
    {
        public int ContactID { get; set; }

        [StringLength(100)]
        public string CustomerName { get; set; }

        [StringLength(200)]
        public string Subject { get; set; }

        [StringLength(500)]
        public string Content { get; set; }

        [StringLength(50)]
        public string Email { get; set; }

        [StringLength(20)]
        public string Phone { get; set; }

        public bool? Status { get; set; }

        public DateTime? DateContact { get; set; }
    }
}
