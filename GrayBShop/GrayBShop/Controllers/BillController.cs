using GrayBShop.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Controllers
{
    public class BillController : Controller
    {
        GrayShop db = new GrayShop();
        // GET: Bill
        [HttpGet]
        public ActionResult Index(int? page)
        {
            if (Session[GrayBShop.Session.ConstainUser.USER_SESSION] == null || Session[GrayBShop.Session.ConstainUser.USER_SESSION].ToString() == "")
            {
                return RedirectToAction("Login", "Home");
            }
            List<Order> list = new List<Order>();
            User tk = (User)Session[GrayBShop.Session.ConstainUser.USER_SESSION];
            list = db.Orders.Where(p => p.UserID == tk.UserID).OrderByDescending(x => x.DateCreate).ToList();
            int pageSize = 8;
            int pageNumber = (page ?? 1);
            return View(list.ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult Details(int id)
        {
            User tk = (User)Session[GrayBShop.Session.ConstainUser.USER_SESSION];
            if (tk == null)
            {
                return RedirectToAction("PageNotFound", "Error");
            }
            else
            {
                if (db.Orders.FirstOrDefault(x => x.UserID == tk.UserID) == null)
                {
                    return RedirectToAction("PageNotFound", "Error");
                }
            }
            var hoadons = db.OrderDetails.Where(x => x.OrderID == id).ToList();
            var sanphams = new List<CartItem>();
            foreach (var item in hoadons)
            {
                var sanpham = new CartItem();
                sanpham.ProductDetail = item.ProductDetail;
                if (item.ProductDetail.ImageProduct.Product.Sale != null)
                {
                    sanpham.Price = item.ProductDetail.ImageProduct.Product.Price - (item.ProductDetail.ImageProduct.Product.Price * item.ProductDetail.ImageProduct.Product.Sale.SalePercent / 100);
                }
                else
                {
                    sanpham.Price = item.ProductDetail.ImageProduct.Product.Price;
                }
                sanpham.ImageID = item.ImageID;
                sanpham.Amount = item.Amount;
                sanpham.Size = item.Size;
                sanphams.Add(sanpham);
            }
            var hoadon = db.Orders.Where(x => x.OrderID == id).FirstOrDefault();
            ViewBag.HoaDon = hoadon;
            return View(sanphams);
        }


        [HttpPost]
        public ActionResult Details(int id, FormCollection collection)
        {

            User tk = (User)Session[GrayBShop.Session.ConstainUser.USER_SESSION];
            var hoaDon = db.Orders.Where(x => x.OrderID == id).FirstOrDefault();
            hoaDon.UserID = tk.UserID;
            hoaDon.UserName = collection["name"];
            hoaDon.Phone = collection["phone"];
            hoaDon.Email = collection["email"];
            hoaDon.Address = collection["address"];
            hoaDon.Note = collection["note"];
            db.SaveChanges();
            var hoadons = db.OrderDetails.Where(x => x.OrderID == id).ToList();
            var sanphams = new List<CartItem>();
            foreach (var item in hoadons)
            {
                var sanpham = new CartItem();
                sanpham.ProductDetail = item.ProductDetail;
                if (item.ProductDetail.ImageProduct.Product.Sale != null)
                {
                    sanpham.Price = item.ProductDetail.ImageProduct.Product.Price - (item.ProductDetail.ImageProduct.Product.Price * item.ProductDetail.ImageProduct.Product.Sale.SalePercent / 100);
                }
                else
                {
                    sanpham.Price = item.ProductDetail.ImageProduct.Product.Price;
                }
                sanpham.ImageID = item.ImageID;
                sanpham.Amount = item.Amount;
                sanpham.Size = item.Size;
                sanphams.Add(sanpham);
            }
            var hoadon = db.Orders.Where(x => x.OrderID == id).FirstOrDefault();
            ViewBag.HoaDon = hoadon;
            return View(sanphams);
        }
        [HttpPost]
        public JsonResult ChangeStatus(int mahd, string stt)
        {
            try
            {
                User tk = (User)Session[GrayBShop.Session.ConstainUser.USER_SESSION];
                Order hd = db.Orders.Where(x => x.OrderID == mahd).FirstOrDefault();
                if (hd.Status == "Đã thanh toán" || hd.Status == "Đang giao hàng")
                {
                    return Json(new { status = false }, JsonRequestBehavior.AllowGet);
                }
                hd.Status = stt;
                
                if (hd.Status=="Đã hủy")
                {
                    hd.Status = stt;
                    var list = hd.OrderDetails.ToList();
                    foreach (var item in list)
                    {
                        var sl = db.Products.Where(p => p.ProductID == item.ProductDetail.ImageProduct.ProductID).FirstOrDefault();
                        sl.AmountInput = sl.AmountInput + item.Amount;
                    }
                    db.SaveChanges();
                    return Json(new { status = true }, JsonRequestBehavior.AllowGet);
                }
                db.SaveChanges();
                return Json(new { status = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new { status = false }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}