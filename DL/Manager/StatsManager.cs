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
         var deposits = depositsRepository.GetDepositsDataByUserId(accountId).Where(x => x.IncomeType == DataType.Deposit).ToList();

         var accountRepository = new AccountRepository();
         var account = accountRepository.GetAccountById(accountId);

         if (account != null)
         {
            toFill.Broker = account.Broker;
            toFill.Leverage = account.Leverage;
            toFill.StartedDate = account.Date ?? DateTime.Now;
            toFill.System = account.System;
            toFill.TimeZone = account.TimeZone ?? 0;
            toFill.Trading = account.Trading;
            toFill.Type = account.Type;
            toFill.Views = account.Views ?? 0;
            toFill.Desctiption = account.Desctiption;
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

            FillGraphData(sortedByDate.ToList(), graphModel, toFill);
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

      private void FillGraphData(List<DepositsData> sortedByDate, Statistic toFill, ShortStatistic shortStat)
      {
         if (sortedByDate.Count == 0)
            return;


         var depositsByDate = sortedByDate.Where(x => x.IncomeType == DataType.Deposit).ToArray();           //.OrderBy(x => x.Date.Date);
         var floatingProfitByDate = sortedByDate.Where(x => x.IncomeType == DataType.FloatingProfit).ToArray();       //.OrderBy(x => x.Date.Date);

         decimal startDeposit = depositsByDate.First().Amount;
         decimal startEquity = 0;
         if (floatingProfitByDate.Length > 0)
            startEquity = floatingProfitByDate.First().Amount + startDeposit;

         for (int i = 0; i < depositsByDate.Length; i++)
         {
            decimal difference = depositsByDate[i].Amount - startDeposit;

            toFill.ProfitData.Add(new ProfitDataValue { Date = depositsByDate[i].Date, Profit = difference });

            decimal currentEquity = 0;
            if (floatingProfitByDate.Length > 0)
               currentEquity = depositsByDate[i].Amount + floatingProfitByDate[i].Amount;

            toFill.BalanceData.Add(new BalanceDataValue
            {
               Date = depositsByDate[i].Date,
               Balance = depositsByDate[i].Amount,
               Equity = currentEquity
            });


            decimal growth = startDeposit != 0 ? (difference / startDeposit) * 100 : 0;

            decimal equityDifference = currentEquity - startEquity;

            decimal equityGrowth = startEquity != 0 ? (equityDifference / startEquity) * 100 : 0;

            toFill.GrowthData.Add(new GrowthDataValue { Date = depositsByDate[i].Date, Growth = growth, EquityGrowth = equityGrowth });
         }

         decimal maxEquity = toFill.BalanceData.Select(x => x.Equity).Max();
         foreach (var item in toFill.BalanceData)
         {
            decimal drawdown = maxEquity != 0 ? ((maxEquity - item.Equity) / maxEquity) * 100 : 0;
            toFill.DrawdownData.Add(new DrawdownDataValue { Date = item.Date, Value = drawdown });
         }

         shortStat.Drawdown = toFill.DrawdownData.Sum(x => x.Value) / sortedByDate.Count;

         decimal sum = toFill.ProfitData.Sum(x => x.Profit);
         shortStat.Daily = sum / sortedByDate.Count;
         shortStat.Monthly = sum / toFill.GrowthData.GroupBy(x => x.Date.Month).Count();

      }

      public void IncrementViews(int accountId)
      {
         var repository = new AccountRepository();
         repository.IncrementViewsById(accountId);
      }
   }
}
