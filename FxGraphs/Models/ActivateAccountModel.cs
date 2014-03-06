using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DL;
using System.ComponentModel.DataAnnotations;

namespace ForexBox.Models
{
    public class ActivateAccountModel
    {
        [Required]
        [RegularExpression(@"^\d+$", ErrorMessage = "Только цифры")]
        public long AccountNumber { get; set; }
        [Required]
        public long BrokerID { get; set; }

        public List<UserAccount> Accounts { get; set; }
    }

    

    public class BrokersDescriptions
    {
        public long BrokerID { get; set; }
        public string BrokerName { get; set; }
    }

    public class BrokerAccounts
    {
        public static List<BrokersDescriptions> GetBrokers()
        {
            var result = new List<BrokersDescriptions>();
            result.Add(new BrokersDescriptions()
                           {
                                BrokerID = -1,
                                BrokerName = "Брокер"
                           }
                
                );

            var brokers = BrokersManagement.GetBrokers();

            foreach (var brokerse in brokers)
            {
                result.Add(new BrokersDescriptions()
                               {
                                   BrokerID = brokerse.ID,
                                   BrokerName = brokerse.BrokerName
                               }
                    );
            }
            
            return result;
        }
    }
}