using DL.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL
{
    public class StatsManager
    {
        public UserStatisticSettings GetOrCreateUserSettings(string loginName)
        {
            UserStatisticSettings settings = new UserStatisticSettings();
            var userRepository = new UsersRepository();
            var user = userRepository.GetUserByLoginName(loginName);

            if (user != null)
            {
                var settingsRepository = new StatisticConfigurationRepository();
                settings = settingsRepository.GetUserStatisticSettingsByUserId(user.UserId);

                if (settings == null)
                {
                    var newSettings = new UserStatisticSettings();
                    newSettings.UserId = user.UserId;

                    bool isSuccess = settingsRepository.AddUserStatisticSettings(newSettings);
                    settings = newSettings;
                }

            }
            return settings;
        }

        public void UpdateUserSettings(UserStatisticSettings settings)
        {
            StatisticConfigurationRepository repository = new StatisticConfigurationRepository();
            repository.UpdateUserStatisticSettings(settings);
        }

    }
}
