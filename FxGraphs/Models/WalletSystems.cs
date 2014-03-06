using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace ForexBox.Models
{
    public class WalletSystems
    {
        public List<PaymentSystemItem> PaymentSystems { get; set; } 

        public WalletSystems()
        {
            PaymentSystems = new List<PaymentSystemItem>();
        }
    }

    public class PaymentSystemItem
    {
        public string PaymentSystemName { get; set; }
        public string WalletID { get; set; }
    }

}