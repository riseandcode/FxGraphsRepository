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

        public void FillUserStatistic(int accountId, ShortStatistic toFill, Statistic graphModel)
        {

            var depositsRepository = new DepositsDataRepository();
            var deposits = depositsRepository.GetDepositsDataByUserId(accountId);

            var accountRepository = new AccountRepository();
            var account = accountRepository.GetAccountById(accountId);

            if (accountId != null)
            {
                toFill.Broker = account.Broker;
                toFill.Leverage = account.Leverage;
                toFill.StartedDate = account.Date ?? DateTime.Now;
                toFill.System = account.System;
                toFill.TimeZone = account.TimeZone ?? 0;
                toFill.Trading = account.Trading;
                toFill.Type = account.Type;
            }

            if (deposits.Count != 0)
            {
                var sortedByDate = deposits.OrderBy(x => x.Date);

                toFill.Deposits = sortedByDate.FirstOrDefault().Amount;

                toFill.Balance = sortedByDate.LastOrDefault().Amount;

                decimal maxAmount = deposits.Max(x => x.Amount);
                var highestEntity = deposits.FirstOrDefault(x => x.Amount == maxAmount);

                if (highestEntity != null)
                {
                    toFill.Highest = highestEntity.Amount;
                    toFill.HighestDate = highestEntity.Date;
                }

                decimal startValue = sortedByDate.FirstOrDefault().Amount;
                decimal endValue = sortedByDate.LastOrDefault().Amount;
                decimal defference = endValue - startValue;
                decimal value = startValue != 0 ? (defference / startValue) * 100 : 0;
                toFill.Profit = endValue - startValue;
                toFill.AbsGain = value;

                toFill.Equity = startValue + toFill.Profit;

                FillGraphData(sortedByDate.ToList(), graphModel);
            }
        }

        public string GetUserNameByAccountId(int accountId)
        {
            string userName = string.Empty;

            var accountRepository = new AccountRepository();
            var account = accountRepository.GetAccountById(accountId);

            if (account != null)
            {
                var userRepository = new UsersRepository();
                var user = userRepository.GetUserById(account.UserId);

                if (user != null)
                    userName = user.UserName;
            }

            return userName;
        }

        private void FillGraphData(List<DepositsData> sortedByDate, Statistic toFill)
        {
            if (sortedByDate.Count == 0)
                return;

            var start = sortedByDate.First();

            foreach (var item in sortedByDate)
            {
                decimal difference = item.Amount - start.Amount;
                toFill.ProfitData.Add(new ProfitDataValue { Date = item.Date, Profit = difference });

                var growth = start.Amount != 0 ? (difference / start.Amount) * 100 : 0;
                toFill.GrowthData.Add(new GrowthDataValue { Date = item.Date, Growth = growth });
                toFill.BalanceData.Add(new BalanceDataValue { Date = item.Date, Balance = item.Amount, Equity = item.Amount });
            }

        }

    }
}
