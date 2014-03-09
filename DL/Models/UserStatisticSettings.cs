using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace DL
{
    [DataContract]
    public class UserStatisticSettings
    {
        public Guid UserId { get; set; }

        [DataMember]
        public bool IsGainVisible { get; set; }
        [DataMember]
        public bool IsAbsGainVisible { get; set; }
        [DataMember]
        public bool IsMonthlyIncomeVisible { get; set; }
        [DataMember]
        public bool IsDailyIncomeVisible { get; set; }
        [DataMember]
        public bool IsDrawdownVisible { get; set; }
        [DataMember]
        public bool IsBalanceVisible { get; set; }
        [DataMember]
        public bool IsEquityVisible { get; set; }
        [DataMember]
        public bool IsHighestVisible { get; set; }
        [DataMember]
        public bool IsProfitVisible { get; set; }
        [DataMember]
        public bool IsInterestVisible { get; set; }
        [DataMember]
        public bool IsDepositsVisible { get; set; }
        [DataMember]
        public bool IsWithdrawalsVisible { get; set; }
        [DataMember]
        public bool IsUpdatedVisible { get; set; }
        [DataMember]
        public bool IsTrackingVisible { get; set; }
        [DataMember]
        public bool IsDescriptionVisible { get; set; }
        [DataMember]
        public bool IsViewsVisible { get; set; }
        [DataMember]
        public bool IsBrokerVisible { get; set; }
        [DataMember]
        public bool IsLeverageVisible { get; set; }
        [DataMember]
        public bool IsTypeVisible { get; set; }
        [DataMember]
        public bool IsSystemVisible { get; set; }
        [DataMember]
        public bool IsTradingVisible { get; set; }
        [DataMember]
        public bool IsStartedVisible { get; set; }
        [DataMember]
        public bool IsTimezoneVisible { get; set; }

        public UserStatisticSettings()
        {
            IsGainVisible = true;
            IsAbsGainVisible = true;
            IsMonthlyIncomeVisible = true;
            IsDailyIncomeVisible = true;
            IsDrawdownVisible = true;
            IsBalanceVisible = true;
            IsEquityVisible = true;
            IsHighestVisible = true;
            IsProfitVisible = true;
            IsInterestVisible = true;
            IsDepositsVisible = true;
            IsWithdrawalsVisible = true;
            IsUpdatedVisible = true;
            IsTrackingVisible = true;
            IsDescriptionVisible = true;
            IsViewsVisible = true;
            IsBrokerVisible = true;
            IsLeverageVisible = true;
            IsTypeVisible = true;
            IsSystemVisible = true;
            IsTradingVisible = true;
            IsStartedVisible = true;
            IsTimezoneVisible = true;
        }
    }
}
