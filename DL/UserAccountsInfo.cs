using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL
{
    public class PaymentSystemAccountInfo
    {
        public long PaymentSystemID { get; set; }
        public string PaymentSystemName { get; set; }
        public string AccountID { get; set; }
    }
    public class UserAccountsInfo
    {
        public long UserID { get; set; }
        public List<PaymentSystemAccountInfo> PaymentSystemAccountInfos { get; set; }
 
        public UserAccountsInfo()
        {
            PaymentSystemAccountInfos = new List<PaymentSystemAccountInfo>();
        }
    }
}
