using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL
{
    public class UsersRepository
    {
        public aspnet_Users GetUserByLoginName(string loginName)
        {
            using (var ctx = new forexBox2Entities())
            {
                return ctx.aspnet_Users.FirstOrDefault(x => x.UserName.ToUpper() == loginName.ToUpper());
            }
        }

        public aspnet_Users GetUserById(Guid userId)
        {
            using (var ctx = new forexBox2Entities())
            {
                return ctx.aspnet_Users.FirstOrDefault(x => x.UserId == userId);
            }
        }
    }    
}
