IMPLEMENTATION MODULE Bosses2;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius, Font;
FROM Graph IMPORT Point, SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Sprites IMPORT DrawSpinners;
FROM Screens8 IMPORT DrawStars8, DrawPlanet, PlanetRadius;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Exobius IMPORT
  SolidFill, PlaneWidth, PlaneHeight,
  EnemyYStart, PlaneXMin, CollisionY,
  Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
  DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
  DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue, DarkestRed,
  DarkRed, Red, LightRed, LightestRed, DarkestBrown, DarkBrown,
  Brown, LightBrown, LightestBrown, DarkestGreen, DarkGreen, Green, LightGreen,
  LightestGreen, DarkestYellow, DarkYellow, Yellow, LightYellow,
  LightestYellow, PlaneX,  Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X,
  Enemy6X, Enemies, BulletX, BulletY, PlaneY, CoverRectangleX,
  Count, Lives, EnemyY, BkColour,
  OldBkColor,  Xs, Ys, OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive,
  SixAlive, ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
  Update3DBullet, DrawPlane, CheckMouse, Die,
  FinishScreen, Key, PlaneXMove, Score,
  BkAddress, DrawGameOver, TextPos;

CONST
    Boss1X = 0;
    Boss2X = 110;
    Boss3X = 220;
    BossMove = 5;
VAR
  Boss1Y, Boss2Y, Boss3Y, Boss1Lives, Boss2Lives, Boss3Lives : CARDINAL;
  BossAddressA, BossAddressB, BossAddressC : ADDRESS;
  OneDead, TwoDead, ThreeDead : BOOLEAN;

PROCEDURE DrawBoss2A(X1, Y1, X2, Y2, X3, Y3 : CARDINAL);
BEGIN
    IF NOT OneDead THEN
       Graph.PutImage (X1, Y1, BossAddressA, Graph._GPSET);
    END;
    IF NOT TwoDead THEN
       Graph.PutImage (X2, Y2, BossAddressA, Graph._GPSET);
    END;
    IF NOT ThreeDead THEN
       Graph.PutImage (X3, Y3, BossAddressA, Graph._GPSET);
    END;
END DrawBoss2A;

PROCEDURE DrawBoss2B(X1, Y1, X2, Y2, X3, Y3 : CARDINAL);
BEGIN
    IF NOT OneDead THEN
       Graph.PutImage (X1, Y1, BossAddressB, Graph._GPSET);
    END;
    IF NOT TwoDead THEN
       Graph.PutImage (X2, Y2, BossAddressB, Graph._GPSET);
    END;
    IF NOT ThreeDead THEN
       Graph.PutImage (X3, Y3, BossAddressB, Graph._GPSET);
    END;
END DrawBoss2B;

PROCEDURE DrawBoss2C(X1, Y1, X2, Y2, X3, Y3 : CARDINAL);
BEGIN
    IF NOT OneDead THEN
       Graph.PutImage (X1, Y1, BossAddressC, Graph._GPSET);
    END;
    IF NOT TwoDead THEN
       Graph.PutImage (X2, Y2, BossAddressC, Graph._GPSET);
    END;
    IF NOT ThreeDead THEN
       Graph.PutImage (X3, Y3, BossAddressC, Graph._GPSET);
    END;
END DrawBoss2C;

PROCEDURE BlowUpBoss2(x, y : CARDINAL);
VAR
  Explosions, Colour : CARDINAL;
BEGIN
  TextPos := Graph.SetTextPosition (1, 15);
  Graph.OutText ("Extra Life!");
  FOR Explosions := 100 TO 0 BY -1 DO
     Sound (Explosions);
     CASE (Lib.RANDOM(10)) OF
        | 1 : Colour := DarkestRed;
        | 2 : Colour := DarkRed;
        | 3 : Colour := Red;
        | 4 : Colour := LightRed;
        | 5 : Colour := LightestRed;
        | 6 : Colour := DarkestYellow;
        | 7 : Colour := DarkYellow;
        | 8 : Colour := Yellow;
        | 9 : Colour := LightYellow;
        |10 : Colour := LightestYellow;
     END;
     Ellipse (Lib.RANDOM(100) + x, Lib.RANDOM(100) + y, Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
     Plot (Lib.RANDOM(100) + x, Lib.RANDOM(100) + y, Colour);
     Delay(10);
     NoSound;
  END;
  Graph.ClearScreen (Graph._GCLEARSCREEN);
  IF OneDead AND TwoDead AND ThreeDead THEN
     ScreenComplete := TRUE;
  END;
  IF (Lives>0) THEN
     Lives := Lives - 1;
  END;
END BlowUpBoss2;

PROCEDURE DrawBarGraphs2;
BEGIN
    Rectangle (0, 0, 101, 10, White, FALSE);
    IF NOT (OneDead) THEN
       Rectangle (1, 1, 100, 9, Black, TRUE);
       Rectangle (1, 1, Boss1Lives*10, 9, Red, TRUE);
    END;

    Rectangle (110, 0, 211, 10, White, FALSE);
    IF NOT (TwoDead) THEN
       Rectangle (111, 1, 210, 9, Black, TRUE);
       Rectangle (111, 1, Boss2Lives*10 + 110, 9, Red, TRUE);
    END;

    Rectangle (220, 0, 318, 10, White, FALSE);
    IF NOT (ThreeDead) THEN
       Rectangle (221, 1, 319, 9, Black, TRUE);
       Rectangle (221, 1, Boss3Lives*10 + 220, 9, Red, TRUE);
    END;
END DrawBarGraphs2;

PROCEDURE HurtBoss2;
CONST
    Boss2FlashDelay = 8;
BEGIN
    IF NOT (OneDead) AND (BulletX<100) THEN
       Disc (Boss1X + 50, Boss1Y + 50, 18, LightestWhite);
       Sound (440);
       Delay (Boss2FlashDelay);
       NoSound;
       Sound (220);
       Delay (Boss2FlashDelay);
       NoSound;
       Sound (50);
       Delay (Boss2FlashDelay);
       NoSound;
       Boss1Lives := Boss1Lives - 1;
       IF (Boss1Lives=0) THEN
          OneDead := TRUE;
          BlowUpBoss2(Boss1X, Boss1Y);
       END;
    END;
    IF NOT (TwoDead) AND (BulletX>110) AND (BulletX < 220) THEN
       Disc (Boss2X + 50, Boss2Y + 50, 18, LightestWhite);
       Sound (440);
       Delay (Boss2FlashDelay);
       NoSound;
       Sound (220);
       Delay (Boss2FlashDelay);
       NoSound;
       Sound (110);
       Delay (Boss2FlashDelay);
       NoSound;
       Boss2Lives := Boss2Lives - 1;
       IF (Boss2Lives=0) THEN
          TwoDead := TRUE;
          BlowUpBoss2(Boss2X, Boss2Y);
       END;
    END;
    IF NOT (ThreeDead) AND (BulletX>220) THEN
       Disc (Boss3X + 50, Boss3Y + 50, 18, LightestWhite);
       Sound (440);
       Delay (Boss2FlashDelay);
       NoSound;
       Sound (220);
       Delay (Boss2FlashDelay);
       NoSound;
       Sound (110);
       Delay (Boss2FlashDelay);
       NoSound;
       Boss3Lives := Boss3Lives - 1;
       IF (Boss3Lives=0) THEN
          ThreeDead := TRUE;
          BlowUpBoss2(Boss3X, Boss3Y);
       END;
    END;
    DrawBarGraphs2;
END HurtBoss2;

PROCEDURE DrawBulletBoss2;
VAR
  NewBulletX : CARDINAL;
  Dist : INTEGER;
BEGIN
    CASE BulletY OF
         | 5 : Disc (PlaneX + (PlaneWidth DIV 2), PlaneY - 4, 4, LightYellow);
               BulletY := 4;
         | 4 : IF (BulletX >= 160) THEN
               Dist := (10 + ((3*70) DIV 2)) * INTEGER(BulletX - 160) DIV 160;
                  NewBulletX := 160 + ABS(Dist);
               ELSIF (BulletX < 160) THEN
               Dist := (10 + ((3*70) DIV 2)) * INTEGER(160 - BulletX) DIV 160;
                  NewBulletX := 160 - ABS(Dist);
               END;
               Disc (NewBulletX, 150, 2, Yellow);
               Delay (3);
               Disc (NewBulletX, 150, 2, Black);
               BulletY := 3;
         | 3 : HurtBoss2;
               BulletY := 0;
    END;
END DrawBulletBoss2;

PROCEDURE FinishScreenBoss2;
BEGIN
  FOR PlaneY := 175 TO 100 BY -2 DO
     IF (PlaneX<155) THEN
        PlaneX := PlaneX + 5;
     END;
     IF (PlaneX>155) THEN
        PlaneX := PlaneX - 5;
     END;
     Graph.ClearScreen (Graph._GCLEARSCREEN);
     DrawPlane (PlaneX, PlaneY, ((PlaneY - 100) DIV 2));
     Delay (40);
  END;
  Graph.ClearScreen(Graph._GCLEARSCREEN);
END FinishScreenBoss2;

PROCEDURE Boss2;
VAR
   BossFall, LeftBehind : CARDINAL;
   Key : CHAR;
   OneDead, TwoDead, ThreeDead : BOOLEAN;
BEGIN
    PlaneX := 145; PlaneY := 174;
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane(PlaneX, PlaneY, PlaneWidth);
    DrawSpinners(Boss1X, 0, 100);
    Storage.ALLOCATE (BossAddressA, CARDINAL(Graph.ImageSize(Boss1X, 0, Boss1X + 100, 100)));
    Graph.GetImage (Boss1X, 0, Boss1X + 100, 100, BossAddressA);
    Graph.PutImage (Boss2X, 0, BossAddressA, Graph._GPSET);
    Graph.PutImage (Boss3X, 0, BossAddressA, Graph._GPSET);
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlane(PlaneX, PlaneY, PlaneWidth);
    DrawSpinners(Boss1X, 1, 100);
    Storage.ALLOCATE (BossAddressB, CARDINAL(Graph.ImageSize(Boss1X, 1, Boss1X + 100, 101)));
    Graph.GetImage (Boss1X, 1, Boss1X + 100, 101, BossAddressB);
    Graph.PutImage (Boss2X, 1, BossAddressB, Graph._GPSET);
    Graph.PutImage (Boss3X, 1, BossAddressB, Graph._GPSET);
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlane(PlaneX, PlaneY, PlaneWidth);
    DrawSpinners(Boss1X, 2, 100);
    Storage.ALLOCATE (BossAddressC, CARDINAL(Graph.ImageSize(Boss1X, 2, Boss1X + 100, 102)));
    Graph.GetImage (Boss1X, 2, Boss1X + 100, 102, BossAddressC);
    Graph.PutImage (Boss2X, 2, BossAddressC, Graph._GPSET);
    Graph.PutImage (Boss3X, 2, BossAddressC, Graph._GPSET);
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlane (PlaneX, PlaneY, PlaneWidth);
    FOR BossFall := 4 TO 50 BY 2 DO
        Rectangle (0, BossFall - 4, 320, BossFall - 1, Black, TRUE);
        CASE (BossFall MOD 3) OF
             | 1 : DrawBoss2A(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 2 : DrawBoss2B(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 0 : DrawBoss2C(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
        END;
    END;
    FOR BossFall := 50 TO 25 BY -2 DO
        Rectangle (0, BossFall + 104, 320, BossFall + 101, Black, TRUE);
        CASE (BossFall MOD 3) OF
             | 1 : DrawBoss2A(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 2 : DrawBoss2B(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 0 : DrawBoss2C(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
        END;
    END;
    FOR BossFall := 25 TO 50 BY 2 DO
        Rectangle (0, BossFall - 4, 320, BossFall - 1, Black, TRUE);
        CASE (BossFall MOD 3) OF
             | 1 : DrawBoss2A(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 2 : DrawBoss2B(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 0 : DrawBoss2C(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
        END;
    END;
    FOR BossFall := 50 TO 40 BY -2 DO
        Rectangle (0, BossFall + 104, 320, BossFall + 101, Black, TRUE);
        CASE (BossFall MOD 3) OF
             | 1 : DrawBoss2A(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 2 : DrawBoss2B(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 0 : DrawBoss2C(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
        END;
    END;
    FOR BossFall := 40 TO 50 BY 2 DO
        Rectangle (0, BossFall - 4, 320, BossFall - 1, Black, TRUE);
        CASE (BossFall MOD 3) OF
             | 1 : DrawBoss2A(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 2 : DrawBoss2B(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
             | 0 : DrawBoss2C(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall);
        END;
    END;

                (* THE ACTION BEGINS!! *)

    Boss1Lives := 10; Boss2Lives := 10; Boss3Lives := 10;
    OneDead := FALSE; TwoDead := FALSE; ThreeDead := FALSE;
    ScreenComplete := FALSE;
    Boss1Y := BossFall; Boss2Y := BossFall; Boss3Y := BossFall;
    DrawBarGraphs2;
    WHILE (NOT (OneDead AND TwoDead AND ThreeDead) AND NOT (GameOver)
     AND NOT (ScreenComplete)) DO
          BossFall := Boss1Y;
          LeftBehind := Lib.RANDOM(3);
          WHILE ((BossFall < 100) AND NOT (ScreenComplete) AND NOT (GameOver))DO
            IF (NOT GameOver) AND (NOT ScreenComplete) THEN
              IF LeftBehind > 1 THEN
                 Rectangle (Boss1X, Boss1Y, Boss1X + 100, Boss1Y + BossFall, Black, TRUE);
                 Boss1Y := BossFall;
              END;
              IF LeftBehind <> 2 THEN
                 Rectangle (Boss2X, Boss2Y, Boss2X + 100, Boss2Y + BossFall, Black, TRUE);
                 Boss2Y := BossFall;
              END;
              IF LeftBehind < 3 THEN
                 Rectangle (Boss3X, Boss3Y, Boss3X + 100, Boss3Y + BossFall, Black, TRUE);
                 Boss3Y := BossFall;
              END;
              Rectangle (0, PlaneY - 2, 320, 200, Black, TRUE);
              DrawPlane (PlaneX, PlaneY, PlaneWidth);
              CASE (BossFall MOD 3) OF
                   | 1 : DrawBoss2A(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y);
                   | 2 : DrawBoss2B(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y);
                   | 0 : DrawBoss2C(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y);
              END;
              CheckMouse;
              DrawBulletBoss2;
              BossFall := BossFall + BossMove;
              IF (BulletY=4) THEN
                 Disc (PlaneX + (PlaneWidth DIV 2), PlaneY - 4, 4, Black);
              END;
              IF (Point (PlaneX + 10, PlaneY - 2) <> Black)
                 OR (Point (PlaneX + 40, PlaneY - 2) <> Black)
                 OR (Point (PlaneX + 25, PlaneY - 2) <> Black) THEN
                 Die;
                 CASE LeftBehind OF
                      | 1 : PlaneX := 30;
                      | 2 : PlaneX := 135;
                      | 3 : PlaneX := 190;
                 END;
              END;
              Delay((GameSpeed+1)*2);
            END; (* IF Statement *)
          END; (* BossFall *)
          WHILE ((BossFall > 50) AND NOT (ScreenComplete) AND NOT (GameOver))DO
            IF (NOT GameOver) AND (NOT ScreenComplete) THEN
              IF LeftBehind > 1 THEN
                 Rectangle (Boss1X, Boss1Y + 100, Boss1X + 100, Boss1Y + BossFall, Black, TRUE);
                 Boss1Y := BossFall;
              END;
              IF LeftBehind <> 2 THEN
                 Rectangle (Boss2X, Boss2Y + 100, Boss2X + 100, Boss2Y + BossFall, Black, TRUE);
                 Boss2Y := BossFall;
              END;
              IF LeftBehind < 3 THEN
                 Rectangle (Boss3X, Boss3Y + 100, Boss3X + 100, Boss3Y + BossFall, Black, TRUE);
                 Boss3Y := BossFall;
              END;
              Rectangle (0, PlaneY - 2, 320, 200, Black, TRUE);
              DrawPlane (PlaneX, PlaneY, PlaneWidth);
              CASE (BossFall MOD 3) OF
                   | 1 : DrawBoss2A(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y);
                   | 2 : DrawBoss2B(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y);
                   | 0 : DrawBoss2C(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y);
              END;
              CheckMouse;
              DrawBulletBoss2;
              BossFall := BossFall - BossMove;
              IF (BulletY=4) THEN
                 Disc (PlaneX + (PlaneWidth DIV 2), PlaneY - 4, 4, Black);
              END;
              IF (Point (PlaneX + 10, PlaneY - 2) <> Black)
                 OR (Point (PlaneX + 40, PlaneY - 2) <> Black)
                 OR (Point (PlaneX + 25, PlaneY - 2) <> Black) THEN
                 Die;
                 CASE LeftBehind OF
                      | 1 : PlaneX := 30;
                      | 2 : PlaneX := 135;
                      | 3 : PlaneX := 190;
                 END;
              END;
              Delay((GameSpeed+1)*2);
            END; (* IF Statement *)
          END; (* BossFall *)
          Graph.ClearScreen (Graph._GCLEARSCREEN);
          DrawBarGraphs2;
    END; (* ScreenComplete Check *)
    IF GameOver THEN
       DrawGameOver;
    END;
    IF ScreenComplete THEN
       FinishScreenBoss2;
    END;
    Storage.DEALLOCATE (BossAddressC, CARDINAL(Graph.ImageSize(Boss1X, 0, Boss1X + 100, 100)));
    Storage.DEALLOCATE (BossAddressB, CARDINAL(Graph.ImageSize(Boss1X, 0, Boss1X + 100, 100)));
    Storage.DEALLOCATE (BossAddressA, CARDINAL(Graph.ImageSize(Boss1X, 0, Boss1X + 100, 100)));
END Boss2;


END Bosses2.
