using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects.DataClasses;
using System.Configuration;

namespace DL
{
    public class UserAccount
    {
        public long AccountNumber { get; set; }
        public bool Active { get; set; }
        public string Broker { get; set; }
        public string StatusDescription { get; set; }
    }

    public static class AccountsManagement 
    {
        static AccountsManagement()
        {
            EntitiesContainer = new forexBox2Entities(ConfigurationManager.ConnectionStrings["ApplicationServices2"].ConnectionString);
        }
        private static forexBox2Entities EntitiesContainer { get; set; }

        public static List<UserAccount> GetAccountsOfUser(Guid userID)
        {
            var accounts = (from ac in EntitiesContainer.Accounts
                            join br in EntitiesContainer.brokers
                                on ac.brokerID equals br.ID
                                where ac.systemUserID == userID
                            select new UserAccount()
                                       {
                                           AccountNumber = ac.accountNumber,
                                           Active = ac.active,
                                           Broker = br.BrokerName
                                       }).ToList();

            return accounts;

        }

        public static Accounts CreateAccount(long accountNumber, Guid userID, long brokerID)
        {
            var newAcc = new Accounts();
            newAcc.systemUserID = userID;
            newAcc.accountNumber = accountNumber;
            newAcc.active = false;
            newAcc.brokerID = brokerID;
            

            EntitiesContainer.Accounts.AddObject(newAcc);
            EntitiesContainer.SaveChanges();
            return newAcc;
        }

        public static double GetPartnerMoney(long accountNumber)
        {
            double result = 25.0f;
            var dep = EntitiesContainer.Deposits.FirstOrDefault(d => d.InvestorID == accountNumber);
            if (dep != null)
            {
                if(dep.balancePartner.HasValue)
                {
                    result = dep.balancePartner.Value;
                }
                else
                {
                    dep.balancePartner = 25.0f;
                    EntitiesContainer.SaveChanges();
                }
            }
            return result;
        }

        public static double GetAmountOfMoney(long accountNumber)
        {
            double result = 0.0f;
            var dep = EntitiesContainer.Deposits.FirstOrDefault(d => d.InvestorID == accountNumber);
            if(dep != null)
            {
                result = dep.balance;
            }
            return result;
        }

        public static double DepositMoney(long accountNumber, double amoun)
        {
            var dep = EntitiesContainer.Deposits.FirstOrDefault(d => d.InvestorID == accountNumber);
            if(dep != null)
            {
                dep.balance = dep.balance + amoun;
                dep.date = DateTime.Now;
                EntitiesContainer.SaveChanges();
            }
            else
            {
                dep = new Deposits();
                dep.balance = amoun;
                dep.InvestorID = accountNumber;
                dep.date = DateTime.Now;
                EntitiesContainer.Deposits.AddObject(dep);
                EntitiesContainer.SaveChanges();
            }
            return dep.balance;
        }
    }
}
