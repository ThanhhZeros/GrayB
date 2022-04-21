using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using GrayBShop.Models;
using PagedList;

namespace GrayBShop.Areas.Admin.Controllers
{
    public class ProductsController : BaseController
    {
        private GrayShop db = new GrayShop();

        // GET: Admin/Products
        public ActionResult Index(string sortOrder, string searchString, string currentFilter, int? page)
        {
            var result = db.Products.Join(db.ImageProducts, p => p.ProductID, a => a.ProductID, (p, a) => new DetailProduct
            {
                ProductID = p.ProductID,
                ProductName = p.ProductName,
                CategoryID = p.Category.CategoryName,
                Images = a.Images,
                Description = p.Descriptions,
                Price = p.Price,
                SaleID=p.Sale.SalePercent,
                DateUpdate = p.DateUpdate

            }).ToList();
            var productDetails = new List<DetailProduct>();
            foreach (var item in result)
            {
                int dem = 0;
                foreach (var t in productDetails)
                {
                    if (item.ProductID.Equals(t.ProductID))
                        dem++;
                }
                if (dem == 0)
                    productDetails.Add(item);
            }
            productDetails = productDetails.OrderByDescending(p => p.DateUpdate).ToList();
            ViewBag.CurrentSort = sortOrder;
            ViewBag.SapTheoTen = String.IsNullOrEmpty(sortOrder) ? "ten_desc" : "";
            ViewBag.SapTheoGia = sortOrder == "gia" ? "gia_desc" : "gia";
            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }
            ViewBag.CurrentFilter = searchString;
            if (!String.IsNullOrEmpty(searchString))
            {
                productDetails = productDetails.Where(p => p.ProductName.ToLower().Contains(searchString.ToLower())).ToList();
            }
            switch (sortOrder)
            {
                case "ten_desc":
                    productDetails = productDetails.OrderByDescending(p => p.ProductName).ToList();
                    break;
                case "gia":
                    productDetails = productDetails.OrderBy(p => p.Price).ToList();
                    break;
                case "gia_desc":
                    productDetails = productDetails.OrderByDescending(p => p.Price).ToList();
                    break;
                default:
                    productDetails = productDetails.OrderByDescending(p => p.DateUpdate).ToList();
                    break;
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(productDetails.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/Products/Details/5
        public ActionResult Details(string id)
        {
            try
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }

                Product sanPham = db.Products.Find(id);
                if (sanPham == null)
                {
                    return HttpNotFound();
                }
                var images = db.ImageProducts.Where(p => p.ProductID == id).ToList();
                var maAnh = 0;
                string filePath = "";
                if (images != null)
                {
                    foreach (var item in images)
                    {
                        filePath += item.Images + ";";
                        maAnh = item.ImageID;
                    }
                }
                filePath = filePath.Substring(0, filePath.Length - 1);
                ViewBag.filePath = filePath;
                var sizes = db.ProductDetails.Where(p => p.ImageID == maAnh).ToList();
                string listSize = "";
                if (sizes != null)
                {
                    foreach (var item in sizes)
                    {
                        listSize += item.Size + "; ";
                    }
                }
                listSize = listSize.Substring(0, listSize.Length - 2);
                ViewBag.listSize = listSize;
                return View(sanPham);
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi !" + ex.Message;
                return View();
            }

        }

        // GET: Admin/Products/Create
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.SaleID = new SelectList(db.Sales, "SaleID", "SalePercent");
            return View();
        }

        // POST: Admin/Products/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Create(DetailProduct productDetail, List<HttpPostedFileBase> uploadFile)
        {
            try
            {
                productDetail.Images = "";
                if (ModelState.IsValid)
                {
                    Product sanPham = new Product();
                    string maSP = "";
                    var list = db.Products.ToList();
                    var sanpham = list.LastOrDefault();
                    if (sanpham == null)
                    {
                        maSP = "SP001";
                    }
                    else
                    {
                        int index = int.Parse(sanpham.ProductID.Substring(2, 3)) + 1;
                        maSP = "SP" + string.Format(CultureInfo.CreateSpecificCulture("da-DK"), "{0:000}", index);
                    }
                    sanPham.ProductID = maSP;
                    sanPham.ProductName = productDetail.ProductName;
                    sanPham.CategoryID = productDetail.CategoryID;
                    sanPham.Descriptions = productDetail.Description;
                    sanPham.Price = productDetail.Price;
                    sanPham.SaleID = productDetail.SaleID;
                    sanPham.DateCreate = DateTime.Now;
                    sanPham.DateUpdate = DateTime.Now;
                    db.Products.Add(sanPham);
                    db.SaveChanges();
                    //Add Anh
                    string[] sizes = productDetail.Size.Split(';');
                    foreach (var item in uploadFile)
                    {
                        ImageProduct anhMoTa = new ImageProduct();
                        string FileName = item.FileName;
                        string filePath = Path.Combine(HttpContext.Server.MapPath("/wwwroot/Images"),
                                                       Path.GetFileName(item.FileName));
                        item.SaveAs(filePath);
                        anhMoTa.Images = FileName;
                        anhMoTa.ProductID = maSP;
                        db.ImageProducts.Add(anhMoTa);
                        db.SaveChanges();
                        //Add san pham chi tiet
                        for (int j = 0; j < sizes.Length; j++)
                        {
                            ProductDetail chiTietSanPham = new ProductDetail();
                            chiTietSanPham.ImageID = anhMoTa.ImageID;
                            chiTietSanPham.Size = int.Parse(sizes[j]);
                            db.ProductDetails.Add(chiTietSanPham);
                            db.SaveChanges();
                        }
                    }

                    return RedirectToAction("Index");
                }
                ViewBag.MaDM = new SelectList(db.Categories, "CategoryID", "CategoryName", productDetail.CategoryID);
                ViewBag.SaleID = new SelectList(db.Sales, "SaleID", "SalePercent", productDetail.SaleID);
                return View(productDetail);
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi nhập dữ liệu !" + ex.Message;
                ViewBag.MaDM = new SelectList(db.Categories, "CategoryID", "CategoryName", productDetail.CategoryID);
                ViewBag.SaleID = new SelectList(db.Sales, "SaleID", "SalePercent", productDetail.SaleID);
                return View(productDetail);

            }
        }

        // GET: Admin/Products/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            int maAnh = 0;
            var images = db.ImageProducts.Where(p => p.ProductID == id).ToList();
            string filePath = "";
            if (images != null)
            {
                foreach (var item in images)
                {
                    maAnh = item.ImageID;
                    filePath += item.Images + ";";
                }
            }
            filePath = filePath.Substring(0, filePath.Length - 1);
            ViewBag.filePath = filePath;
            string listSize = "";
            var sizes = db.ProductDetails.Where(p => p.ImageID == maAnh).ToList();
            if (sizes != null)
            {
                foreach (var item in sizes)
                {
                    listSize += item.Size + ";";
                }
            }
            listSize = listSize.Substring(0, listSize.Length - 1);
            ViewBag.listSize = listSize;
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            ViewBag.SaleID = new SelectList(db.Sales, "SaleID", "SalePercent", product.SaleID);
            DetailProduct productDetail = new DetailProduct()
            {
                ProductID = product.ProductID,
                ProductName = product.ProductName,
                Price = product.Price,
                Images = filePath,
                Size = listSize,
                Description = product.Descriptions,
                CategoryID = product.CategoryID,
                DateCreate = product.DateCreate,
                DateUpdate = product.DateUpdate,
                SaleID=product.SaleID,
                Sale=product.Sale,
                Category = product.Category
            };
            return View(productDetail);
            
        }

        // POST: Admin/Products/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(DetailProduct productDetail, List<HttpPostedFileBase> uploadFile, string id)
        {
            try
            {
                if (productDetail.Images == null && uploadFile == null)
                {
                    ViewBag.Error = "Chọn ảnh !";
                    ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", productDetail.CategoryID);
                    ViewBag.SaleID = new SelectList(db.Sales, "SaleID", "SalePercent", productDetail.SaleID);
                    return View(productDetail);
                }
                if (ModelState.IsValid)
                {
                    var sanPham = db.Products.Where(p => p.ProductID == id).FirstOrDefault();
                    sanPham.ProductName = productDetail.ProductName;
                    sanPham.Descriptions = productDetail.Description;
                    sanPham.Price = productDetail.Price;
                    sanPham.CategoryID = productDetail.CategoryID;
                    sanPham.SaleID = productDetail.SaleID;
                    sanPham.DateUpdate = DateTime.Now;
                    db.SaveChanges();
                    string[] sizes = productDetail.Size.Split(';');
                    //Xóa ảnh cũ bị loại bỏ
                    var listimages = db.ImageProducts.Where(p => p.ProductID == id).ToList();

                    //string[] newimages = productDetail.Anh;
                    if (productDetail.Images != null)
                    {
                        string[] newimages = productDetail.Images.Split(';');
                        foreach (var item in listimages)
                        {
                            int dem = 0;
                            for (int i = 0; i < newimages.Length; i++)
                                if (item.Images == newimages[i])
                                    dem++;
                            if (dem == 0)
                            {
                                db.ImageProducts.Remove(item);
                                db.SaveChanges();
                            }
                            else
                            {
                                //Cập nhật lại size cho ảnh cũ
                                var sizecu = db.ProductDetails.Where(p => p.ImageID == item.ImageID);
                                foreach (var itemcu in sizecu)
                                {
                                    db.ProductDetails.Remove(itemcu);
                                }
                                for (int j = 0; j < sizes.Length; j++)
                                {
                                    ProductDetail chiTietSanPham = new ProductDetail();
                                    chiTietSanPham.ImageID = item.ImageID;
                                    chiTietSanPham.Size = int.Parse(sizes[j]);
                                    db.ProductDetails.Add(chiTietSanPham);
                                }
                            }
                        }
                    }
                    else
                    {
                        foreach (var item in listimages)
                        {
                            db.ImageProducts.Remove(item);
                            db.SaveChanges();
                        }
                    }

                    //Lưu thêm ảnh mới
                    if (uploadFile != null)
                    {
                        foreach (var item in uploadFile)
                        {
                            if (item != null)
                            {
                                ImageProduct anhMoTa = new ImageProduct();
                                string FileName = item.FileName;
                                string filePath = Path.Combine(HttpContext.Server.MapPath("/wwwroot/Images"),
                                                               Path.GetFileName(item.FileName));
                                item.SaveAs(filePath);
                                anhMoTa.Images = FileName;
                                anhMoTa.ProductID =id;
                                db.ImageProducts.Add(anhMoTa);
                                db.SaveChanges();

                                //Add san pham chi tiet
                                for (int j = 0; j < sizes.Length; j++)
                                {
                                    ProductDetail chiTietSanPham = new ProductDetail();
                                    chiTietSanPham.ImageID = anhMoTa.ImageID;
                                    chiTietSanPham.Size = int.Parse(sizes[j]);
                                    db.ProductDetails.Add(chiTietSanPham);
                                }
                                db.SaveChanges();
                            }
                        }
                    }

                }
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi nhập dữ liệu !" + ex.Message;
                ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", productDetail.CategoryID);
                ViewBag.SaleID = new SelectList(db.Sales, "SaleID", "SalePercent", productDetail.SaleID);
                return View(productDetail);

            }
        }

        // GET: Admin/Products/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Admin/Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
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
        public ActionResult Add()
        {
            return View();
        }
    }
}
