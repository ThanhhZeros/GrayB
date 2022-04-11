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
    public class ImageProductsController : BaseController
    {
        private GrayShop db = new GrayShop();

        // GET: Admin/ImageProducts
        public ActionResult Index()
        {
            var imageProducts = db.ImageProducts.Include(i => i.Product);
            return View(imageProducts.ToList());
        }

        // GET: Admin/ImageProducts/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ImageProduct imageProduct = db.ImageProducts.Find(id);
            if (imageProduct == null)
            {
                return HttpNotFound();
            }
            return View(imageProduct);
        }

        // GET: Admin/ImageProducts/Create
        public ActionResult Create()
        {
            ViewBag.ProductID = new SelectList(db.Products, "ProductID", "ProductName");
            return View();
        }

        // POST: Admin/ImageProducts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ImageID,Images,ProductID")] ImageProduct imageProduct)
        {
            if (ModelState.IsValid)
            {
                db.ImageProducts.Add(imageProduct);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ProductID = new SelectList(db.Products, "ProductID", "ProductName", imageProduct.ProductID);
            return View(imageProduct);
        }

        // GET: Admin/ImageProducts/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ImageProduct imageProduct = db.ImageProducts.Find(id);
            if (imageProduct == null)
            {
                return HttpNotFound();
            }
            ViewBag.ProductID = new SelectList(db.Products, "ProductID", "ProductName", imageProduct.ProductID);
            return View(imageProduct);
        }

        // POST: Admin/ImageProducts/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ImageID,Images,ProductID")] ImageProduct imageProduct)
        {
            if (ModelState.IsValid)
            {
                db.Entry(imageProduct).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ProductID = new SelectList(db.Products, "ProductID", "ProductName", imageProduct.ProductID);
            return View(imageProduct);
        }

        // GET: Admin/ImageProducts/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ImageProduct imageProduct = db.ImageProducts.Find(id);
            if (imageProduct == null)
            {
                return HttpNotFound();
            }
            return View(imageProduct);
        }

        // POST: Admin/ImageProducts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ImageProduct imageProduct = db.ImageProducts.Find(id);
            db.ImageProducts.Remove(imageProduct);
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
