using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL
{
    public class ShortStatistic
    {
        public UserStatisticSettings Settings { get; set; }

        public decimal AbsGain { get; set; }
        public decimal Deposits { get; set; }
        public decimal Balance { get; set; }
        public decimal Profit { get; set; }
        public decimal Highest { get; set; }
        public DateTime HighestDate { get; set; }
        public decimal Equity { get; set; }
        public decimal Drawdown { get; set; }
        public decimal Daily { get; set; }
        public decimal Monthly { get; set; }

        public string Broker { get; set; }
        public string Leverage { get; set; }
        public string Type { get; set; }
        public string System { get; set; }
        public string Trading { get; set; }
        public DateTime StartedDate { get; set; }
        public int TimeZone { get; set; }
        public int Views { get; set; }
    }
}
