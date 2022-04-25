using GrayBShop.Areas.Admin.Data;
using GrayBShop.Models;
using GrayBShop.Session;
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
                              SaleID = p.SaleID,
                              Sale=p.Sale,
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
                                                         SaleID = hotsp.FirstOrDefault().p.SaleID,
                                                         Sale=hotsp.FirstOrDefault().p.Sale,
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
        [HttpGet]
        public ActionResult Contact()
        {
            return View();
        }
        [ChildActionOnly]
        public ActionResult DanhMuc()
        {
            IEnumerable<Category> danhmucs = db.Categories.Select(p => p);
            return PartialView(danhmucs);
        }
        [ChildActionOnly]
        public ActionResult SearchBox()
        {

            return PartialView();
        }
        [HttpGet]
        public ActionResult Login()
        {
            /*TaiKhoanNguoiDung session = (TaiKhoanNguoiDung)Session[ShoesShopOnline.Session.ConstaintUser.USER_SESSION];
            if (session != null)
            {
                return RedirectToAction("PageNotFound", "Error");
            }*/
            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginAccount loginAccount)
        {
            if (ModelState.IsValid)
            {
                User tk = db.Users.Where
                (a => a.UserName.Equals(loginAccount.username) && a.Password.Equals(loginAccount.password) && a.RoleID==3).FirstOrDefault();
                if (tk != null)
                {
                    if (tk.Status == false)
                    {
                        ModelState.AddModelError("ErrorLogin", "Tài khoản của bạn đã bị vô hiệu hóa !");
                    }
                    else
                    {
                        Session.Add(ConstainUser.USER_SESSION, tk);
                        return RedirectToAction("Index", "Home");
                    }
                }
                else
                {
                    ModelState.AddModelError("ErrorLogin", "Tài khoản hoặc mật khẩu không đúng!");
                }
            }
            return View(loginAccount);
        }
        [HttpGet]
        public ActionResult Logout()
        {
            Session.Remove(ConstainUser.USER_SESSION);
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult SignUp()
        {
            User session = (User)Session[GrayBShop.Session.ConstainUser.USER_SESSION];
            if (session != null)
            {
                return RedirectToAction("PageNotFound", "Error");
            }
            return View();
        }

        [HttpPost]
        public ActionResult SignUp(User tk)
        {
            User check = db.Users.Where
                (a => a.UserName.Equals(tk.UserName)).FirstOrDefault();
            if (check != null)
            {
                ModelState.AddModelError("ErrorSignUp", "Tên đăng nhập đã tồn tại");
            }
            else
            {
                try
                {
                    tk.Status = true;
                    tk.RoleID = 3;
                    db.Users.Add(tk);
                    db.SaveChanges();
                    User session = db.Users.Where(a => a.UserName.Equals(tk.UserName)).FirstOrDefault();
                    Session[GrayBShop.Session.ConstainUser.USER_SESSION] = session;
                    return RedirectToAction("Index", "Home");
                }
                catch (Exception)
                {
                    ModelState.AddModelError("ErrorSignUp", "Đăng ký không thành công. Thử lại sau !");
                }
            }

            return View(tk);
        }
        [ChildActionOnly]
        public PartialViewResult HeaderCart()
        {
            var cart = Session[ConstainCart.CartSession];
            var list = new List<CartItem>();

            if (cart != null)
            {
                list = (List<CartItem>)cart;
            }
            return PartialView(list);
        }
    }
}