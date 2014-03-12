using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL
{
    /// <summary>
    /// Deposits Repository class
    /// Contains data about deposits changing
    /// </summary>
    public class DepositsDataRepository
    {
        /// <summary>
        /// Method get from database all deposits data by uerid
        /// </summary>
        /// <param name="userId">Account id</param>
        /// <returns>List of deposit data for current user</returns>
        public List<DepositsData> GetDepositsDataByUserId(Guid userId)
        {
            using (var ctx = new forexBox2Entities())
            {
                var values = ctx.DepositsDatas.Where(x => x.UserId == userId).ToList();                
                return values;
            }
        }
    }
}
