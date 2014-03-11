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

        public void FillUserStatistic(string loginName, ShortStatistic toFill, Statistic graphModel)
        {
            var userRepository = new UsersRepository();
            var user = userRepository.GetUserByLoginName(loginName);

            if (user != null)
            {
                var depositsRepository = new DepositsDataRepository();
                var deposits = depositsRepository.GetDepositsDataByUserId(user.UserId);

                if (deposits.Count != 0)
                {
                var sortedByDate = deposits.OrderBy(x => x.Date);

                if (sortedByDate.FirstOrDefault() != null)
                    toFill.Deposits = sortedByDate.FirstOrDefault().Amount;

                if (sortedByDate.LastOrDefault() != null)
                    toFill.Balance = sortedByDate.LastOrDefault().Amount;                

                decimal maxAmount = deposits.Max(x => x.Amount);
                var highestEntity = deposits.FirstOrDefault(x => x.Amount == maxAmount);
                
                if (highestEntity != null)
                {
                    toFill.Highest = highestEntity.Amount;
                    toFill.HighestDate = highestEntity.Date;
                }

                if (sortedByDate.FirstOrDefault() != null && sortedByDate.LastOrDefault() != null)
                {
                    decimal startValue = sortedByDate.FirstOrDefault().Amount;
                    decimal endValue = sortedByDate.LastOrDefault().Amount;
                    decimal defference = endValue - startValue;
                    decimal value = (defference / startValue) * 100;
                    toFill.Profit = endValue - startValue;
                    toFill.AbsGain = value;

                    toFill.Equality = startValue + toFill.Profit;
                }

                FillGraphData(sortedByDate, graphModel);
            }
            }

        private void FillGraphData(IEnumerable<DepositsData> sortedByDate, Statistic toFill)
        {
           
        }
    }
}
}
