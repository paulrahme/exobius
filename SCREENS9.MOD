
IMPLEMENTATION MODULE Screens9;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT
  Str, Graph, Lib, IO, Window, Storage, Exobius, Storage;

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
  DrawPlane, CheckMouse, Die, A, B,
  C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
  FinishScreen, PlaneXMove, CheckDeath1, Score,
  PlaneInMemory, PlaneAddress, BkAddress, BkSize, ClearTheBuffer, Cheat,
  DrawGameOver;

FROM Screens7 IMPORT
     DrawPillarBottom;

FROM Screens8 IMPORT
     DrawPlanet;

CONST
    PlanetX = 160;
    PlanetY = 100;
    PlanetRadius = 70;

PROCEDURE DrawPartialSky (x : CARDINAL);
BEGIN
    Rectangle (x,0,x+27,6,0,TRUE);
    Rectangle (x,7,x+27,13,184,TRUE);
    Rectangle (x,14,x+27,20,183,TRUE);
    Rectangle (x,21,x+27,28,182,TRUE);
    Rectangle (x,28,x+27,34,181,TRUE);
    Rectangle (x,35,x+27,41,180,TRUE);
    Rectangle (x,42,x+27,48,179,TRUE);
    Rectangle (x,49,x+27,55,178,TRUE);
    Rectangle (x,56,x+27,62,177,TRUE);
    Rectangle (x,63,x+27,69,176,TRUE);
    Rectangle (x,70,x+27,76,177,TRUE);
    Rectangle (x,77,x+27,83,178,TRUE);
    Rectangle (x,84,x+27,90,179,TRUE);
    Rectangle (x,91,x+27,97,180,TRUE);
    Rectangle (x,98,x+27,104,181,TRUE);
    Rectangle (x,105,x+27,200,DarkRed,TRUE);
END DrawPartialSky;

PROCEDURE Screen9;
CONST
    NoOfPillars = 16;
    NoOfCircles = 200;
    NewNoOfPillars = 35;
(***) PlanetRadius = 50;
VAR
  PillarCount, Pillar1X, Pillar2X, Pillar3X, Pillar4X, Pillar5X, Pillar1Y,
  Pillar2Y, Pillar3Y, Pillar4Y, Pillar5Y, Pillar6Y, OldPlaneX : CARDINAL;
BEGIN
    Count := PlanetRadius;
    WHILE (Count<100) DO
        DrawPlanet (PlanetX, PlanetY, Count);
        Count := Count + (Count DIV 15);
    END;
    FOR Count := 100 TO 250 BY 7 DO
        Disc (PlanetX, PlanetY, Count, DarkRed);
    END;
    Rectangle (0, 0, 320, 200, DarkRed, TRUE);
    FOR Count := 0 TO 100 DO
        HLine (0, Count, 320, 178);
        Delay (9);
    END;
    Rectangle (0,0,319,6,0,TRUE);
    Rectangle (0,7,319,13,184,TRUE);
    Rectangle (0,14,319,20,183,TRUE);
    Rectangle (0,21,320,28,182,TRUE);
    Rectangle (0,28,319,34,181,TRUE);
    Rectangle (0,35,320,41,180,TRUE);
    Rectangle (0,42,320,48,179,TRUE);
    Rectangle (0,49,319,55,178,TRUE);
    Rectangle (0,56,319,62,177,TRUE);
    Rectangle (0,63,319,69,176,TRUE);
    Rectangle (0,70,319,76,177,TRUE);
    Rectangle (0,77,319,83,178,TRUE);
    Rectangle (0,84,319,90,179,TRUE);
    Rectangle (0,91,320,97,180,TRUE);
    Rectangle (0,98,319,104,181,TRUE);
    ClearTheBuffer;
    PlaneX := 145; PlaneY := 175; PlaneInMemory := FALSE;
    PillarCount := 0;
    Pillar1X := (RANDOM(11)+1)*25; Pillar2X := (RANDOM(11)+1)*25;
    Pillar3X := 325; Pillar4X := 325; Pillar5X := 325;
    WHILE (PillarCount<NewNoOfPillars) AND NOT (GameOver) DO
          PillarCount := PillarCount + 1;
          Pillar5X := Pillar4X; Pillar4X := Pillar3X; Pillar3X := Pillar2X;
          Pillar2X := Pillar1X; Pillar1X := (RANDOM(11)+1)*25;
          IF (PillarCount>NewNoOfPillars-6) THEN
             Pillar1X := 325;
          END;
          FOR Pillar1Y := 100 TO 118 BY 2 DO
            IF NOT (GameOver) THEN
              Delay (GameSpeed);
              Pillar2Y := Pillar1Y + 20; Pillar3Y := Pillar2Y + 20;
              Pillar4Y := Pillar3Y + 20; Pillar5Y := Pillar4Y + 20;
              IF (Pillar1Y<105) THEN
                    Rectangle (Pillar1X, 200 - Pillar1Y, Pillar1X + 1, Pillar1Y, DarkestGrey, TRUE);
              ELSIF (Pillar1Y>104) AND (Pillar1Y<112) THEN
                    Rectangle (Pillar1X, 200 - Pillar1Y, Pillar1X + 3, Pillar1Y, Grey, TRUE);
              ELSIF (Pillar1Y>111) THEN
                    DrawPillarBottom (Pillar1X, Pillar1Y);
              END;
              DrawPillarBottom (Pillar2X, Pillar2Y);
              DrawPillarBottom (Pillar3X, Pillar3Y);
              DrawPillarBottom (Pillar4X, Pillar4Y);
              DrawPillarBottom (Pillar5X, Pillar5Y);
              IF (Point (PlaneX + 25, PlaneY - 2) <> DarkRed) THEN
                 OldPlaneX := PlaneX;
                 Die;
                 REPEAT
                      PlaneX := Lib.RANDOM(250);
                 UNTIL (Point(PlaneX + (PlaneWidth DIV 2), PlaneY - 1) = DarkRed);
                 Rectangle (OldPlaneX, PlaneY, OldPlaneX+PlaneWidth, PlaneY+PlaneHeight, DarkRed, TRUE);
              END;
              OldPlaneX := PlaneX;
              CheckMouse;
              Rectangle (OldPlaneX, PlaneY, OldPlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkRed, TRUE);
              DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
            END;
          END;
          DrawPartialSky (Pillar5X);
    NoSound;
    IF GameOver THEN
       DrawGameOver;
    END;
    END;
END Screen9;

END Screens9.
