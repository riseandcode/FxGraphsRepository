using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;

namespace DL
{
   public class Statistic
   {
      public Statistic()
      {
         GrowthData = new List<GrowthDataValue>();
         BalanceData = new List<BalanceDataValue>();
         ProfitData = new List<ProfitDataValue>();
         DrawdownData = new List<DrawdownDataValue>();
      }

      public ShortStatistic ShortStatisticData { get; set; }

      public List<GrowthDataValue> GrowthData { get; set; }

      public List<BalanceDataValue> BalanceData { get; set; }

      public List<ProfitDataValue> ProfitData { get; set; }

      public List<DrawdownDataValue> DrawdownData { get; set; }

      public GraphType CurrentGraphType { get; set; }
   }


   public class BaseDataValue
   {
      private DateTime date;

      [ScriptIgnore]
      public DateTime Date
      {
         get { return date; }
         set
         {
            date = value;
            StringDate = value.ToString("MMM dd, yy");
         }
      }

      public string StringDate { get; set; }
   }

   public class GrowthDataValue : BaseDataValue
   {
      public decimal Growth { get; set; }
      public decimal EquityGrowth { get; set; }
   }

   public class BalanceDataValue : BaseDataValue
   {
      public decimal Balance { get; set; }
      public decimal Equity { get; set; }
   }

   public class ProfitDataValue : BaseDataValue
   {
      public decimal Profit { get; set; }
   }

   public class DrawdownDataValue : BaseDataValue
   {
      public decimal Value { get; set; }
   }
}
