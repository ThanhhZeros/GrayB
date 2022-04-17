using GrayBShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Controllers
{
    public class AccountUserController : Controller
    {
        GrayShop db = new GrayShop();
        // GET: AccountUser
        [HttpGet]
        public ActionResult ChangePassWord()
        {
            if (Session[GrayBShop.Session.ConstainUser.USER_SESSION] == null || Session[GrayBShop.Session.ConstainUser.USER_SESSION].ToString() == "")
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }

        [HttpPost]
        public ActionResult ChangePassWord(string oldpassword, string password)
        {
            User tk = (User)Session[GrayBShop.Session.ConstainUser.USER_SESSION];
            if (tk.Password != oldpassword)
            {
                ModelState.AddModelError("ErrorUpdate", "Mật khẩu cũ không đúng");
            }
            else
            {
                User edit = db.Users.Where(a => a.UserID.Equals(tk.UserID)).FirstOrDefault();
                edit.Password = password;
                db.SaveChanges();
                Session[GrayBShop.Session.ConstainUser.USER_SESSION] = edit;
                ModelState.AddModelError("ErrorUpdate", "Đổi mật khẩu thành công!");
            }
            return View();
        }


        [HttpGet]
        public ActionResult UserInfor(int id)
        {
            User session = (User)Session[GrayBShop.Session.ConstainUser.USER_SESSION];
            if (session == null)
            {
                return RedirectToAction("PageNotFound", "Error");
            }
            else
            {
                User tk = db.Users.Where(a => a.UserID.Equals(id)).FirstOrDefault();
                return View(tk);
            }
        }

        [HttpPost]
        public ActionResult UserInfor([Bind(Include = "UserID,Name,Phone,Address,Email")] User tk)
        {
            User edit = db.Users.Where(a => a.UserID.Equals(tk.UserID)).FirstOrDefault();
            try
            {
                edit.Name = tk.Name;
                edit.Address = tk.Address;
                edit.Email = tk.Email;
                edit.Phone = tk.Phone;
                db.SaveChanges();
                Session[GrayBShop.Session.ConstainUser.USER_SESSION] = edit;
            }
            catch (Exception)
            {
                ModelState.AddModelError("ErrorUpdate", "Cập nhật thông tin không thành công ! Thử lại sau !");
            }
            return View(edit);
        }
    }
}