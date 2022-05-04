using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using GrayBShop.Models;

namespace GrayBShop.Areas.Admin.Controllers
{
    public class ProfileController : Controller
    {
        private GrayShop db = new GrayShop();

        // GET: Admin/Profile
        public ActionResult AdminInfor(int id)
        {
            User session = (User)Session[GrayBShop.Session.ConstainUser.ADMIN_SESSION];
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
        public ActionResult AdminInfor([Bind(Include = "UserID,UserName,Name,Password,Address,Email,Phone")] User tk)
        {
            User edit = db.Users.Where(a => a.UserID.Equals(tk.UserID) && a.RoleID!=3).FirstOrDefault();
            try
            {
                edit.UserName = tk.UserName;
                edit.Name = tk.Name;
                edit.Password = tk.Password;
                edit.Address = tk.Address;
                edit.Email = tk.Email;
                edit.Phone = tk.Phone;
                db.SaveChanges();
                Session[GrayBShop.Session.ConstainUser.ADMIN_SESSION] = edit;
            }
            catch (Exception)
            {
                ModelState.AddModelError("ErrorUpdate", "Cập nhật thông tin không thành công ! Thử lại sau !");
            }
            return View(edit);
        }
    }
}
