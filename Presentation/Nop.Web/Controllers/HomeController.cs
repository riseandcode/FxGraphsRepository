using System;
using System.Web.Mvc;
using Nop.Core;
using Nop.Core.Domain.Customers;
using Nop.Core.Domain.Forums;
using Nop.Core.Domain.Localization;
using Nop.Core.Domain.Media;
using Nop.Core.Domain.Orders;
using Nop.Core.Domain.Tax;
using Nop.Services.Authentication;
using Nop.Services.Authentication.External;
using Nop.Services.Catalog;
using Nop.Services.Common;
using Nop.Services.Customers;
using Nop.Services.Directory;
using Nop.Services.Forums;
using Nop.Services.Helpers;
using Nop.Services.Localization;
using Nop.Services.Media;
using Nop.Services.Messages;
using Nop.Services.Orders;
using Nop.Services.Tax;
using Nop.Web.Framework.UI.Captcha;
using Nop.Web.Models.Customer;

namespace Nop.Web.Controllers
{
    public class HomeController : BaseNopController
    {
        
        public ActionResult Index()
        {
            if (!User.Identity.IsAuthenticated)
                return View("Home");
            return View();
        }

        public ActionResult Account()
        {
            return View();
        }

        public ActionResult Activate()
        {
            return View();
        }

        public ActionResult Advisors()
        {
            return View();
        }

        public ActionResult Download()
        {
            return View();
        }

        public ActionResult FAQ()
        {
            return View();
        }

        public ActionResult FAQ2()
        {
            return View();
        }

        public ActionResult Forex()
        {
            return View();
        }

        public ActionResult Free()
        {
            return View();
        }

        public ActionResult Help()
        {
            return View();
        }
        
        public ActionResult Home()
        {
            return View();
        }

        public ActionResult Load()
        {
            return View();
        }

        public ActionResult Login()
        {

            return View();
        } 
        
        public ActionResult News()
        {
            return View();
        }

        public ActionResult Open()
        {
            return View();
        }

        public ActionResult Partner()
        {
            return View();
        }

        public ActionResult Registration()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            return View("Index", model);
            
        }
    }
}
