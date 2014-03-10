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
        public decimal Equality { get; set; }
    }
}
