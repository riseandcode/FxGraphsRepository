using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ForexBox.Models
{
    public class MainCabinetModel
    {
        public long PartnerID { get; set; }
        public double Amount { get; set; }
        public string AmountString
        {
            get { return Amount.ToString("N2"); }
        }
        public double PartnerAmount { get; set; }
        public string PartnerAmountString
        {
            get { return PartnerAmount.ToString("N2"); }
        }
    }
}