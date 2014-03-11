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
            var data = new List<GrowthData> { new GrowthData { year = 2003, win = 13, loss = 3 },
                                             new GrowthData { year = 2004, win = 16, loss = 7 },
                                              new GrowthData{year=2005,win=17,loss=8}};
            return data;
         }
      }

      public List<BalanceData> BalanceData
      {
         get
         {
            var data = new List<BalanceData> { new BalanceData { year = 2003, win = 13, loss = 3 },
                                             new BalanceData { year = 2004, win = 16, loss = 7 },
                                              };
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

   public struct BalanceData
   {
      public int year { get; set; }
      public int win { get; set; }
      public int loss { get; set; }
   }
}
