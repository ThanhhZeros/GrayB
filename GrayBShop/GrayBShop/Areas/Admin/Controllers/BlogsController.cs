using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using GrayBShop.Models;
using PagedList;

namespace GrayBShop.Areas.Admin.Controllers
{
    public class BlogsController : BaseController
    {
        private GrayShop db = new GrayShop();

        // GET: Admin/Blogs
        public ActionResult Index(string searchString, int? page)
        {
            ViewBag.searchString = searchString;
            var blogs = db.Blogs.Include(b => b.BlogCategory);
            var a = blogs.ToList();
            if (!String.IsNullOrEmpty(searchString))
            {
                blogs = blogs.Where(tk => tk.BlogName.Contains(searchString));
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(blogs.OrderBy(tk => tk.DateCreate).ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/Blogs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Blog blog = db.Blogs.Find(id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            return View(blog);
        }

        // GET: Admin/Blogs/Create
        public ActionResult Create()
        {
            ViewBag.BlogCategoryID = new SelectList(db.BlogCategories, "BlogCategoryID", "BlogCategoryName");
            return View();
        }

        // POST: Admin/Blogs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BlogID,BlogName,DateCreate,Content,Images,BlogCategoryID")] Blog blog, HttpPostedFileBase uploadFile)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    blog.Images = "";
                    //var f = Request.Files["Images"];
                    
                        string FileName = uploadFile.FileName;
                        string filePath = Path.Combine(HttpContext.Server.MapPath("/wwwroot/Images"),
                                                       Path.GetFileName(uploadFile.FileName));
                        uploadFile.SaveAs(filePath);
                        blog.Images = FileName;
                    
                    
                    blog.DateCreate = DateTime.Now;
                    db.Blogs.Add(blog);
                    db.SaveChanges();
                }
                    return RedirectToAction("Index");
            }
            catch(Exception ex)
            {
                ViewBag.BlogCategoryID = new SelectList(db.BlogCategories, "BlogCategoryID", "BlogCategoryName", blog.BlogCategoryID);
                return View(blog);
            }
        }

        // GET: Admin/Blogs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Blog blog = db.Blogs.Find(id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            ViewBag.BlogCategoryID = new SelectList(db.BlogCategories, "BlogCategoryID", "BlogCategoryName", blog.BlogCategoryID);
            return View(blog);
        }

        // POST: Admin/Blogs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BlogID,BlogName,DateCreate,Content,Images,BlogCategoryID")] Blog blog)
        {
            if (ModelState.IsValid)
            {
                blog.Images = "";
                var f = Request.Files["uploadFile"];
                if (f != null && f.ContentLength > 0)
                {

                    string FileName = System.IO.Path.GetFileName(f.FileName);
                    string filePath = Server.MapPath("/wwwroot/Images" + FileName);
                    f.SaveAs(filePath);
                    blog.Images = FileName;
                }


                blog.DateCreate = DateTime.Now;
                db.Entry(blog).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.BlogCategoryID = new SelectList(db.BlogCategories, "BlogCategoryID", "BlogCategoryName", blog.BlogCategoryID);
            return View(blog);
        }

        // GET: Admin/Blogs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Blog blog = db.Blogs.Find(id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            return View(blog);
        }

        // POST: Admin/Blogs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Blog blog = db.Blogs.Find(id);
            db.Blogs.Remove(blog);
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
