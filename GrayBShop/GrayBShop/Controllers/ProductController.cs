using GrayBShop.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Controllers
{
    public class ProductController : Controller
    {
        GrayShop db = new GrayShop();
        // GET: Product
        [HttpGet]
        public ActionResult Index(string searchString, string searchPrice, string madm, int? page)
        {

            ViewBag.searchString = searchString;
            ViewBag.searchPrice = searchPrice;
            ICollection<DetailProduct> sanphams = (from p in db.Products
                                                   join a in db.ImageProducts on p.ProductID equals a.ProductID
                                                   where p.CategoryID == madm
                                                   select new DetailProduct()
                                                   {
                                                       CategoryID = p.CategoryID,
                                                       ProductID = p.ProductID,
                                                       ProductName = p.ProductName,
                                                       Price = p.Price,
                                                       ImageID = a.ImageID,
                                                       Images = a.Images,
                                                       Description = p.Descriptions
                                                   }).ToList();
            ViewBag.madm = madm;
            var danhmuc = (from ten in db.Categories where ten.CategoryID.Equals(madm) select ten).FirstOrDefault();
            try
            {

                if (!String.IsNullOrEmpty(searchString) && !String.IsNullOrEmpty(searchPrice) && searchPrice != null)
                {
                    decimal Gia = Convert.ToDecimal(searchPrice);
                    sanphams = (from p in db.Products
                                join a in db.ImageProducts on p.ProductID equals a.ProductID
                                where p.ProductName.Contains(searchString) && Math.Abs(p.Price - Gia) <= 500000
                                select new DetailProduct()
                                {
                                    CategoryID = p.CategoryID,
                                    ProductID = p.ProductID,
                                    ProductName = p.ProductName,
                                    Price = p.Price,
                                    ImageID = a.ImageID,
                                    Images = a.Images,
                                    Description = p.Descriptions
                                }).OrderByDescending(s => s.Price).ToList();
                }
                else if (!String.IsNullOrEmpty(searchString))
                {
                    sanphams = (from p in db.Products
                                join a in db.ImageProducts on p.ProductID equals a.ProductID
                                where p.ProductName.Contains(searchString)
                                select new DetailProduct()
                                {
                                    CategoryID = p.CategoryID,
                                    ProductID = p.ProductID,
                                    ProductName = p.ProductName,
                                    Price = p.Price,
                                    ImageID = a.ImageID,
                                    Images = a.Images,
                                    Description = p.Descriptions
                                }).ToList();
                }
                else if (!String.IsNullOrEmpty(searchPrice) && searchPrice != null)
                {
                    decimal Gia = Convert.ToDecimal(searchPrice);
                    sanphams = (from p in db.Products
                                join a in db.ImageProducts on p.ProductID equals a.ProductID
                                where Math.Abs(p.Price - Gia) <= 500000
                                select new DetailProduct()
                                {
                                    CategoryID = p.CategoryID,
                                    ProductID = p.ProductID,
                                    ProductName = p.ProductName,
                                    Price = p.Price,
                                    ImageID = a.ImageID,
                                    Images = a.Images,
                                    Description = p.Descriptions
                                }).OrderByDescending(s => s.Price).ToList();
                }
                else if (madm == null)
                {
                    sanphams = (from p in db.Products
                                join a in db.ImageProducts on p.ProductID equals a.ProductID
                                select new DetailProduct()
                                {
                                    CategoryID = p.CategoryID,
                                    ProductID = p.ProductID,
                                    ProductName = p.ProductName,
                                    Price = p.Price,
                                    ImageID = a.ImageID,
                                    Images = a.Images,
                                    Description = p.Descriptions
                                }).OrderByDescending(s => s.DateCreate).ToList();
                }
            }
            catch (Exception)
            {

            }
            ICollection<DetailProduct> products = Filter(sanphams, 100);
            if (products.Count() == 0)
            {
                ViewBag.Error = "Không tìm được sản phẩm phù hợp!";
            }
            int pageSize = 9;
            int pageNumber = (page ?? 1);
            return View(products.ToPagedList(pageNumber, pageSize));
        }

        

        public ActionResult DetailProduct(string id, int maImage, string madm)
        {
            //SanPham sp = db.SanPhams.Include("DanhMucSP").Where(s => s.MaSP.Equals(id)).FirstOrDefault();

            var sanpham = (from p in db.Products
                           join a in db.ImageProducts on p.ProductID equals a.ProductID
                           where p.ProductID.Equals(id) && a.ImageID == maImage
                           select new DetailProduct()
                           {
                               CategoryID = p.CategoryID,
                               ProductID = p.ProductID,
                               ProductName = p.ProductName,
                               Price = p.Price,
                               ImageID = a.ImageID,
                               Images = a.Images,
                               Description = p.Descriptions
                           }).FirstOrDefault();
            //int maImage = sanpham.maANh;
            ICollection<ImageProduct> listAnh = (from a in db.ImageProducts
                                            where a.ProductID.Equals(id)
                                            select a).ToList();
            ICollection<ProductDetail> listSize = (from s in db.ProductDetails
                                                    where s.ImageID.Equals(maImage)
                                                    select s).ToList();
            ICollection<DetailProduct> Products = (from p in db.Products
                                                   join a in db.ImageProducts on p.ProductID equals a.ProductID
                                                   where p.CategoryID == madm
                                                   select new DetailProduct()
                                                   {
                                                       CategoryID = p.CategoryID,
                                                       ProductID = p.ProductID,
                                                       ProductName = p.ProductName,
                                                       Price = p.Price,
                                                       ImageID = a.ImageID,
                                                       Images = a.Images,
                                                       Description = p.Descriptions
                                                   }).ToList();
            ICollection<DetailProduct> RelateProducts = Filter(Products, 4);
            ViewBag.Images = listAnh;
            ViewBag.SizeList = listSize;
            ViewBag.ListRelate = RelateProducts;
            ViewBag.check = RelateProducts.Count();
            return View(sanpham);
        }
        private ICollection<DetailProduct> Filter(ICollection<DetailProduct> products, int count)
        {
            List<DetailProduct> list = new List<DetailProduct>();
            foreach (var item in products)
            {
                int dem = 0;
                foreach (var t in list)
                {
                    if (item.ProductID == t.ProductID)
                        dem++;
                }
                if (dem == 0 && list.Count() < count)
                    list.Add(item);
            }
            return list;
        }
    }
}