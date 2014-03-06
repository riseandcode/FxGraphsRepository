using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using DL;
using ForexBox.LanguagesLocalization;
using ForexBox.Models;
using System.Web.Security;
using System.Net.Mail;
using ForexBox.Helpers;

namespace ForexBox.Controllers
{
    public class HomeController : ForexBoxController
    {

        private const string partKey = "partnerKey";
        public const string Salt = "someckindadsfasdfdasfdasfdasfdas";
        private void AddEmailValidator()
        {
            ViewBag.Title = "Регистрация. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
        }

        public ActionResult ChangeCulture(Culture lang, string returnUrl)
        {
            if (returnUrl.Length >= 3)
            {
                returnUrl = returnUrl.Substring(3);
            }
            return Redirect("/" + lang.ToString() + returnUrl);
        }

        public ActionResult MainDesign()
        {
            return View();
        }

        public ActionResult Index()
        {
            AddEmailValidator();
            ViewBag.Title = ResourceReader.GetRes("Index", "Indextitle");
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            return View();
        }

        public ActionResult MainCabinet()
        {
            long idPartner = UsersManager.GetIdAsPartner(User.Identity.Name);
            ViewData["PartnerCode"] = idPartner;
            var m = new MainCabinetModel();
            m.Amount = AccountsManagement.GetAmountOfMoney(idPartner);
            m.PartnerAmount = AccountsManagement.GetPartnerMoney(idPartner);
            m.PartnerID = idPartner;

            return View(m);
        }

        public ActionResult PartnerArrived()
        {
            AddEmailValidator();
            var parKey = HttpContext.Request.Params[partKey].ToString();
            if (HttpContext.Request.Cookies[partKey] == null)
            {
                var cook = new HttpCookie("partnerKey", parKey);
                cook.Expires = DateTime.Now.AddHours(5);
                HttpContext.Response.Cookies.Add(cook); 
            }
            return View("Index");
        }

       
        public ActionResult Account()
        {
            AddEmailValidator();
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            ViewBag.Title = 
            ViewData["PartnerCode"] = UsersManager.GetIdAsPartner(User.Identity.Name);
            return View();
        }

        
        public ActionResult WithdrawRequest(string amount)
        {
            if(Request.IsAjaxRequest() && Request.IsAuthenticated)
            {
                var message = UsersManager.GetIdAsPartner(User.Identity.Name).ToString() + " хочет получить " + amount;
                SendMail("forexboxinfo@gmail.com", "new withdraw request", message);

                return Json(true);
            }
            return Json(false);
        }

       
        public ActionResult Withdraw()
        {
            AddEmailValidator();
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            ViewBag.Title = "Снять средства";
            ViewData["PartnerCode"] = UsersManager.GetIdAsPartner(User.Identity.Name);

            var un = HttpContext.User.Identity.Name;
            var uID = UsersManager.GetUserIDByName(un);
            var accounts = AccountsManagement.GetAccountsOfUser(uID);

            foreach (var userAccount in accounts)
            {
                userAccount.StatusDescription = userAccount.Active ? "Активен" 
                    : "В обработке";
            }

            var model = new ActivateAccountModel();
            model.BrokerID = 4;

            model.Accounts = accounts;
            //return View(model);
            return View();
        }

        public ActionResult Activate()
        {
            ViewBag.Title = "Активация счета. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";

            if (!User.Identity.IsAuthenticated)
                return View("Index");

            var un = HttpContext.User.Identity.Name;
            var uID = UsersManager.GetUserIDByName(un);
            var accounts = AccountsManagement.GetAccountsOfUser(uID);

            foreach (var userAccount in accounts)
            {
                userAccount.StatusDescription = userAccount.Active ? "Активен"
                    : "В обработке";
            }

            var model = new ActivateAccountModel();
            model.BrokerID = 4;

            model.Accounts = accounts;
            return View(model);
        }

        [HttpPost]
        [Authorize]
        //[ValidateAntiForgeryToken(Salt = "Activate")]
        public ActionResult Activate(ActivateAccountModel model)
        {
            model.BrokerID = 4;
            ViewBag.Title = "Активация счета. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            AddEmailValidator();
            if (!User.Identity.IsAuthenticated)
                return View("Index");

            var un = HttpContext.User.Identity.Name;
            var uID = UsersManager.GetUserIDByName(un);
            if(ModelState.IsValid)
            {
                var accs = AccountsManagement.GetAccountsOfUser(uID);
                bool notNeededAddtion = accs.FindAll(a => a.AccountNumber == model.AccountNumber).Count > 0;
                ModelState.Clear();
                var accounts = AccountsManagement.GetAccountsOfUser(uID);
                if (!notNeededAddtion)
                {
                    var brokers = BrokersManagement.GetBrokers();
                    string brokerName = brokers.Where(b => b.ID == model.BrokerID).First().BrokerName;
                    AccountsManagement.CreateAccount(model.AccountNumber, uID, model.BrokerID);
                    accounts = AccountsManagement.GetAccountsOfUser(uID);
                    var userMail = Membership.GetUser(User.Identity.Name).Email;
                    SendActivatedMail( model.AccountNumber.ToString(), userMail, brokerName);                    
                }

                foreach (var userAccount in accounts)
                {
                    userAccount.StatusDescription = userAccount.Active
                                                        ? "Активен"
                                                        : "В обработке";
                }

                model = new ActivateAccountModel();
                model.Accounts = accounts;
            }
            return View(model);
        }

       
        public ActionResult Advisors()
        {
            AddEmailValidator();
            ViewBag.Title = "Наши советники. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            return View();
        }
        public ActionResult Company()
        {

            ViewBag.Title = ResourceReader.GetRes("Index", "ForexBox");
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            return View();
        }
        public ActionResult Download()
        {
            ViewBag.Title = "Скачать советник. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            return View();
        }
        public ActionResult Installation()
        {
            ViewBag.Title = "Скачать советник. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            return View();
        }

        public ActionResult FAQ()
        {
            ViewBag.Title = "С чего начать?";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            return View();
        }

        public ActionResult PartnerPage()
        {
            ViewBag.Title = ResourceReader.GetRes("Index", "ForexBox");
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            return View();
        }

        public ActionResult PammCabinet()
        {
            ViewBag.Title = "ПАММ счет ForexBox. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            return View();
        }

        public ActionResult PAMM()
        {
            ViewBag.Title = "ПАММ счет ForexBox. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            return View();
        }

        public ActionResult Free()
        {
            ViewBag.Title = "Почему бессплатно. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            return View();
        }

        public ActionResult Help()
        {
            ViewBag.Title = "Контакты. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            return View();
        }

       
        public ActionResult Advisor()
        {
            ViewBag.Title = "Страница советника. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            return View();
        }

        public ActionResult Login()
        {
            ViewBag.Title = "Войти в кабинет. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            return View();
        }


        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult CheckAvailabilityUserName(string userName)
        {
            if(UsersManager.IsUserNameAvailable(userName))
            {
                return Json("true");
            }
            return Json("false");
        }

        public ActionResult CheckAvailabilityUserMail(string userMail)
        {
            if (Membership.FindUsersByEmail(userMail).Count == 0)
            {
                return Json("true");
            }
            return Json("false");
        }

        public ActionResult CheckLogin(string userName, string password)
        {
            if(Membership.ValidateUser(userName, password))
            {
                return Json("true");
            }
            return Json("false");
        }

        [HttpPost]
        public ActionResult Login(string userName, string password)
        {
            return Login1(new LogOnModel() {
             Password = password,
             UserName = userName,
             RememberMe = false
            
            }, "");
        }

        [HttpPost]
        public ActionResult Login1(LogOnModel model, string returnUrl)
        {
            ViewBag.Title = "Войти в кабинет. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            if(ModelState.IsValid)
            {

                if (Membership.ValidateUser(model.UserName, model.Password))
                {
                    FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);
                    return Json(new {Success = true });
                }
                else
                {
                    ModelState.AddModelError("", "The user name or password provided is incorrect.");
                }

            }
            return View("Login", model);
        }

        public ActionResult News()
        {
            ViewBag.Title = "Новости компании";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";            
            return View();
        }

        public ActionResult SavePaymentSession(long partnerID, string amount)
        {
            if(Request.IsAjaxRequest() && Request.IsAuthenticated)
            {
                var pInfo = new PaymentInfo();
                double resMoney;
                var resParse = double.TryParse(amount, out resMoney);
                if (resParse)
                {
                    pInfo.Amount = resMoney;
                }
                else
                {
                    if(amount.Contains('.'))
                    {
                        amount = amount.Replace('.', ',');
                    }
                    else
                    {
                        amount = amount.Replace(',', '.');
                    }

                    resParse = double.TryParse(amount, out resMoney);
                    if (resParse)
                    {
                        pInfo.Amount = resMoney;
                    }
                }
                
                pInfo.PartnerID = partnerID;
                Session["paymentInfo"] = pInfo;
                return Json(new { Success = true });
            }
            return Json(new {Success = false});
        }

        public ActionResult GetPaymentSession()
        {
            return Json(Session["paymentInfo"] ?? new { Success = false });
        }

        public ActionResult DeletePaymentSession()
        {
            Session["paymentInfo"] = null;
            return Json(new { Success = true });
        }

        public ActionResult Deposit()
        {
            AddEmailValidator();
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            ViewBag.Title = "Пополнить счет";
            ViewData["PartnerCode"] = UsersManager.GetIdAsPartner(User.Identity.Name);
            
            return View();
        }

        [Authorize]
        public ActionResult WalletSystems()
        {
            AddEmailValidator();
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            var webMoneyWallet = UsersManager.GetWebMoneyWallet(User.Identity.Name);
            var psi = new PaymentSystemItem();
            psi.PaymentSystemName = "Web money";
            psi.WalletID = webMoneyWallet;

            return View(psi);
        }


        public ActionResult UpdateBalance(double money, long partnerID)
        {
            if(Request.IsAjaxRequest() && Request.IsAuthenticated)
            {
                AccountsManagement.DepositMoney(partnerID, money);
                Session["paymentInfo"] = null;
                return Json(new { Success = true });
            }
            return Json(new { Success = false });
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken(Salt = "WalletSystems")]
        public ActionResult WalletSystems(PaymentSystemItem paymentSystem)
        {
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            UsersManager.SaveWebMoneyWallet(User.Identity.Name, paymentSystem.WalletID);


            return View(paymentSystem);
        }

        public ActionResult AdvertisementMaterials()
        {
            AddEmailValidator();
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            var adv = new AdvertisementMaterialsModel();
            adv.PartnerCode = UsersManager.GetIdAsPartner(User.Identity.Name).ToString();


            return View(adv);
        }
        public ActionResult Partner()
        {
            AddEmailValidator();
            if (!User.Identity.IsAuthenticated)
                return View("Index");
            ViewBag.Title = "Кабинет партнера";

            ViewData["PartnerCode"] = UsersManager.GetIdAsPartner(User.Identity.Name);
            
            string userName = User.Identity.Name;
            var pm = new PartnerModel();

            //http://4rexbox.com/home/PartnerArrived?partnerKey=5657


            //The URL to login
            string domain = HttpContext.Request.Url.GetLeftPart(UriPartial.Authority) + HttpRuntime.AppDomainAppVirtualPath;

            //link to send
            string link = domain + "/home/PartnerArrived?partnerKey={0}";
            link = link.Replace("//", "/");
            pm.PartnerCode = UsersManager.GetIdAsPartner(userName);
            pm.PartnerURL = string.Format(link, pm.PartnerCode);
            pm.WebMoneyWallet = UsersManager.GetWebMoneyWallet(userName);

            //return View(pm);
            return View();
        }

        public ActionResult Registration()
        {
            ViewBag.Title = "Регистрация. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            return View();
        }

        [HttpPost]
        public ActionResult Register(string userName, string email, string password, string confirmPassword, int parentID)
        {
            var rm = new RegisterModel();
            rm.ConfirmPassword = confirmPassword;
            rm.Email = email;
            rm.Password = password;
            rm.UserName = userName;
            rm.PartnerCode = parentID;
            return Register1(rm);

        }


        [HttpPost]
        public ActionResult Register1(RegisterModel model)
        {
            ViewBag.Title = "Регистрация. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            if (ModelState.IsValid)
            {
                // Attempt to register the user
                MembershipCreateStatus createStatus;
                Membership.CreateUser(model.UserName, model.Password, model.Email, null, null, true, null, out createStatus);
                if (createStatus == MembershipCreateStatus.Success)
                {
                    long ? pCode;
                    if(model.PartnerCode == 0)
                    {
                        pCode = null;
                    }
                    else
                    {
                        pCode = model.PartnerCode;
                    }
                    UsersManager.CreatePartnerRecord(model.UserName, pCode);                   
                    return Json(new { Success = true });
                 }               
                else
                {
                    ModelState.AddModelError("", ErrorCodeToString(createStatus));
                }
            }

            // If we got this far, something failed, redisplay form
            return View("Registration", model);

        }

        [Authorize]
        public ActionResult SendPammRegister(string nameSurname, string phoneNumber, string mail, string language, string depositSize)
        {
            if (User.Identity.IsAuthenticated)
            {
                string to = mail;
                string subject = nameSurname + " хочет октрыть счет";
                string body = nameSurname + " хочет открыть счет на сумму " + depositSize + " понятный ему язык: " + language;
                this.SendMail(to, subject, body);
                
                return Json(new { Success = true });
            }
            return Json(new { Success = false });
        }

        [Authorize]
        public ActionResult Success()
        {
            ViewData["PartnerCode"] = UsersManager.GetIdAsPartner(User.Identity.Name);
            return View();
        }

        [Authorize]
        public ActionResult Failed()
        {
            return View();
        }

        public ActionResult PassReset()
        {
            ViewBag.Title = "Смена пароля. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            var model = new ResetPasswordModel();
            model.UserName = Request.QueryString["userName"];
            model.GeneratedPassword = Request.QueryString["oldPassword"];
            return View(model);
            //return View();
        }

        [HttpPost]
        public ActionResult PassReset(string userName, string newPassword, string oldPassword)
        {
            ViewBag.Title = "Смена пароля. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            var model = new ResetPasswordModel();
            model.GeneratedPassword = oldPassword;
            model.NewPassword = newPassword;
            model.NewPasswordRepeat = newPassword;
            model.UserName = userName;

            MembershipUser currentUser = Membership.GetUser(model.UserName);
            UsersManager.SetLockedStatusToFalse(currentUser.Email);

            var changePasswordSucceeded = currentUser.ChangePassword(model.GeneratedPassword, model.NewPassword);
           
            if(changePasswordSucceeded)
            {
                return Json("true");
            }
            return Json("false");
        }

        public ActionResult Email()
        {
            ViewBag.Title = "Сброс пароля. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            return View();
        }

        [HttpPost]
        public ActionResult Email(string mail)
        {
            var model = new EmailResetModel() { Email = mail };
            return Email1(model);
        }


        [HttpPost]
        public ActionResult Email1(EmailResetModel model)
        {
            ViewBag.Title = "Сброс пароля. Автоматическая торговля на рынке форекс. Скачать советник бессплатно.";
            if (ModelState.IsValid)
            {
                string userName = Membership.GetUserNameByEmail(model.Email);
                if(userName != null)
                {
                    MembershipUser currentUser = Membership.GetUser(userName);
                    UsersManager.SetLockedStatusToFalse(currentUser.Email);
                    if (model.Email.ToLower() == currentUser.Email.ToLower())
                    {
                        SendResetEmail(currentUser);
                        return Json(new { Success = true });
                    }
                }
            }
            ViewData["emailValidator"] = @"/^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
            model.Message = "На вашу почту была отправлена ссылка. Пожалуйста нажмите на нее";
            ModelState.Clear();
            return View("Email", model);
        }

        public void SendActivatedMail(string accountNumber, string userMail, string brokerName)
        {
            string body = string.Format("Был открыт счет {0} для пользователя {1} брокер {2}", accountNumber, userMail, brokerName);

            var message = new MailMessage("noreplyForexBox@gmail.com", "forexboxinfo@gmail.com")
            {
                Subject = "new account created",
                BodyEncoding = System.Text.Encoding.GetEncoding("utf-8"),
                IsBodyHtml = true,
                Priority = MailPriority.High,
            };

            AlternateView plainView = System.Net.Mail.AlternateView.CreateAlternateViewFromString
            (System.Text.RegularExpressions.Regex.Replace(body, @"<(.|\n)*?>", string.Empty), null, "text/plain");

            AlternateView htmlView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(body, null, "text/html");

            message.AlternateViews.Add(plainView);
            message.AlternateViews.Add(htmlView);

            SendMail("forexboxinfo@gmail.com", "new account created", body);

        }

        private void SendMail(string to, string subject, string body)
        {
            var m = new System.Web.Mail.MailMessage
                        {
                            From = "support@4rexbox.com",
                            To = to,
                            Subject = subject,
                            Body = body,
                            BodyFormat = System.Web.Mail.MailFormat.Html,
                            BodyEncoding = System.Text.Encoding.GetEncoding("windows-1251")
                        };

            System.Web.Mail.SmtpMail.SmtpServer = "robots.1gb.ua";
            System.Web.Mail.SmtpMail.Send(m);

        }


        public void SendResetEmail(MembershipUser user)
        {
            //The URL to login
            string domain = HttpContext.Request.Url.GetLeftPart(UriPartial.Authority) + HttpRuntime.AppDomainAppVirtualPath;

            //link to send
            string link = domain + "/Home/PassReset?userName={0}&oldPassword={1}";
            link = link.Replace("//", "/");

            string newPassword = user.ResetPassword();
            link = string.Format(link, user.UserName, newPassword);
            
            var body = @"<html>
<head>
<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"">  
<title>ForexBox</title>  
<style type=""text/css"">
	body, #header h1, #header h2, p {margin: 0; padding: 0;} 
</style>
</head>  
<body> 
<table width=""100%""  cellpadding=""0"" cellspacing=""0"" style=""font-size:12px;line-height:22px;font-family:Arial,sans-serif;color:#555555;table-layout:fixed"">
<tbody><tr><td style=""background-color:#ededed;color:#555555;font-family:Arial,sans-serif;font-size:12px;line-height:22px"">	
<table rules=""none"" frame=""border"" width=""400"" align=""center"" border=""0"" cellpadding=""0"" cellspacing=""0"" style=""font-size:12px;border-collapse:collapse;border:0px solid #e4e2e4;line-height:22px;font-family:Arial,sans-serif;color:#555555;border-spacing:0;border:solid 1px #ededed;cursor:default;"">		
<tbody><tr><td valign=""top"" style=""background-color:#ededed;border-collapse:collapse;color:#555555;font-family:Arial,sans-serif;font-size:12px;line-height:22px"">
<table width=""400"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""margin-top:24px;color:#555555;font-family:Arial,sans-serif;font-size:12px;line-height:22px"">
<tbody><tr>
<td valign=""top"" width=""150"" style=""font-size:25px; text-shadow: 1px 1px white;font-weight:bold;font-family:Tahoma,sans-serif;color:#333;padding-bottom:10px""><a style=""color:#666;font-size:24px"">Forex</a><a style=""color:#F84040;font-size:24px"">Box</a></td>				
<td valign=""top"" align=""right"" style=""text-align:right;font-size:12px;line-height:16px;font-family:Arial,sans-serif;color:#3fb6dd;padding-top:6px"">
<a style=""color:#666;font-size:14px; text-shadow: 1px 1px white"" href=""http://4rexbox.com"" target=""_blank"">Главная</a>&nbsp;&nbsp;&nbsp;
<a style=""color:#666;font-size:14px; text-shadow: 1px 1px white"" href=""http://4rexbox.com/Home/News"" target=""_blank"">Новости</a>&nbsp;&nbsp;&nbsp;
</td>
</tr>
</tbody></table> 
</td></tr>		
<tr><td valign=""top"" bgcolor=""#ffffff"" style=""border-top:solid 1px #e0e0e0;background-color:#ffffff;border-collapse:collapse;color:#555555;font-family:Arial,sans-serif;font-size:10px;line-height:18px"">
<table width=""400"" cellpadding=""0"" cellspacing=""0""><tbody><tr><td height=""40"">&nbsp;</td></tr></tbody></table>				
<table width=""400"" align=""center"" cellpadding=""0"" cellspacing=""0"">
<tbody><tr><td valign=""top"" style=""color:#666;font-family:Arial,sans-serif;font-size:14px;line-height:20px"">						
<span style=""font-size:17px;line-height:10px;font-weight:bold;color:#666;text-align:center"">
	Здравствуйте уважаемый(мая) 

"
                + user.UserName +
            
            @"
</span>		
<table width=""400"" cellpadding=""0"" cellspacing=""0"" align=""center"" style=""clear:both""><tbody><tr><td height=""32""></td></tr></tbody></table>		
	Вы отправили заявку для смены пароля<br> от Вашего кабинета ForexBox.							
<table width=""400"" cellpadding=""0"" cellspacing=""0"" align=""center"" style=""clear:both""><tbody><tr><td height=""32""></td></tr></tbody></table>		
	Пройдите по следующей <a href=" + link + @">ссылке</a> <br>
    Или скопируйте ее в адрессную строку:<br><br>
    <i>" + link + @"</i><br><br>
	И в появившейся странице введите Ваш новый пароль.<br>
					
</td></tr></tbody></table>
<table width=""400"" cellpadding=""0"" cellspacing=""0""><tbody><tr><td height=""20""></td></tr></tbody></table>
</td></tr>
<tr><td valign=""top"" bgcolor=""#d9ecff"" style=""background-color:#fafafa;border-top:solid 1px #e0e0e0;border-bottom:solid 1px #e0e0e0;color:#777777;font-family:Arial,sans-serif;font-size:14px;line-height:19px"">
<table width=""400"" cellpadding=""0"" cellspacing=""0"" align=""center"" style=""clear:both""><tbody><tr><td height=""20""></td></tr></tbody></table>
<table width=""400"" cellpadding=""0"" cellspacing=""0"" align=""center""><tbody><tr><td style=""color:#666;font-family:Arial,sans-serif;font-size:14px;font-weight:normal;line-height:19px"">
	Если Вы не отправляли заявку для смены пароля,<br>
	то просто проигнорируйте это письмо.<br><br>
	Если у Вас есть какие-либо вопросы, пожалуйста,<br>
	обращайтесь к нам в тех-поддержку.<br><br>
	Еще раз благодарим за сотрудничество, и желаем<br>
    успешной торговли вместе с ForexBox!<br>
</td></tr></tbody></table>	
<table width=""400"" cellpadding=""0"" cellspacing=""0"" align=""center"" style=""clear:both""><tbody><tr><td height=""32""></td></tr></tbody></table>
</td></tr>
<tr><td valign=""top"" style=""background-color:#ededed;border-collapse:collapse;color:#777777;font-family:Arial,sans-serif;font-size:10px;line-height:18px;border-top:solid 1px #e0e0e0"">				
<table width=""400"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""color:#777777;font-family:Arial,sans-serif;font-size:10px;line-height:18px""><tbody><tr>
<td valign=""top"" style=""font-size:10px;border-top-color:#eeeeee;line-height:18px;font-family:Arial,sans-serif;color:#777777;border-top-style:solid;border-top-width:1px"">								
<table width=""400"" align=""center"" cellpadding=""0"" cellspacing=""0"" style=""color:#777777;font-family:Arial,sans-serif;font-size:10px;line-height:18px"">
<tbody><tr>
<td valign=""top"" width=""160"" style=""color:#999999;font-family:Arial,sans-serif;font-size:11px;line-height:16px"">													
<b style=""font-weight:bold;color:#333"">«ForexBox»</b>
<br><a href=""http://4rexbox.com"" style=""color:#3279bb;text-decoration:underline"" target=""_blank"">www.4rexbox.com</a>
<br><a style=""color:#3279bb;text-decoration:underline"">support@4rexbox.com</a>							
</td>																		
</tr>
</tbody></table>							
<table width=""450"" cellpadding=""0"" cellspacing=""0""><tbody><tr><td height=""40""></td></tr></tbody></table>
</td>	
</tr></tbody></table>					
</td></tr>		
</tbody></table>	
</td></tr></tbody></table>
</body>
";








            AlternateView plainView = System.Net.Mail.AlternateView.CreateAlternateViewFromString
            (System.Text.RegularExpressions.Regex.Replace(body, @"<(.|\n)*?>", string.Empty), null, "text/plain");

            AlternateView htmlView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(body, null, "text/html");
            SendMail(user.Email, "Password reset", body);


            /*
            var message = new MailMessage("noreplyForexBox@gmail.com", user.Email)
            {
                Subject = "Password Reset",
                BodyEncoding = System.Text.Encoding.GetEncoding("utf-8"),
                IsBodyHtml = true,
                Priority = MailPriority.High,
            };

            message.AlternateViews.Add(plainView);
            message.AlternateViews.Add(htmlView);
            var client = new SmtpClient("smtp.gmail.com");
            client.Port = 587;

            client.Credentials = new System.Net.NetworkCredential("noreplyForexBox@gmail.com", "pefe2o3go");
            client.EnableSsl = true;
               

            client.Send(message);*/
        }



        #region Status Codes
        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "User name already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion

    }
}
