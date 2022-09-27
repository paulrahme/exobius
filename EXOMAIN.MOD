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
    SetVGAMode, SetTextMode, Cheat, Key,
    GameOver, ScreenComplete, Score, ClearTheBuffer, Lives,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen;

FROM Intro IMPORT PlayTitleSequence, PlaneToPlanet;
FROM Intros1 IMPORT PlayIntroSequence, PlayEndSequence;
FROM Screens1 IMPORT Screen1;
FROM Screens2 IMPORT Screen2;
FROM Screens3 IMPORT Screen3;
FROM Screens4 IMPORT Screen4, Screen5;
FROM Screens6 IMPORT Screen6;
FROM Screens7 IMPORT Screen7;
FROM Screens8 IMPORT Screen8;
FROM Screens9 IMPORT Screen9;
FROM Bosses IMPORT Boss1, Boss2, Boss3, Boss4;

(* Main loop *)
BEGIN
    SetVGAMode;
    Score := 0;
    GameOver := FALSE;
    ScreenComplete := FALSE;
    Lives := 0;

    (*PlayIntroSequence();
    PlayTitleSequence();
    ClearTheBuffer;
    PlaneToPlanet;*)
    Screen1;
    IF NOT GameOver THEN
        Boss1();
    END;
    IF NOT GameOver THEN
        Screen2();
    END;
    IF NOT GameOver THEN
        Screen3();
    END;
    IF NOT GameOver THEN
        Screen4();
    END;
    IF NOT GameOver THEN
       Screen5();
    END;
    IF NOT GameOver THEN
       Boss2();
    END;
    IF NOT GameOver THEN
       Screen6();
    END;
    IF NOT GameOver THEN
       Screen7();
    END;
    IF NOT GameOver THEN
        Screen8();
    END;
    IF NOT GameOver THEN
        Boss3();
    END;
    IF NOT GameOver THEN
        Screen9();
    END;
    IF NOT GameOver THEN
        Boss4();
    END;
    IF NOT GameOver THEN
        PlayEndSequence();
    END;

    SetTextMode();
END Exomain.
