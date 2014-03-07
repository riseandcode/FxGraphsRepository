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
        public int UserId { get; set; }

        [DataMember]
        public bool IsGainVisible { get; private set; }
        [DataMember]
        public bool IsAbsGainVisible { get; private set; }
        [DataMember]
        public bool IsMonthlyIncomeVisible { get; private set; }
        [DataMember]
        public bool IsDailyIncomeVisible { get; private set; }
        [DataMember]
        public bool IsDrawdownVisible { get; private set; }
        [DataMember]
        public bool IsBalanceVisible { get; private set; }
        [DataMember]
        public bool IsEquityVisible { get; private set; }
        [DataMember]
        public bool IsHighestVisible { get; private set; }
        [DataMember]
        public bool IsProfitVisible { get; private set; }
        [DataMember]
        public bool IsInterestVisible { get; private set; }
        [DataMember]
        public bool IsDepositsVisible { get; private set; }
        [DataMember]
        public bool IsWithdrawalsVisible { get; private set; }
        [DataMember]
        public bool IsUpdatedVisible { get; private set; }
        [DataMember]
        public bool IsTrackingVisible { get; private set; }
        [DataMember]
        public bool IsDescriptionVisible { get; private set; }
        [DataMember]
        public bool IsViewsVisible { get; private set; }
        [DataMember]
        public bool IsBrokerVisible { get; private set; }
        [DataMember]
        public bool IsLeverageVisible { get; private set; }
        [DataMember]
        public bool IsTypeVisible { get; private set; }
        [DataMember]
        public bool IsSystemVisible { get; private set; }
        [DataMember]
        public bool IsTradingVisible { get; private set; }
        [DataMember]
        public bool IsStartedVisible { get; private set; }
        [DataMember]
        public bool IsTimezoneVisible { get; private set; }
    }
}
