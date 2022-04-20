namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Blog")]
    public partial class Blog
    {
        public int BlogID { get; set; }

        [StringLength(100)]
        public string BlogName { get; set; }

        public DateTime? DateCreate { get; set; }

        [Column(TypeName = "ntext")]
        public string Content { get; set; }

        [StringLength(300)]
        public string Images { get; set; }

        public int? BlogCategoryID { get; set; }

        public virtual BlogCategory BlogCategory { get; set; }
    }
}
