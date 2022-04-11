using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GrayBShop.Areas.Admin.Data
{
    public class LoginAccount
    {
        public string id { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập Tên đăng nhập")]
        public string username { set; get; }
        [Required(ErrorMessage = "Vui lòng nhập mật khẩu")]
        public string password { set; get; }
    }
}