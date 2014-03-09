﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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

            ViewBag.Settings = 1;
            return View("Index");
        }
    }
}
