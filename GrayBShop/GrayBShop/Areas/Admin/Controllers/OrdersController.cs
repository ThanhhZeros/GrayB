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
    public class OrdersController : BaseController
    {
        private GrayShop db = new GrayShop();

        // GET: Admin/Orders
        public ActionResult Index(int? page, DateTime? searchString, string stringFilter)
        {
            List<Order> hoaDons = db.Orders.Include(h => h.User).Select(p => p).ToList();
            var status = (from hd in db.Orders group hd by hd.Status into tt select tt);
            List<string> values = new List<string>();
            foreach (var item in status)
            {
                string k =item.Key.ToString();
                values.Add(k);
            }
            ViewBag.status = values;

            if (searchString != null && !string.IsNullOrEmpty(stringFilter))
            {
                ViewBag.searchString = searchString.Value.ToShortDateString();
                string search = searchString.Value.ToShortDateString();
                hoaDons = hoaDons.Where(hd => hd.DateCreate.ToShortDateString().Equals(search) && hd.Status.Equals(stringFilter)).ToList();
            }
            else if (searchString != null)
            {
                ViewBag.searchString = searchString.Value.ToShortDateString();
                string search = searchString.Value.ToShortDateString();
                hoaDons = hoaDons.Where(hd => hd.DateCreate.ToShortDateString().Equals(search)).ToList();
            }
            else if (!string.IsNullOrEmpty(stringFilter))
            {
                hoaDons = hoaDons.Where(hd => hd.Status.Equals(stringFilter)).ToList();
            }
            if (hoaDons.Count() == 0)
            {
                ViewBag.Error = "Oops, Không thấy đơn hàng nào!";
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);

            return View(hoaDons.OrderByDescending(hd => hd.DateCreate).ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/Orders/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // GET: Admin/Orders/Create
        public ActionResult Create()
        {
            ViewBag.UserID = new SelectList(db.Users, "UserID", "UserName");
            return View();
        }

        // POST: Admin/Orders/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "OrderID,UserID,UserName,Phone,Address,Email,DateCreate,Status,Note")] Order order)
        {
            if (ModelState.IsValid)
            {
                db.Orders.Add(order);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserID = new SelectList(db.Users, "UserID", "UserName", order.UserID);
            return View(order);
        }

        // GET: Admin/Orders/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserID = new SelectList(db.Users, "UserID", "UserName", order.UserID);
            return View(order);
        }

        // POST: Admin/Orders/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, string Status)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var hoaDon = db.Orders.Find(id);
                    hoaDon.Status = Status;
                    db.Entry(hoaDon).State = EntityState.Modified;
                    db.SaveChanges();

                }
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi edit dữ liệu! " + ex.Message;
                return View();
            }
        }

        // GET: Admin/Orders/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // POST: Admin/Orders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Order order = db.Orders.Find(id);
            db.Orders.Remove(order);
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
