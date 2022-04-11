﻿using GrayBShop.Areas.Admin.Data;
using GrayBShop.Models;
using GrayBShop.Session;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        GrayShop db = new GrayShop();
        // GET: Admin/Login
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Index(LoginAccount loginAccount)
        {
            if (ModelState.IsValid)
            {
                User tk = db.Users.Where(a => a.UserName.Equals(loginAccount.username)
                && a.Password.Equals(loginAccount.password) && a.RoleID!=3).SingleOrDefault();
                if (tk != null)
                {
                    if (tk.Status == false)
                    {
                        ModelState.AddModelError("ErrorLogin", "Tài khoản đã bị vô hiệu hóa! Liên hệ quản trị viên!");
                    }
                    else
                    {
                        Session.Add(ConstainUser.ADMIN_SESSION, tk);
                        return RedirectToAction("Index", "HomeAdmin");
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
            Session.Remove(ConstainUser.ADMIN_SESSION);
            return RedirectToAction("Index");
        }
    }
}