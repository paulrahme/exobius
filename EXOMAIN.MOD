MODULE Exomain;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

FROM Exobius IMPORT
    Init, ShutDown, SetVGAMode, SetTextMode,
    GameOver, ClearTheBuffer;

FROM Font IMPORT DrawFontTest;
FROM Slides IMPORT PlayIntroSlideshow, PlayGoodEnding, PlayBadEnding;
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
FROM Bosses4 IMPORT Boss4;
FROM Bosses7 IMPORT Boss7;
FROM Bosses8 IMPORT Boss8;
FROM Bosses9 IMPORT Boss9;

PROCEDURE PlayLevels();
BEGIN
    Screen1();      IF GameOver THEN RETURN; END;
    Boss1();        IF GameOver THEN RETURN; END;
    Screen2();      IF GameOver THEN RETURN; END;
    Screen3();      IF GameOver THEN RETURN; END;
    Screen4();      IF GameOver THEN RETURN; END;
    Boss4();        IF GameOver THEN RETURN; END;
    Screen6();      IF GameOver THEN RETURN; END;
    Screen7();      IF GameOver THEN RETURN; END;

    (* Stage/boss split *)
    IF NOT PlaneInAir THEN
        Boss7();    IF GameOver THEN RETURN; END;
    ELSE
        FlyThroughSpace();
        Screen8();  IF GameOver THEN RETURN; END;
        Boss8();    IF GameOver THEN RETURN; END;
        Screen9();  IF GameOver THEN RETURN; END;
        Boss9();    IF GameOver THEN RETURN; END;
  END;
END PlayLevels;

(* Main loop *)
BEGIN
    SetVGAMode();
    Init();

    PlayIntroSlideshow();
    PlayTitleSequence();
    ClearTheBuffer();
    PlaneToPlanet();

    PlayLevels();

    IF NOT GameOver THEN
        IF (PlaneInAir) THEN
            PlayGoodEnding();
        ELSE
            PlayBadEnding();
        END;
    END;

    ShutDown();
    SetTextMode();
END Exomain.
