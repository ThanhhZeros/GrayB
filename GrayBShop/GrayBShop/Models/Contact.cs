namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Contact")]
    public partial class Contact
    {
        [DisplayName("Mã liên hệ")]
        public int ContactID { get; set; }

        [Required]
        [StringLength(100)]
        [DisplayName("Tên khách hàng")]
        public string CustomerName { get; set; }

        [Required]
        [StringLength(500)]
        [DisplayName("Nội dung")]
        public string Content { get; set; }

        [Required]
        [StringLength(50)]
        public string Email { get; set; }

        [Required]
        [StringLength(20)]
        [DisplayName("Số điện thoại")]
        public string Phone { get; set; }

        [DisplayName("Trạng thái")]
        public bool? Status { get; set; }

        [DisplayName("Ngày liên hệ")]
        public DateTime? DateContact { get; set; }
    }
}
