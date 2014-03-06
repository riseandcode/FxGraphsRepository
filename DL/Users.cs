using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace DL
{
    public static class UsersManager
    {
        static UsersManager()
        {
            EntitiesContainer = new forexBox2Entities(ConfigurationManager.ConnectionStrings["ApplicationServices2"].ConnectionString);
        }
        private static forexBox2Entities EntitiesContainer { get; set; }

        public static Guid GetUserIDByName(string userName)
        {
            var result = EntitiesContainer.aspnet_Users.Where(u => u.UserName == userName).First();
            return result.UserId;
        }

        public static void UpdateLockedOut(Guid userID)
        {
            // var memberShip 
        }

        public static bool IsUserNameAvailable(string userName)
        {
            bool result = EntitiesContainer.aspnet_Users.Where(u => u.UserName == userName).ToList().Count() == 0;
            return result;
        }

        public static void SetLockedStatusToFalse(string email)
        {
            var item = EntitiesContainer.aspnet_Membership.Where(p => p.Email == email).First();
            item.IsLockedOut = false;
            item.FailedPasswordAnswerAttemptCount = 0;
            item.FailedPasswordAttemptWindowStart = Convert.ToDateTime("1754-01-01");
            item.FailedPasswordAnswerAttemptWindowStart = Convert.ToDateTime("1754-01-01");
            item.LastLockoutDate = Convert.ToDateTime("1754-01-01");
            item.FailedPasswordAttemptCount = 0;
            EntitiesContainer.SaveChanges();
        }

        public static long CreatePartnerRecord(string userName, long ? parentID)
        {
            var userSystemID = EntitiesContainer.aspnet_Users.Where(u => u.UserName == userName).First().UserId;

            var pr = new Partners();

            pr.systemID = userSystemID;
            if (parentID.HasValue)
            {
                pr.ParentID = parentID;
            }

            EntitiesContainer.Partners.AddObject(pr);
            EntitiesContainer.SaveChanges();
            return pr.ID;
        }

        public static long GetIdAsPartner(string userName)
        {
            var middleRes = EntitiesContainer.aspnet_Users.Where(u => u.UserName == userName).First().UserId;
            var result = EntitiesContainer.Partners.Where(p => p.systemID == middleRes).First().ID;

            return result;
        }

        public static string GetWebMoneyWallet(string userName)
        {
            try
            {
                var walletNumber =
                EntitiesContainer.UsersPaymentSystems.Where(u => u.aspnet_Users.UserName == userName).First().AccountID;

                return walletNumber;
            }
            catch (Exception)
            {
                return string.Empty;
            }
            
        }

        public static void SaveWebMoneyWallet(string userName, string walletID)
        {
            var doExist = GetWebMoneyWallet(userName);
            if(!string.IsNullOrEmpty(doExist))
            {
                var paymentItem =
                    EntitiesContainer.UsersPaymentSystems.Where(u => u.aspnet_Users.UserName == userName).First();
                paymentItem.AccountID = walletID;
                EntitiesContainer.SaveChanges();
            }
            else
            {
                var paymentItemNew = new UsersPaymentSystems();
                var userID = EntitiesContainer.aspnet_Users.Where(u => u.UserName == userName).First().UserId;
                paymentItemNew.AccountID = walletID;
                paymentItemNew.userID = userID;
                paymentItemNew.PaymentSystemID = 1; // web money
                EntitiesContainer.UsersPaymentSystems.AddObject(paymentItemNew);
                EntitiesContainer.SaveChanges();
            }
        }

        public static UserAccountsInfo GetUserAccounts(string userName)
        {
            var result = new UserAccountsInfo();

            // var middleRes = from ps in EntitiesContainer.PaymentSystems
            result.UserID = 123;
            result.PaymentSystemAccountInfos.Add(new PaymentSystemAccountInfo() {AccountID = "www", PaymentSystemID = 1, PaymentSystemName = "Web Money"});
            result.PaymentSystemAccountInfos.Add(new PaymentSystemAccountInfo() { AccountID = "www", PaymentSystemID = 2, PaymentSystemName = "Rbk" });
            result.PaymentSystemAccountInfos.Add(new PaymentSystemAccountInfo() { AccountID = "www", PaymentSystemID = 3, PaymentSystemName = "Liq pay" });


            return result;
        }
    }
}
