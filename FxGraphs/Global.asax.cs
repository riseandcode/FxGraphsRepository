using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using ForexBox.LanguagesLocalization;
using DL;

namespace ForexBox
{
   // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
   // visit http://go.microsoft.com/?LinkId=9394801

   public class MvcApplication : System.Web.HttpApplication
   {
      public static void RegisterGlobalFilters(GlobalFilterCollection filters)
      {
         filters.Add(new HandleErrorAttribute());
      }

      public static void RegisterRoutes(RouteCollection routes)
      {
         routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

         routes.MapRoute(
            "Stats",
            "Stats/{userName}/{graphType}",
            new { controller = "Stats", action = "Index", graphType = UrlParameter.Optional }
        );

         routes.MapRoute(
             "Default", // Route name
             "{controller}/{action}/{id}", // URL with parameters
             new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
         );

         


         foreach (Route r in routes)
         {
            if (!(r.RouteHandler is SingleCultureMvcRouteHandler))
            {
               r.RouteHandler = new MultiCultureMvcRouteHandler();
               r.Url = "{culture}/" + r.Url;
               //Adding default culture 
               if (r.Defaults == null)
               {
                  r.Defaults = new RouteValueDictionary();
               }
               r.Defaults.Add("culture", Culture.ru.ToString());

               //Adding constraint for culture param
               if (r.Constraints == null)
               {
                  r.Constraints = new RouteValueDictionary();
               }
               r.Constraints.Add("culture", new CultureConstraint(Culture.en.ToString(), Culture.ru.ToString(),
                   Culture.de.ToString(), Culture.it.ToString(), Culture.es.ToString(), Culture.uk.ToString(),
                   Culture.zh.ToString(), Culture.hi.ToString()));
            }
         }

         routes.MapRoute(
             "Catchall",
             "{*anything}",
             new { controller = "Home", action = "Index" });
      }

      protected void Application_Start()
      {
         AreaRegistration.RegisterAllAreas();

         RegisterGlobalFilters(GlobalFilters.Filters);
         RegisterRoutes(RouteTable.Routes);
      }
   }
}