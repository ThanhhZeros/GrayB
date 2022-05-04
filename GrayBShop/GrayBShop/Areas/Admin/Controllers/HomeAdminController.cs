using GrayBShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Areas.Admin.Controllers
{
    public class HomeAdminController : BaseController
    {
        GrayShop db = new GrayShop();
        // GET: Admin/HomeAdmin
        public ActionResult Index()
        {
            int? dem = 0,demsp=0;
            decimal dt = 0;
            int thang, nam;
            foreach (var item in db.Orders)
            {
                if (item.Status.Equals("Chờ xác nhận"))
                {
                    dem++;
                }
            }
            ViewBag.tong = dem;
            demsp=db.Products.Count();
            ViewBag.tongsp = demsp;
            
            if (DateTime.Now.Month == 1)
            {
                thang = 12;
                nam = DateTime.Now.Year - 1;
            }
            else
            {
                thang = DateTime.Now.Month - 1;
                nam = DateTime.Now.Year;
            }
            var list = db.Orders.Where(p => p.DateCreate.Month == thang && p.DateCreate.Year == nam && p.Status == "Đã thanh toán");
            foreach (var item in list)
            {
                dt +=decimal.Parse(item.OrderDetails.Sum(p => p.Amount * p.ProductDetail.ImageProduct.Product.Price).ToString());
            }
            ViewBag.doanhthu = dt;
            int[] dataOfYear = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            for (int i = 0; i < 12; i++)
            {
                int month = i + 1;
                decimal data = 0;
                try
                {
                    var listdt = db.Orders.Where(b => b.DateCreate.Month == month &&b.DateCreate.Year==DateTime.Now.Year && b.Status=="Đã thanh toán");
                    foreach (var item in listdt)
                    {
                        data += decimal.Parse(item.OrderDetails.Sum(p => p.Amount * p.ProductDetail.ImageProduct.Product.Price).ToString());
                    }
                }
                catch (Exception ex)
                {

                }
                dataOfYear[i] = (int)data;
            }
            ViewBag.dataOfYear = dataOfYear;
            int countlh = 0;
            countlh = db.Contacts.Count();
            ViewBag.LienHe = countlh;
            return View();
        }
    }
}