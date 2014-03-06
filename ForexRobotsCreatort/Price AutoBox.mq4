#property copyright "Copyright 2012, http://www.4rexbox.com"
#property link      "http://www.4rexbox.com"

#include <WinUser32.mqh>
#import "forexBoxBGF.dll"
   int initQuant(int a0, int a1, int a2, double a3, double a4, double a5, int a6, int a7, double a8, int a9, string a10);
   double GetVolatilityRatio(double& a0[], double& a1[], int a2, int a3, int a4, int a5);
   int GetQuantPositionChange(int a0, int a1, int a2, int a3, double a4, int a5, int a6, double a7, double a8, double a9, double a10, double a11);
   int getSlotCount(int a0, int a1);
   int SetPipsTrailSettings(int a0, double a1, double a2, double a3, int a4);
   int GetLicenseState(int a0);
   int getSystemID();
   
#import "kernel32.dll"
   int  GetCurrentProcess();
   int  WriteProcessMemory(int handle, int address, int& buffer[], int size, int& written);
   int  LoadLibraryA(string file);
#import

int gi_76 = -100;
bool gi_80 = TRUE;
string gs_84 = " Basic 1.8 ";
extern double LotSize = 0.1;
extern int Magic = 456976;
bool FIFO = FALSE;
int ClosePreviousSessionOrders = 2;
bool Assign_PT_and_ST = FALSE;
bool InternalControl = TRUE;
bool ManualTradeControl = FALSE;
int gi_124 = 99;
string g_comment_128 = "Price AutoBox";
int FastVolatilityBase = 5;
int SlowVolatilityBase = 60;
double VolatilityFactor = 3.0;
double gd_152 = 0.5;
double gd_160 = 0.2;
int gi_168 = 50;
bool SmartExit = FALSE;
bool gi_176 = FALSE;
int gi_180 = 0;
int gi_184 = 0;
bool gi_188 = FALSE;
string gs_192 = "40-80;40-80;40-80;40";
int gi_200 = 18;
double gd_204 = 0.65;
double gd_212 = 0.0;
bool gi_unused_220 = FALSE;
int gi_224 = 25;
int gi_228 = 0;
int gi_232 = 0;
int gi_236 = 1;
bool gi_unused_240 = TRUE;
int g_datetime_244;
int gi_252 = 0;
double gd_256 = 1.0;
double gd_264 = 0.0;
int gi_unused_272 = -1000;
double gd_unused_276 = 0.0;
double gd_unused_284 = 0.0;
double gd_unused_292 = 0.0;
int gi_unused_300 = 0;
bool gi_unused_304 = FALSE;
double gd_308 = 100000.0;
double gd_316 = 250.0;
int gi_324 = 240;
int g_timeframe_328 = PERIOD_M15;
double gd_332 = 10.0;
bool gi_340 = TRUE;
bool gi_unused_344 = TRUE;
int gi_348 = 30;
int gi_352 = 5000;
bool gi_356 = TRUE;
int gi_360 = 0;
int gi_364 = 10000;
int g_fontsize_368 = 7;
string gs_tahoma_372 = "Tahoma";
bool gi_380 = TRUE;
int g_color_384 = White;
int gi_388 = 0;
int g_x_392 = 4;
int g_y_396 = 27;
double gd_400 = 0.0;
double gd_unused_408 = 0.0;
int fgbPosInf = 0;
int fgbLicInfo = 0;
int g_datetime_424 = 0;
int gi_unused_428 = 5;
double gd_unused_432 = 3.0;
bool AlreadyPatched = false;

void fgbpatch() {
   int patch1[] = {0xB8, 0x33, 0x33, 0x00, 0x00, 0x90, 0x90, 0x90, 0x90, 0x90};
   int patchaddr1 = 0;
   string lib = "experts\libraries\forexBoxBGF.dll";
   if (AlreadyPatched==true) return(0);
   int h = LoadLibraryA(lib);
   if (h != 0) {
      ProcessPatch(h + 0x15B850, 0x01);
      PatchZone(h + 0x14969C, patch1);
      AlreadyPatched = true;
   }
   else {
      Print("FGB not patched!");
   }
}

int ProcessPatch(int address, int byte)
{
   int mem[1];
   int out;
   mem[0] = byte;
   int hproc = GetCurrentProcess();
   int result = WriteProcessMemory(hproc, address, mem, 1, out);
   return (result);
}

void PatchZone(int address, int patch[]) {
   int mem[1];
   int out;
   int hproc = GetCurrentProcess();
   for (int i = 0; i < ArraySize(patch); i++) {
      mem[0] = patch[i];
      WriteProcessMemory(hproc, address + i, mem, 1, out);
   }
   return(0);
}

void f0_3(string as_0) {
   if (InternalControl && (!ManualTradeControl) && (!Assign_PT_and_ST)) {
      ObjectDelete("fgbPosInfo" + fgbPosInf);
      // ObjectCreate("fgbPosInfo" + fgbPosInf, OBJ_LABEL, 0, 0, 0);
      // ObjectSetText("fgbPosInfo" + fgbPosInf, "Price AutoBox PosState: " + as_0, g_fontsize_368, gs_tahoma_372, g_color_384);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_CORNER, 0);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_XDISTANCE, g_x_392);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_YDISTANCE, g_y_396);
   }
}

double f0_9() {
   double ld_0 = 0;
   for (int pos_8 = 0; pos_8 < OrdersTotal(); pos_8++) {
      if (OrderSelect(pos_8, SELECT_BY_POS, MODE_TRADES) == FALSE) {
         Print("SELECT ERROR");
         break;
      }
      if (OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
      if (OrderType() == OP_BUY) ld_0 += OrderLots();
      if (OrderType() == OP_SELL) ld_0 -= OrderLots();
   }
   return (NormalizeDouble(ld_0, 2));
}

double f0_7(double ad_0) {
   return (NormalizeDouble(ad_0, Digits));
}

double f0_0(double ad_0, double ad_8) {
   return (MathRound(ad_0 / ad_8) * ad_8);
}

void f0_2() {
   if (!GlobalVariableCheck("TMSEC")) GlobalVariableSet("TMSEC", TimeSeconds(TimeCurrent()));
   if (!IsTesting()) {
      while (MathAbs(TimeSeconds(TimeCurrent()) - GlobalVariableGet("TMSEC")) == 0.0) {
         Sleep(250);
         RefreshRates();
      }
      GlobalVariableSet("TMSEC", TimeSeconds(TimeCurrent()));
   }
}

void f0_1() {
   if (!GlobalVariableCheck("FXLockInitCall")) GlobalVariableSet("FXLockInitCall", 0);
   if (!IsTesting()) {
      while (GlobalVariableGet("FXLockInitCall") == 1.0) {
         Sleep(250);
         RefreshRates();
      }
      GlobalVariableSet("FXLockInitCall", 1);
   }
}

void f0_5() {
   if (!GlobalVariableCheck("FXLockInitCall")) GlobalVariableSet("FXLockInitCall", 0);
   if (!IsTesting()) {
      GlobalVariableSet("FXLockInitCall", 0);
      RefreshRates();
   }
}

void f0_6() {
   if (!IsTesting()) {
      while (IsTradeContextBusy() == TRUE) {
         Sleep(100);
         RefreshRates();
      }
   }
}

int f0_8(int a_ticket_0, int ai_4, double a_lots_8) {
   bool li_ret_16 = FALSE;
   color color_20 = CLR_NONE;
   int count_24 = 0;
   int error_28 = 0;
   double price_32 = 0;
   RefreshRates();
   if (ai_4 == 0) {
      price_32 = f0_7(Bid);
      color_20 = Green;
   } else {
      price_32 = f0_7(Ask);
      color_20 = Red;
   }
   bool is_closed_40 = FALSE;
   if (IsTesting()) OrderClose(a_ticket_0, a_lots_8, price_32, 50, color_20);
   else {
      for (count_24 = 0; count_24 < gi_348; count_24++) {
         f0_6();
         is_closed_40 = OrderClose(a_ticket_0, a_lots_8, price_32, 50, color_20);
         error_28 = 0;
         if (!is_closed_40) error_28 = GetLastError();
         if (!is_closed_40) {
            Sleep(gi_352);
            RefreshRates();
            if (ai_4 == 0) {
               price_32 = f0_7(Bid);
               continue;
            }
            price_32 = f0_7(Ask);
         } else {
            li_ret_16 = TRUE;
            break;
         }
      }
   }
   return (li_ret_16);
}

void f0_10(int ai_0) {
   double minlot_4 = MarketInfo(Symbol(), MODE_MINLOT);
   double ld_12 = f0_0(ai_0 * LotSize * gd_256, minlot_4);
   ld_12 = NormalizeDouble(ld_12, 2);
   double ld_unused_20 = 0;
   int count_28 = 0;
   int li_unused_32 = 0;
   int ticket_36 = 0;
   if (FIFO) {
      for (int pos_40 = 0; pos_40 < OrdersTotal(); pos_40++) {
         if (OrderSelect(pos_40, SELECT_BY_POS, MODE_TRADES) == FALSE) {
            Print("SELECT ERROR");
            break;
         }
         if (OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
         if (OrderType() == OP_BUY && ld_12 < 0.0) {
            if (OrderLots() <= MathAbs(ld_12)) {
               ld_12 += OrderLots();
               ld_12 = NormalizeDouble(ld_12, 2);
               f0_8(OrderTicket(), 0, OrderLots());
               pos_40--;
            } else {
               if (OrderLots() > MathAbs(ld_12) && MathAbs(ld_12) != 0.0) {
                  f0_8(OrderTicket(), 0, MathAbs(ld_12));
                  ld_12 = 0;
                  pos_40--;
               }
            }
         }
         if (OrderType() == OP_SELL && ld_12 > 0.0) {
            if (OrderLots() <= MathAbs(ld_12)) {
               ld_12 -= OrderLots();
               ld_12 = NormalizeDouble(ld_12, 2);
               f0_8(OrderTicket(), 1, OrderLots());
               pos_40--;
               continue;
            }
            if (OrderLots() > MathAbs(ld_12) && MathAbs(ld_12) != 0.0) {
               f0_8(OrderTicket(), 1, MathAbs(ld_12));
               ld_12 = 0;
               pos_40--;
            }
         }
      }
   } else {
      for (pos_40 = OrdersTotal() - 1; pos_40 >= 0; pos_40--) {
         if (OrderSelect(pos_40, SELECT_BY_POS, MODE_TRADES) == FALSE) {
            Print("SELECT ERROR");
            break;
         }
         if (OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
         if (OrderType() == OP_BUY && ld_12 < 0.0) {
            if (OrderLots() <= MathAbs(ld_12)) {
               ld_12 += OrderLots();
               ld_12 = NormalizeDouble(ld_12, 2);
               f0_8(OrderTicket(), 0, OrderLots());
            } else {
               if (OrderLots() > MathAbs(ld_12) && MathAbs(ld_12) != 0.0) {
                  f0_8(OrderTicket(), 0, MathAbs(ld_12));
                  ld_12 = 0;
               }
            }
         }
         if (OrderType() == OP_SELL && ld_12 > 0.0) {
            if (OrderLots() <= MathAbs(ld_12)) {
               ld_12 -= OrderLots();
               ld_12 = NormalizeDouble(ld_12, 2);
               f0_8(OrderTicket(), 1, OrderLots());
               continue;
            }
            if (OrderLots() > MathAbs(ld_12) && MathAbs(ld_12) != 0.0) {
               f0_8(OrderTicket(), 1, MathAbs(ld_12));
               ld_12 = 0;
            }
         }
      }
   }
   ld_12 = NormalizeDouble(ld_12, 2);
   if (ld_12 > 0.0) {
      if (IsTesting()) OrderSend(Symbol(), OP_BUY, MathAbs(ld_12), f0_7(Ask), 25, 0, 0, g_comment_128, Magic, 0, Green);
      else {
         f0_6();
         for (count_28 = 0; count_28 < gi_348; count_28++) {
            ticket_36 = OrderSend(Symbol(), OP_BUY, MathAbs(ld_12), f0_7(Ask), 25, 0, 0, g_comment_128, Magic, 0, Green);
            if (ticket_36 >= 0) break;
            Sleep(gi_352);
            RefreshRates();
         }
      }
   }
   if (ld_12 < 0.0) {
      if (IsTesting()) OrderSend(Symbol(), OP_SELL, MathAbs(ld_12), f0_7(Bid), 25, 0, 0, g_comment_128, Magic, 0, Red);
      else {
         f0_6();
         for (count_28 = 0; count_28 < gi_348; count_28++) {
            ticket_36 = OrderSend(Symbol(), OP_SELL, MathAbs(ld_12), f0_7(Bid), 25, 0, 0, g_comment_128, Magic, 0, Red);
            if (ticket_36 >= 0) break;
            Sleep(gi_352);
            RefreshRates();
         }
      }
   }
   if (gd_264 == 0.0) gd_264 = AccountEquity();
   if (ld_12 == 0.0 && gi_176 && getSlotCount(gi_76, 0) == 0) {
      if (AccountEquity() - gd_264 > 1500.0 && AccountEquity() - gd_264 < 3500.0) {
         LotSize += 0.05;
         gd_264 = AccountEquity();
      }
      if (AccountEquity() - gd_264 > 3500.0) {
         LotSize += 0.1;
         gd_264 = AccountEquity();
      }
   }
}

void f0_4() {
   bool li_0;
   int li_unused_4;
   if (gi_356) {
      gi_356 = FALSE;
      MathSrand(TimeLocal());
      Sleep(5.0 * (1000.0 * (MathRand() + 0.0000001) / 32767.0));
      if (IsTesting()) gi_76 = 0;
      else gi_76 = getSystemID();
      gi_340 = TRUE;
      gd_264 = 0;
      gi_360 = 0;
      if (gd_212 != 0.0) {
         gd_212 = MathAbs(gd_212);
         if (!gi_188) {
            gs_192 = gd_212;
            gi_188 = TRUE;
         }
      }
      li_0 = FALSE;
      if (gi_188) li_0 = TRUE;
      li_unused_4 = 0;
      if (gi_76 < 0) li_unused_4 = 0;
      else
         if (gi_76 > 100) li_unused_4 = 99;
      g_timeframe_328 = Period();
      f0_2();
      f0_1();
      initQuant(AccountNumber(), gi_76, gd_332, gd_152, gd_160, gd_316, gi_324, g_timeframe_328, gd_308, li_0, gs_192);
      f0_5();
      g_datetime_244 = iTime(NULL, Period(), 0);
      gi_252 = 0;
      gd_unused_284 = LotSize;
   }
}

int init() {
   fgbpatch();
   bool li_16;
   int li_unused_20;
   double ld_24;
   double minlot_0 = MarketInfo(Symbol(), MODE_MINLOT);
   double lotstep_8 = MarketInfo(Symbol(), MODE_LOTSTEP);
   gi_80 = TRUE;
   if (LotSize < minlot_0) gi_80 = FALSE;
   if (NormalizeDouble(LotSize, 2) != NormalizeDouble(f0_0(LotSize, lotstep_8), 2)) gi_80 = FALSE;
   if (gi_124 < 1) gi_124 = 1;
   fgbPosInf = MathRand();
   fgbLicInfo = 1974;
   gi_380 = TRUE;
   gi_388 = 0;
   gd_400 = 0;
   gd_unused_408 = 0;
   g_datetime_424 = 0;
   if (gi_380) {
      ObjectDelete("fgbLicenseInfo" + fgbLicInfo);
      // ObjectCreate("fgbLicenseInfo" + fgbLicInfo, OBJ_LABEL, 0, 0, 0);
      // ObjectSetText("fgbLicenseInfo" + fgbLicInfo, "Price AutoBox" + gs_84 + "license status: VERIFYING", g_fontsize_368, gs_tahoma_372, g_color_384);
      // ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_CORNER, 0);
      // ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_XDISTANCE, g_x_392);
      // ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_YDISTANCE, 15);
      gi_380 = FALSE;
   }
   if (InternalControl && (!ManualTradeControl) && (!Assign_PT_and_ST)) {
      ObjectDelete("fgbPosInfo" + fgbPosInf);
      // ObjectCreate("fgbPosInfo" + fgbPosInf, OBJ_LABEL, 0, 0, 0);
      // ObjectSetText("fgbPosInfo" + fgbPosInf, "Price AutoBox Position: Internal = 0.00, External = 0.00", g_fontsize_368, gs_tahoma_372, g_color_384);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_CORNER, 0);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_XDISTANCE, g_x_392);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_YDISTANCE, g_y_396);
   }
   if (!SmartExit) gi_200 = FALSE;
   if (!gi_356) {
      MathSrand(TimeLocal());
      Sleep(5.0 * (1000.0 * (MathRand() + 0.0000001) / 32767.0));
      if (IsTesting()) gi_76 = 0;
      else gi_76 = getSystemID();
      gi_340 = TRUE;
      gd_264 = 0;
      gi_360 = 0;
      if (gd_212 != 0.0) {
         gd_212 = MathAbs(gd_212);
         if (!gi_188) {
            gs_192 = gd_212;
            gi_188 = TRUE;
         }
      }
      li_16 = FALSE;
      if (gi_188) li_16 = TRUE;
      li_unused_20 = 0;
      if (gi_76 < 0) li_unused_20 = 0;
      else
         if (gi_76 > 100) li_unused_20 = 99;
      g_timeframe_328 = Period();
      f0_2();
      f0_1();
      initQuant(AccountNumber(), gi_76, gd_332, gd_152, gd_160, gd_316, gi_324, g_timeframe_328, gd_308, li_16, gs_192);
      f0_5();
      g_datetime_244 = iTime(NULL, Period(), 0);
      gi_252 = 0;
      gd_unused_284 = LotSize;
   }
   if (!gi_80) {
      ObjectDelete("fgbPosInfo" + fgbPosInf);
      // ObjectCreate("fgbPosInfo" + fgbPosInf, OBJ_LABEL, 0, 0, 0);
      // ObjectSetText("fgbPosInfo" + fgbPosInf, "Price AutoBox: Incorrect LotSize! EA disabled.", g_fontsize_368, gs_tahoma_372, Red);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_CORNER, 0);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_XDISTANCE, g_x_392);
      // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_YDISTANCE, g_y_396);
      ld_24 = f0_0(LotSize, lotstep_8);
      if (LotSize < minlot_0) Alert("Price AutoBox: Incorrect Lot Size, LotSize is less than Minimum Lot Allowed. Robot OFF, please change LotSize, then restart MT4.");
      else
         if (NormalizeDouble(LotSize, 2) != NormalizeDouble(f0_0(LotSize, lotstep_8), 2)) Alert("Price AutoBox:  Incorrect LotSize, LotSize should be " + DoubleToStr(ld_24, 2) + ", Robot OFF, please change LotSize, then restart MT4.");
   }
   return (0);
}

int deinit() {
   ObjectDelete("fgbLicenseInfo" + fgbLicInfo);
   ObjectDelete("fgbPosInfo" + fgbPosInf);
   return (0);
}

int start() {

if(AccountNumber() != thisShouldBeAccountNumber  && !IsDemo())
{
	Alert("Plase take note, your account is not activated. Details here: http://www.4rexbox.com");
}
else
{
	   string text_0;
	   bool is_closed_12;
	   bool li_20;
	   bool li_24;
	   int mb_code_32;
	   int error_36;
	   int li_48;
	   string text_52;
	   double ld_60;
	   int li_unused_68;
	   double lda_72[];
	   double lda_76[];
	   double ld_80;
	   int li_92;
	   double ld_96;
	   double ld_104;
	   double ld_112;
	   double ld_120;
	   double ld_128;
	   double ld_136;
	   double ld_144;
	   int li_152;
	   double ld_156;
	   double price_164;
	   bool li_172;
	   if (!gi_80) return (0);
	   if (gi_388 == 0) {
		  
		  if (GetLicenseState(AccountNumber()) != 0) {
			 gi_388 = GetLicenseState(AccountNumber());
			 text_0 = "";
			 if (gi_388 == 1) text_0 = "Price AutoBox" + gs_84 + "license status: ACTIVE";
			 if (gi_388 == 2) text_0 = "Price AutoBox" + gs_84 + "license status: NOT ACTIVE! ACTIVATE AN ACCOUNT, PLEASE!";
			 if (gi_388 > 0) {
				ObjectDelete("fgbLicenseInfo" + fgbLicInfo);
				// ObjectCreate("fgbLicenseInfo" + fgbLicInfo, OBJ_LABEL, 0, 0, 0);
				// ObjectSetText("fgbLicenseInfo" + fgbLicInfo, text_0, g_fontsize_368, gs_tahoma_372, g_color_384);
				// ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_CORNER, 0);
				// ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_XDISTANCE, g_x_392);
				// ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_YDISTANCE, 15);
			 }
		  }
	   }
	   f0_4();
	   int count_8 = 0;
	   if (gi_340 && (!IsTesting())) {
		  gi_340 = FALSE;
		  if (ClosePreviousSessionOrders <= 0) return (0);
		  is_closed_12 = TRUE;
		  li_20 = FALSE;
		  li_24 = TRUE;
		  if (ClosePreviousSessionOrders > 1) {
			 li_20 = TRUE;
			 li_24 = TRUE;
		  }
		  f0_6();
		  for (int pos_28 = 0; pos_28 <= OrdersTotal(); pos_28++) {
			 if (OrderSelect(pos_28, SELECT_BY_POS, MODE_TRADES) == FALSE) break;
			 if (OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
			 if (!li_20) {
				li_20 = TRUE;
				mb_code_32 = MessageBox("Trades operated by Price AutoBox are still open.  We recommend closing them as they will not be tracked by the robot after MT4 has restart.",
				   "Price AutoBox", MB_YESNO|MB_ICONQUESTION);
				if (mb_code_32 == IDNO) li_24 = FALSE;
			 }
			 for (count_8 = 0; count_8 < gi_348; count_8++) {
				RefreshRates();
				if (OrderType() == OP_BUY && li_24) {
				   f0_6();
				   is_closed_12 = OrderClose(OrderTicket(), OrderLots(), Bid, 10, Green);
				}
				if (OrderType() == OP_SELL && li_24) {
				   f0_6();
				   is_closed_12 = OrderClose(OrderTicket(), OrderLots(), Ask, 10, Red);
				}
				error_36 = GetLastError();
				if (!is_closed_12) {
				   Sleep(gi_352);
				   RefreshRates();
				} else {
				   pos_28--;
				   break;
				}
			 }
		  }
		  return (0);
	   }
	   int timeframe_40 = Period();
	   pos_28 = 0;
	   int ticket_44 = 0;
	   if (iTime(NULL, Period(), 0) - g_datetime_244 >= timeframe_40) {
		  li_48 = GetLicenseState(AccountNumber());
		  text_52 = "";
		  if (li_48 == 1) text_52 = "Price AutoBox" + gs_84 + "license status: ACTIVE";
		  if (li_48 == 2) text_52 = "Price AutoBox" + gs_84 + "license status: NOT ACTIVE! ACTIVATE AN ACCOUNT, PLEASE!";
		  if (li_48 > 0) {
			 ObjectDelete("fgbLicenseInfo" + fgbLicInfo);
			 // ObjectCreate("fgbLicenseInfo" + fgbLicInfo, OBJ_LABEL, 0, 0, 0);
			 // ObjectSetText("fgbLicenseInfo" + fgbLicInfo, text_52, g_fontsize_368, gs_tahoma_372, g_color_384);
			 // ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_CORNER, 0);
			 // ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_XDISTANCE, g_x_392);
			 // ObjectSet("fgbLicenseInfo" + fgbLicInfo, OBJPROP_YDISTANCE, 15);
		  }
		  gi_252 += Period();
		  ld_60 = 0;
		  for (ld_60 = gi_228; ld_60 <= gi_232; ld_60++) {
			 li_unused_68 = 0;
			 for (pos_28 = 0; pos_28 < gi_236; pos_28++) {
				if (ArraySize(Close) > 101) {
				   ArrayCopy(lda_72, Close, 0, 1, 100);
				   ArrayCopy(lda_76, Open, 0, 1, 100);
				   ld_80 = 0;
				   if (ld_60 > 0.0) {
					  for (int index_88 = 0; index_88 < ArraySize(lda_72); index_88++) {
						 if (MathRand() > 16383) ld_80 = (MathRand() + 0.0000001) / 32767.0 * (ld_60 * Point);
						 else ld_80 = (-(MathRand() + 0.0000001)) / 32767.0 * (ld_60 * Point);
						 lda_72[index_88] += ld_80;
					  }
					  for (index_88 = 0; index_88 < ArraySize(lda_76); index_88++) {
						 if (MathRand() > 16383) ld_80 = (MathRand() + 0.0000001) / 32767.0 * (ld_60 * Point);
						 else ld_80 = (-(MathRand() + 0.0000001)) / 32767.0 * (ld_60 * Point);
						 lda_76[index_88] += ld_80;
					  }
				   }
				}
				li_92 = 0;
				ld_96 = 0;
				g_datetime_244 = iTime(NULL, Period(), 0);
				if (ArraySize(Close) > 101) {
				   f0_2();
				   ld_96 = GetVolatilityRatio(lda_72, lda_76, FastVolatilityBase, SlowVolatilityBase, 100, AccountNumber());
				   if (MathAbs(ld_96) >= VolatilityFactor) {
					  if (ld_96 > 0.0) li_92 = 1;
					  else li_92 = -1;
					  gi_360 += li_92;
					  if (MathAbs(gi_360) > gi_364) {
						 gi_360 = gi_364 * (gi_360 / MathAbs(gi_360));
						 li_92 = 0;
					  }
				   }
				}
				ld_104 = gd_152;
				ld_112 = gd_160;
				ld_120 = High[iHighest(NULL, 0, MODE_HIGH, gi_168, 1)] - Low[iLowest(NULL, 0, MODE_LOW, gi_168, 1)];
				ld_120 *= gd_308;
				if ((!Assign_PT_and_ST) || ManualTradeControl) {
				   ld_128 = 1.0 * (gi_180 + 0.0) / MathPow(10, Digits);
				   ld_136 = 1.0 * (gi_184 + 0.0) / MathPow(10, Digits);
				   ld_144 = 0;
				   f0_2();
				   SetPipsTrailSettings(gi_76, ld_128, ld_136, ld_144, gi_124);
				   li_152 = GetQuantPositionChange(AccountNumber(), gi_76, 0, gi_224, lda_72[0], li_92, gi_252, ld_104, ld_112, ld_120, gi_200, gd_204);
				   gi_360 += li_152;
				   gd_400 += NormalizeDouble(li_152 * LotSize, 2);
				   if (li_152 != 0) {
					  f0_3("Updating");
					  f0_10(li_152);
					  g_datetime_424 = TimeCurrent();
				   }
				} else {
				   ld_156 = High[iHighest(NULL, 0, MODE_HIGH, gi_168, 1)] - Low[iLowest(NULL, 0, MODE_LOW, gi_168, 1)];
				   price_164 = 0;
				   if (li_92 == 1) {
					  price_164 = f0_7(Ask);
					  if (IsTesting()) {
						 ticket_44 = OrderSend(Symbol(), OP_BUY, LotSize, price_164, 25, 0, 0, g_comment_128, Magic, 0, Green);
						 OrderModify(ticket_44, price_164, price_164 - NormalizeDouble(ld_156 * gd_160, Digits), price_164 + NormalizeDouble(ld_156 * gd_152, Digits), 0, Green);
					  } else {
						 f0_6();
						 for (count_8 = 0; count_8 < gi_348; count_8++) {
							ticket_44 = OrderSend(Symbol(), OP_BUY, LotSize, price_164, 25, 0, 0, g_comment_128, Magic, 0, Green);
							if (ticket_44 >= 0) break;
							Sleep(gi_352);
							RefreshRates();
							price_164 = f0_7(Ask);
						 }
						 if (ticket_44 >= 0 && (!ManualTradeControl)) {
							for (count_8 = 0; count_8 < gi_348; count_8++) {
							   if (!(!OrderModify(ticket_44, price_164, f0_7(price_164) - NormalizeDouble(ld_156 * gd_160, Digits), f0_7(price_164) + NormalizeDouble(ld_156 * gd_152, Digits), 0,
								  Green))) break;
							   Sleep(gi_352);
							   RefreshRates();
							}
						 }
					  }
				   }
				   if (li_92 == -1) {
					  price_164 = f0_7(Bid);
					  if (IsTesting()) {
						 ticket_44 = OrderSend(Symbol(), OP_SELL, LotSize, price_164, 25, 0, 0, g_comment_128, Magic, 0, Red);
						 OrderModify(ticket_44, price_164, price_164 + NormalizeDouble(ld_156 * gd_160, Digits), price_164 - NormalizeDouble(ld_156 * gd_152, Digits), 0, Red);
						 continue;
					  }
					  count_8 = 0;
					  f0_6();
					  while (count_8 < gi_348) {
						 ticket_44 = OrderSend(Symbol(), OP_SELL, LotSize, price_164, 100, 0, 0, g_comment_128, Magic, 0, Red);
						 if (ticket_44 >= 0) break;
						 Sleep(gi_352);
						 RefreshRates();
						 price_164 = f0_7(Bid);
						 count_8++;
					  }
					  if (ticket_44 >= 0 && (!ManualTradeControl)) {
						 for (count_8 = 0; count_8 < gi_348; count_8++) {
							if (!(!OrderModify(ticket_44, price_164, f0_7(price_164) + NormalizeDouble(ld_156 * gd_160, Digits), f0_7(price_164) - NormalizeDouble(ld_156 * gd_152, Digits), 0,
							   Red))) break;
							Sleep(gi_352);
							RefreshRates();
						 }
					  }
				   }
				}
			 }
		  }
	   } else {
		  if ((!ManualTradeControl) && !Assign_PT_and_ST && gi_184 > 0 || gi_180 > 0) {
			 ld_104 = gd_152;
			 ld_112 = gd_160;
			 ld_120 = High[iHighest(NULL, 0, MODE_HIGH, gi_168, 1)] - Low[iLowest(NULL, 0, MODE_LOW, gi_168, 1)];
			 ld_120 *= gd_308;
			 ld_136 = 1.0 * (gi_184 + 0.0) / MathPow(10, Digits);
			 ld_128 = 1.0 * (gi_180 + 0.0) / MathPow(10, Digits);
			 f0_2();
			 li_172 = FALSE;
			 ld_144 = 1;
			 f0_2();
			 SetPipsTrailSettings(gi_76, ld_128, ld_136, ld_144, gi_124);
			 li_152 = GetQuantPositionChange(AccountNumber(), gi_76, 0, gi_224, f0_7(Close[0]), li_172, gi_252, ld_104, ld_112, ld_120, gi_200, gd_204);
			 gd_400 += NormalizeDouble(li_152 * LotSize, 2);
			 gi_360 += li_152;
			 if (li_152 != 0) {
				f0_3("Updating");
				f0_10(li_152);
				g_datetime_424 = TimeCurrent();
			 }
		  }
	   }
	   if (TimeCurrent() - g_datetime_424 >= 30 || MathAbs(NormalizeDouble(f0_9(), 2) - NormalizeDouble(gd_400, 2)) < LotSize && InternalControl && (!ManualTradeControl) &&
		  (!Assign_PT_and_ST)) {
		  if (MathAbs(NormalizeDouble(f0_9(), 2) - NormalizeDouble(gd_400, 2)) < LotSize) {
			 // ObjectDelete("fgbPosInfo" + fgbPosInf);
			 // ObjectCreate("fgbPosInfo" + fgbPosInf, OBJ_LABEL, 0, 0, 0);
			 // ObjectSetText("fgbPosInfo" + fgbPosInf, "Price AutoBox Position: Internal = " + DoubleToStr(NormalizeDouble(f0_9(), 2), 2) + ", External = " + DoubleToStr(NormalizeDouble(gd_400,
			//	2), 2), g_fontsize_368, gs_tahoma_372, g_color_384);
			 // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_CORNER, 0);
			 // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_XDISTANCE, g_x_392);
			 // ObjectSet("fgbPosInfo" + fgbPosInf, OBJPROP_YDISTANCE, g_y_396);
		  }
		  if (MathAbs(NormalizeDouble(f0_9(), 2) - NormalizeDouble(gd_400, 2)) >= LotSize && TimeCurrent() - g_datetime_424 >= 30) {
			 f0_10(NormalizeDouble((NormalizeDouble(gd_400, 2) - NormalizeDouble(f0_9(), 2)) / LotSize, 2));
			 f0_3("Updating");
		  }
	   }
	   if (TimeCurrent() - g_datetime_424 >= 30) g_datetime_424 = TimeCurrent();
	   return (0);
   }
}