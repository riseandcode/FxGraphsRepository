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

         var start = sortedByDate.First();

         toFill.ProfitData.Add(new ProfitDataValue { Date = start.Date, Profit = 0 });
         toFill.GrowthData.Add(new GrowthDataValue { Date = start.Date, Growth = 0 });
         
         for (int i = 0; i < sortedByDate.Count; i++)
         {
            if (i > 0)
            {
               decimal difference = sortedByDate[i].Amount - sortedByDate[i - 1].Amount;
               toFill.ProfitData.Add(new ProfitDataValue { Date = sortedByDate[i].Date, Profit = difference });

               var growth = sortedByDate[i - 1].Amount != 0 ? (difference / sortedByDate[i - 1].Amount) * 100 : 0;
               toFill.GrowthData.Add(new GrowthDataValue { Date = sortedByDate[i].Date, Growth = growth });


            }

            //TODO check Equity
            toFill.BalanceData.Add(new BalanceDataValue { Date = sortedByDate[i].Date, Balance = sortedByDate[i].Amount, Equity = sortedByDate[i].Amount });
         }

      }
   }
}
