using GrayBShop.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Areas.Admin.Controllers
{
    public class AdminController : Controller
    {
        GrayShop db = new GrayShop();
        // GET: Admin/Admin
        public ActionResult Index(int? page)
        {
            User ses = (User)Session[GrayBShop.Session.ConstainUser.ADMIN_SESSION];
            if (ses.RoleID == 2)
            {
                return RedirectToAction("Index", "HomeAdmin");
            }
            ViewBag.Error = TempData["Error"];
            ViewBag.Success = TempData["Success"];
            var taikhoans = db.Users.Select(tk => tk).Where(r=>r.RoleID!=3);
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(taikhoans.OrderBy(tk => tk.UserID).ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "UserID,UserName,Password,Name,Phone,Address,Email,Status,RoleID")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User taiKhoanQuanTri = db.Users.Find(id);
            if (taiKhoanQuanTri == null)
            {
                return HttpNotFound();
            }
            return View(taiKhoanQuanTri);
        }

        // POST: Admin/TaiKhoanQuanTris/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, bool Status)
        {
            string Error = null;
            string Success = null;
            try
            {
                User login = (User)Session[GrayBShop.Session.ConstainUser.ADMIN_SESSION];
                if (ModelState.IsValid)
                {
                    User acc = (from tk in db.Users where tk.UserID.Equals(id) select tk).FirstOrDefault();
                    if (login.UserID == acc.UserID)
                    {
                        Error = "Bạn không thể sửa tài khoản này!";
                    }
                    else
                    {
                        var taiKhoanQuanTri = db.Users.Find(id);
                        taiKhoanQuanTri.Status = Status;
                        db.Entry(taiKhoanQuanTri).State = EntityState.Modified;
                        db.SaveChanges();
                        Success = "Update thành công!";
                    }
                }
                TempData["Error"] = Error;
                TempData["Success"] = Success;
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi edit dữ liệu! " + ex.Message;
                return View();
            }
        }

        // GET: Admin/TaiKhoanQuanTris/Delete/5
        public ActionResult Delete(int? id)
        {

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User taiKhoanQuanTri = db.Users.Find(id);
            if (taiKhoanQuanTri == null)
            {
                return HttpNotFound();
            }
            return View(taiKhoanQuanTri);
        }

        // POST: Admin/TaiKhoanQuanTris/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            User taiKhoanQuanTri = db.Users.Find(id);
            db.Users.Remove(taiKhoanQuanTri);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}