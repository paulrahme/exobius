MODULE Exomain;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Storage, Graph, IO, FIO, Process;

FROM Graph IMPORT
    ClearScreen, OutText, SetTextPosition, _GCLEARSCREEN;

FROM IO IMPORT
    WrLn, RdKey, RdCard, WrStr, KeyPressed, WrCard;

FROM Lib IMPORT
    Delay;

FROM Exobius IMPORT
    SetVGAMode, SetTextMode, Cheat, Key, NoteDelay,
    GameOver, ScreenComplete, PlaneInMemory, Score, ClearTheBuffer, Lives,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen;

FROM Intro IMPORT
    Infinite_Software, FlashScreen, SpinRectangle, MakeDiamond, ExoLogo,
    WriteMyName, FillAtmosFear, WriteAtmosFear, ReadyForWriting,
    WriteThinks, PlaneToPlanet;

FROM Intros1 IMPORT Intro1, Intro2, Intro3, Intro4, Intro5, EndGame;
FROM Screens1 IMPORT Screen1;
FROM Screens2 IMPORT Screen2;
FROM Screens3 IMPORT Screen3;
FROM Screens4 IMPORT Screen4, Screen5;
FROM Screens6 IMPORT Screen6;
FROM Screens7 IMPORT Screen7;
FROM Screens8 IMPORT Screen8;
FROM Screens9 IMPORT Screen9;
FROM Bosses IMPORT Boss1, Boss2, Boss3, Boss4;

VAR
   OldCoords : Graph.TextCoords;

(* Main loop *)
BEGIN
    SetVGAMode;
    PlaneInMemory := FALSE;
    Score := 0;
    GameOver := FALSE;
    ScreenComplete := FALSE;
    Lives := 0;

(*   ClearScreen(_GCLEARSCREEN);
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
*)    ClearScreen (_GCLEARSCREEN);
(*    Screen1;
    IF NOT GameOver THEN
        Boss1;
    END;
*)    IF NOT GameOver THEN
        Screen2;
    END;
    IF NOT GameOver THEN
        Screen3;
    END;
(*    IF NOT GameOver THEN
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
*)    IF NOT GameOver THEN
        Boss4;
    END;
    IF NOT GameOver THEN
        EndGame;
    END;

    SetTextMode;
END Exomain.
