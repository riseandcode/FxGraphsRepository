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
    }
}
