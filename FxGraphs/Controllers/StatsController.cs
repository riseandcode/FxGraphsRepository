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
        public ActionResult Index(int accountId, string graphType)
        {
            StatsManager manager = new StatsManager();
            GraphType type = manager.ParseStringToGrphType(graphType);

            if (type == GraphType.none)
                return RedirectToAction("Index", "Stats", new { accountId = accountId, graphType = "growth" });

            if (accountId == 0)
                ViewData["AccountError"] = true;
            
            manager.IncrementViews(accountId);

            Statistic stat = new Statistic();
            stat.CurrentGraphType = type;

            ShortStatistic shortStat = new ShortStatistic();
            shortStat.Settings = manager.GetAccountSettings(accountId);

            manager.FillUserStatistic(accountId, shortStat, stat);
            stat.ShortStatisticData = shortStat;

            return View("Index", stat);
        }
    }
}
