#property copyright "Copyright 2012, http://www.4rexbox.com"
#property link      "http://www.4rexbox.com"

 double Max_Allocation_Per_Trade = 8.0;
extern double Fixed_LotSize = 0.01;
 double FinalTarget_x_H1_ATR = 1.0;
 double StopLoss_x_H1_ATR = 4.0;
 double Trail_StopLoss_x_H1_ATR = 1.0;
 double Trail_Trigger_x_H1_ATR = 1.0;
 bool Friday_Trade = TRUE;
extern int MagicNumber = 11995533;
 string EA_COMMENT_PREFIX = "Moonbeam";

double g_ilow_76;
double g_ihigh_84;
double g_iclose_92;
double g_iopen_100;
double g_ihigh_108;
double g_ilow_116;
double g_ima_124;
double g_iatr_132;
double g_ienvelopes_148;
double g_ienvelopes_156;
double g_ienvelopes_164;
double g_ienvelopes_172;
double g_ienvelopes_180;
double g_ienvelopes_188;
double g_ienvelopes_196;
double g_ienvelopes_204;
double g_ienvelopes_212;
double g_ienvelopes_220;
double g_ienvelopes_228;
double g_ienvelopes_236;
double gd_252;
double gd_268 = 0.0;
double gd_360;
bool gi_384 = FALSE;
double g_order_stoploss_416;
double g_order_open_price_436;
double g_order_open_price_444;
double g_iatr_452;
double gd_492;
double gd_500;
double g_ibands_548;
double g_ibands_556;
double gd_572;
double g_ibands_580;
double g_ibands_588;
double g_ibands_612;
double g_ibands_620;
double g_order_profit_644;
double g_order_profit_660;
double g_order_open_price_704;
double g_time_764;
double g_time_772;
double gd_804;
double g_time_860;
double g_time_868;
double g_istochastic_1040;
double g_istochastic_1048;
double g_istochastic_1072;
double g_istochastic_1080;
double g_istochastic_1088;
double g_istochastic_1096;
double g_istochastic_1104;
double g_istochastic_1112;
double g_istochastic_1120;
double g_istochastic_1128;
double g_istochastic_1136;
double g_istochastic_1144;
double g_istochastic_1152;
double g_istochastic_1160;
int gi_1176;
double gd_1180;
double gd_1188;
double g_spread_1196;
string gs_1260 = "";
double gd_1356 = 0.0;
double gd_1380 = 30.0;
bool gi_1396 = TRUE;
double g_ienvelopes_1444;
double g_ienvelopes_1452;
double g_ibands_1460;
double g_ibands_1468;
double gd_1476;
double gd_1492;
double gd_1500;
double gd_1524;
double gd_1532;
int gi_1572 = 6;
double g_iatr_1616;
int gi_1668 = 0;
string g_symbol_1676 = "";
int g_digits_1684 = 5;
double g_point_1688 = 0.0001;
double gd_1720 = 0.0;
double gd_1728 = 0.0;
bool gi_1736 = TRUE;
int gi_1744 = 1;
bool gi_1796 = TRUE;
double gd_1804 = 300.0;
double gd_1812 = 100.0;



string gs_unused_1852 = "Advanced Options";
double gd_1860 = 35.0;
double gd_1868 = -35.0;
double gd_1908 = 0.0;
double gd_1916 = 0.0;
double gd_1924 = 0.0;
double gd_1932 = 0.0;
string gs_1940 = "";
double gd_1956 = 0.0;
double gd_1964 = 0.0;
double gd_1988 = 0.0;
bool gi_2016 = TRUE;
bool gi_2020 = TRUE;
double gd_2024 = 400.0;
double gd_2044;
string gs_2100 = "";
int g_bars_2116;
string gs_true_2204 = "True";
double gd_2316;
double g_iopen_2344;
double g_iclose_2352;


void start() {

if(AccountNumber() != thisShouldBeAccountNumber  && !IsDemo())
{
	Alert("Plase take note, your account is not activated. Details here: http://www.4rexbox.com");
}
else
{

   g_iatr_452 = iATR(NULL, PERIOD_W1, 14, 1);
   f0_14();
   }
}

void init() {
   int lia_32[1];
   string ls_44;
   string ls_52;
   string ls_60;
   string ls_68;
   double ld_88;
   double ld_100;
   double ld_108;
   double ld_unused_116;
   double lotsize_124;
   double lotstep_132;
   double marginrequired_140;
   double tickvalue_148;
   double ticksize_156;
   double ld_164;
   int li_172;
   double ld_176;
   
   string ls_8 = "";
   if (StringFind(Symbol(), "EURUSD", 0) < 0)
    {
      ls_8 = "Wrong currency pair. " + Symbol() + " only runs on EURUSD.";
      Alert(ls_8);
      return (0);
    }
   
   if (!IsDllsAllowed() || ((!IsTradeAllowed()) && !IsTradeContextBusy()))
    {
      if (!IsDllsAllowed()) {
         ls_8 = "DLL functions are disabled. Please check \'Allow DLL imports\' in Options.";
      } else {
         ls_8 = "Live trading is disabled. Please check \'Allow live trading\' in Options.";
      }
      Alert(ls_8);
      return (0);
   }
   if (Period() != PERIOD_M15) {
      ls_8 = "Wrong time frame. " + Period() + " runs on the M15 timeframe.";
      return (0);
   }
   gs_1940 = EA_COMMENT_PREFIX;
   g_spread_1196 = MarketInfo(Symbol(), MODE_SPREAD);
   if (FinalTarget_x_H1_ATR < 1.0) FinalTarget_x_H1_ATR = 1;
   if (StopLoss_x_H1_ATR < 1.0) StopLoss_x_H1_ATR = 1;
   if (Trail_StopLoss_x_H1_ATR < 0.0) Trail_StopLoss_x_H1_ATR = 0;
   if (Trail_Trigger_x_H1_ATR < 0.0) Trail_Trigger_x_H1_ATR = 0;
   
   gd_1720 = Max_Allocation_Per_Trade;
   gd_1728 = Fixed_LotSize;
   gi_1176 = MagicNumber;
   gd_1180 = gd_1720;
   double ld_12 = 1;
   if (MarketInfo(Symbol(), MODE_DIGITS) == 5.0) ld_12 = 10;
   if (MarketInfo(Symbol(), MODE_DIGITS) == 4.0) ld_12 = 1;
   gd_804 = 1 / Point;
   
   gd_1188 = gd_1728;
   
   
   gd_1908 = gd_1908 * ld_12 * Point;
   gd_1924 = gd_1924 * ld_12 * Point;
   gd_1860 = gd_1860 * ld_12 * Point;
   gd_1916 = gd_1916 * ld_12 * Point;
   gd_1932 = gd_1932 * ld_12 * Point;
   gd_1868 = gd_1868 * ld_12 * Point;
   g_iatr_1616 = iATR(NULL, PERIOD_D1, 30, 1);
   g_iatr_452 = iATR(NULL, PERIOD_W1, 14, 1);
   
   if (gd_1908 == 0.0) gd_1908 = g_iatr_1616 / 4.0;
   if (gd_1916 == 0.0) gd_1916 = g_iatr_1616 / 5.0;
   if (gd_1924 == 0.0) gd_1924 = g_iatr_1616 / 2.0;
   if (gd_1932 == 0.0) gd_1932 = g_iatr_1616 / 3.0;
   g_ibands_1460 = iBands(NULL, PERIOD_H1, 20, 2, 0, PRICE_CLOSE, MODE_UPPER, 1);
   g_ibands_1468 = iBands(NULL, PERIOD_H1, 20, 2, 0, PRICE_CLOSE, MODE_LOWER, 1);
   gd_1476 = (g_ibands_1460 + g_ibands_1468) / 2.0;
   gd_1500 = iLow(NULL, PERIOD_H1, iLowest(NULL, PERIOD_H1, MODE_LOW, 194, 1));
   g_time_860 = Time[iLowest(NULL, PERIOD_H1, MODE_LOW, 194, 1)];
   gd_1492 = iHigh(NULL, PERIOD_H1, iHighest(NULL, PERIOD_H1, MODE_HIGH, 194, 1));
   g_time_868 = Time[iHighest(NULL, PERIOD_H1, MODE_HIGH, 194, 1)];
   gd_1532 = iLow(NULL, PERIOD_H1, iLowest(NULL, PERIOD_H1, MODE_LOW, 72, 1));
   g_time_764 = Time[iLowest(NULL, PERIOD_H1, MODE_LOW, 72, 1)];
   gd_1524 = iHigh(NULL, PERIOD_H1, iHighest(NULL, PERIOD_H1, MODE_HIGH, 72, 1));
   g_time_772 = Time[iHighest(NULL, PERIOD_H1, MODE_HIGH, 72, 1)];
      
   
  
   if (gd_1180 < 1.0) gd_1180 = 1;
   if (gd_1180 > 50.0) gd_1180 = 50;
   if (gd_2024 < 10.0) gd_2024 = 10;
   if (gd_2024 > 500.0) gd_2024 = 500;
   if (gi_1176 < 1 || gi_1176 > 2147483640) gi_1176 = 99118260;
   if (gd_1188 < 0.0) gd_1188 = 0.0;
   if (gd_1356 < 0.0) gd_1356 = 0;
   if (gd_1988 < 5.0) gd_1988 = 200;
   if (gd_1956 < 5.0) gd_1956 = 300;
   if (gd_1964 < 5.0) gd_1964 = 90;
   
   gd_1380 = 30;
   
   
   
   
   ObjectsDeleteAll(0, OBJ_LABEL);
   
      ObjectsDeleteAll(0, OBJ_LABEL);
      // ObjectCreate("Validation", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("MagicNumber", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("Status", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("OpenTrade", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("PriceAction", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("PriceAction2", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("Version", OBJ_LABEL, 0, 0, 0);
      // ObjectSet("Validation", OBJPROP_CORNER, 0);
      // ObjectSet("Validation", OBJPROP_XDISTANCE, 10);
      // ObjectSet("Validation", OBJPROP_YDISTANCE, 40);
      // ObjectSet("MagicNumber", OBJPROP_CORNER, 0);
      // ObjectSet("MagicNumber", OBJPROP_XDISTANCE, 10);
      // ObjectSet("MagicNumber", OBJPROP_YDISTANCE, 55);
      // ObjectSet("Status", OBJPROP_CORNER, 0);
      // ObjectSet("Status", OBJPROP_XDISTANCE, 10);
      // ObjectSet("Status", OBJPROP_YDISTANCE, 70);
      // ObjectSet("OpenTrade", OBJPROP_CORNER, 0);
      // ObjectSet("OpenTrade", OBJPROP_XDISTANCE, 10);
      // ObjectSet("OpenTrade", OBJPROP_YDISTANCE, 90);
      // ObjectSet("PriceAction", OBJPROP_CORNER, 0);
      // ObjectSet("PriceAction", OBJPROP_XDISTANCE, 10);
      // ObjectSet("PriceAction", OBJPROP_YDISTANCE, 105);
      // ObjectSet("PriceAction2", OBJPROP_CORNER, 0);
      // ObjectSet("PriceAction2", OBJPROP_XDISTANCE, 10);
      // ObjectSet("PriceAction2", OBJPROP_YDISTANCE, 120);
      // ObjectSet("Version", OBJPROP_CORNER, 0);
      // ObjectSet("Version", OBJPROP_XDISTANCE, 10);
      // ObjectSet("Version", OBJPROP_YDISTANCE, 135);
      // ObjectSetText("Validation", WindowExpertName() + " Activation Code : Validation Okay", 8, "Arial", Yellow);
      // ObjectSetText("MagicNumber", "Trade MagicNumber : " + gi_1176, 8, "Arial", White);
      gd_2316 = 0;
      f0_8();
      for (int pos_96 = 0; pos_96 < OrdersTotal(); pos_96++) {
         if (OrderSelect(pos_96, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
         if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
         ld_88 += OrderProfit();
      }
      // ObjectSetText("OpenTrade", "", 8, "Arial", White);
      // if (gs_2100 == "") ObjectSetText("OpenTrade", "||||||||||||.... ", 8, "Arial", White);
      // if (gs_2100 == "BUYTRADE") ObjectSetText("OpenTrade", "Ray Scalper Trade : LONG " + Symbol(), 8, "Arial", White);
      // if (gs_2100 == "SELLTRADE") ObjectSetText("OpenTrade", "Ray Scalper Trade : SHORT " + Symbol(), 8, "Arial", White);
      g_symbol_1676 = Symbol();
      ld_100 = MarketInfo(g_symbol_1676, MODE_MINLOT);
      ld_108 = MarketInfo(g_symbol_1676, MODE_MAXLOT);
      ld_unused_116 = AccountLeverage();
      lotsize_124 = MarketInfo(g_symbol_1676, MODE_LOTSIZE);
      lotstep_132 = MarketInfo(g_symbol_1676, MODE_LOTSTEP);
      marginrequired_140 = MarketInfo(g_symbol_1676, MODE_MARGINREQUIRED);
      tickvalue_148 = MarketInfo(g_symbol_1676, MODE_TICKVALUE);
      ticksize_156 = MarketInfo(g_symbol_1676, MODE_TICKSIZE);
      ld_164 = MathMin(AccountBalance(), AccountEquity());
      li_172 = 0;
      ld_176 = 0.0;
      if (lotstep_132 == 0.01) li_172 = 2;
      if (lotstep_132 == 0.1) li_172 = 1;
      if (gi_1736 == TRUE) ld_176 = f0_3(g_symbol_1676, gd_2044);
      if (gi_1736 == FALSE) ld_176 = f0_11(g_symbol_1676, gd_2044);
      ld_176 = StrToDouble(DoubleToStr(ld_176, li_172));
      if (ld_176 < ld_100) ld_176 = ld_100;
      if (ld_176 > ld_108) ld_176 = ld_108;
      // if (gs_2100 == "") ObjectSetText("Status", "Ray Scalper >>> Waiting... Lot Size for next trade = " + DoubleToStr(ld_176, 2), 8, "Arial", White);
      // if (gs_2100 != "" && ld_88 >= 0.0) ObjectSetText("Status", "Ray Scalper Trade Gain : " + DoubleToStr(ld_88, 0), 8, "Arial", Lime);
      // if (gs_2100 != "" && ld_88 < 0.0) ObjectSetText("Status", "Ray Scalper Trade Gain : " + DoubleToStr(ld_88, 0), 8, "Arial", Red);
      // ObjectSetText("PriceAction", "H1 ATR : " + DoubleToStr(g_iatr_1616, 5) + " || W1 ATR : " + DoubleToStr(g_iatr_452, 5) + " Points", 8, "Arial", White);
      // if (gs_2100 == "SELLTRADE") ObjectSetText("PriceAction2", "H1 move above: " + DoubleToStr(g_order_open_price_436 + gd_1988 * ld_12 * Point, 5) + " Will Trigger StopLoss", 8, "Arial", White);
      else {
         // if (gs_2100 == "BUYTRADE") ObjectSetText("PriceAction2", "H1 move below: " + DoubleToStr(g_order_open_price_436 - gd_1988 * ld_12 * Point, 5) + " Will Trigger StopLoss", 8, "Arial", White);
         // else ObjectSetText("PriceAction2", "||||||||||||....", 8, "Arial", White);
      }
      // if (gs_2100 == "SELLTRADE") ObjectSetText("PriceAction3", "Price move below: " + DoubleToStr(g_order_open_price_436 - gd_1908 * ld_12 * Point, 5) + " Will Trigger Trailing SL", 8, "Arial", White);
      // else {
         
         // if (gs_2100 == "BUYTRADE") ObjectSetText("PriceAction3", "Price move above: " + DoubleToStr(g_order_open_price_436 + gd_1908 * ld_12 * Point, 5) + " Will Trigger Trailing SL", 8, "Arial", White);
         // else ObjectSetText("PriceAction3", "||||||||||||....", 8, "Arial", White);
      // }
      // ObjectSetText("Version", "Version 1.0 : Build Date 20120827", 8, "Arial", Lime);

   
}

void deinit() {
 ObjectsDeleteAll(0, OBJ_LABEL);
}

double f0_11(string a_symbol_0, double ad_unused_8) {
   double ld_16;
   double ld_24;
   double ld_unused_32;
   double lotsize_40;
   double lotstep_48;
   double marginrequired_56;
   double tickvalue_64;
   double ticksize_72;
   double ld_80;
   int li_88;
   double ld_ret_92;
   if (gd_1188 == 0.0) {
      ld_16 = MarketInfo(a_symbol_0, MODE_MINLOT);
      ld_24 = MarketInfo(a_symbol_0, MODE_MAXLOT);
      ld_unused_32 = AccountLeverage();
      lotsize_40 = MarketInfo(a_symbol_0, MODE_LOTSIZE);
      lotstep_48 = MarketInfo(a_symbol_0, MODE_LOTSTEP);
      marginrequired_56 = MarketInfo(a_symbol_0, MODE_MARGINREQUIRED);
      tickvalue_64 = MarketInfo(a_symbol_0, MODE_TICKVALUE);
      ticksize_72 = MarketInfo(a_symbol_0, MODE_TICKSIZE);
      ld_80 = MathMin(AccountBalance(), AccountEquity());
      li_88 = 0;
      ld_ret_92 = 0.0;
      if (lotstep_48 == 0.01) li_88 = 2;
      if (lotstep_48 == 0.1) li_88 = 1;
      ld_ret_92 = ld_80 * (gd_1180 / gi_1744 / 100.0) / (gd_1988 / 2.0 * (tickvalue_64 / ld_16));
      ld_ret_92 = StrToDouble(DoubleToStr(ld_ret_92, li_88));
      if (ld_ret_92 < ld_16) ld_ret_92 = ld_16;
      if (ld_ret_92 <= ld_24) return (ld_ret_92);
      ld_ret_92 = ld_24;
      return (ld_ret_92);
   }
   if (gd_1188 > 0.0) return (gd_1188);
   return (0.0);
}

double f0_3(string a_symbol_0, double ad_unused_8) {
   double ld_16;
   double ld_24;
   double leverage_32;
   double lotsize_40;
   double lotstep_48;
   double marginrequired_56;
   double ld_64;
   int li_72;
   double ld_ret_76;
   if (gd_1188 == 0.0) {
      ld_16 = MarketInfo(a_symbol_0, MODE_MINLOT);
      ld_24 = MarketInfo(a_symbol_0, MODE_MAXLOT);
      leverage_32 = AccountLeverage();
      lotsize_40 = MarketInfo(a_symbol_0, MODE_LOTSIZE);
      lotstep_48 = MarketInfo(a_symbol_0, MODE_LOTSTEP);
      marginrequired_56 = MarketInfo(a_symbol_0, MODE_MARGINREQUIRED);
      ld_64 = MathMin(AccountBalance(), AccountEquity()) * (gd_1180 / gi_1744) / 100.0;
      li_72 = 0;
      ld_ret_76 = 0.0;
      if (lotstep_48 == 0.01) li_72 = 2;
      if (lotstep_48 == 0.1) li_72 = 1;
      gd_2316 = 0;
      f0_8();
      ld_ret_76 = 50.0 * ld_64 / (marginrequired_56 * leverage_32);
      ld_ret_76 = StrToDouble(DoubleToStr(ld_ret_76, li_72));
      if (ld_ret_76 < ld_16) ld_ret_76 = ld_16;
      if (ld_ret_76 <= ld_24) return (ld_ret_76);
      ld_ret_76 = ld_24;
      return (ld_ret_76);
   }
   if (gd_1188 > 0.0) return (gd_1188);
   return (0.0);
}

double f0_9(double ad_0, double ad_8, double ad_16, double ad_24) {
   if (ad_8 == 0.0) return (0);
   return (NormalizeDouble(ad_0 - MathAbs(ad_8) * ad_16, ad_24));
}

double f0_10(double ad_0, double ad_8, double ad_16, double ad_24) {
   if (ad_8 == 0.0) return (0);
   return (NormalizeDouble(ad_0 + MathAbs(ad_8) * ad_16, ad_24));
}

double f0_13(double ad_0, double ad_8, double ad_16, double ad_24) {
   if (ad_8 == 0.0) return (0);
   return (NormalizeDouble(ad_0 + MathAbs(ad_8) * ad_16, ad_24));
}

double f0_5(double ad_0, double ad_8, double ad_16, double ad_24) {
   if (ad_8 == 0.0) return (0);
   return (NormalizeDouble(ad_0 - MathAbs(ad_8) * ad_16, ad_24));
}

int f0_2(string a_symbol_0, int a_magic_8, int a_cmd_12, int ai_16, int ai_20, string as_24) {
   int cmd_48;
   int li_unused_52;
   bool li_56;
   int li_60;
   double price_64;
   double price_72;
   int error_80;
   bool li_32 = FALSE;
   if (a_symbol_0 == "None") li_32 = TRUE;
   bool li_36 = FALSE;
   if (a_magic_8 == 0) li_36 = TRUE;
   int error_40 = 0;
   for (int pos_44 = OrdersTotal() - 1; pos_44 >= 0; pos_44--) {
      if (OrderSelect(pos_44, SELECT_BY_POS, MODE_TRADES) != FALSE) {
         if (li_36) a_magic_8 = OrderMagicNumber();
         if (a_magic_8 == OrderMagicNumber()) {
            if (gi_1176 == OrderMagicNumber()) {
               if (li_32) a_symbol_0 = OrderSymbol();
               if (a_symbol_0 == OrderSymbol()) {
                  g_point_1688 = MarketInfo(a_symbol_0, MODE_POINT);
                  g_digits_1684 = MarketInfo(a_symbol_0, MODE_DIGITS);
                  if (g_point_1688 == 0.001) {
                     g_point_1688 = 0.01;
                     g_digits_1684 = 3;
                  } else {
                     if (g_point_1688 == 0.00001) {
                        g_point_1688 = 0.0001;
                        g_digits_1684 = 5;
                     }
                  }
                  cmd_48 = OrderType();
                  if (cmd_48 != a_cmd_12 && a_cmd_12 != 1024) continue;
                  li_unused_52 = 0;
                  li_56 = FALSE;
                  li_60 = ai_16;
                  while (!li_56) {
                     while (IsTradeContextBusy()) Sleep(10);
                     RefreshRates();
                     price_64 = NormalizeDouble(MarketInfo(a_symbol_0, MODE_ASK), g_digits_1684);
                     price_72 = NormalizeDouble(MarketInfo(a_symbol_0, MODE_BID), g_digits_1684);
                     
                     g_order_profit_660 = g_order_profit_644;
                     g_order_profit_644 = OrderProfit();
                     if (cmd_48 == OP_BUY) OrderClose(OrderTicket(), OrderLots(), price_72, ai_20 * g_point_1688, CLR_NONE);
                     else
                        if (cmd_48 == OP_SELL) OrderClose(OrderTicket(), OrderLots(), price_64, ai_20 * g_point_1688, CLR_NONE);
                     error_80 = GetLastError();
                     switch (error_80) {
                     case 135/* PRICE_CHANGED */: continue;
                     case 138/* REQUOTE */: continue;
                     case 0/* NO_ERROR */:
                        li_56 = TRUE;
                        break;
                     case 130/* INVALID_STOPS */:
                     case 4/* SERVER_BUSY */:
                     case 6/* NO_CONNECTION */:
                     case 129/* INVALID_PRICE */:
                     case 136/* OFF_QUOTES */:
                     case 137/* BROKER_BUSY */:
                     case 146/* TRADE_CONTEXT_BUSY */:
                        li_60++;
                        break;
                     case 131/* INVALID_TRADE_VOLUME */:
                        li_56 = TRUE;
                        Alert(as_24 + " Invalid Lots");
                        break;
                     case 132/* MARKET_CLOSED */:
                        li_56 = TRUE;
                        Alert(as_24 + " Market Close");
                        break;
                     case 133/* TRADE_DISABLED */:
                        li_56 = TRUE;
                        Alert(as_24 + " Trades Disabled");
                        break;
                     case 134/* NOT_ENOUGH_MONEY */:
                        li_56 = TRUE;
                        Alert(as_24 + " Not Enough Money");
                        break;
                     case 148/* TRADE_TOO_MANY_ORDERS */:
                        li_56 = TRUE;
                        Alert(as_24 + " Too Many Orders");
                        break;
                     case 149/* TRADE_HEDGE_PROHIBITED */:
                        li_56 = TRUE;
                        Alert(as_24 + " Hedge is prohibited");
                        break;
                     case 1/* NO_RESULT */:
                     default:
                        li_56 = TRUE;
                        Print("Unknown Error - " + error_80);
                     }
                     if (li_60 > 10) li_56 = TRUE;
                     if (error_40 < error_80) error_40 = error_80;
                  }
               }
            }
         }
      }
   }
   return (error_40);
}

int f0_12(string a_symbol_0, double ad_8, string a_comment_16, int ai_24, int ai_28, int a_magic_32, int ai_36, int ai_40) {
   int ticket_68;
   int li_unused_72;
   bool li_76;
   int count_80;
   double lots_84;
   double price_92;
   double ld_100;
   double price_108;
   int error_116;
   g_point_1688 = MarketInfo(a_symbol_0, MODE_POINT);
   g_digits_1684 = MarketInfo(a_symbol_0, MODE_DIGITS);
   if (g_point_1688 == 0.001) {
      g_point_1688 = 0.01;
      g_digits_1684 = 3;
   } else {
      if (g_point_1688 == 0.00001) {
         g_point_1688 = 0.0001;
         g_digits_1684 = 5;
      }
   }
   double maxlot_44 = MarketInfo(a_symbol_0, MODE_MAXLOT);
   double ld_52 = ad_8;
   int li_60 = 1;
   if (ad_8 > maxlot_44) li_60 = MathFloor(ad_8 / maxlot_44) + 1.0;
   for (int count_64 = 0; count_64 < li_60; count_64++) {
      ticket_68 = -1;
      li_unused_72 = 0;
      li_76 = FALSE;
      count_80 = 0;
      lots_84 = NormalizeDouble(ad_8 / MathMax(li_60, 1), 2);
      if (ld_52 - maxlot_44 <= 0.0) lots_84 = ld_52;
      while (!li_76) {
         while (IsTradeContextBusy()) Sleep(10);
         RefreshRates();
         price_92 = NormalizeDouble(MarketInfo(a_symbol_0, MODE_ASK), g_digits_1684);
         ld_100 = NormalizeDouble(MarketInfo(a_symbol_0, MODE_BID), g_digits_1684);
         ticket_68 = OrderSend(a_symbol_0, OP_BUY, lots_84, price_92, 0, 0.0, 0.0, a_comment_16, a_magic_32, ai_40 * g_point_1688, CLR_NONE);
         price_108 = f0_9(price_92, ai_24, g_point_1688, g_digits_1684);
         error_116 = GetLastError();
         if (error_116 == 0/* NO_ERROR */) {
            gs_2100 = "BUYTRADE";
            
            
            gs_true_2204 = "False";
         }
         switch (error_116) {
         case 135/* PRICE_CHANGED */: continue;
         case 138/* REQUOTE */: continue;
         case 0/* NO_ERROR */:
            li_76 = TRUE;
            if (OrderSelect(ticket_68, SELECT_BY_TICKET)) OrderModify(ticket_68, OrderOpenPrice(), price_108, f0_13(price_92, ai_28, g_point_1688, g_digits_1684), 0, CLR_NONE);
            if (gi_2016 == TRUE) {
               ObjectCreate("BUYSYM" + ticket_68, OBJ_ARROW, 0, OrderOpenTime(), OrderOpenPrice());
               ObjectSet("BUYSYM" + ticket_68, OBJPROP_ARROWCODE, 200);
               ObjectSet("BUYSYM" + ticket_68, OBJPROP_COLOR, Lime);
               gi_384 = TRUE;
               g_order_open_price_704 = OrderOpenPrice();
               gd_2316 = 0;
               for (int pos_124 = 0; pos_124 < OrdersTotal(); pos_124++) {
                  if (OrderSelect(pos_124, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
                  if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
                  gd_2316 += 1.0;
               }
               if (gd_2316 == 1.0) {
                  g_order_open_price_436 = OrderOpenPrice();
                  g_order_stoploss_416 = OrderStopLoss();
                  gd_360 = MathAbs(g_order_open_price_436 - g_order_stoploss_416) / 2.0;
               }
            }
            if (gi_2020 != TRUE) break;
            PlaySound("alert2.wav");
            break;
         case 130/* INVALID_STOPS */:
         case 4/* SERVER_BUSY */:
         case 6/* NO_CONNECTION */:
         case 129/* INVALID_PRICE */:
         case 136/* OFF_QUOTES */:
         case 137/* BROKER_BUSY */:
         case 146/* TRADE_CONTEXT_BUSY */:
            count_80++;
            break;
         case 131/* INVALID_TRADE_VOLUME */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Invalid Lots");
            break;
         case 132/* MARKET_CLOSED */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Market Close");
            break;
         case 133/* TRADE_DISABLED */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Trades Disabled");
            break;
         case 134/* NOT_ENOUGH_MONEY */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Not Enough Money");
            break;
         case 148/* TRADE_TOO_MANY_ORDERS */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Too Many Orders");
            break;
         case 149/* TRADE_HEDGE_PROHIBITED */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Hedge is prohibited");
            break;
         case 1/* NO_RESULT */:
         default:
            li_76 = TRUE;
            Print("Unknown Error - " + error_116);
         }
         if (count_80 > ai_36) li_76 = TRUE;
      }
      ld_52 -= lots_84;
   }
   return (ticket_68);
}

int f0_0(string a_symbol_0, double ad_8, string a_comment_16, int ai_24, int ai_28, int a_magic_32, int ai_36, int ai_40) {
   int ticket_68;
   int li_unused_72;
   bool li_76;
   int count_80;
   double lots_84;
   double ld_92;
   double price_100;
   double price_108;
   int error_116;
   g_point_1688 = MarketInfo(a_symbol_0, MODE_POINT);
   g_digits_1684 = MarketInfo(a_symbol_0, MODE_DIGITS);
   if (g_point_1688 == 0.001) {
      g_point_1688 = 0.01;
      g_digits_1684 = 3;
   } else {
      if (g_point_1688 == 0.00001) {
         g_point_1688 = 0.0001;
         g_digits_1684 = 5;
      }
   }
   double maxlot_44 = MarketInfo(a_symbol_0, MODE_MAXLOT);
   double ld_52 = ad_8;
   int li_60 = 1;
   if (ad_8 > maxlot_44) li_60 = MathFloor(ad_8 / maxlot_44) + 1.0;
   for (int count_64 = 0; count_64 < li_60; count_64++) {
      ticket_68 = -1;
      li_unused_72 = 0;
      li_76 = FALSE;
      count_80 = 0;
      lots_84 = NormalizeDouble(ad_8 / MathMax(li_60, 1), 2);
      if (ld_52 - maxlot_44 <= 0.0) lots_84 = ld_52;
      while (!li_76) {
         while (IsTradeContextBusy()) Sleep(10);
         RefreshRates();
         ld_92 = NormalizeDouble(MarketInfo(a_symbol_0, MODE_ASK), g_digits_1684);
         price_100 = NormalizeDouble(MarketInfo(a_symbol_0, MODE_BID), g_digits_1684);
         price_108 = f0_10(price_100, ai_24, g_point_1688, g_digits_1684);
         ticket_68 = OrderSend(a_symbol_0, OP_SELL, lots_84, price_100, 0, 0.0, 0.0, a_comment_16, a_magic_32, ai_40 * g_point_1688, CLR_NONE);
         error_116 = GetLastError();
         if (error_116 == 0/* NO_ERROR */) {
            gs_2100 = "SELLTRADE";
            gs_true_2204 = "False";
         }
         switch (error_116) {
         case 135/* PRICE_CHANGED */: continue;
         case 138/* REQUOTE */: continue;
         case 0/* NO_ERROR */:
            li_76 = TRUE;
            if (OrderSelect(ticket_68, SELECT_BY_TICKET)) OrderModify(ticket_68, OrderOpenPrice(), price_108, f0_5(price_100, ai_28, g_point_1688, g_digits_1684), 0, CLR_NONE);
            if (gi_2016 == TRUE) {
               ObjectCreate("SELLSYM" + ticket_68, OBJ_ARROW, 0, OrderOpenTime(), OrderOpenPrice());
               ObjectSet("SELLSYM" + ticket_68, OBJPROP_ARROWCODE, 202);
               ObjectSet("SELLSYM" + ticket_68, OBJPROP_COLOR, Red);
               g_order_open_price_704 = OrderOpenPrice();
               gi_384 = TRUE;
               gd_2316 = 0;
               for (int pos_124 = 0; pos_124 < OrdersTotal(); pos_124++) {
                  if (OrderSelect(pos_124, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
                  if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
                  gd_2316 += 1.0;
               }
               if (gd_2316 == 1.0) {
                  g_order_open_price_436 = OrderOpenPrice();
                  g_order_stoploss_416 = OrderStopLoss();
                  gd_360 = MathAbs(g_order_open_price_436 - g_order_stoploss_416) / 2.0;
               }
            }
            if (gi_2020 != TRUE) break;
            PlaySound("alert2.wav");
            break;
         case 130/* INVALID_STOPS */:
         case 4/* SERVER_BUSY */:
         case 6/* NO_CONNECTION */:
         case 129/* INVALID_PRICE */:
         case 136/* OFF_QUOTES */:
         case 137/* BROKER_BUSY */:
         case 146/* TRADE_CONTEXT_BUSY */:
            count_80++;
            break;
         case 131/* INVALID_TRADE_VOLUME */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Invalid Lots");
            break;
         case 132/* MARKET_CLOSED */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Market Close");
            break;
         case 133/* TRADE_DISABLED */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Trades Disabled");
            break;
         case 134/* NOT_ENOUGH_MONEY */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Not Enough Money");
            break;
         case 148/* TRADE_TOO_MANY_ORDERS */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Too Many Orders");
            break;
         case 149/* TRADE_HEDGE_PROHIBITED */:
            li_76 = TRUE;
            Alert(a_comment_16 + " Hedge is prohibited");
            break;
         case 1/* NO_RESULT */:
         default:
            li_76 = TRUE;
            Print("Unknown Error - " + error_116);
         }
         if (count_80 > ai_36) li_76 = TRUE;
      }
      ld_52 -= lots_84;
   }
   return (ticket_68);
}

void f0_4() {
   double ld_12;
   double ld_20;
   int li_28;
   int li_32;
   int li_36;
   int li_40;
   string ls_44;
   for (int pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
      if (OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
      if (OrderType() == OP_SELL) f0_6();
   }
   int count_4 = 0;
   for (int pos_8 = 0; pos_8 < OrdersTotal(); pos_8++) {
      if (OrderSelect(pos_8, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
      count_4++;
   }
   if (count_4 < gi_1744) {
      if (Friday_Trade == FALSE && DayOfWeek() > 4) return;
      ld_12 = 1;
      if (MarketInfo(Symbol(), MODE_DIGITS) == 5.0) ld_12 = 10;
      if (MarketInfo(Symbol(), MODE_DIGITS) == 4.0) ld_12 = 1;
      if ((Ask - Bid) / ld_12 / Point <= 2.0 * g_spread_1196) {
         g_symbol_1676 = Symbol();
         g_point_1688 = MarketInfo(g_symbol_1676, MODE_POINT);
         g_digits_1684 = MarketInfo(g_symbol_1676, MODE_DIGITS);
         if (g_point_1688 == 0.00001) g_point_1688 = 0.0001;
         else
            if (g_point_1688 == 0.001) g_point_1688 = 0.01;
         gd_2044 = gd_1180 / gi_1744;
         ld_20 = 0.0;
         li_28 = 3;
         li_32 = gd_1988;
         li_36 = gd_1956;
         li_40 = 10;
         ls_44 = gs_1940 + " - Enter LONG";
         if (ld_20 <= 0.0) {
            if (gi_1736 == TRUE) ld_20 = f0_3(g_symbol_1676, gd_2044);
            if (gi_1736 == FALSE) ld_20 = f0_11(g_symbol_1676, gd_2044);
            if (gd_2044 <= 0.0) {
               Alert(ls_44 + "- Invalid Lots/Risk settings!");
               return;
            }
         }
         gi_384 = FALSE;
         Comment(gs_1940 + " - Buy | please wait ...");
         f0_12(g_symbol_1676, ld_20, ls_44, li_32, li_36, gi_1176, li_40, li_28);
         Comment("");
         if (gi_384 == TRUE) gs_true_2204 = "False";
      }
   }
}

void f0_15() {
   double ld_12;
   double ld_20;
   int li_28;
   int li_32;
   int li_36;
   int li_40;
   string ls_44;
   for (int pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
      if (OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
      if (OrderType() == OP_BUY) f0_6();
   }
   int count_4 = 0;
   for (int pos_8 = 0; pos_8 < OrdersTotal(); pos_8++) {
      if (OrderSelect(pos_8, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
      count_4++;
   }
   if (count_4 < gi_1744) {
      if (Friday_Trade == FALSE && DayOfWeek() > 4) return;
      ld_12 = 1;
      if (MarketInfo(Symbol(), MODE_DIGITS) == 5.0) ld_12 = 10;
      if (MarketInfo(Symbol(), MODE_DIGITS) == 4.0) ld_12 = 1;
      if ((Ask - Bid) / ld_12 / Point <= 2.0 * g_spread_1196) {
         g_symbol_1676 = Symbol();
         g_point_1688 = MarketInfo(g_symbol_1676, MODE_POINT);
         g_digits_1684 = MarketInfo(g_symbol_1676, MODE_DIGITS);
         if (g_point_1688 == 0.00001) g_point_1688 = 0.0001;
         else
            if (g_point_1688 == 0.001) g_point_1688 = 0.01;
         gd_2044 = gd_1180 / gi_1744;
         ld_20 = 0.0;
         li_28 = 3;
         li_32 = gd_1988;
         li_36 = gd_1956;
         li_40 = 10;
         ls_44 = gs_1940 + " - Enter SHORT";
         if (ld_20 <= 0.0) {
            if (gi_1736 == TRUE) ld_20 = f0_3(g_symbol_1676, gd_2044);
            if (gi_1736 == FALSE) ld_20 = f0_11(g_symbol_1676, gd_2044);
            if (gd_2044 <= 0.0) {
               Alert(ls_44 + "- Invalid Lots/Risk settings!");
               return;
            }
         }
         gi_384 = FALSE;
         Comment(gs_1940 + " - Sell | please wait ...");
         f0_0(g_symbol_1676, ld_20, ls_44, li_32, li_36, gi_1176, li_40, li_28);
         Comment("");
         if (gi_384 == TRUE) gs_true_2204 = "False";
      }
   }
}

void f0_6() {
   int li_0 = 9999;
   int li_4 = 10;
   int li_8 = 10;
   string ls_12 = gs_1940 + " - Close ALL ";
   g_symbol_1676 = Symbol();
   g_point_1688 = MarketInfo(g_symbol_1676, MODE_POINT);
   g_digits_1684 = MarketInfo(g_symbol_1676, MODE_DIGITS);
   if (g_point_1688 == 0.00001) g_point_1688 = 0.0001;
   else
      if (g_point_1688 == 0.001) g_point_1688 = 0.01;
   Comment(ls_12 + " | Closing All Orders, please wait ...");
   f0_2(g_symbol_1676, gi_1176, 1024, li_4, li_8, ls_12);
   Comment("");
   if (li_0 == 0) {
      gs_2100 = "";
      g_order_open_price_704 = 0;
      g_order_stoploss_416 = 0;
   }
}

void f0_7(double a_price_0) {
   for (int pos_8 = 0; pos_8 < OrdersTotal(); pos_8++) {
      if (OrderSelect(pos_8, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
      if (OrderStopLoss() > a_price_0 + (Ask - Bid) && OrderType() == OP_SELL) OrderModify(OrderTicket(), OrderOpenPrice(), a_price_0, OrderTakeProfit(), 0);
      if (OrderStopLoss() < a_price_0 - (Ask - Bid) && OrderType() == OP_BUY) OrderModify(OrderTicket(), OrderOpenPrice(), a_price_0, OrderTakeProfit(), 0);
      g_order_profit_644 = OrderProfit();
   }
}

void f0_1() {
   gd_2316 = 0;
   for (int pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
      if (OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
      if (OrderType() == OP_BUY) {
         gs_2100 = "BUYTRADE";
         gs_1260 = "";
      }
      if (OrderType() == OP_SELL) {
         gs_2100 = "SELLTRADE";
         gs_1260 = "";
      }
   }
   int li_4 = Time[0];
   int ticket_8 = -1;
   for (int pos_12 = OrdersTotal() - 1; pos_12 >= 0; pos_12--) {
      if (OrderSelect(pos_12, SELECT_BY_POS) && OrderMagicNumber() == gi_1176 && OrderSymbol() == Symbol() && OrderOpenTime() < li_4) {
         li_4 = OrderOpenTime();
         ticket_8 = OrderTicket();
      }
   }
   if (OrderSelect(ticket_8, SELECT_BY_TICKET) == TRUE) g_order_open_price_436 = OrderOpenPrice();
}

void f0_8() {
   gd_2316 = 0;
   
   for (int pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
      if (OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
      gd_2316 += 1.0;
   }
   int datetime_4 = 0;
   int ticket_8 = -1;
   
   for (int pos_12 = OrdersTotal() - 1; pos_12 >= 0; pos_12--) {
      if (OrderSelect(pos_12, SELECT_BY_POS) && OrderMagicNumber() == gi_1176 && OrderSymbol() == Symbol() && OrderOpenTime() > datetime_4) {
         datetime_4 = OrderOpenTime();
         ticket_8 = OrderTicket();
      }
   }
   if (OrderSelect(ticket_8, SELECT_BY_TICKET) == TRUE) g_order_open_price_444 = OrderOpenPrice();
   if (gd_2316 == 0.0) {
      gd_268 = -999;
   }
}

void f0_14() {
   int lia_16[1];
   string ls_20;
   int li_28;
   double ld_32;
   double ld_40;
   double ld_48;
   
   double ld_64;
   double ld_80;
   double ld_92;
   double ld_100;
   double ld_unused_108;
   double lotsize_116;
   double lotstep_124;
   double marginrequired_132;
   double tickvalue_140;
   double ticksize_148;
   double ld_156;
   int li_164;
   double ld_168;
   double ld_0 = (Bid + Ask) / 2.0;
   gd_2316 = 0;
   f0_8();
   if (g_order_open_price_436 == 0.0) g_order_open_price_436 = g_order_open_price_444;
   if (gd_2316 > 0.0 && gs_2100 == "") f0_1();
   else {
      if (gd_2316 == 0.0 && gs_2100 != "" || gs_1260 != "") {
         gs_2100 = "";
         gs_1260 = "";
         gd_268 = -999;
         
         g_order_profit_660 = g_order_profit_644;
         g_order_profit_644 = 0;
      }
   }
   if (gd_2316 == 0.0) {
      gd_268 = -999;
   }
   g_symbol_1676 = Symbol();
   g_point_1688 = MarketInfo(g_symbol_1676, MODE_POINT);
   g_digits_1684 = MarketInfo(g_symbol_1676, MODE_DIGITS);
   if (g_point_1688 == 0.00001) g_point_1688 = 0.0001;
   else
      if (g_point_1688 == 0.001) g_point_1688 = 0.01;
   double ld_8 = 1;
   if (MarketInfo(Symbol(), MODE_DIGITS) == 5.0) ld_8 = 10;
   if (MarketInfo(Symbol(), MODE_DIGITS) == 4.0) ld_8 = 1;
   gd_804 = Point;
   gi_1176 = MagicNumber;
   
   if (g_bars_2116 != Bars) {
      g_iatr_452 = iATR(NULL, PERIOD_W1, 14, 1);
      
      g_point_1688 = MarketInfo(g_symbol_1676, MODE_POINT);
      g_digits_1684 = MarketInfo(g_symbol_1676, MODE_DIGITS);
      if (g_point_1688 == 0.00001) g_point_1688 = 0.0001;
      else
         if (g_point_1688 == 0.001) g_point_1688 = 0.01;
      
      gd_252 = 1 / g_point_1688;
      g_ibands_1460 = iBands(NULL, PERIOD_H1, 20, 2, 0, PRICE_MEDIAN, MODE_UPPER, 1);
      g_ibands_1468 = iBands(NULL, PERIOD_H1, 20, 2, 0, PRICE_MEDIAN, MODE_LOWER, 1);
      g_ibands_612 = iBands(NULL, PERIOD_H1, 20, 2, 0, PRICE_MEDIAN, MODE_UPPER, 2);
      g_ibands_620 = iBands(NULL, PERIOD_H1, 20, 2, 0, PRICE_MEDIAN, MODE_LOWER, 2);
      g_ienvelopes_1444 = iEnvelopes(NULL, PERIOD_H1, 40, MODE_EMA, 1, PRICE_CLOSE, 0.4, MODE_UPPER, 1);
      g_ienvelopes_1452 = iEnvelopes(NULL, PERIOD_H1, 40, MODE_EMA, 1, PRICE_CLOSE, 0.4, MODE_LOWER, 1);
      g_istochastic_1040 = iStochastic(NULL, PERIOD_H1, 45, 27, 27, MODE_EMA, 1, MODE_MAIN, 1);
      g_istochastic_1048 = iStochastic(NULL, PERIOD_H1, 45, 27, 27, MODE_EMA, 1, MODE_SIGNAL, 1);
      g_istochastic_1072 = iStochastic(NULL, PERIOD_H1, 5, 3, 3, MODE_EMA, 1, MODE_MAIN, 1);
      g_istochastic_1080 = iStochastic(NULL, PERIOD_H1, 5, 3, 3, MODE_EMA, 1, MODE_SIGNAL, 1);
      g_istochastic_1088 = iStochastic(NULL, PERIOD_H1, 5, 3, 3, MODE_EMA, 1, MODE_MAIN, 2);
      g_istochastic_1096 = iStochastic(NULL, PERIOD_H1, 5, 3, 3, MODE_EMA, 1, MODE_SIGNAL, 2);
      g_istochastic_1104 = iStochastic(NULL, PERIOD_M15, 9, 9, 9, MODE_EMA, 1, MODE_MAIN, 1);
      g_istochastic_1112 = iStochastic(NULL, PERIOD_M15, 9, 9, 9, MODE_EMA, 1, MODE_SIGNAL, 1);
      g_istochastic_1120 = iStochastic(NULL, PERIOD_M15, 9, 9, 9, MODE_EMA, 1, MODE_MAIN, 2);
      g_istochastic_1128 = iStochastic(NULL, PERIOD_M15, 9, 9, 9, MODE_EMA, 1, MODE_SIGNAL, 2);
      g_istochastic_1136 = iStochastic(NULL, PERIOD_H1, 15, 9, 9, MODE_EMA, 0, MODE_MAIN, 1);
      g_istochastic_1144 = iStochastic(NULL, PERIOD_H1, 15, 9, 9, MODE_EMA, 0, MODE_SIGNAL, 1);
      g_istochastic_1152 = iStochastic(NULL, PERIOD_H1, 15, 9, 9, MODE_EMA, 0, MODE_MAIN, 2);
      g_istochastic_1160 = iStochastic(NULL, PERIOD_H1, 15, 9, 9, MODE_EMA, 0, MODE_SIGNAL, 2);
      g_ienvelopes_196 = iEnvelopes(NULL, PERIOD_H1, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_UPPER, 1);
      g_ienvelopes_212 = iEnvelopes(NULL, PERIOD_H1, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_LOWER, 1);
      g_ienvelopes_204 = iEnvelopes(NULL, PERIOD_H1, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_UPPER, 2);
      g_ienvelopes_220 = iEnvelopes(NULL, PERIOD_H1, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_LOWER, 2);
      g_ienvelopes_228 = iEnvelopes(NULL, PERIOD_H1, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_UPPER, 4);
      g_ienvelopes_236 = iEnvelopes(NULL, PERIOD_H1, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_LOWER, 4);
      g_ibands_548 = iBands(NULL, PERIOD_M15, 20, 2, 0, PRICE_MEDIAN, MODE_UPPER, 1);
      g_ibands_556 = iBands(NULL, PERIOD_M15, 20, 2, 0, PRICE_MEDIAN, MODE_LOWER, 1);
      g_ibands_580 = iBands(NULL, PERIOD_M15, 20, 2, 0, PRICE_MEDIAN, MODE_UPPER, 2);
      g_ibands_588 = iBands(NULL, PERIOD_M15, 20, 2, 0, PRICE_MEDIAN, MODE_LOWER, 2);
      gd_572 = (gd_492 + gd_500) / 2.0;
      g_ienvelopes_148 = iEnvelopes(NULL, PERIOD_M15, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_UPPER, 1);
      g_ienvelopes_164 = iEnvelopes(NULL, PERIOD_M15, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_LOWER, 1);
      g_ienvelopes_156 = iEnvelopes(NULL, PERIOD_M15, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_UPPER, 2);
      g_ienvelopes_172 = iEnvelopes(NULL, PERIOD_M15, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_LOWER, 2);
      g_ienvelopes_180 = iEnvelopes(NULL, PERIOD_M15, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_UPPER, 4);
      g_ienvelopes_188 = iEnvelopes(NULL, PERIOD_M15, 20, MODE_EMA, 1, PRICE_MEDIAN, 0.35, MODE_LOWER, 4);
      g_iatr_1616 = iATR(NULL, PERIOD_H1, 14, 1);
      gd_1988 = g_iatr_1616 / ld_8 / Point;
      if (gd_1988 < 15.0 && g_iatr_452 > 0.02) gd_1988 = 15;
      if (gd_1988 < 20.0 && g_iatr_452 <= 0.02) gd_1988 = 20;
      gd_1956 = FinalTarget_x_H1_ATR * gd_1988;
      gd_1964 = Trail_StopLoss_x_H1_ATR * gd_1988;
      gd_1908 = Trail_Trigger_x_H1_ATR * gd_1988;
      if (g_iatr_452 > 0.045) gd_1956 = 4.0 * gd_1988;
      if (gd_1988 > 30.0 && g_iatr_452 < 0.02) gd_1988 = 30;
      gd_1988 = StopLoss_x_H1_ATR * gd_1988;
   }
   if (g_bars_2116 != Bars) {
      
      g_bars_2116 = Bars;
      gs_true_2204 = "True";
      g_ihigh_108 = iHigh(NULL, PERIOD_W1, 1);
      g_ilow_116 = iLow(NULL, PERIOD_W1, 1);
      g_ima_124 = iMA(NULL, PERIOD_W1, 5, 0, MODE_EMA, PRICE_TYPICAL, 1);
      g_iatr_132 = iATR(NULL, PERIOD_W1, 4, 1);
      
   }
   g_iclose_2352 = iClose(NULL, PERIOD_M15, 1);
   g_iopen_2344 = iOpen(NULL, PERIOD_M15, 1);
   g_ilow_76 = iLow(NULL, PERIOD_H1, 1);
   g_ihigh_84 = iHigh(NULL, PERIOD_H1, 1);
   g_iclose_92 = iClose(NULL, PERIOD_H1, 1);
   g_iopen_100 = iOpen(NULL, PERIOD_H1, 1);
   for (int pos_72 = 0; pos_72 < OrdersTotal(); pos_72++) {
      if (OrderSelect(pos_72, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
      if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
      if (OrderType() == OP_BUY) ld_64 += (Bid - OrderOpenPrice()) / ld_8 / Point;
      if (OrderType() == OP_SELL) ld_64 += (OrderOpenPrice() - Bid) / ld_8 / Point;
   }
   if (gd_268 < ld_64) gd_268 = ld_64;
   if (gd_268 > gd_1908 && gi_1796 == TRUE) {
      if (gs_2100 == "SELLTRADE" && ld_0 < g_order_open_price_436 - gd_1964 * ld_8 * Point - 0.0005) f0_7(g_order_open_price_436 - gd_1964 * ld_8 * Point);
      if (gs_2100 == "BUYTRADE" && ld_0 > g_order_open_price_436 + gd_1964 * ld_8 * Point + 0.0005) f0_7(g_order_open_price_436 + gd_1964 * ld_8 * Point);
   }
   if (gd_268 > 2.0 * gd_1908 && gi_1796 == TRUE) {
      if (gs_2100 == "SELLTRADE" && ld_0 < g_order_open_price_436 - 2.0 * gd_1964 * ld_8 * Point - 0.0005) f0_7(g_order_open_price_436 - 2.0 * gd_1964 * ld_8 * Point);
      if (gs_2100 == "BUYTRADE" && ld_0 > g_order_open_price_436 + 2.0 * gd_1964 * ld_8 * Point + 0.0005) f0_7(g_order_open_price_436 + 2.0 * gd_1964 * ld_8 * Point);
   }
   bool li_76 = FALSE;
   if (gs_true_2204 == "True") {
      li_76 = TradeCall1(g_ibands_556, g_ibands_588, g_ienvelopes_164, g_ibands_548, g_ibands_580, g_ienvelopes_148, g_ibands_1468, g_ibands_620, g_ibands_1460, g_ibands_612,
         g_ilow_76, g_iopen_2344, g_iclose_2352, g_ihigh_84, g_iopen_100, g_iclose_92, g_ienvelopes_1452, g_ienvelopes_1444, g_ienvelopes_212, g_ienvelopes_220, g_ienvelopes_236,
         g_ienvelopes_196, g_ienvelopes_204, g_ienvelopes_228, g_istochastic_1040, g_istochastic_1048, g_istochastic_1072, g_istochastic_1080, g_istochastic_1104, g_istochastic_1112,
         g_istochastic_1136, g_istochastic_1144, g_iatr_1616, g_iatr_452);
      if (li_76 == TRUE && gs_2100 == "") f0_4();
      else {
         if (li_76 == TRUE && gs_2100 == "SELLTRADE") {
            f0_6();
            f0_4();
         }
      }
      if (li_76 == 2 && gs_2100 == "") f0_15();
      else {
         if (li_76 == 2 && gs_2100 == "BUYTRADE") {
            f0_6();
            f0_15();
         }
      }
   }
   if (Seconds() == 0 || gi_1668 == 0) {
      gi_1668++;
      ObjectsDeleteAll(0, OBJ_LABEL);
      // ObjectCreate("Validation", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("MagicNumber", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("Status", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("OpenTrade", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("PriceAction", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("PriceAction2", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("PriceAction3", OBJ_LABEL, 0, 0, 0);
      // ObjectCreate("Version", OBJ_LABEL, 0, 0, 0);
      ObjectSet("Validation", OBJPROP_CORNER, 0);
      ObjectSet("Validation", OBJPROP_XDISTANCE, 10);
      ObjectSet("Validation", OBJPROP_YDISTANCE, 40);
      ObjectSet("MagicNumber", OBJPROP_CORNER, 0);
      ObjectSet("MagicNumber", OBJPROP_XDISTANCE, 10);
      ObjectSet("MagicNumber", OBJPROP_YDISTANCE, 55);
      ObjectSet("Status", OBJPROP_CORNER, 0);
      ObjectSet("Status", OBJPROP_XDISTANCE, 10);
      ObjectSet("Status", OBJPROP_YDISTANCE, 70);
      ObjectSet("OpenTrade", OBJPROP_CORNER, 0);
      ObjectSet("OpenTrade", OBJPROP_XDISTANCE, 10);
      ObjectSet("OpenTrade", OBJPROP_YDISTANCE, 90);
      ObjectSet("PriceAction", OBJPROP_CORNER, 0);
      ObjectSet("PriceAction", OBJPROP_XDISTANCE, 10);
      ObjectSet("PriceAction", OBJPROP_YDISTANCE, 105);
      ObjectSet("PriceAction2", OBJPROP_CORNER, 0);
      ObjectSet("PriceAction2", OBJPROP_XDISTANCE, 10);
      ObjectSet("PriceAction2", OBJPROP_YDISTANCE, 120);
      ObjectSet("PriceAction3", OBJPROP_CORNER, 0);
      ObjectSet("PriceAction3", OBJPROP_XDISTANCE, 10);
      ObjectSet("PriceAction3", OBJPROP_YDISTANCE, 135);
      ObjectSet("Version", OBJPROP_CORNER, 0);
      ObjectSet("Version", OBJPROP_XDISTANCE, 10);
      ObjectSet("Version", OBJPROP_YDISTANCE, 150);
      // ObjectSetText("Validation", WindowExpertName() + " �������� ������ �������", 10, "Arial", Yellow);
      // ObjectSetText("MagicNumber", "Trade MagicNumber : " + gi_1176, 8, "Arial", White);
      for (int pos_88 = 0; pos_88 < OrdersTotal(); pos_88++) {
         if (OrderSelect(pos_88, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
         if (OrderMagicNumber() != gi_1176 || OrderSymbol() != Symbol()) continue;
         ld_80 += OrderProfit();
      }
      // ObjectSetText("OpenTrade", "", 8, "Arial", White);
      // if (gs_2100 == "") ObjectSetText("OpenTrade", "||||||||||||.... ", 8, "Arial", White);
      // if (gs_2100 == "BUYTRADE") ObjectSetText("OpenTrade", "Ray Scalper Trade : LONG " + Symbol(), 8, "Arial", White);
      // if (gs_2100 == "SELLTRADE") ObjectSetText("OpenTrade", "Ray Scalper Trade : SHORT " + Symbol(), 8, "Arial", White);
      g_symbol_1676 = Symbol();
      ld_92 = MarketInfo(g_symbol_1676, MODE_MINLOT);
      ld_100 = MarketInfo(g_symbol_1676, MODE_MAXLOT);
      ld_unused_108 = AccountLeverage();
      lotsize_116 = MarketInfo(g_symbol_1676, MODE_LOTSIZE);
      lotstep_124 = MarketInfo(g_symbol_1676, MODE_LOTSTEP);
      marginrequired_132 = MarketInfo(g_symbol_1676, MODE_MARGINREQUIRED);
      tickvalue_140 = MarketInfo(g_symbol_1676, MODE_TICKVALUE);
      ticksize_148 = MarketInfo(g_symbol_1676, MODE_TICKSIZE);
      ld_156 = MathMin(AccountBalance(), AccountEquity());
      li_164 = 0;
      ld_168 = 0.0;
      if (lotstep_124 == 0.01) li_164 = 2;
      if (lotstep_124 == 0.1) li_164 = 1;
      if (gi_1736 == TRUE) ld_168 = f0_3(g_symbol_1676, gd_2044);
      if (gi_1736 == FALSE) ld_168 = f0_11(g_symbol_1676, gd_2044);
      ld_168 = StrToDouble(DoubleToStr(ld_168, li_164));
      if (ld_168 < ld_92) ld_168 = ld_92;
      if (ld_168 > ld_100) ld_168 = ld_100;
      // if (gs_2100 == "") ObjectSetText("Status", "Ray Scalper >>> Waiting... Lot Size for next trade = " + DoubleToStr(ld_168, 2), 8, "Arial", White);
      // if (gs_2100 != "" && ld_80 >= 0.0) ObjectSetText("Status", "Ray Scalper Trade Gain : " + DoubleToStr(ld_80, 0), 8, "Arial", Lime);
      // if (gs_2100 != "" && ld_80 < 0.0) ObjectSetText("Status", "Ray Scalper Trade Gain : " + DoubleToStr(ld_80, 0), 8, "Arial", Red);
      // ObjectSetText("PriceAction", "H1 ATR : " + DoubleToStr(g_iatr_1616, 5) + " || W1 ATR : " + DoubleToStr(g_iatr_452, 5) + " Points", 8, "Arial", White);
      // if (gs_2100 == "SELLTRADE") ObjectSetText("PriceAction2", "H1 move above: " + DoubleToStr(g_order_open_price_436 + gd_1988 * ld_8 * Point, 5) + " Will Trigger StopLoss", 8, "Arial", White);
      else {
         // if (gs_2100 == "BUYTRADE") ObjectSetText("PriceAction2", "H1 move below: " + DoubleToStr(g_order_open_price_436 - gd_1988 * ld_8 * Point, 5) + " Will Trigger StopLoss", 8, "Arial", White);
         // else ObjectSetText("PriceAction2", "||||||||||||....", 8, "Arial", White);
      }
      // if (gs_2100 == "SELLTRADE") ObjectSetText("PriceAction3", "Price move below: " + DoubleToStr(g_order_open_price_436 - gd_1908 * ld_8 * Point, 5) + " Will Trigger Trailing SL", 8, "Arial", White);
      // else {
         // if (gs_2100 == "BUYTRADE") ObjectSetText("PriceAction3", "Price move above: " + DoubleToStr(g_order_open_price_436 + gd_1908 * ld_8 * Point, 5) + " Will Trigger Trailing SL", 8, "Arial", White);
         // else ObjectSetText("PriceAction3", "||||||||||||....", 8, "Arial", White);
      // }
      // ObjectSetText("Version", "Version 1.0 : Build Date 20120827", 8, "Arial", Lime);
      
   }
}


int TradeCall1(double ibands_556, double ibands_588, double ienvelopes_164, double ibands_548, double ibands_580, double ienvelopes_148, double ibands_1468, double ibands_620, double ibands_1460, double ibands_612, double ilow_76, double iopen_2344, double iclose_2352, double ihigh_84, double iopen_100, double iclose_92, double ienvelopes_1452, double ienvelopes_1444, double ienvelopes_212, double ienvelopes_220, double ienvelopes_236, double ienvelopes_196, double ienvelopes_204, double ienvelopes_228, double istochastic_1040, double istochastic_1048, double istochastic_1072, double istochastic_1080, double istochastic_1104, double istochastic_1112, double istochastic_1136, double istochastic_1144, double iatr_1616, double iatr_452)
{
  if ( (ibands_612 < ienvelopes_196) && (ibands_1460 > ienvelopes_196) && (ienvelopes_204 > ienvelopes_228) && (ienvelopes_196 > ienvelopes_228)
      && (istochastic_1104 > istochastic_1112) && (iatr_452 < 0.04) && (iatr_452 > 0.02)) return (1);

  if ((ibands_620 > ienvelopes_212) && (ibands_1468 < ienvelopes_212) && (ienvelopes_220 < ienvelopes_236) && (ienvelopes_212 < ienvelopes_236)
      && (istochastic_1104 < istochastic_1112) && (iatr_452 < 0.04) && (iatr_452 > 0.02)) return (2);

  if ((ibands_580 < ienvelopes_148) && (ibands_548 > ienvelopes_148) && (istochastic_1104 > istochastic_1112) && (istochastic_1136 > istochastic_1144)
      && (iatr_452 < 0.04)) return (1);

  if ((ibands_588 > ienvelopes_164) && (ibands_556 < ienvelopes_164) && (istochastic_1104 < istochastic_1112) && (istochastic_1136 < istochastic_1144)
      && (iatr_452 < 0.04)) return (2);

  if ((ilow_76 < ienvelopes_1452) && (iclose_92 > ienvelopes_1452) && (iopen_100 < iclose_92) && (ibands_1468 > ienvelopes_1452) && (iatr_452 > 0.02)
      && (istochastic_1136 > istochastic_1144)) return (1);

  if ((ihigh_84 > ienvelopes_1444) && (iclose_92 < ienvelopes_1444) && (iopen_100 > iclose_92) && (ibands_1460 < ienvelopes_1444) && (iatr_452 > 0.02)
      && (istochastic_1136 < istochastic_1144)) return (2);

  if (((2.0 * iatr_1616) < (iclose_2352 - iopen_2344)) && (istochastic_1040 < istochastic_1048) && (istochastic_1072 > istochastic_1080)) return (1);

  if (((2.0 * iatr_1616) < (iopen_2344 - iclose_2352)) && (istochastic_1040 > istochastic_1048) && (istochastic_1072 < istochastic_1080)) return (2);

  if (((2.0 * iatr_1616) < (iclose_2352 - iopen_2344)) && (istochastic_1136 < istochastic_1144) && (iatr_452 < 0.045)) return (1);
  
  if (((2.0 * iatr_1616) < (iopen_2344 - iclose_2352)) && (istochastic_1136 > istochastic_1144) && (iatr_452 < 0.045)) return (2);
  return (0);
}

