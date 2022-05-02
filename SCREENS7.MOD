IMPLEMENTATION MODULE Screens7;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT
  Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius, Storage;

FROM Graph IMPORT
  SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point, GetImage;

FROM Lib IMPORT
  Sound, NoSound, Delay, RANDOM;

FROM Exobius IMPORT
  NoteDelay, SolidFill, PlaneWidth, PlaneHeight, PlaneMovement,
  EnemyYStart, PlaneXMin, PlaneXMax, CollisionY, NegPlaneSize,
  Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
  DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
  DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue, DarkestRed,
  DarkRed, Red, LightRed, LightestRed, DarkestBrown, DarkBrown,
  Brown, LightBrown, LightestBrown, DarkestGreen, DarkGreen, Green, LightGreen,
  LightestGreen, DarkestYellow, DarkYellow, Yellow, LightYellow,
  LightestYellow, PlaneX,  Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X,
  Enemy6X, Enemies, BulletX, BulletY, PlaneY, Width, Height, CoverRectangleX,
  Count, Lives, EnemyY,  NegPlaneAddress, WritingAddress,  BkColour,
  OldBkColor,  Xs, Ys,  OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive,
  SixAlive, ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
  DrawBullet, DrawPlane, CheckMouse, CheckKeyboard, Die, A, B,
  C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
  FinishScreen1, Key, PlaneXMove, CheckDeath1, Score, Screen,
  PlaneInMemory, PlaneAddress, BkAddress, BkSize, ClearTheBuffer, Cheat,
  GraphicsCard, DrawGameOver;

PROCEDURE DrawPillarBottom(x, y : CARDINAL);
VAR
  PillarX, PillarY, PillarColour : CARDINAL;
BEGIN
    FOR PillarX := 0 TO 27 DO
        CASE PillarX OF
             | 0, 1 : PillarColour := DarkestGrey;
             | 2, 3 : PillarColour := DarkGrey;
             | 4, 5 : PillarColour := Grey;
             | 6, 7 : PillarColour := LightGrey;
             | 8, 9 : PillarColour := LightestGrey;
             | 10, 11 : PillarColour := DarkestWhite;
             | 12, 13 : PillarColour := DarkWhite;
             | 14, 15 : PillarColour := White;
             | 16, 17 : PillarColour := LightWhite;
             | 18, 19 : PillarColour := LightestWhite;
             | 20, 21 : PillarColour := LightWhite;
             | 22, 23 : PillarColour := White;
             | 24, 25 : PillarColour := DarkWhite;
             | 26, 27 : PillarColour := DarkestWhite;
        END;
        CASE PillarX OF
             | 0, 27 : PillarY := y;
             | 1, 26 : PillarY := y + 1;
             | 2, 3, 25, 24 : PillarY := y + 2;
             | 4, 5, 6, 7, 8, 23, 22, 21, 20, 19 : PillarY := y + 3;
             | 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 : PillarY := y + 4;
        END;
        IF (PillarY<200) THEN
           Line (x + ((y-100)*PillarX DIV 100), 200-PillarY, x + ((y-100)*PillarX DIV 100), PillarY, PillarColour)
        ELSE
           Line (x + ((y-100)*PillarX DIV 100), 0, x + ((y-100)*PillarX DIV 100), 200, PillarColour);
        END;
    END;
END DrawPillarBottom;

PROCEDURE DrawPillarTop(x, y : CARDINAL);
VAR
  PillarX, PillarColour : CARDINAL;
BEGIN
    FOR PillarX := 0 TO 27 DO
        CASE PillarX OF
             | 0, 1 : PillarColour := DarkestGrey;
             | 2, 3 : PillarColour := DarkGrey;
             | 4, 5 : PillarColour := Grey;
             | 6, 7 : PillarColour := LightGrey;
             | 8, 9 : PillarColour := LightestGrey;
             | 10, 11 : PillarColour := DarkestWhite;
             | 12, 13 : PillarColour := DarkWhite;
             | 14, 15 : PillarColour := White;
             | 16, 17 : PillarColour := LightWhite;
             | 18, 19 : PillarColour := LightestWhite;
             | 20, 21 : PillarColour := LightWhite;
             | 22, 23 : PillarColour := White;
             | 24, 25 : PillarColour := DarkWhite;
             | 26, 27 : PillarColour := DarkestWhite;
        END;
        Line (x + (y*PillarX DIV 200), y, x + (y*PillarX DIV 200), 200, PillarColour);
    END;
    Ellipse (x + (y*13 DIV 200), y, y*13 DIV 200, y*5 DIV 200, White, TRUE);
END DrawPillarTop;

PROCEDURE Screen7;
CONST
    NoOfPillars = 16;
    NoOfCircles = 200;
    NewNoOfPillars = 35;
VAR
  PillarCount, Pillar1X, Pillar2X, Pillar3X, Pillar4X, Pillar5X, Pillar1Y,
  Pillar2Y, Pillar3Y, Pillar4Y, Pillar5Y, Pillar6Y, StarColour, CircleRadius,
  Stars, BlueCircles, CircleColour, OldPlaneX : CARDINAL;
  PlaneOnPillars : BOOLEAN;
BEGIN
    ClearTheBuffer;
    PlaneX := 145; PlaneY := 175; PlaneInMemory := FALSE;
    IF (GraphicsCard=3) THEN
       Rectangle (0, 0, 320, 100, DarkestGrey, TRUE);
    END;
    Rectangle (0, 100, 320, 200, DarkBrown, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Graph.GetImage (PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, PlaneAddress);
    PlaneInMemory := FALSE;
    FOR PillarCount := 105 TO 200 DO
        Rectangle (0, 100, 320, 200, DarkBrown, TRUE);
        IF (PillarCount >150) THEN
           DrawPillarTop (PlaneX, PillarCount);
        ELSE
           Rectangle (0, 0, 320, 100, Black, TRUE);
           Ellipse (CARDINAL(PlaneX - 8) + (PillarCount*13 DIV 200), PillarCount, PillarCount*13 DIV 200, PillarCount*5 DIV 200, White, TRUE);
        END;
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
        Delay (GameSpeed);
    END;
    FOR PillarCount := 90 TO 200 BY 8 DO
        Rectangle (0, 98, 320, PillarCount, Black, TRUE);
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
        NoSound;
        Sound (PillarCount*5);
    END;
    NoSound;
    PillarCount := 0; PlaneOnPillars := TRUE;
    Pillar1X := (RANDOM(11)+1)*25; Pillar2X := (RANDOM(11)+1)*25;
    Pillar3X := (RANDOM(11)+1)*25; Pillar4X := (RANDOM(11)+1)*25;
    Pillar5X := (RANDOM(11)+1)*25;
    WHILE (PlaneOnPillars) AND (PillarCount<NoOfPillars) DO
          PillarCount := PillarCount + 1;
          Pillar5X := Pillar4X; Pillar4X := Pillar3X; Pillar3X := Pillar2X;
          Pillar2X := Pillar1X; Pillar1X := (RANDOM(11)+1)*25;
          FOR Pillar1Y := 80 TO 100 DO
              CheckMouse;
              Delay (CARDINAL(TRUNC(REAL(GameSpeed)*1.5)));
              Pillar2Y := Pillar1Y + 20; Pillar3Y := Pillar2Y + 20;
              Pillar4Y := Pillar3Y + 20; Pillar5Y := Pillar4Y + 20;
              Graph.ClearScreen (Graph._GCLEARSCREEN);
              FOR Stars := 1 TO 15 DO
                  CASE (RANDOM(5)) OF
                       | 1 : StarColour := Blue;
                       | 2 : StarColour := White;
                       | 3 : StarColour := Grey;
                       | 4 : StarColour := Yellow;
                       | 5 : StarColour := LightestWhite;
                  END;
                  Plot (RANDOM(320), RANDOM(200), StarColour);
              END;
              IF (Pillar1Y<85) THEN
                    Rectangle (Pillar1X, Pillar1Y, Pillar1X + 1, 200, DarkestGrey, TRUE);
              ELSIF (Pillar1Y>84) AND (Pillar1Y<92) THEN
                    Rectangle (Pillar1X, Pillar1Y, Pillar1X + 3, 200, Grey, TRUE);
              ELSIF (Pillar1Y>91) THEN
                    DrawPillarTop (Pillar1X, Pillar1Y);
              END;
              DrawPillarTop (Pillar2X, Pillar2Y);
              DrawPillarTop (Pillar3X, Pillar3Y);
              DrawPillarTop (Pillar4X, Pillar4Y);
              DrawPillarTop (Pillar5X, Pillar5Y);
              IF (Pillar1Y<85) THEN
                 PlaneY := PlaneY - 10;
              END;
              IF (Pillar1Y>84) AND (Pillar1Y<88) THEN
                 PlaneY := PlaneY - 6;
              END;
              IF (Pillar1Y>87) AND (Pillar1Y<94) THEN
                 PlaneY := PlaneY + 4;
              END;
              IF (Pillar1Y>93) AND (Pillar1Y<95) THEN
                 PlaneY := PlaneY + 6;
              END;
              IF (Pillar1Y>95) AND (Pillar1Y<100) THEN
                 PlaneY := PlaneY + 10;
              END;
              IF (Pillar1Y=100) THEN
                 PlaneY := 175;
                 IF (Point (PlaneX + 25, PlaneY + 8) <> White) THEN
                    PlaneOnPillars := FALSE;
                 END;
              END;
              DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
          END;
    END;
    IF (PlaneOnPillars) THEN
       FOR Pillar2Y := 120 TO 200 BY 5 DO
           NoSound;
           Sound ((Pillar2Y-100)*20);
           Graph.ClearScreen (Graph._GCLEARSCREEN);
           FOR Stars := 1 TO 15 DO
               CASE (RANDOM(5)) OF
                    | 1 : StarColour := Blue;
                    | 2 : StarColour := White;
                    | 3 : StarColour := Grey;
                    | 4 : StarColour := Yellow;
                    | 5 : StarColour := LightestWhite;
               END;
               Plot (RANDOM(320), RANDOM(200), StarColour);
           END;
           DrawPillarTop (Pillar2X, Pillar2Y);
           DrawPillarTop (Pillar3X, Pillar2Y+20);
           DrawPillarTop (Pillar4X, Pillar2Y+40);
           DrawPillarTop (Pillar5X, Pillar2Y+60);
           DrawPlane (PlaneX, PlaneY, PlaneWidth ,PlaneHeight);
       END;
       NoSound;
       FOR BlueCircles := 1 TO NoOfCircles DO
        IF NOT (GameOver) THEN
           Graph.ClearScreen (Graph._GCLEARSCREEN);
           FOR Stars := 1 TO 15 DO
               CASE (RANDOM(5)) OF
                    | 1 : StarColour := Blue;
                    | 2 : StarColour := White;
                    | 3 : StarColour := Grey;
                    | 4 : StarColour := Yellow;
                    | 5 : StarColour := LightestWhite;
               END;
               Plot (RANDOM(320), RANDOM(200), StarColour);
           END;
         CircleRadius := (BlueCircles + 20) MOD 10;
         IF (CircleRadius=0) THEN
            CircleRadius := 10;
         END;
         WHILE (CircleRadius<200) DO
               IF (CircleRadius<40) THEN
                     CircleColour := DarkGrey
               ELSIF (CircleRadius>39) AND (CircleRadius<80) THEN
                     CircleColour := DarkestBlue
               ELSIF (CircleRadius>79) AND (CircleRadius<120) THEN
                     CircleColour := DarkBlue
               ELSIF (CircleRadius>119) AND (CircleRadius<160) THEN
                     CircleColour := Blue
               ELSIF (CircleRadius>159) THEN
                     CircleColour := LightBlue;
               END;
               Circle (160, 100, CircleRadius, CircleColour);
               CircleRadius := CircleRadius*2;
         END;
         OldPlaneX := PlaneX;
         CheckMouse;
         PlaneX := OldPlaneX;
         DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
         IF (PlaneX<145) THEN
            PlaneX := PlaneX + INTEGER(RANDOM(5))
         ELSIF (PlaneX>145) THEN
            PlaneX := PlaneX - INTEGER(RANDOM(5));
         END;
        END;
     END;
  END; (* Circle-Walkthrough *)
  IF NOT (PlaneOnPillars) THEN
     Graph.ClearScreen(Graph._GCLEARSCREEN);
     FOR PillarCount := 200 TO 100 BY -8 DO
         Rectangle (0, PillarCount, 320, 201, DarkBrown, TRUE);
         DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
         NoSound;
         Sound (PillarCount*5);
     END;
     NoSound;
     Rectangle (0, 100, 320, 200, DarkBrown, TRUE);
     PillarCount := 0;
     Pillar1X := (RANDOM(11)+1)*25; Pillar2X := (RANDOM(11)+1)*25;
     Pillar3X := (RANDOM(11)+1)*25; Pillar4X := (RANDOM(11)+1)*25;
     Pillar5X := (RANDOM(11)+1)*25; PlaneInMemory := TRUE;
     WHILE (PillarCount<NewNoOfPillars) AND NOT (GameOver) DO
           PillarCount := PillarCount + 1;
           Pillar5X := Pillar4X; Pillar4X := Pillar3X; Pillar3X := Pillar2X;
           Pillar2X := Pillar1X; Pillar1X := (RANDOM(11)+1)*25;
           FOR Stars := 1 TO 15 DO
               CASE (RANDOM(5)) OF
                    | 1 : StarColour := LightBlue;
                    | 2 : StarColour := White;
                    | 3 : StarColour := Grey;
                    | 4 : StarColour := LightestYellow;
                    | 5 : StarColour := LightestWhite;
               END;
               Plot (RANDOM(320), RANDOM(100), StarColour);
           END;
           FOR Pillar1Y := 100 TO 118 BY 2 DO
             IF NOT (GameOver) THEN
               Delay (GameSpeed*2);
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
               IF (Point (PlaneX + 25, PlaneY - 2) <> DarkBrown) THEN
                  OldPlaneX := PlaneX;
                  Die;
                  Rectangle (OldPlaneX, PlaneY, OldPlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkBrown, TRUE);
               END;
               OldPlaneX := PlaneX;
               CheckMouse;
               Rectangle (OldPlaneX, PlaneY, OldPlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkBrown, TRUE);
               IF (Graph.Point(315, 195)=Black) THEN
                  Rectangle (250, 190, 320, 200, DarkBrown, TRUE);
               END;
               DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
             END;
           END;
           Rectangle (Pillar5X, 0, Pillar5X + 27, 100, Black, TRUE);
           Rectangle (Pillar5X, 100, Pillar5X + 27, 200, DarkBrown, TRUE);
     END; (* PlaneOnGround *)
     PlaneInMemory := FALSE;
     IF NOT GameOver THEN
        FOR PillarCount := 100 TO 300 BY 8 DO
            Rectangle (0, 0, 320, PillarCount, Black, TRUE);
            DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
            NoSound;
            Sound (PillarCount*5);
        END;
     END;
     NoSound;
  END;
  IF GameOver THEN
     DrawGameOver;
  END;
END Screen7;

END Screens7.
