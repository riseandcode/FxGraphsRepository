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
        public ActionResult Index(int accountId, string graphType = "growth")
        {
            StatsManager manager = new StatsManager();

            Statistic stat = new Statistic();
            stat.CurrentGraphType = graphType;

            ShortStatistic shortStat = new ShortStatistic();
            shortStat.Settings = manager.GetOrCreateUserSettings(User.Identity.Name);

            manager.FillUserStatistic(accountId, shortStat, stat);
            stat.ShortStatisticData = shortStat;

            return View("Index", stat);
        }
    }
}
