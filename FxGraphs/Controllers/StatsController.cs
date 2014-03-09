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

        [HttpGet]
        public ContentResult GetGraphData(string graphType)
        {
            string json = "[{ \"year\": \"2003\", \"win\": 13,\"extremum\": \"MIN: 13\",\"loss\": 3},{\"year\": \"2004\",\"win\": 22,\"loss\": 1}]";

            return Content(json, "application/json");

        }
        public ActionResult Index(string id)
        {
            StatsManager manager = new StatsManager();

            Statistic stat = new Statistic();
            
            ShortStatistic shortStat = new ShortStatistic();
            shortStat.Settings = manager.GetOrCreateUserSettings(id);

            stat.ShortStatisticData = shortStat;

            return View("Index", stat);
        }
    }
}
