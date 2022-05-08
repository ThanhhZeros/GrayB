using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using GrayBShop.Models;
using PagedList;

namespace GrayBShop.Areas.Admin.Controllers
{
    public class SalesController : Controller
    {
        private GrayShop db = new GrayShop();

        // GET: Admin/Sales
        public ActionResult Index(string searchString, int? page)
        {
            User ses = (User)Session[GrayBShop.Session.ConstainUser.ADMIN_SESSION];
            if (ses.RoleID == 2)
            {
                return RedirectToAction("Index", "HomeAdmin");
            }
            ViewBag.searchString = searchString;
            var dm = db.Sales.Select(tk => tk);
            if (!String.IsNullOrEmpty(searchString))
            {
                dm = dm.Where(tk => tk.SaleName.Contains(searchString));
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(dm.OrderBy(tk => tk.SaleID).ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/Sales/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sale sale = db.Sales.Find(id);
            if (sale == null)
            {
                return HttpNotFound();
            }
            return View(sale);
        }

        // GET: Admin/Sales/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Sales/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SaleID,SaleName,SalePercent,DateStart,DateFinish")] Sale sale)
        {
            if (ModelState.IsValid)
            {
                if (sale.DateStart < DateTime.Now)
                {
                    ViewBag.Error = "Nhập ngày bắt đầu lớn hơn hoặc bằng ngày hiện tại";
                }
                else if (sale.DateStart > sale.DateFinish)
                {
                    ViewBag.Error = "Nhập ngày bắt đầu nhỏ hơn ngày kết thúc";
                }
                else
                {

                db.Sales.Add(sale);
                db.SaveChanges();
                return RedirectToAction("Index");
                }
            }

            return View(sale);
        }

        // GET: Admin/Sales/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sale sale = db.Sales.Find(id);
            if (sale == null)
            {
                return HttpNotFound();
            }
            return View(sale);
        }

        // POST: Admin/Sales/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SaleID,SaleName,SalePercent,DateStart,DateFinish")] Sale sale)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sale).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sale);
        }

        // GET: Admin/Sales/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sale sale = db.Sales.Find(id);
            if (sale == null)
            {
                return HttpNotFound();
            }
            return View(sale);
        }

        // POST: Admin/Sales/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {

            Sale sale = db.Sales.Find(id);
            db.Sales.Remove(sale);
            db.SaveChanges();
            return RedirectToAction("Index");
            }catch(Exception ex)
            {
                ViewBag.Error = "Lỗi !" + ex.Message;
                return RedirectToAction("Index");
            }
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
