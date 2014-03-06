using System;
using System.Collections.Generic;
using System.Linq;
using System.Resources;
using System.Threading;
using System.Web;

namespace ForexBox.LanguagesLocalization
{
    public class ResourceReader
    {
        public static string GetRes(string viewName, string resName)
        {
            var culture = Thread.CurrentThread.CurrentCulture;

            var fileName = viewName + culture.Parent.Name + ".resx";
            var folderName = HttpContext.Current.Server.MapPath("~/LanguageResources/");

            var rr = new System.Resources.ResXResourceReader(folderName + fileName); 
            
            var resources = rr.GetEnumerator();
            while (resources.MoveNext())
            {
                if (resources.Key.ToString() == resName)
                {
                    return resources.Value.ToString();
                }
            }
            return "";
        }
    }
}