using GrayBShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrayBShop.Controllers
{
    public class NewFeedController : Controller
    {
        GrayShop db =new GrayShop();
        // GET: NewFeed
        public ActionResult Index()
        {
            var list = (from tt in db.Blogs select tt);
            ICollection<Blog> news = (from tt in db.Blogs orderby tt.DateCreate select tt).ToList();
            Blog newsfisrt = (from tt in db.Blogs orderby tt.DateCreate select tt).FirstOrDefault();
            ViewBag.news = news;
            return View(newsfisrt);
        }
        public ActionResult Single(int ma)
        {
            var newfeed = (from tt in db.Blogs where tt.BlogID.Equals(ma) select tt).FirstOrDefault();
            return View(newfeed);
        }
    }
}