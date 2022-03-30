namespace GrayBShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Introduce")]
    public partial class Introduce
    {
        [Key]
        [Column("Introduce")]
        public int Introduce1 { get; set; }

        [Column(TypeName = "ntext")]
        public string Detail { get; set; }
    }
}
