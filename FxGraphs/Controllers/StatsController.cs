using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DL;

namespace ForexBox.Controllers
{
   public class StatsController : ForexBoxController
   {
      //
      // GET: /Stats/

      public ActionResult Test()
      {
         return View("Index");
      }


      public ActionResult Index(string userName, string graphType = "growth")
      {
         StatsManager manager = new StatsManager();

         Statistic stat = new Statistic();
         stat.CurrentGraphType = graphType;
         ShortStatistic shortStat = new ShortStatistic();
         shortStat.Settings = manager.GetOrCreateUserSettings(userName);
         manager.FillUserStatistic(userName, shortStat, stat);

         stat.ShortStatisticData = shortStat;

         return View("Index", stat);
      }
   }
}
