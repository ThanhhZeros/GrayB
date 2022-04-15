using GrayBShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Controllers
{
    public class HomeController : Controller
    {
        GrayShop db = new GrayShop();
        // GET: Home
        public ActionResult Index()
        {
            ICollection<DetailProduct> sanphamnew = (from s in db.Products select new DetailProduct { }).ToList();
            sanphamnew = (from p in db.Products
                          join a in db.ImageProducts on p.ProductID equals a.ProductID
                          orderby p.DateCreate descending
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
            //get products hot
            ICollection<DetailProduct> sanphamhot = (from hot in db.OrderDetails
                                                     join chsp in db.OrderDetails on hot.ImageID equals chsp.ImageID
                                                     join a in db.ImageProducts on chsp.ImageID equals a.ImageID
                                                     join p in db.Products on a.ProductID equals p.ProductID
                                                     select new
                                                     {
                                                         hot,
                                                         chsp,
                                                         a,
                                                         p
                                                     } into t1
                                                     group t1 by t1.hot.ImageID into hotsp
                                                     orderby hotsp.Count()
                                                     select new DetailProduct
                                                     {
                                                         CategoryID = hotsp.FirstOrDefault().p.CategoryID,
                                                         ProductID = hotsp.FirstOrDefault().p.ProductID,
                                                         ProductName = hotsp.FirstOrDefault().p.ProductName,
                                                         Price = hotsp.FirstOrDefault().p.Price,
                                                         ImageID = hotsp.FirstOrDefault().chsp.ImageID,
                                                         Images = hotsp.FirstOrDefault().a.Images,
                                                         Description = hotsp.FirstOrDefault().p.Descriptions
                                                     }).Take(8).ToList();
            ICollection<DetailProduct> products = new List<DetailProduct>();
            products = Filter(sanphamnew, 8);
            //Get newFeed
            ICollection<Blog> newfeed = (from tt in db.Blogs orderby tt.DateCreate descending select tt).Take(3).ToList();
            ViewBag.ListNewFeed = newfeed;
            //ICollection<ProductDetail> Producthot = Filter(sanphamhot,8);
            ViewBag.ListHot = sanphamhot;
            return View(products.ToList());

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