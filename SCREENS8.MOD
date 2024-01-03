IMPLEMENTATION MODULE Screens8;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Exobius;
FROM Graph IMPORT Rectangle, Line, Circle, Disc, Plot, Point, ClearScreen;
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
    UpBulletX, UpBulletY, TheStars : CARDINAL;
  
PROCEDURE DrawStars8;
VAR
    Stars, StarX, StarY : CARDINAL;
    StarColour : BYTE;
BEGIN
    FOR Stars := 1 TO 5 DO
        CASE (Stars) OF
            |1: StarColour := Blue;
            |2: StarColour := White;
            |3: StarColour := Grey;
            |4: StarColour := Yellow;
            |5: StarColour := LightestWhite;
        END;
        StarX := RANDOM(319); StarY := 20 + RANDOM(179);
        IF (GetPixel(StarX, StarY) = Black) THEN
            PutPixel(StarX, StarY, StarColour);
        END;
    END;
END DrawStars8;

PROCEDURE DrawFallBall(x : CARDINAL);
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

PROCEDURE SetEnemies(NewEnemyIndex : CARDINAL);
BEGIN
    Enemies := NewEnemyIndex;
    
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
        |5: EnemyColour1 := Grey;
            EnemyColour2 := LightGrey;
            EnemyColour3 := LightestGrey;
            EnemyColour4 := DarkestWhite;
            EnemyColour5 := DarkWhite;
        |6: EnemyColour1 := DarkestBrown;
            EnemyColour2 := DarkBrown;
            EnemyColour3 := Brown;
            EnemyColour4 := LightBrown;
            EnemyColour5 := LightestBrown;

        |7: ScreenComplete := TRUE;
    END;
END SetEnemies;

PROCEDURE DrawEnemies8;
BEGIN
    IF (EnemyY < 90) THEN
        EnemyRadius := EnemyY DIV 10;
        Enemy1X := 160 - EnemyY;
        Enemy2X := 160 - (EnemyY DIV 2);
        Enemy4X := 160 + (EnemyY DIV 2);
        Enemy5X := 160 + EnemyY
    ELSIF (EnemyY < 111) THEN
        EnemyRadius := EnemyY DIV 10;
        Enemy1X := 70;
        Enemy2X := 115;
        Enemy4X := 205;
        Enemy5X := 250
    ELSIF (EnemyY < 150) THEN
        EnemyRadius := (150 - EnemyY) DIV 4;
        Enemy1X := 160 - (150 - EnemyY)*7 DIV 4;
        Enemy2X := 160 - (150 - EnemyY)*23 DIV 16;
        Enemy4X := 160 + (150 - EnemyY)*41 DIV 48;
        Enemy5X := 160 + (150 - EnemyY)*25 DIV 32
    ELSIF (EnemyY < 199) THEN
        EnemyRadius := (EnemyY - 150) DIV 2;
        Enemy1X := 160 - (EnemyY-150)*16 DIV 5;
        Enemy2X := 160 - (EnemyY-150)*8 DIV 5;
        Enemy4X := 160 + (EnemyY-150)*8 DIV 5;
        Enemy5X := 160 + (EnemyY-150)*15 DIV 5;
    ELSE (* Gone offscreen *)
        RETURN;
    END;
    Enemy3X := 160;

    IF (OneDead = 0) THEN DrawFallBall(Enemy1X); END;
    IF (TwoDead = 0) THEN DrawFallBall(Enemy2X); END;
    IF (ThreeDead = 0) THEN DrawFallBall(Enemy3X); END;
    IF (FourDead = 0) THEN DrawFallBall(Enemy4X); END;
    IF (FiveDead = 0) THEN DrawFallBall(Enemy5X); END;
END DrawEnemies8;

PROCEDURE CheckEnemyHitOrDying(EnemyX, DeadStage, Bullet3DMinX, Bullet3DMaxX, UpBulletMinX, UpBulletMaxX : CARDINAL) : CARDINAL;
VAR
    SoundFreq, Colour : CARDINAL;
BEGIN
    CASE DeadStage OF
        |0: IF ((EnemyY > 80) AND (EnemyY < 120) AND (BulletX >= Bullet3DMinX) AND (BulletX <= Bullet3DMaxX)) OR
                ((EnemyY >= 120) AND (EnemyY < 199) AND (UpBulletX >= UpBulletMinX) AND (UpBulletX <= UpBulletMaxX))
            THEN
                SoundFreq := 35; Colour := LightRed; Score := Score + 20; DeadStage := DeadStage + 1;
            ELSE
                RETURN 0;
            END;
        |1: SoundFreq := 28; Colour := LightestRed; DeadStage := DeadStage + 1;
        |2: SoundFreq := 21; Colour := DarkestYellow; DeadStage := DeadStage + 1;
        |3: NoSound(); RETURN 3;
    END;

    NoSound();
    Sound(SoundFreq);
    Disc(EnemyX - EnemyRadius, EnemyY - EnemyRadius, EnemyRadius, Colour);
    RETURN DeadStage;
END CheckEnemyHitOrDying;

PROCEDURE CheckEnemies8;
BEGIN;
    IF (EnemyY < 200) THEN
        OneDead := CheckEnemyHitOrDying(Enemy1X, OneDead, 0, 129, 0, 63);
        TwoDead := CheckEnemyHitOrDying(Enemy2X, TwoDead, 130, 159, 64, 127);
        ThreeDead := CheckEnemyHitOrDying(Enemy3X, ThreeDead, 160, 189, 128, 191);
        FourDead := CheckEnemyHitOrDying(Enemy4X, FourDead, 190, 253, 192, 255);
        FiveDead := CheckEnemyHitOrDying(Enemy5X, FiveDead, 256, 319, 256, 319);
    END;
END CheckEnemies8;

PROCEDURE DrawBullet8;
VAR
    NewBulletX : CARDINAL;
    Dist : INTEGER;
BEGIN
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

PROCEDURE DrawPlanet();
VAR
    Radius, PlanetDots, DotX, DotY, LeftX, TopY : CARDINAL;
BEGIN
    Radius := 2 + (PlanetRadius DIV PlanetRadiusScaleDiv);
    LeftX := PlanetX - Radius;
    TopY := PlanetY - Radius;

    Disc(PlanetX, PlanetY, Radius, DarkRed);
    Circle(PlanetX, PlanetY, Radius, DarkestRed);
    Circle(PlanetX, PlanetY, Radius - 1, DarkestRed);

    Line (LeftX + Radius*13 DIV 50, TopY + Radius*16 DIV 50, LeftX + Radius*36 DIV 50, TopY + Radius*20 DIV 50,Red);
    Line (LeftX + Radius*28 DIV 50, TopY + Radius*39 DIV 50, LeftX + Radius*64 DIV 50, TopY + Radius*36 DIV 50,Red);
    Line (LeftX + Radius*57 DIV 50, TopY + Radius*61 DIV 50, LeftX + Radius*93 DIV 50, TopY + Radius*67 DIV 50,Red);
    Line (LeftX + Radius*99 DIV 50, TopY + Radius*43 DIV 50, LeftX + Radius*71 DIV 50, TopY + Radius*44 DIV 50,Red);
    Line (LeftX + Radius*10 DIV 50, TopY + Radius*80 DIV 50, LeftX + Radius*70 DIV 50, TopY + Radius*75 DIV 50,Red);
    Line (LeftX + Radius*80 DIV 50, TopY + Radius*90 DIV 50, LeftX + Radius*64 DIV 50, TopY + Radius*89 DIV 50,Red);
    Line (LeftX + Radius*20 DIV 50, TopY + Radius*31 DIV 50, LeftX + Radius*54 DIV 50, TopY + Radius*31 DIV 50,DarkestRed);
    Line (LeftX + Radius*37 DIV 50, TopY + Radius*81 DIV 50, LeftX + Radius*64 DIV 50, TopY + Radius*79 DIV 50,DarkestRed);
    Line (LeftX + Radius*10 DIV 50, TopY + Radius*46 DIV 50, LeftX + Radius*29 DIV 50, TopY + Radius*48 DIV 50,DarkestRed);
    Line (LeftX + Radius*41 DIV 50, TopY + Radius*14 DIV 50, LeftX + Radius*74 DIV 50, TopY + Radius*9 DIV 50,DarkestRed);
    Line (LeftX + Radius*86 DIV 50, TopY + Radius*80 DIV 50, LeftX + Radius*71 DIV 50, TopY + Radius*81 DIV 50,Black);
    Line (LeftX + Radius*8 DIV 50,  TopY + Radius*21 DIV 50, LeftX + Radius*45 DIV 50, TopY + Radius*26 DIV 50,Black);

    FOR PlanetDots := 1 TO (Radius * 8) DO
        DotX := LeftX + RANDOM(Radius*2);
        DotY := TopY + RANDOM(Radius*2);
        IF (GetPixel(DotX, DotY) > Black) THEN
            PutPixel(DotX, DotY, Red);
        END;
    END;
END DrawPlanet;

PROCEDURE Screen8;
BEGIN
    BulletY := 0; UpBulletY := 65000; PlaneX := 145;
    PlaneY := 175; UpBulletX := 65000; EnemyY := 0;
    ScreenComplete := FALSE; PlanetRadius := 2;
    NoSound();
    SetEnemies(0);
    WHILE NOT (GameOver) AND NOT (ScreenComplete) DO
        NoSound();
        SetEnemies(Enemies + 1);

        (* Period between waves of enemies *)
        FOR TheStars := 1 TO 20 DO
            IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                CheckMouse8();
                ClearScreen(Graph._GCLEARSCREEN);
                DrawPlanet();
                DrawPlane(PlaneX, PlaneY, PlaneWidth);
                DrawBullet8();
                UpBullet8();
                DrawStars8();
                Delay(GameSpeed);
            END;
        END;
        
        (* Wave of enemies *)
        OneDead := 0; TwoDead := 0; ThreeDead := 0; FourDead := 0; FiveDead := 0;
        FOR EnemyY := 5 TO 198 DO
            IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                CheckMouse8();
                Graph.ClearScreen (Graph._GCLEARSCREEN);
                PlanetRadius := PlanetRadius + 1;
                DrawPlanet();
                DrawPlane(PlaneX, PlaneY, PlaneWidth);
                DrawEnemies8();
                DrawBullet8();
                UpBullet8();
                CheckEnemies8();
                CheckDeath8();
                DrawStars8();
                Delay(GameSpeed * 3 DIV 4);
            END;
        END;
    END;

    IF (GameOver) THEN
        NoSound();
        DrawGameOver;
    END;
END Screen8;

END Screens8.
