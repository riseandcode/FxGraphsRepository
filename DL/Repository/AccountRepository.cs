using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL
{
    public class AccountRepository
    {
        public AccountData GetAccountById(int accountId)
        {
            using (var ctx = new forexBox2Entities())
            {
                return ctx.AccountDatas.FirstOrDefault(x => x.Id == accountId);
            }
        }

        public bool AddAcount(AccountData account)
        {
            using (var ctx = new forexBox2Entities())
            {
                ctx.AccountDatas.AddObject(account);

                try
                {
                    ctx.SaveChanges();
                }
                catch { return false; }
            }

            return true;
        }

        public List<AccountData> GetAccountsByUserId(Guid id)
        {
            using (var ctx = new forexBox2Entities())
            {
                return ctx.AccountDatas.Where(x => x.UserId == id).ToList();
            }
        }

        public bool DeleteAccount(int id)
        {
            using (var ctx = new forexBox2Entities())
            {
                var account = ctx.AccountDatas.FirstOrDefault(x => x.Id == id);
                if (account != null)
                {
                    var datas = ctx.DepositsDatas.Where(x => x.AccountId == id);
                    foreach (var data in datas)
                    {
                        ctx.DeleteObject(data);
                    }

                    ctx.DeleteObject(account);
                }

                try
                {
                    ctx.SaveChanges();
                }
                catch { return false; }
            }

            return true;
        }

        public void IncrementViewsById(int accountId)
        {
            using (var ctx = new forexBox2Entities())
            {
                var account = ctx.AccountDatas.FirstOrDefault(x => x.Id == accountId);

                if (account != null)
                {
                    account.Views = (account.Views == null) ? 1 : account.Views + 1;

                    try
                    {
                        ctx.SaveChanges();
                    }
                    catch { }
                }
            }
        }
    }
}
