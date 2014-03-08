using DL.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL.Manager
{
    public class StatsManager
    {
        public void GetUserSettings(string loginName)
        {
            var userRepository = new UsersRepository();
            var user = userRepository.GetUserByLoginName(loginName);

            var settingsRepository = new StatisticConfigurationRepository();
            //var settings = settingsRepository.GetUserStatisticSettingsByUserId(user.UserId);
        }
    }
}
