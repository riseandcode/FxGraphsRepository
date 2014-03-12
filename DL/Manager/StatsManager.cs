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
      }

      private void FillGraphData(List<DepositsData> sortedByDate, Statistic toFill)
      {
         if (sortedByDate.Count == 0)
            return;


         var depositsByDate = sortedByDate.Where(x => x.IncomeType == DataType.Deposit).ToArray();           //.OrderBy(x => x.Date.Date);
         var floatingProfitByDate = sortedByDate.Where(x => x.IncomeType == DataType.FloatingProfit).ToArray();       //.OrderBy(x => x.Date.Date);

         decimal startDeposit = depositsByDate.First().Amount;
         decimal startEquity = floatingProfitByDate.First().Amount + startDeposit;

         for (int i = 0; i < depositsByDate.Length; i++)
         {
            decimal difference = depositsByDate[i].Amount - startDeposit;

            toFill.ProfitData.Add(new ProfitDataValue { Date = depositsByDate[i].Date, Profit = difference });

            decimal currentEquity = depositsByDate[i].Amount + floatingProfitByDate[i].Amount;
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

            if (i + 1 < depositsByDate.Length && currentEquity!=0)
            {
               decimal drawdown = ((currentEquity - (depositsByDate[i + 1].Amount + floatingProfitByDate[i + 1].Amount)) / currentEquity) * 100;
               toFill.DrawdownData.Add(new DrawdownDataValue { Date = depositsByDate[i + 1].Date, Value = drawdown });
            }
         }
      }
   }
}
