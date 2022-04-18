using GrayBShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace GrayBShop.Models
{
    public class CartItem
    {
        [ScriptIgnore]
        public virtual ProductDetail ProductDetail { set; get; }
        public int ImageID { set; get; }
        public int Size { set; get; }
        public int Amount { set; get; }
        public decimal Price { set; get; }
    }
}