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
    Init, ShutDown, SetVGAMode, SetTextMode, Cheat, Key,
    GameOver, ScreenComplete, Score, ClearTheBuffer, Lives,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen;

FROM Slides IMPORT PlayIntroSlideshow, PlayEndSlideshow;
FROM Intro1 IMPORT PlayTitleSequence;
FROM Intro2 IMPORT PlaneToPlanet;
FROM Screens1 IMPORT Screen1;
FROM Screens2 IMPORT Screen2;
FROM Screens3 IMPORT Screen3;
FROM Screens4 IMPORT Screen4;
FROM Screens6 IMPORT Screen6;
FROM Screens7 IMPORT Screen7, PlaneInAir, FlyThroughSpace;
FROM Screens8 IMPORT Screen8;
FROM Screens9 IMPORT Screen9;
FROM Bosses1 IMPORT Boss1;
FROM Bosses2 IMPORT Boss2;
FROM Bosses3 IMPORT Boss3;
FROM Bosses4 IMPORT Boss4;
FROM Bosses7 IMPORT Boss7;

PROCEDURE PlayLevels();
BEGIN
(*    Screen1();      IF GameOver THEN RETURN; END;
    Boss1();        IF GameOver THEN RETURN; END;
    Screen2();      IF GameOver THEN RETURN; END;
    Screen3();      IF GameOver THEN RETURN; END;
    Screen4();      IF GameOver THEN RETURN; END;
    Boss2();        IF GameOver THEN RETURN; END;
    Screen6();      IF GameOver THEN RETURN; END;
    Screen7();      IF GameOver THEN RETURN; END;
*)
    (* Stage/boss split *)
    IF NOT PlaneInAir THEN
        Boss7();    IF GameOver THEN RETURN; END;
    ELSE
        FlyThroughSpace();
        Screen8();  IF GameOver THEN RETURN; END;
        Boss3();    IF GameOver THEN RETURN; END;
    END;

    Screen9();      IF GameOver THEN RETURN; END;
    Boss4();        IF GameOver THEN RETURN; END;
END PlayLevels;

(* Main loop *)
BEGIN
    SetVGAMode();
    Init();

(*    PlayIntroSlideshow();
    PlayTitleSequence();
    ClearTheBuffer();
    PlaneToPlanet();
*)
    PlayLevels();
    IF NOT GameOver THEN
        PlayEndSlideshow();
    END;

    ShutDown();
    SetTextMode();
END Exomain.
