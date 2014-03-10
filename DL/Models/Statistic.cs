using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL
{
   public class Statistic
   {
      public ShortStatistic ShortStatisticData { get; set; }

      public List<GrowthData> GrowthData
      {
         get
         {
            // string json = "[{ \"year\": \"2003\", \"win\": 13,\"extremum\": \"MIN: 13\",\"loss\": 3},{\"year\": \"2004\",\"win\": 22,\"loss\": 1}]";
            var data = new List<GrowthData> { new GrowthData { year = 2003, win = 13, loss = 3 },
                                             new GrowthData { year = 2004, win = 16, loss = 7 },
                                              new GrowthData{year=2005,win=17,loss=8}};
            return data;
         }
      }

      public string CurrentGraphType { get; set; }
   }

   public struct GrowthData
   {
      public int year { get; set; }
      public int win { get; set; }
      public int loss { get; set; }
   }


}
