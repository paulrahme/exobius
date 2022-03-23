MODULE Exomain;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Storage, Graph, IO, FIO, Process;

FROM Graph IMPORT
     SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line,
     HLine, Circle, Ellipse, Disc, Plot, Arc, InitVGA, _MRES256COLOR,
     _GCLEARSCREEN, _DEFAULTMODE, ClearScreen, GetImage, ImageSize,
     _MRES4COLOR, _MRES16COLOR, InitCGA, InitEGA, OutText, SetTextPosition;

FROM IO IMPORT
     WrLn, RdKey, RdCard, WrStr, KeyPressed, WrCard;

FROM Lib IMPORT
     Delay;

FROM Exobius IMPORT
     VgaInitialisation, GameSpeed, Cheat, Key, Mode, NoteDelay,
     GameOver, ScreenComplete, PlaneInMemory, PlaneAddress, DrawPlane,
     Score, MouseUsed, ClearTheBuffer, Lives, GraphicsCard,
	  Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
	  DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue, DarkestBrown,
	  DarkBrown, Brown, LightBrown, LightestBrown, DarkestRed, DarkRed,
     Red, LightRed, LightestRed, DarkestYellow, DarkYellow, Yellow,
     LightYellow, LightestYellow, DarkestWhite, DarkWhite, White,
     LightWhite, LightestWhite, DarkestGreen, DarkGreen, Green, LightGreen,
     LightestGreen, MouseOrNot, BkAddress, HighDetail;

FROM Bosses IMPORT
     Boss1, Boss2, Boss3, Boss4;

FROM Intro IMPORT
     Infinite_Software, FlashScreen, SpinRectangle, MakeDiamond, ExoLogo,
     WriteMyName, FillAtmosFear, WriteAtmosFear, ReadyForWriting,
     WriteThinks, PlaneToPlanet;

FROM Intros1 IMPORT
     Intro1, Intro2, Intro3, Intro4, Intro5;

FROM Screens IMPORT
     Screen1, Screen2, Screen3;

FROM Screens2 IMPORT
     Screen4, Screen5;

FROM Screens3 IMPORT
     Screen6;

FROM Screens4 IMPORT
     Screen7;

FROM Screens5 IMPORT
     Screen8;

FROM Screens6 IMPORT
     Screen9;

FROM Storage IMPORT
     ALLOCATE;

VAR
     DetailCard : CARDINAL;
     f : FIO.File;
     OldCoords : Graph.TextCoords;

PROCEDURE EndGame;
BEGIN
    ClearScreen(_GCLEARSCREEN);
    Intro1;
    Intro2;
    Key := IO.RdKey();
    ClearScreen(_GCLEARSCREEN);
    Intro3;
    OldCoords := SetTextPosition (1, 1);
    OutText("''You're not a bad driver'', he says...");
    Key := IO.RdKey();
    OldCoords := SetTextPosition (1, 1);
    OutText("''What you doing in a place like this''");
    Key := IO.RdKey();
    ClearScreen(_GCLEARSCREEN);
    ClearScreen(_GCLEARSCREEN);
    Intro5;
    OldCoords := SetTextPosition (1, 1);
    OutText("''...so just keep the car...''");
    Key := IO.RdKey();
    OldCoords := SetTextPosition (2, 1);
    OutText("''...and go on home, okay?''");
    Key := IO.RdKey();

END EndGame;

PROCEDURE Main;
BEGIN
  ClearScreen(_GCLEARSCREEN);
  Intro1;
  OldCoords := SetTextPosition (1, 1);
  OutText("Working at Le Grande Pizzeria");
  OldCoords := SetTextPosition (2, 1);
  OutText("Has bad days...");
  Key := IO.RdKey();
  ClearScreen(_GCLEARSCREEN);
  Intro2;
  OldCoords := SetTextPosition (23, 1);
  OutText("But does this look like your dream");
  OldCoords := SetTextPosition (24, 1);
  OutText("ship?...");
  Key := IO.RdKey();
  ClearScreen(_GCLEARSCREEN);
  Intro3;
  OldCoords := SetTextPosition (1, 1);
  OutText("''Park it well'', he says...");
  Key := IO.RdKey();
  ClearScreen(_GCLEARSCREEN);
  Intro4;
  Key := IO.RdKey();

  ClearScreen(_GCLEARSCREEN);
  PlaneInMemory := FALSE;
  Score := 0;
  Infinite_Software;
  Delay (12*NoteDelay);
  IF NOT (KeyPressed()) THEN
     FlashScreen;
  END;
  IF NOT (KeyPressed()) THEN
     SpinRectangle;
  END;
  IF NOT (KeyPressed()) THEN
     MakeDiamond;
  END;
  IF NOT (KeyPressed()) THEN
     ExoLogo;
  END;
  IF NOT (KeyPressed()) THEN
     WriteMyName;
  END;
  IF NOT (KeyPressed()) THEN
     WriteAtmosFear;
  END;
  IF NOT (KeyPressed()) THEN
     WriteThinks;
  END;
  ClearTheBuffer;
  PlaneToPlanet;
  GameOver := FALSE;
  ScreenComplete := FALSE;
  ClearScreen (_GCLEARSCREEN);
  Lives := 0;
  ClearScreen (_GCLEARSCREEN);
  Screen1;
  IF NOT GameOver THEN
     Boss1;
  END;
  IF NOT GameOver THEN
     Screen2;
  END;
  IF NOT GameOver THEN
     Screen3;
  END;
  IF NOT GameOver THEN
     Screen4;
  END;
  IF NOT GameOver THEN
     Screen5;
  END;
  IF NOT GameOver THEN
     Boss2;
  END;
  IF NOT GameOver THEN
     Screen6;
  END;
  IF NOT GameOver THEN
     Screen7;
  END;
  IF NOT GameOver THEN
     Screen8;
  END;
  IF NOT GameOver THEN
     Boss3;
  END;
  IF NOT GameOver THEN
     Screen9;
  END;
  IF NOT GameOver THEN
     Boss4;
  END;
  IF NOT GameOver THEN
     EndGame;
  END;
END Main;

BEGIN
  VgaInitialisation;
  IF NOT (FIO.Exists("exobius.cfg")) THEN
     WrStr("Note : EXOBIUS.CFG not found - Can put the 4 values (spaces in between) in it.");
     WrLn;
     WrStr("Enter GameSpeed...0 for fastest, etc.");
     GameSpeed := RdCard();
     WrStr("Please select controlling device:");
     WrLn;
     WrLn;
     WrStr("1) Keyboard   (N.B. Use NUMLOCK!!)");
     WrLn;
     WrStr("2) Mouse");
     WrLn;
     MouseOrNot := RdCard();
     IF (MouseOrNot = 2) THEN
        MouseUsed := TRUE;
     ELSE
        MouseUsed := FALSE;
     END;
     WrStr("Please select video mode:");
     WrLn;
     WrLn;
     WrStr("1) CGA ( 4  colours)");WrLn;
     WrStr("2) EGA ( 16 colours)");WrLn;
     WrStr("3) VGA (256 colours)");WrLn;
     GraphicsCard := RdCard();
     WrLn;
     WrStr("Please enter detail level:");
     WrLn;
     WrLn;
     WrStr("1) High Detail");WrLn;
     WrStr("2) Low Detail");WrLn;
     DetailCard := RdCard();
     HighDetail := (DetailCard=1);
  ELSE
     WrStr("Reading Setup...");WrLn;
     f := FIO.Open ("exobius.cfg");
     GameSpeed := FIO.RdCard(f);
     WrStr("GameSpeed=");IO.WrCard(GameSpeed,0);WrLn;
     MouseOrNot := FIO.RdCard(f);
     WrStr("Keyboard/Mouse=");IO.WrCard(MouseOrNot,0);WrLn;
     GraphicsCard := FIO.RdCard(f);
     WrStr("GraphicsCard=");IO.WrCard(GraphicsCard,0);WrLn;
     DetailCard := FIO.RdCard(f); HighDetail := (DetailCard=1);
     WrStr("Detail H/L=");IO.WrCard(DetailCard,0);WrLn;
     WrLn;
     FIO.Close(f);
  END;
  WrStr("Enjoy...Press a key to continue");
  Key := RdKey();
  IF (Key=CHR(235)) THEN
     Cheat := TRUE;
  ELSE
     Cheat := FALSE;
  END;
  CASE GraphicsCard OF
     | 1 : Mode := SetVideoMode (_MRES4COLOR);
                	  Black := 0;
			  DarkestGrey := 3;
			  DarkGrey := 3;
			  Grey := 2;
			  LightGrey := 3;
			  LightestGrey := 3;
			  DarkestWhite := 2;
			  DarkWhite := 3;
			  White := 3;
			  LightWhite := 3;
			  LightestWhite := 3;
			  DarkestBlue := 1;
			  DarkBlue := 1;
			  Blue := 1;
			  LightBlue := 1;
			  LightestBlue := 3;
			  DarkestRed := 2;
			  DarkRed := 2;
			  Red := 1;
			  LightRed := 1;
			  LightestRed := 1;
			  DarkestBrown := 2;
			  DarkBrown := 2;
			  Brown := 2;
			  LightBrown := 2;
			  LightestBrown := 2;
			  DarkestGreen := 1;
			  DarkGreen := 1;
			  Green := 1;
			  LightGreen := 1;
			  LightestGreen := 3;
			  DarkestYellow := 2;
			  DarkYellow := 2;
			  Yellow := 1;
			  LightYellow := 3;
			  LightestYellow := 3;
     | 2 : Mode := SetVideoMode (_MRES16COLOR);
			  Black := 0;
			  DarkestGrey := 8;
			  DarkGrey := 8;
			  Grey := 8;
			  LightGrey := 7;
			  LightestGrey := 7;
			  DarkestWhite := 7;  
			  DarkWhite := 7;
			  White := 7;  
			  LightWhite := 15;
			  LightestWhite := 15;
			  DarkestBlue := 1;
			  DarkBlue := 1;
			  Blue := 3;
			  LightBlue := 9;
			  LightestBlue := 11;
			  DarkestRed := 4;
			  DarkRed := 4;
			  Red := 4;
			  LightRed := 12;
			  LightestRed := 12;
			  DarkestBrown := 6;
			  DarkBrown := 6;
			  Brown := 6;
			  LightBrown := 12;
			  LightestBrown := 12;
			  DarkestGreen := 2;
			  DarkGreen := 2;
			  Green := 2;
			  LightGreen := 10;
			  LightestGreen := 10;
			  DarkestYellow := 14;
			  DarkYellow := 14;
			  Yellow := 14;
			  LightYellow := 14;
			  LightestYellow := 14;
     | 3 : Mode := SetVideoMode (_MRES256COLOR);
			  Black := 0;
			  DarkestGrey := 17;
			  DarkGrey := 19;
			  Grey := 21;
			  LightGrey := 23;
			  LightestGrey := 25;
			  DarkestWhite := 26;
			  DarkWhite := 27;
			  White := 28;
			  LightWhite := 29;
			  LightestWhite := 30;
			  DarkestBlue := 175;
			  DarkBlue := 104;
			  Blue := 1;
			  LightBlue := 55;
			  LightestBlue := 80;
			  DarkestRed := 184;
			  DarkRed := 112;
			  Red := 4;
			  LightRed := 40;
			  LightestRed := 41;
			  DarkestBrown := 185;
			  DarkBrown := 186;
			  Brown := 114;
			  LightBrown := 6;
			  LightestBrown := 42;
			  DarkestGreen := 187;
			  DarkGreen := 190;
			  Green := 120;
			  LightGreen := 2;
			  LightestGreen := 48;
			  DarkestYellow := 42;
			  DarkYellow := 43;
			  Yellow := 44;
			  LightYellow := 14;
			  LightestYellow := 68;
  END;
  Main;
  Mode := SetVideoMode (_DEFAULTMODE);
END Exomain.


