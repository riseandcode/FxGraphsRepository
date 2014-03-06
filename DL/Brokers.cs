using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects.DataClasses;
using System.Configuration;

namespace DL
{
    public static class BrokersManagement
    {
        private static forexBox2Entities EntitiesContainer { get; set; }

        static BrokersManagement()
        {
             EntitiesContainer = new forexBox2Entities(ConfigurationManager.ConnectionStrings["ApplicationServices2"].ConnectionString);
        }

        public static List<brokers> GetBrokers()
        {
            var result = EntitiesContainer.brokers.Where(p => p.ID > 0).ToList();
            return result;
        }
    }
}
