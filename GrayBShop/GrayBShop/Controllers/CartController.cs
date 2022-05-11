using GrayBShop.Models;
using GrayBShop.Session;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace GrayBShop.Controllers
{
    public class CartController : Controller
    {
        GrayShop db = new GrayShop();
        // GET: Cart
        public ActionResult Index()
        {
            var cart = Session[ConstainCart.CartSession];
            var list = new List<CartItem>();
            if (cart != null)
            {
                list = (List<CartItem>)cart;
            }
            return View(list);
        }
        public JsonResult AddCart(int maSP, int kichCo, string ProductID)
        {
            var SanPham = db.ProductDetails.Where(p => p.ImageID == maSP).FirstOrDefault();
            var cart = Session[ConstainCart.CartSession];
            if (cart != null)
            {
                var list = (List<CartItem>)cart;
                if (list.Exists(x => x.ProductDetail.ImageID == maSP && x.Size == kichCo))
                {
                    foreach (var item in list)
                    {
                        if (item.Amount >= SanPham.ImageProduct.Product.AmountInput)
                        {
                            return Json(new { status = false });
                        }
                        if (item.ProductDetail.ImageID == maSP && item.Size == kichCo)
                            item.Amount += 1;
                        
                    }
                }
                else
                {
                    var item = new CartItem();
                    item.ProductDetail = SanPham;
                    item.ImageID = SanPham.ImageID;
                    item.ProductID = SanPham.ImageProduct.ProductID;
                    item.Size = kichCo;
                    if (SanPham.ImageProduct.Product.Sale != null)
                    {
                        item.Price = SanPham.ImageProduct.Product.Price-(SanPham.ImageProduct.Product.Price* SanPham.ImageProduct.Product.Sale.SalePercent/100);
                    }
                    else
                    {
                        item.Price = SanPham.ImageProduct.Product.Price;
                    }
                    item.Amount = 1;
                    
                    list.Add(item);
                }
                Session[ConstainCart.CartSession] = list;
            }
            else
            {
                var item = new CartItem();
                item.ProductDetail = SanPham;
                item.ImageID = SanPham.ImageID;
                item.Size = kichCo;
                item.Amount = 1;
                if (SanPham.ImageProduct.Product.Sale != null)
                {
                    item.Price = SanPham.ImageProduct.Product.Price - (SanPham.ImageProduct.Product.Price * SanPham.ImageProduct.Product.Sale.SalePercent / 100);
                }
                else
                {
                    item.Price = SanPham.ImageProduct.Product.Price;
                }
                var list = new List<CartItem>();
                list.Add(item);
                Session[ConstainCart.CartSession] = list;
            }
            return Json(new
            {
                status = true
            });
        }

        public JsonResult Update(string cartModel)
        {
            var jsonCart = new JavaScriptSerializer().Deserialize<List<CartItem>>(cartModel);
            var sessionCart = (List<CartItem>)Session[ConstainCart.CartSession];
            foreach (var item in sessionCart)
            {
                var jsonItem = jsonCart.SingleOrDefault(x => x.ProductDetail.ImageID == item.ImageID && x.Size == item.Size);
                if (jsonItem != null)
                {
                    item.Amount = jsonItem.Amount;
                }
            }
            Session[ConstainCart.CartSession] = sessionCart;
            return Json(sessionCart, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Delete(int MaAnh, int KichCo)
        {
            var sessionCart = (List<CartItem>)Session[ConstainCart.CartSession];
            sessionCart.RemoveAll(x => x.ImageID == MaAnh && x.Size == KichCo);
            Session[ConstainCart.CartSession] = sessionCart;
            return Json(sessionCart, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult Payment()
        {

            if (Session[GrayBShop.Session.ConstainUser.USER_SESSION] == null || Session[GrayBShop.Session.ConstainUser.USER_SESSION].ToString() == "")
            {
                return RedirectToAction("Login", "Home");
            }
            else
            {
                var cart = Session[ConstainCart.CartSession];
                var list = new List<CartItem>();
                //var check = db.Products.ToList();
                
                if (cart != null)
                {
                    list = (List<CartItem>)cart;
                    foreach (var item in list)
                    {
                        var check = db.Products.Where(p => p.ProductID == item.ProductDetail.ImageProduct.Product.ProductID).FirstOrDefault();
                        if (item.Amount >= check.AmountInput)
                        {
                            return Json(new { status = false });
                        }
                    }
                }
                return View(list);
            }
        }

        public ActionResult Payment(FormCollection collection)
        {
            //Thêm đơn hàng
            Order hoaDon = new Order();
            User tk = (User)Session[GrayBShop.Session.ConstainUser.USER_SESSION];
            hoaDon.UserID = tk.UserID;
            hoaDon.UserName = collection["name"];
            hoaDon.Phone = collection["phone"];
            hoaDon.Email = collection["email"];
            hoaDon.Address = collection["address"];
            hoaDon.Note = collection["note"];
            hoaDon.DateCreate = DateTime.Now;
            hoaDon.Status = "Chờ xác nhận";
            db.Orders.Add(hoaDon);
            db.SaveChanges();
            //Thêm chi tiết đơn hàng
            var cart = Session[ConstainCart.CartSession];
            var list = new List<CartItem>();
            list = (List<CartItem>)cart;
            
            foreach (var item in list)
            {
                OrderDetail cthd = new OrderDetail();
                cthd.OrderID = hoaDon.OrderID;
                cthd.ImageID = item.ImageID;
                cthd.Size = item.Size;
                cthd.Amount = item.Amount;
                db.OrderDetails.Add(cthd);
                var sl = db.Products.Where(p => p.ProductID == item.ProductDetail.ImageProduct.ProductID).FirstOrDefault();
                sl.AmountInput = sl.AmountInput - item.Amount;
            }
            db.SaveChanges();
            Session[ConstainCart.CartSession] = null;
            return RedirectToAction("SubmitOrder", "Cart");
        }

        public ActionResult SubmitOrder()
        {
            return View();
        }
    }
}