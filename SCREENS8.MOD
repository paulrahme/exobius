IMPLEMENTATION MODULE Screens8;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Exobius;
FROM Graph IMPORT Rectangle, Line, Disc, Plot, Point, ClearScreen;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Exobius IMPORT
    PlaneWidth, GetPixel, PutPixel,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, BulletX, BulletY, PlaneY, CoverRectangleX,
    Enemies, Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X, Enemy6X, EnemyY,
    ScreenComplete, GameOver, DrawGameOver, GameSpeed,
    DrawPlane, CheckMouse, Die, Score;

CONST
    PlanetX = 159;
    PlanetY = 99;

VAR
    EnemyColour1, EnemyColour2, EnemyColour3, EnemyColour4, EnemyColour5,
    EnemyRadius, OneDead, TwoDead, ThreeDead, FourDead, FiveDead,
    UpBulletX, UpBulletY, TheStars, PlanetRadius : CARDINAL;
  
PROCEDURE DrawStars8;
VAR
    Stars, StarX, StarY : CARDINAL;
    StarColour : BYTE;
BEGIN
    FOR Stars := 1 TO 15 DO
        CASE (RANDOM(5)) OF
            |1: StarColour := Blue;
            |2: StarColour := White;
            |3: StarColour := Grey;
            |4: StarColour := Yellow;
            |5: StarColour := LightestWhite;
        END;
        StarX := RANDOM(319); StarY := RANDOM(199);
        IF (GetPixel(StarX, StarY) = Black) THEN
            PutPixel(StarX, StarY, StarColour);
        END;
    END;
END DrawStars8;

PROCEDURE DrawFallBall (x : CARDINAL);
VAR
    y : CARDINAL;
BEGIN
    x := x + (EnemyRadius DIV 2);
    y := EnemyY + (EnemyRadius DIV 2);
    Disc (x, y, EnemyRadius, EnemyColour1);
    IF (EnemyRadius>4) THEN
        Disc(x + (EnemyRadius DIV 10), y - (EnemyRadius DIV 10), EnemyRadius-1, EnemyColour2);
        Disc(x + (EnemyRadius DIV 5), y - (EnemyRadius DIV 5), EnemyRadius-2, EnemyColour3);
        Disc(x + (EnemyRadius*3 DIV 10), y - (EnemyRadius*3 DIV 10), EnemyRadius-3, EnemyColour4);
        Disc(x + (EnemyRadius*2 DIV 5), y - (EnemyRadius*2 DIV 5), EnemyRadius-4, EnemyColour5);
    END;
    CASE (y MOD 9) OF
        |0,1,2: Disc (x, y - (EnemyRadius*2 DIV 5), EnemyRadius DIV 3, Black);
        |3,4,5: Disc (x, y, EnemyRadius DIV 3, Black);
        |6,7,8: Disc (x, y + (EnemyRadius*2 DIV 5), EnemyRadius DIV 3, Black);
    END;
END DrawFallBall;

PROCEDURE DrawEnemies8;
BEGIN
    CASE Enemies OF
        |1: EnemyColour1 := DarkestYellow;
            EnemyColour2 := DarkYellow;
            EnemyColour3 := Yellow;
            EnemyColour4 := LightYellow;
            EnemyColour5 := LightestYellow;
        |2: EnemyColour1 := DarkestBlue;
            EnemyColour2 := DarkBlue;
            EnemyColour3 := Blue;
            EnemyColour4 := LightBlue;
            EnemyColour5 := LightestBlue;
        |3: EnemyColour1 := DarkestRed;
            EnemyColour2 := DarkRed;
            EnemyColour3 := Red;
            EnemyColour4 := LightRed;
            EnemyColour5 := LightestRed;
        |4: EnemyColour1 := DarkestGreen;
            EnemyColour2 := DarkGreen;
            EnemyColour3 := Green;
            EnemyColour4 := LightGreen;
            EnemyColour5 := LightestGreen;
        |5: EnemyColour1 := DarkestGrey;
            EnemyColour2 := DarkGrey;
            EnemyColour3 := Grey;
            EnemyColour4 := LightGrey;
            EnemyColour5 := LightestGrey;
        |6: EnemyColour1 := DarkestBrown;
            EnemyColour2 := DarkBrown;
            EnemyColour3 := Brown;
            EnemyColour4 := LightBrown;
            EnemyColour5 := LightestBrown;
    END;
    IF (EnemyY<90) THEN
        EnemyRadius := EnemyY DIV 10;
        Enemy1X := 160 - EnemyY;
        Enemy2X := 160 - (EnemyY DIV 2);
        Enemy4X := 160 + (EnemyY DIV 2);
        Enemy5X := 160 + EnemyY
    ELSIF (EnemyY>89) AND (EnemyY<111) THEN
        EnemyRadius := EnemyY DIV 10;
        Enemy1X := 70;
        Enemy2X := 115;
        Enemy4X := 205;
        Enemy5X := 250
    ELSIF (EnemyY>110) AND (EnemyY<150) THEN
        EnemyRadius := (150 - EnemyY) DIV 4;
        Enemy1X := 160 - (150 - EnemyY)*7 DIV 4;
        Enemy2X := 160 - (150 - EnemyY)*23 DIV 16;
        Enemy4X := 160 + (150 - EnemyY)*41 DIV 48;
        Enemy5X := 160 + (150 - EnemyY)*25 DIV 32
    ELSIF (EnemyY>149) AND (EnemyY<200) THEN
        EnemyRadius := (EnemyY - 150) DIV 2;
        Enemy1X := 160 - (EnemyY-150)*16 DIV 5;
        Enemy2X := 160 - (EnemyY-150)*8 DIV 5;
        Enemy4X := 160 + (EnemyY-150)*8 DIV 5;
        Enemy5X := 160 + (EnemyY-150)*15 DIV 5;
    END;
    Enemy3X := 160;
    IF (OneDead=0) THEN DrawFallBall (Enemy1X); END;
    IF (TwoDead=0) THEN DrawFallBall (Enemy2X); END;
    IF (ThreeDead=0) THEN DrawFallBall (Enemy3X); END;
    IF (FourDead=0) THEN DrawFallBall (Enemy4X); END;
    IF (FiveDead=0) THEN DrawFallBall (Enemy5X); END;
END DrawEnemies8;

PROCEDURE DrawEnemyDead(X, DeadStage : CARDINAL);
VAR
    SoundFreq, Colour : CARDINAL;
BEGIN
    CASE DeadStage OF
       |0: SoundFreq := 35; Colour := LightRed; Score := Score + 20;
       |1: SoundFreq := 28; Colour := LightestRed;
       |2: SoundFreq := 21; Colour := DarkestYellow;
    END;
    NoSound();
    Sound(SoundFreq);
    Disc(X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, Colour);
END DrawEnemyDead;

PROCEDURE CheckEnemies8;
BEGIN;
    IF (EnemyY >= 150) THEN
        UpBulletY := 65000;
    END;

    IF (OneDead < 3) AND ((BulletX <= 130) OR (UpBulletX <= 60)) THEN
        DrawEnemyDead(Enemy1X, OneDead);
        OneDead := OneDead + 1;
    END;
  
    IF (TwoDead < 3) AND (((BulletX >= 128) AND (BulletX <= 160)) OR ((UpBulletX >= 100) AND (UpBulletX <= 160))) THEN
        DrawEnemyDead(Enemy2X, TwoDead);
        TwoDead := TwoDead + 1;
    END;

    IF (ThreeDead < 3) AND (((BulletX >= 160) AND (BulletX <= 190)) OR ((UpBulletX >= 160) AND (UpBulletX <= 200))) THEN
        DrawEnemyDead(Enemy3X, ThreeDead);
        ThreeDead := ThreeDead + 1;
    END;

    IF (FourDead < 3) AND (((BulletX >= 190) AND (BulletX <= 225)) OR ((UpBulletX >= 205) AND (UpBulletX <= 240))) THEN
        DrawEnemyDead(Enemy4X, FourDead);
        FourDead := FourDead + 1;
    END;

    IF (FiveDead < 3) AND ((BulletX >= 224) OR (UpBulletX >= 250)) THEN
        DrawEnemyDead(Enemy5X, FiveDead);
        FiveDead := FiveDead + 1;
    END;
END CheckEnemies8;

PROCEDURE DrawBullet8;
VAR
    NewBulletX : CARDINAL;
    Dist : INTEGER;
BEGIN
    IF (EnemyY >= 150) THEN
        UpBulletY := 65000;
    END;
    CASE BulletY OF
        |5: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*70) DIV 2))*(BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*70) DIV 2))*(160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 170, 4, LightestYellow);
            IF (EnemyY >= 158) THEN CheckEnemies8(); END;
            BulletY := 4;
        |4: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*45) DIV 2))*(BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*45) DIV 2))*(160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 145, 3, LightYellow);
            IF (EnemyY >= 149) THEN CheckEnemies8(); END;
            BulletY := 3;
        |3: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*20) DIV 2))*(BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*20) DIV 2))*(160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 120, 2, Yellow);
            BulletY := 2;
        |2: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*5) DIV 2))*(BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*5) DIV 2))*(160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 105, 1, DarkYellow);
            BulletY := 1;
        |1: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*1) DIV 2))*(BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*1) DIV 2))*(160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 101, 1, DarkestYellow);
            BulletY := 0;
    END;
END DrawBullet8;

PROCEDURE UpBullet8;
BEGIN
    Line(UpBulletX, UpBulletY, UpBulletX, UpBulletY + 11, Black);
    IF (UpBulletY = 170) THEN
        UpBulletX := PlaneX + (PlaneWidth DIV 2);
        Rectangle(UpBulletX - 1, UpBulletY, UpBulletX + 1, UpBulletY + 15, Black, TRUE);
        Line(UpBulletX, UpBulletY, UpBulletX, UpBulletY + 15, Black);
    END;
    UpBulletY := UpBulletY - 10;
    IF (UpBulletY < 15) THEN
        Rectangle (UpBulletX - 1, UpBulletY - 5, UpBulletX + 1, UpBulletY + 15, Black, TRUE);
        UpBulletY := 65000;
    END;
    Rectangle(UpBulletX - 1, UpBulletY + 1, UpBulletX + 1, UpBulletY + 9, LightBlue, FALSE);
    Line(UpBulletX, UpBulletY, UpBulletX, UpBulletY + 10, LightWhite);
    IF (UpBulletY>80) AND (UpBulletY<115) AND (EnemyY>80) AND (EnemyY<100) THEN
        BulletY := 0;
        CheckEnemies8();
    END;
END UpBullet8;

PROCEDURE CheckMouse8;
BEGIN
    CheckMouse();
    IF (BulletY = 5) AND (UpBulletY > 60000) THEN
        UpBulletX := PlaneX + (PlaneWidth DIV 2);
        UpBulletY := 170;
    END;
END CheckMouse8;

PROCEDURE CheckDeath8;
BEGIN
    IF (EnemyY>160) THEN
       IF (OneDead=0) AND (PlaneX<128) OR
          (TwoDead=0) AND (PlaneX>127) AND (PlaneX<160) OR
          (ThreeDead=0) AND (PlaneX>159) AND (PlaneX<192) OR
          (FourDead=0) AND (PlaneX>191) AND (PlaneX<224) OR
          (FiveDead=0) AND (PlaneX>223) THEN
          Die;
          OneDead := 3;
       END;
    END;
END CheckDeath8;

PROCEDURE DrawPlanet(x, y : CARDINAL);
CONST
    RadiusScaleDiv = 15;
VAR
    Radius, PlanetDots, DotX, DotY : CARDINAL;
BEGIN
    Radius := 2 + (PlanetRadius DIV RadiusScaleDiv);
    
    Disc(x, y, Radius, DarkestRed);
    Disc(x, y, Radius * 48 DIV 50, DarkRed);

    IF (Radius < 100) THEN
       Line ((x-Radius)+Radius*13 DIV 50,(y-Radius)+Radius*16 DIV 50,(x-Radius)+Radius*36 DIV 50,(y-Radius)+Radius*20 DIV 50,Red);
       Line ((x-Radius)+Radius*28 DIV 50,(y-Radius)+Radius*39 DIV 50,(x-Radius)+Radius*64 DIV 50,(y-Radius)+Radius*36 DIV 50,Red);
       Line ((x-Radius)+Radius*57 DIV 50,(y-Radius)+Radius*61 DIV 50,(x-Radius)+Radius*93 DIV 50,(y-Radius)+Radius*67 DIV 50,Red);
       Line ((x-Radius)+Radius*99 DIV 50,(y-Radius)+Radius*43 DIV 50,(x-Radius)+Radius*71 DIV 50,(y-Radius)+Radius*44 DIV 50,Red);
       Line ((x-Radius)+Radius*10 DIV 50,(y-Radius)+Radius*80 DIV 50,(x-Radius)+Radius*70 DIV 50,(y-Radius)+Radius*75 DIV 50,Red);
       Line ((x-Radius)+Radius*80 DIV 50,(y-Radius)+Radius*90 DIV 50,(x-Radius)+Radius*64 DIV 50,(y-Radius)+Radius*89 DIV 50,Red);
       Line ((x-Radius)+Radius*36 DIV 50,(y-Radius)+Radius*49 DIV 50,(x-Radius)+Radius*81 DIV 50,(y-Radius)+Radius*48 DIV 50,DarkRed);
       Line ((x-Radius)+Radius*10 DIV 50,(y-Radius)+Radius*65 DIV 50,(x-Radius)+Radius*66 DIV 50,(y-Radius)+Radius*57 DIV 50,DarkRed);
       Line ((x-Radius)+Radius*55 DIV 50,(y-Radius)+Radius*29 DIV 50,(x-Radius)+Radius*87 DIV 50,(y-Radius)+Radius*23 DIV 50,DarkRed);
       Line ((x-Radius)+Radius*20 DIV 50,(y-Radius)+Radius*31 DIV 50,(x-Radius)+Radius*54 DIV 50,(y-Radius)+Radius*31 DIV 50,DarkestRed);
       Line ((x-Radius)+Radius*37 DIV 50,(y-Radius)+Radius*81 DIV 50,(x-Radius)+Radius*64 DIV 50,(y-Radius)+Radius*79 DIV 50,DarkestRed);
       Line ((x-Radius)+Radius*10 DIV 50,(y-Radius)+Radius*46 DIV 50,(x-Radius)+Radius*29 DIV 50,(y-Radius)+Radius*48 DIV 50,DarkestRed);
       Line ((x-Radius)+Radius*41 DIV 50,(y-Radius)+Radius*14 DIV 50,(x-Radius)+Radius*74 DIV 50,(y-Radius)+Radius*9 DIV 50,DarkestRed);
       Line ((x-Radius)+Radius*86 DIV 50,(y-Radius)+Radius*80 DIV 50,(x-Radius)+Radius*71 DIV 50,(y-Radius)+Radius*81 DIV 50,Black);
       Line ((x-Radius)+Radius*8 DIV 50, (y-Radius)+Radius*21 DIV 50,(x-Radius)+Radius*45 DIV 50,(y-Radius)+Radius*26 DIV 50,Black);
    END;

    FOR PlanetDots := 1 TO (Radius*10) DO
        DotX := (x - Radius) + RANDOM(Radius*2);
        DotY := (y - Radius) + RANDOM(Radius*2);
        IF (GetPixel(DotX, DotY) > Black) THEN
            PutPixel(DotX, DotY, Red);
        END;
    END;
END DrawPlanet;

PROCEDURE Screen8;
BEGIN
    Enemies := 0; BulletY := 0; UpBulletY := 65000; PlaneX := 145;
    PlaneY := 175; UpBulletX := 65000; EnemyY := 0;
    ScreenComplete := FALSE; PlanetRadius := 2;
    NoSound;
    WHILE NOT (GameOver) AND NOT (ScreenComplete) DO
        NoSound();
        Enemies := Enemies + 1;
        IF (Enemies = 6) THEN ScreenComplete := TRUE; END;

        (* Period between waves of enemies *)
        FOR TheStars := 1 TO 30 DO
            IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                CheckMouse8();
                ClearScreen(Graph._GCLEARSCREEN);
                PlanetRadius := PlanetRadius + 1;
                DrawPlanet(PlanetX, PlanetY);
                DrawPlane(PlaneX, PlaneY, PlaneWidth);
                DrawBullet8();
                UpBullet8();
                DrawStars8();
                Delay(GameSpeed);
            END;
        END;
        
        (* Wave of enemies *)
        OneDead := 0; TwoDead := 0; ThreeDead := 0; FourDead := 0; FiveDead := 0;
        FOR EnemyY := 2 TO 199 BY 2 DO
            IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                CheckMouse8();
                Graph.ClearScreen (Graph._GCLEARSCREEN);
                PlanetRadius := PlanetRadius + 1;
                DrawPlanet(PlanetX, PlanetY);
                DrawPlane(PlaneX, PlaneY, PlaneWidth);
                DrawEnemies8();
                DrawBullet8();
                UpBullet8();
                CheckDeath8();
                IF (EnemyY>150) THEN CheckEnemies8(); END;
                DrawStars8();
                Delay(GameSpeed);
            END;
        END;
    END;

    IF (GameOver) THEN
        DrawGameOver;
    END;
END Screen8;

END Screens8.
