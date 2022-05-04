using GrayBShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Controllers
{
    public class ContactClientController : Controller
    {
        GrayShop db = new GrayShop();
        // GET: ContactClient
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Index([Bind(Include = "ContactID,CustomerName,Content,Email,Phone,Status,DateContact")] Contact contact)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    contact.DateContact = DateTime.Now;
                    contact.Status = true;
                    ViewBag.Success = "Ý kiến đóng góp của bạn đã gửi đến quản trị viên!";
                    db.Contacts.Add(contact);
                    db.SaveChanges();
                    return RedirectToAction("Contact");
                }
                return View(contact);
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Lỗi edit dữ liệu! " + ex.Message;
                return View();
            }


        }
    }
}