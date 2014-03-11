using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DL
{
    public partial class DepositsData
    {
        public DataType IncomeType
        {
            get { return ParseDataType(Type); }
        }

        private DataType ParseDataType(int? type)
        {
            switch (type)
            {
                case 0:
                    return DataType.Deposit;
                case 1:
                    return DataType.FloatingProfit;

                default:
                    return DataType.Deposit;
            }
        }
    }

    public enum DataType
    {
        Deposit = 0, FloatingProfit
    }
}
