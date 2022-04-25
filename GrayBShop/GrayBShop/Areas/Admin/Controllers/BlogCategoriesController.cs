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
    public class BlogCategoriesController : BaseController
    {
        private GrayShop db = new GrayShop();

        // GET: Admin/BlogCategories
        public ActionResult Index(string searchString, int? page)
        {
            ViewBag.searchString = searchString;
            var dm = db.BlogCategories.Select(tk => tk);
            if (!String.IsNullOrEmpty(searchString))
            {
                dm = dm.Where(tk => tk.BlogCategoryName.Contains(searchString));
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(dm.OrderBy(tk => tk.BlogCategoryID).ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/BlogCategories/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BlogCategory blogCategory = db.BlogCategories.Find(id);
            if (blogCategory == null)
            {
                return HttpNotFound();
            }
            return View(blogCategory);
        }

        // GET: Admin/BlogCategories/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/BlogCategories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BlogCategoryID,BlogCategoryName")] BlogCategory blogCategory)
        {
            if (ModelState.IsValid)
            {
                db.BlogCategories.Add(blogCategory);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(blogCategory);
        }

        // GET: Admin/BlogCategories/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BlogCategory blogCategory = db.BlogCategories.Find(id);
            if (blogCategory == null)
            {
                return HttpNotFound();
            }
            return View(blogCategory);
        }

        // POST: Admin/BlogCategories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BlogCategoryID,BlogCategoryName")] BlogCategory blogCategory)
        {
            if (ModelState.IsValid)
            {
                db.Entry(blogCategory).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(blogCategory);
        }

        // GET: Admin/BlogCategories/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BlogCategory blogCategory = db.BlogCategories.Find(id);
            if (blogCategory == null)
            {
                return HttpNotFound();
            }
            return View(blogCategory);
        }

        // POST: Admin/BlogCategories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {
            BlogCategory blogCategory = db.BlogCategories.Find(id);
            db.BlogCategories.Remove(blogCategory);
            db.SaveChanges();
            return RedirectToAction("Index");

            }catch(Exception ex)
            {
                ViewBag.Error = "Bạn không thể xóa";
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
