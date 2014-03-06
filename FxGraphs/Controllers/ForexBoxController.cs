using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ForexBox.LanguagesLocalization;

namespace ForexBox.Controllers
{
    public class ForexBoxController : Controller
    {
        public ForexBoxController()
        {
            ViewData["Exit"] = new HtmlString(ResourceReader.GetRes("ForexBox", "exit") );
            ViewData["Enter"] = new HtmlString("Войти");
            ViewData["load"] = new HtmlString("О советнике");
            ViewData["News"] = new HtmlString("Новости сайта");
            ViewData["Free"] = new HtmlString("Почему бесплатно?");
            ViewData["Forex"] = new HtmlString("Что такое Forex?");
            ViewData["Faq"] = new HtmlString("Вопросы и ответы");
            ViewData["Partnertext"] = new HtmlString("Стать партнером");
            ViewData["Videotext"] = new HtmlString("Как это работает?");
            ViewData["Inkabinet"] = new HtmlString(ResourceReader.GetRes("ForexBox", "incabinet") );
            ViewData["Incontakts"] = new HtmlString("Контакты");
            ViewData["Inload"] = new HtmlString("Советник");
        }

    }
}