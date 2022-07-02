IMPLEMENTATION MODULE Screens8;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT
  Str, Graph, Lib, IO, Window, Storage, Exobius, MsMouse, Storage;

FROM Graph IMPORT
  SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line,
  HLine, Circle, Ellipse, Disc, Plot, Arc, Point, GetImage, ClearScreen;

FROM Lib IMPORT
  Sound, NoSound, Delay, RANDOM;

FROM Exobius IMPORT
  SolidFill, PlaneWidth, PlaneHeight, PlaneMovement,
  EnemyYStart, CollisionY, NegPlaneSize,
  Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
  DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
  DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue, DarkestRed,
  DarkRed, Red, LightRed, LightestRed, DarkestBrown, DarkBrown,
  Brown, LightBrown, LightestBrown, DarkestGreen, DarkGreen, Green, LightGreen,
  LightestGreen, DarkestYellow, DarkYellow, Yellow, LightYellow,
  LightestYellow, PlaneX,  Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X,
  Enemy6X, Enemies, BulletX, BulletY, PlaneY, Width, Height, CoverRectangleX,
  Count, Lives, EnemyY, BkColour,
  OldBkColor,  Xs, Ys, OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive,
  SixAlive, ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
  DrawPlane, CheckMouse, Die,
  A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
  FinishScreen, PlaneXMove, CheckDeath1, Score,
  PlaneInMemory, PlaneAddress, BkAddress, BkSize, Cheat,
  DrawGameOver;

CONST
    PlanetX = 160;
    PlanetY = 100;

VAR
  EnemyColour1, EnemyColour2, EnemyColour3, EnemyColour4, EnemyColour5,
     EnemyRadius, OneDead, TwoDead, ThreeDead, FourDead, FiveDead,
     UpBulletX, UpBulletY, TheStars : CARDINAL;

PROCEDURE DrawStars8;
VAR
  Stars, StarColour, StarX, StarY : CARDINAL;
BEGIN
    FOR Stars := 1 TO 15 DO
        CASE (RANDOM(5)) OF
             | 1 : StarColour := Blue;
             | 2 : StarColour := White;
             | 3 : StarColour := Grey;
             | 4 : StarColour := Yellow;
             | 5 : StarColour := LightestWhite;
        END;
        StarX := RANDOM(320); StarY := RANDOM(200);
        IF (Point(StarX, StarY)=Black) THEN
           Plot (StarX, StarY, StarColour);
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
       Disc (x + (EnemyRadius DIV 10), y - (EnemyRadius DIV 10), EnemyRadius-1, EnemyColour2);
       Disc (x + (EnemyRadius DIV 5), y - (EnemyRadius DIV 5), EnemyRadius-2, EnemyColour3);
       Disc (x + (EnemyRadius*3 DIV 10), y - (EnemyRadius*3 DIV 10), EnemyRadius-3, EnemyColour4);
       Disc (x + (EnemyRadius*2 DIV 5), y - (EnemyRadius*2 DIV 5), EnemyRadius-4, EnemyColour5);
    END;
    CASE (y MOD 9) OF
         | 0, 1, 2 : Disc (x, y - (EnemyRadius*2 DIV 5), EnemyRadius DIV 3, Black);
         | 3, 4, 5 : Disc (x, y, EnemyRadius DIV 3, Black);
         | 6, 7, 8 : Disc (x, y + (EnemyRadius*2 DIV 5), EnemyRadius DIV 3, Black);
    END;
END DrawFallBall;

PROCEDURE DrawEnemies8;
BEGIN
    CASE Enemies OF
         | 1 : EnemyColour1 := DarkestYellow;
               EnemyColour2 := DarkYellow;
               EnemyColour3 := Yellow;
               EnemyColour4 := LightYellow;
               EnemyColour5 := LightestYellow;
         | 2 : EnemyColour1 := DarkestBlue;
               EnemyColour2 := DarkBlue;
               EnemyColour3 := Blue;
               EnemyColour4 := LightBlue;
               EnemyColour5 := LightestBlue;
         | 3 : EnemyColour1 := DarkestRed;
               EnemyColour2 := DarkRed;
               EnemyColour3 := Red;
               EnemyColour4 := LightRed;
               EnemyColour5 := LightestRed;
         | 4 : EnemyColour1 := DarkestGreen;
               EnemyColour2 := DarkGreen;
               EnemyColour3 := Green;
               EnemyColour4 := LightGreen;
               EnemyColour5 := LightestGreen;
         | 5 : EnemyColour1 := DarkestGrey;
               EnemyColour2 := DarkGrey;
               EnemyColour3 := Grey;
               EnemyColour4 := LightGrey;
               EnemyColour5 := LightestGrey;
         | 6 : EnemyColour1 := DarkestBrown;
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
    IF (OneDead=0) THEN
       DrawFallBall (Enemy1X);
    END;
    IF (TwoDead=0) THEN
       DrawFallBall (Enemy2X);
    END;
    IF (ThreeDead=0) THEN
       DrawFallBall (Enemy3X);
    END;
    IF (FourDead=0) THEN
       DrawFallBall (Enemy4X);
    END;
    IF (FiveDead=0) THEN
       DrawFallBall (Enemy5X);
    END;
END DrawEnemies8;

PROCEDURE BlowUpEnemy8;
BEGIN;
  IF (EnemyY >= 150) THEN
     UpBulletY := 65000;
  END;
  IF (BulletX<=130) OR (UpBulletX<=60)THEN
    IF (OneDead=0) THEN
     NoSound;
     Sound (30);
     Disc (Enemy1X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius , LightRed);
     OneDead := 1
    ELSIF (OneDead=1) THEN
     NoSound;
     Sound (25);
     Disc (Enemy1X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightestRed);
     OneDead := 2;
    ELSIF (OneDead=2) THEN
     NoSound;
     Sound (21);
     Disc (Enemy1X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius , DarkestYellow);
     OneDead := 3;
     NoSound;
    END;
  END;
  IF ((BulletX>=128) AND (BulletX<=160)) OR ((UpBulletX>=100) AND (UpBulletX<=160)) THEN
    IF (TwoDead=0) THEN
     NoSound;
     Sound (30);
     Disc (Enemy2X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightRed);
     TwoDead := 1
    ELSIF (TwoDead=1) THEN
     NoSound;
     Sound (25);
     Disc (Enemy2X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightestRed);
     TwoDead := 2
    ELSIF (TwoDead=2) THEN
     NoSound;
     Sound (21);
     Disc (Enemy2X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, DarkestYellow);
     TwoDead := 3;
     NoSound;
    END;
  END;
  IF ((BulletX>=160) AND (BulletX<=190)) OR ((UpBulletX>=160) AND (UpBulletX<=200)) THEN
    IF (ThreeDead=0) THEN
     NoSound;
     Sound (30);
     Disc (Enemy3X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightRed);
     ThreeDead := 1
    ELSIF (ThreeDead=1) THEN
     NoSound;
     Sound (25);
     Disc (Enemy3X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightestRed);
     ThreeDead := 2
    ELSIF (ThreeDead=2) THEN
     NoSound;
     Sound (21);
     Disc (Enemy3X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, DarkestYellow);
     NoSound;
     FourDead := 3;
    END;
  END;
  IF ((BulletX>=190) AND (BulletX<=225)) OR ((UpBulletX>=205) AND (UpBulletX<=240)) THEN
    IF (FourDead=0) THEN
     NoSound;
     Sound (30);
     Disc (Enemy4X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightRed);
     FourDead := 1
    ELSIF (FourDead=1) THEN
     NoSound;
     Sound (25);
     Disc (Enemy4X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightestRed);
     FourDead := 2
    ELSIF (FourDead=2) THEN
     NoSound;
     Sound (21);
     Disc (Enemy4X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, DarkestYellow);
     Lib.Delay (100);
     NoSound;
     FourDead := 3;
    END;
  END;
  IF (BulletX>=224) OR (UpBulletX>=250)THEN
    IF (FiveDead=0) THEN
     NoSound;
     Sound (30);
     Disc (Enemy5X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightRed);
     FiveDead := 1
    ELSIF (FiveDead=1) THEN
     NoSound;
     Sound (25);
     Disc (Enemy5X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, LightestRed);
     FiveDead := 2
    ELSIF (FiveDead=2) THEN
     NoSound;
     Sound (21);
     Disc (Enemy5X + EnemyRadius, EnemyY + EnemyRadius, EnemyRadius, DarkestYellow);
     NoSound;
     FiveDead := 3;
    END;
  END;
  Score := Score + 20;
END BlowUpEnemy8;

PROCEDURE DrawBullet8;
VAR
  NewBulletX : CARDINAL;
  Dist : INTEGER;
BEGIN
  IF (EnemyY >= 150) THEN
     UpBulletY := 65000;
  END;
  CASE BulletY OF
     |5 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*70) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*70) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 170, 4, LightestYellow);
          IF (EnemyY >= 158) THEN
             BlowUpEnemy8;
          END;
          BulletY := 4;
     |4 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*45) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*45) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 145, 3, LightYellow);
          IF (EnemyY >= 149) THEN
             BlowUpEnemy8;
          END;
          BulletY := 3;
     |3 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*20) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*20) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 120, 2, Yellow);
          BulletY := 2;
     |2 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*5) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*5) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 105, 1, DarkYellow);
          BulletY := 1;
     |1 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*1) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*1) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 101, 1, DarkestYellow);
          BulletY := 0;
   END;
END DrawBullet8;

PROCEDURE UpBullet8;
BEGIN
  Line (UpBulletX, UpBulletY, UpBulletX, UpBulletY + 11, Black);
  IF (UpBulletY = 170) THEN
     UpBulletX := PlaneX + (Width DIV 2);
     Rectangle (UpBulletX - 1, UpBulletY, UpBulletX + 1, UpBulletY + 15, Black, TRUE);
     Line (UpBulletX, UpBulletY, UpBulletX, UpBulletY + 15, Black);
  END;
  UpBulletY := UpBulletY - 10;
  IF (UpBulletY < 15) THEN
     Rectangle (UpBulletX - 1, UpBulletY - 5, UpBulletX + 1, UpBulletY + 15, Black, TRUE);
     UpBulletY := 65000;
  END;
  Rectangle (UpBulletX - 1, UpBulletY + 1, UpBulletX + 1, UpBulletY + 9, LightBlue, FALSE);
  Line (UpBulletX, UpBulletY, UpBulletX, UpBulletY + 10, LightWhite);
  IF (UpBulletY>80) AND (UpBulletY<115) AND (EnemyY>80) AND (EnemyY<100) THEN
     BulletY := 0;
     BlowUpEnemy8;
  END;
END UpBullet8;

PROCEDURE CheckMouse8;
VAR
  TextPos : Graph.TextCoords;
BEGIN
  CheckMouse();
  IF (BulletY = 5) THEN
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

PROCEDURE DrawPlanet (x, y, Radius : CARDINAL);
VAR
  PlanetDots, DotX, DotY : CARDINAL;
BEGIN
    Disc (x, y, Radius*50 DIV 50, DarkestRed);
    Disc (x, y, Radius*48 DIV 50, DarkRed);
    IF (Radius<100) THEN
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
    FOR PlanetDots := 1 TO (PlanetRadius*35) DO
    DotX := (x - Radius) + RANDOM(Radius*2);
    DotY := (y - Radius) + RANDOM(Radius*2);
    IF (Point(DotX, DotY)<>Black) THEN
    Plot (DotX, DotY, Red);
    END;
END;
END DrawPlanet;

PROCEDURE Screen8;
BEGIN
    Enemies := 0; BulletY := 0; UpBulletY := 65000; PlaneX := 145;
    PlaneY := 175; UpBulletX := 65000; PlaneInMemory := FALSE; EnemyY := 0;
    ScreenComplete := FALSE; PlanetRadius := 2;
    NoSound;
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlanet (PlanetX, PlanetY, PlanetRadius);
    WHILE NOT (GameOver) AND NOT (ScreenComplete) DO
          NoSound;
          Enemies := Enemies + 1;
          IF (Enemies=6) THEN
             ScreenComplete := TRUE;
          END;
          FOR TheStars := 1 TO 30 DO
              IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                 CheckMouse8;
                 ClearScreen (Graph._GCLEARSCREEN);
                 DrawPlanet (PlanetX, PlanetY, PlanetRadius);
                 DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
                 DrawBullet8;
                 UpBullet8;
                 DrawStars8;
                 Delay (GameSpeed);
              END;
          END;
          Graph.ClearScreen (Graph._GCLEARSCREEN);
          PlanetRadius := PlanetRadius + 1;
          DrawPlanet (PlanetX, PlanetY, PlanetRadius);
          OneDead := 0; TwoDead := 0; ThreeDead := 0; FourDead := 0; FiveDead := 0;
          FOR EnemyY := 2 TO 200 BY 3 DO
              IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                 CheckMouse8;
                 Graph.ClearScreen (Graph._GCLEARSCREEN);
                 IF (EnemyY MOD 7 = 0) THEN
                    PlanetRadius := PlanetRadius + 1;
                 END;
                 DrawPlanet (PlanetX, PlanetY, PlanetRadius);
                 DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
                 DrawEnemies8;
                 DrawBullet8;
                 UpBullet8;
                 CheckDeath8;
                 IF (EnemyY>150) THEN
                    BlowUpEnemy8;
                 END;
                 DrawStars8;
                 Delay (GameSpeed DIV 2);
              END;
          END;
    END;
    IF (GameOver) THEN
       DrawGameOver;
    END;
END Screen8;

END Screens8.
