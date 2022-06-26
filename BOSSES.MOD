IMPLEMENTATION MODULE Bosses;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT
     Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius;

FROM Graph IMPORT
     Point, SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;

FROM Lib IMPORT
     Sound, NoSound, Delay, RANDOM;

FROM Exobius IMPORT
  SolidFill, PlaneWidth, PlaneHeight, PlaneMovement,
  EnemyYStart, PlaneXMin, PlaneXMax, CollisionY, NegPlaneSize,
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
  DrawBullet, DrawPlane, CheckMouse, Die, A, B,
  C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
  FinishScreen, Key, PlaneXMove, Score,
  PlaneAddress, BkAddress, BkSize, GroundAddress, GroundSize,
  DrawGameOver;

FROM Storage IMPORT
     ALLOCATE, DEALLOCATE;

FROM Sprites IMPORT
  DrawSpinners;

FROM Screens8 IMPORT
  DrawStars8, DrawPlanet, PlanetRadius;

CONST
    Boss1X = 0;
    Boss2X = 110;
    Boss3X = 220;
    MouthY = 60;
VAR
  Boss1Y, Boss2Y, Boss3Y, Boss3Y3, Boss1Lives, Boss2Lives : CARDINAL;
  Boss3X3, Boss3Lives : INTEGER;
  TextPos : Graph.TextCoords;
  BossAddressA, BossAddressB, BossAddressC : ADDRESS;
  OneDead, TwoDead, ThreeDead, BossDiving : BOOLEAN;

TYPE
  CoordArray = ARRAY [0..10] OF CARDINAL;
PROCEDURE DrawBoss1 (x, y : CARDINAL);
BEGIN
        Disc (x + 50, y + 60, 40, DarkestRed);
        Disc (x + 52, y + 58, 36, DarkRed);
        Disc (x + 54, y + 56, 32, Red);
        Disc (x + 56, y + 54, 28, LightRed);
        Disc (x + 58, y + 52, 24, LightestRed);
        Disc (x + 60, y + 50, 20, DarkestYellow);
        Disc (x + 62, y + 48, 16, DarkYellow);
        Disc (x + 64, y + 46, 12, Yellow);
        Disc (x + 66, y + 44, 8, LightYellow);
        Disc (x + 68, y + 42, 4, LightestYellow);
        Plot (x + 69, y + 41, LightestWhite);
        Disc (x + 50, y + 10, 10, DarkestGreen);
        Disc (x + 51, y + 9, 8, DarkGreen);
        Disc (x + 52, y + 8, 6, Green);
        Disc (x + 53, y + 7, 4, LightGreen);
        Disc (x + 54, y + 6, 2, LightestGreen);
        Plot (x + 55, y + 5, LightestWhite);
        Disc (x + 46, y + 2, 2, Black);
        Disc (x + 54, y + 2, 2, Black);
        Line (x + 47, y + 0, x + 50, y + 4, Grey);
        Line (x + 53, y + 0, x + 50, y + 4, Grey);
        Line (x + 45, y + MouthY, x + 55, y + MouthY, Black);
        Disc (x + 50, y + 60, 3, Black);
END DrawBoss1;

PROCEDURE KillBoss1;
VAR
  Explosions, Colour : CARDINAL;
BEGIN
  Rectangle (0, 0, 319, 10, White, FALSE);
  FOR Explosions := 1 TO 500 DO
     Sound (Lib.RANDOM(15) + 20);
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
     Ellipse (Lib.RANDOM(100) + 109, Lib.RANDOM(100) + 49, Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
     Plot (Lib.RANDOM(100) + 109, Lib.RANDOM(100) + 49, Colour);
     NoSound;
  END;
  ScreenComplete := TRUE;
  IF (Lives>0) THEN
     Lives := Lives - 1;
  END;
END KillBoss1;

PROCEDURE DrawStars;
VAR
  Stars : CARDINAL;
BEGIN
    FOR Stars := 1 TO 10 DO
        Plot (Lib.RANDOM(320), Lib.RANDOM(100), White);
    END;
END DrawStars;

PROCEDURE Boss1;
CONST
        SpitX = 160;
        SpitMovement = 2;
        SpitHitY = 150;
        MouthY = 65;
        BossFallSpeed = 5;
VAR
        SpitCount, BossFall, SpitY, BossLives, GroundLines, GroundLineX : CARDINAL;
BEGIN
        EnemyY := 99;
        ScreenComplete := FALSE;
        PlaneX := PlaneXMin;
        PlaneY := 175;
        Width := 50;
        Height := 25;
        Storage.ALLOCATE (BkAddress, MAX(CARDINAL));
        Xs[0] := 0; Xs[1] := 112; Xs[2] := 208; Xs[3] := 320;
        Ys[0] := 200; Ys[1] := 151; Ys[2] := 151; Ys[3] := 200;
        Polygon (4, Xs, Ys, LightBrown);
        Graph.GetImage (0, 0, 320, 200, BkAddress);
        FOR BossFall := 0 TO 50  BY BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;
        FOR BossFall := 50 TO 25 BY -BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;
        FOR BossFall := 25 TO 50  BY BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;
        FOR BossFall := 50 TO 40 BY -BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;
        FOR BossFall := 40 TO 50  BY BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;

        (* The Action Begins !! *)

        Graph.PutImage(0, 0, BkAddress, Graph._GPSET);
        Graph.PutImage(0, 100, GroundAddress, Graph._GPSET);
        FOR GroundLines := 1 TO 30 DO
            GroundLineX := RANDOM(80);
            Line (GroundLineX DIV 16 + 150, 100, GroundLineX, 200, LightestBrown);
            Line (GroundLineX DIV 16 + 155, 100, GroundLineX+80, 200, LightestBrown);
            Line (GroundLineX DIV 16 + 160, 100, GroundLineX+160, 200, LightestBrown);
            Line (GroundLineX DIV 16 + 165, 100, GroundLineX+240, 200, LightestBrown);
            GroundLineX := RANDOM(150);
            Line (GroundLineX, 100, 0, 100 + GroundLineX*2 DIV 3, Green);
            Line (320-GroundLineX, 100, 320, 100 + GroundLineX*2 DIV 3, Green);
            GroundLineX := RANDOM(150);
            Line (GroundLineX, 100, 0, 100 + GroundLineX*2 DIV 3, LightestGreen);
            Line (320-GroundLineX, 100, 320, 100 + GroundLineX*2 DIV 3, LightestGreen);
            GroundLineX := RANDOM(80);
            Line (GroundLineX DIV 16 + 150, 100, GroundLineX, 200, Brown);
            Line (GroundLineX DIV 16 + 155, 100, GroundLineX+80, 200, Brown);
            Line (GroundLineX DIV 16 + 160, 100, GroundLineX+160, 200, Brown);
            Line (GroundLineX DIV 16 + 165, 100, GroundLineX+240, 200, Brown);
        END;
        DrawBoss1 (110, BossFall);
        Rectangle (0, 0, 319, 10, White, FALSE);
        Rectangle (1, 1, 318, 9, Black, TRUE);
        Disc (160, MouthY, 5, Black);   (* Open Boss' Mouth *)
        Graph.GetImage (0, 0, 320, 200, BkAddress);
        CheckMouse;
        IF (PlaneX < PlaneXMin) THEN
                PlaneX := PlaneXMin;
        END;
        IF (PlaneX > PlaneXMax) THEN
                PlaneX := PlaneXMax;
        END;
        DrawPlane (PlaneX, PlaneY, Width, Height);
        DrawBullet;
        IF (BulletY  > 99) THEN
                BulletY := BulletY - 1;
        END;
        BossLives := 8;
        WHILE NOT GameOver AND NOT ScreenComplete DO
                 SpitY := MouthY;
                 WHILE (SpitY < 200) AND NOT (ScreenComplete) AND NOT (GameOver) DO
                        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                        Rectangle (1, 1, 318, 9, Black, TRUE);
                        Rectangle (1, 1, BossLives*50, 9, Red, TRUE);
                        Graph.GetImage (0, 0, 320, 200, BkAddress);
                        Ellipse (SpitX, SpitY, (SpitY - MouthY)*4 DIV 5, (SpitY - MouthY)*2 DIV 5, Blue, TRUE);
                        Ellipse (SpitX, SpitY, (SpitY + 1 - MouthY)*4 DIV 5, (SpitY + 2 - MouthY)*2 DIV 5, LightestBlue, FALSE);
                        IF (SpitY > SpitHitY) AND (PlaneX > 20) AND (PlaneX < 220) THEN
                                Die;
                        END;
                        CheckMouse;
                        DrawPlane (PlaneX, PlaneY, Width, Height);
                        DrawBullet;
                        IF (BulletY  < 6) AND (BulletY > 0) THEN
                                BulletY := BulletY - 1;
                        END;
                        IF (BulletX > 140) AND (BulletX < 170) AND (BulletY < 3) THEN
                                Disc (160, 110, 40, LightestWhite);
                                BossLives := BossLives - 1;
                                BulletY := 50;
                                Delay (5);
                                Score := Score + 150;
                        END;
                        IF (BossLives = 0) THEN
                                KillBoss1;
                                TextPos := Graph.SetTextPosition (1, 15);
                                Graph.OutText ("Extra Life!");
                                ScreenComplete := TRUE;
                        END;
                        Delay (GameSpeed DIV 2);
                        SpitY := SpitY + 1 + (SpitY - MouthY) DIV 2;
                END;    (* This "END" From SpitY < 200 Check. *)
        END;            (* This "END" From ScreenComplete Check. *)
        IF ScreenComplete AND NOT GameOver THEN
           FinishScreen;
        END;
        IF GameOver THEN
           G(110, 30); A(140, 30); M(170, 30); E(200, 30);
           O(110, 60); V(140, 60); E(170, 60); R(200, 60);
           Key := IO.RdKey();
        END;
        Storage.DEALLOCATE(GroundAddress, GroundSize);
        Storage.DEALLOCATE(BkAddress, MAX(CARDINAL));
END Boss1;

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
     DrawPlane (PlaneX, PlaneY, ((PlaneY - 100) DIV 2), ((PlaneY - 100) DIV 4));
     Delay (40);
  END;
  Graph.ClearScreen(Graph._GCLEARSCREEN);
END FinishScreenBoss2;

PROCEDURE Boss2;
CONST
    Boss1X = 0;
    Boss2X = 110;
    Boss3X = 220;
    BossMove = 5;
VAR
   BossFall, LeftBehind : CARDINAL;
   Key : CHAR;
   OneDead, TwoDead, ThreeDead : BOOLEAN;
BEGIN
    PlaneX := 145; PlaneY := 174;
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane(PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Graph.GetImage (PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, PlaneAddress);
    DrawSpinners(Boss1X, 0, 100);
    Storage.ALLOCATE (BossAddressA, CARDINAL(Graph.ImageSize(Boss1X, 0, Boss1X + 100, 100)));
    Graph.GetImage (Boss1X, 0, Boss1X + 100, 100, BossAddressA);
    Graph.PutImage (Boss2X, 0, BossAddressA, Graph._GPSET);
    Graph.PutImage (Boss3X, 0, BossAddressA, Graph._GPSET);
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlane(PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    DrawSpinners(Boss1X, 1, 100);
    Storage.ALLOCATE (BossAddressB, CARDINAL(Graph.ImageSize(Boss1X, 1, Boss1X + 100, 101)));
    Graph.GetImage (Boss1X, 1, Boss1X + 100, 101, BossAddressB);
    Graph.PutImage (Boss2X, 1, BossAddressB, Graph._GPSET);
    Graph.PutImage (Boss3X, 1, BossAddressB, Graph._GPSET);
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlane(PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    DrawSpinners(Boss1X, 2, 100);
    Storage.ALLOCATE (BossAddressC, CARDINAL(Graph.ImageSize(Boss1X, 2, Boss1X + 100, 102)));
    Graph.GetImage (Boss1X, 2, Boss1X + 100, 102, BossAddressC);
    Graph.PutImage (Boss2X, 2, BossAddressC, Graph._GPSET);
    Graph.PutImage (Boss3X, 2, BossAddressC, Graph._GPSET);
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
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
              DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
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
              DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
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

PROCEDURE DrawBoss3(x, y : CARDINAL);
VAR
  WingColour, WingColour2, WingTip : CARDINAL;
BEGIN
    Xs[0] := x+40; Ys[0] := y+15; Xs[1] := x+50; Ys[1] := y+30; Xs[2] := x+60; Ys[2] := y+15;
    Polygon (3, Xs, Ys, Red);
    Xs[0] := x+45; Ys[0] := y+15; Xs[1] := x+50; Ys[1] := y+24; Xs[2] := x+55; Ys[2] := y+15;
    Polygon (3, Xs, Ys, Red);
    Disc (x+43,y+10,2,Blue);
    Disc (x+57,y+10,2,Blue);
    IF NOT BossDiving THEN
       Xs[0] := x+40; Ys[0] := y+14; Xs[1] := x+50; Ys[1] := y+4; Xs[2] := x+60; Ys[2] := y+14;
       Polygon (3, Xs, Ys, LightestRed);
    END;
    Line (x+50,y+7,x+50,y+14,Red);
    Line (x+48,y+9,x+47,y+14,Red);
    Line (x+52,y+9,x+53,y+14,Red);
    CASE (x MOD 10) OF
         |  0,9,10,11  : WingTip := y; WingColour := DarkestGrey; WingColour2 := LightWhite;
         |  1,2,18,19  : WingTip := y+2; WingColour := Grey; WingColour2 := DarkWhite;
         |  3,4,16,17  : WingTip := y+4; WingColour := LightGrey; WingColour2 := LightestGrey;
         |  5,6,14,15  : WingTip := y+6; WingColour := DarkWhite; WingColour2 := Grey;
         |  7,8,12,13  : WingTip := y+8; WingColour := LightWhite; WingColour2 := DarkGrey;
    END;
    Xs[0] := x; Xs[1] := x+25; Xs[2] := x + 25;
    Ys[0] := y+30; Ys[1] := WingTip; Ys[2] := WingTip + 20;
    Polygon (3, Xs, Ys, WingColour);
    Xs[0] := x + 100; Xs[1] := x + 75; Xs[2] := x+75;
    Polygon (3, Xs, Ys, WingColour);
    Xs[0] := x + 25; Xs[1] := x + 25; Xs[2] := x + 50; Xs[3] := x + 40;
    Ys[0] := WingTip; Ys[1] := WingTip + 20; Ys[2] := y + 30; Ys[3] := y + 15;
    Polygon (4, Xs, Ys, WingColour2);
    Xs[0] := x + 75; Xs[1] := x + 75; Xs[2] := x + 50; Xs[3] := x + 60;
    Polygon (4, Xs, Ys, WingColour2);
END DrawBoss3;

PROCEDURE HurtBoss3;
BEGIN
    Sound (100);
    Xs[0] := Boss3X3; Xs[1] := Boss3X3 + 25; Xs[2] := Boss3X3 + 50;
          Xs[3] := Boss3X3 + 75; Xs[4] := Boss3X3 + 100; Xs[5] := Boss3X3 + 75;
          Xs[6] := Boss3X3 + 50; Xs[7] := Boss3X3 + 25;
    Ys[0] := Boss3Y3 + 30; Ys[1] := Boss3Y3; Ys[2] := Boss3Y3 + 15;
          Ys[3] := Boss3Y3; Ys[4] := Boss3Y3 + 30; Ys[5] := Boss3Y3 + 20;
          Ys[6] := Boss3Y3 + 30; Ys[7] := Boss3Y3 + 20;
    Polygon (8, Xs, Ys, LightestWhite);
    Boss3Lives := Boss3Lives - 1;
    IF (Boss3Lives=0) THEN
       ScreenComplete := TRUE;
    END;
    Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
    Rectangle (1, 1, 318, 9, Black, TRUE);
    Rectangle (1, 1, Boss3Lives*4, 9, Red, TRUE);
    Rectangle (0, 0, 319, 10, White, FALSE);
    Graph.GetImage (0, 0, 320, 200, BkAddress);
    NoSound;
END HurtBoss3;

PROCEDURE FinishScreenBoss3;
BEGIN
  FOR PlaneY := 175 TO 100 BY -2 DO
     IF (PlaneX<155) THEN
        PlaneX := PlaneX + 5;
     END;
     IF (PlaneX>155) THEN
        PlaneX := PlaneX - 5;
     END;
     Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
     DrawPlane (PlaneX, PlaneY, ((PlaneY - 100) DIV 2), ((PlaneY - 100) DIV 4));
     DrawStars8;
     Delay (40);
  END;
  Graph.ClearScreen(Graph._GCLEARSCREEN);
END FinishScreenBoss3;

PROCEDURE KillBoss3;
VAR
  Explosions, Colour : CARDINAL;
BEGIN
  TextPos := Graph.SetTextPosition (1, 15);
  Graph.OutText ("Extra Life!");
  ScreenComplete := TRUE;
  FOR Explosions := 200 TO 0 BY -1 DO
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
     Ellipse (Lib.RANDOM(100) + CARDINAL(Boss3X3), Lib.RANDOM(30) + Boss3Y3, Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
     Plot (Lib.RANDOM(100) + CARDINAL(Boss3X3), Lib.RANDOM(30) + Boss3Y3, Colour);
     Delay(10);
     NoSound;
  END;
END KillBoss3;

PROCEDURE DrawBullet8Boss;
BEGIN
    Line (PlaneX + (PlaneWidth DIV 2), PlaneY-1, PlaneX + (PlaneWidth DIV 2), 0, White);
    Line (PlaneX + (PlaneWidth DIV 2)-1, PlaneY-1, PlaneX + (PlaneWidth DIV 2), 0, LightBlue);
    Line (PlaneX + (PlaneWidth DIV 2)+1, PlaneY-1, PlaneX + (PlaneWidth DIV 2), 0, LightBlue);
    IF (PlaneX>(Boss3X3-30)) AND (PlaneX<(Boss3X3+80)) THEN
       HurtBoss3;
    END;
END DrawBullet8Boss;

PROCEDURE Boss3;
VAR
  Boss3Move : INTEGER;
CONST
    BossDive = 20;
    Boss3YTop = 20;
BEGIN
    Boss3Lives := 80; GameOver := FALSE; ScreenComplete := FALSE;
    ALLOCATE (BkAddress, MAX(CARDINAL));
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlanet (160, 100, PlanetRadius);
    Rectangle (1, 1, 318, 9, Black, TRUE);
    Rectangle (1, 1, Boss3Lives*4, 9, Red, TRUE);
    Rectangle (0, 0, 319, 10, White, FALSE);
    Graph.GetImage (0, 0, 320, 200, BkAddress);
    Boss3X3 := 160;
    BossDiving := FALSE;
    FOR Boss3Y3 := 200 TO Boss3YTop BY -(BossDive) DO
        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
        DrawBoss3 (Boss3X3, Boss3Y3);
    END;
    WHILE NOT (GameOver) AND NOT (ScreenComplete) DO
          IF NOT (GameOver) AND NOT (ScreenComplete) THEN
             Delay (GameSpeed);
             Boss3Move := Lib.RANDOM(5)+1;
             Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
             DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
             IF (PlaneX<Boss3X3) THEN
                Boss3X3 := Boss3X3 - Boss3Move
             ELSIF (PlaneX>Boss3X3) THEN
                Boss3X3 := Boss3X3 + Boss3Move;
             END;
             DrawBoss3 (Boss3X3, Boss3Y3);
             CheckMouse;
             IF (BulletY=5) THEN
                BulletY := 0;
                DrawBullet8Boss;
             END;
             DrawStars8;
             IF (PlaneX>Boss3X3-10) AND (PlaneX<=Boss3X3+50) THEN
                Boss3Y3 := Boss3YTop; BossDiving := TRUE;
                WHILE (Boss3Y3<170) AND NOT (GameOver) AND NOT (ScreenComplete) DO
                  IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                    Boss3Y3 := Boss3Y3 + BossDive;
                    Delay (GameSpeed);
                    Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                    DrawBoss3 (Boss3X3, Boss3Y3);
                    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
                    CheckMouse;
                    IF (BulletY=5) THEN
                       BulletY := 0;
                       DrawBullet8Boss;
                    END;
                    DrawStars8;
                    IF (Boss3Y3>140) AND (PlaneX>Boss3X3-35) AND (PlaneX<(Boss3X3+85)) THEN
                       Die;
                    END;
                  END;
                END;
                Boss3Y3 := 180;
                WHILE (Boss3Y3>Boss3YTop) AND NOT (GameOver) AND NOT (ScreenComplete) DO
                  IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                    Boss3Y3 := Boss3Y3 - BossDive;
                    Delay (GameSpeed);
                    Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                    DrawBoss3 (Boss3X3, Boss3Y3);
                    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
                    CheckMouse;
                    IF (BulletY=5) THEN
                       BulletY := 0;
                       DrawBullet8Boss;
                    END;
                    DrawStars8;
                    IF (Boss3Y3>140) AND ((PlaneX>(Boss3X3-35)) AND (PlaneX<(Boss3X3+85))) THEN
                       Die;
                    END;
                  END;
                END;
             END;
             BossDiving := FALSE;
          END;
    END;
    IF (ScreenComplete) THEN
       KillBoss3;
       FinishScreenBoss3;
    END;
    IF (GameOver) THEN
       DrawGameOver;
    END;
    DEALLOCATE (BkAddress, MAX(CARDINAL));
    IF (ScreenComplete) AND (Lives>0) THEN
       Lives := Lives - 1;
    END;
END Boss3;

PROCEDURE WritePlayExobius(x,y,Width : CARDINAL);
BEGIN
    Line (x+Width*59 DIV 150,y+Width*120 DIV 150,x+Width*79 DIV 150,y+Width*133 DIV 150,Red);
    Line (x+Width*41 DIV 150,y+Width*120 DIV 150,x+Width*21 DIV 150,y+Width*133 DIV 150,DarkRed);
    Line (x+Width*42 DIV 150,y+Width*122 DIV 150,x+Width*40 DIV 150,y+Width*127 DIV 150,Blue);
    Line (x+Width*42 DIV 150,y+Width*122 DIV 150,x+Width*44 DIV 150,y+Width*124 DIV 150,Blue);
    Line (x+Width*44 DIV 150,y+Width*124 DIV 150,x+Width*42 DIV 150,y+Width*125 DIV 150,Blue);
    Line (x+Width*46 DIV 150,y+Width*123 DIV 150,x+Width*45 DIV 150,y+Width*127 DIV 150,Blue);
    Line (x+Width*47 DIV 150,y+Width*127 DIV 150,x+Width*46 DIV 150,y+Width*127 DIV 150,Blue);
    Line (x+Width*50 DIV 150,y+Width*127 DIV 150,x+Width*51 DIV 150,y+Width*123 DIV 150,Blue);
    Line (x+Width*54 DIV 150,y+Width*127 DIV 150,x+Width*52 DIV 150,y+Width*123 DIV 150,Blue);
    Line (x+Width*51 DIV 150,y+Width*123 DIV 150,x+Width*53 DIV 150,y+Width*125 DIV 150,Blue);
    Line (x+Width*55 DIV 150,y+Width*123 DIV 150,x+Width*57 DIV 150,y+Width*125 DIV 150,Blue);
    Line (x+Width*57 DIV 150,y+Width*125 DIV 150,x+Width*58 DIV 150,y+Width*123 DIV 150,Blue);
    Line (x+Width*58 DIV 150,y+Width*123 DIV 150,x+Width*59 DIV 150,y+Width*127 DIV 150,Blue);
    Line (x+Width*35 DIV 150,y+Width*132 DIV 150,x+Width*31 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*35 DIV 150,y+Width*132 DIV 150,x+Width*37 DIV 150,y+Width*132 DIV 150,LightBlue);
    Line (x+Width*36 DIV 150,y+Width*135 DIV 150,x+Width*33 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*31 DIV 150,y+Width*138 DIV 150,x+Width*35 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*39 DIV 150,y+Width*132 DIV 150,x+Width*40 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*42 DIV 150,y+Width*132 DIV 150,x+Width*36 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*45 DIV 150,y+Width*132 DIV 150,x+Width*43 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*43 DIV 150,y+Width*136 DIV 150,x+Width*44 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*44 DIV 150,y+Width*137 DIV 150,x+Width*46 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*46 DIV 150,y+Width*135 DIV 150,x+Width*46 DIV 150,y+Width*132 DIV 150,LightBlue);
    Line (x+Width*48 DIV 150,y+Width*132 DIV 150,x+Width*48 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*48 DIV 150,y+Width*138 DIV 150,x+Width*51 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*51 DIV 150,y+Width*137 DIV 150,x+Width*49 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*49 DIV 150,y+Width*135 DIV 150,x+Width*51 DIV 150,y+Width*133 DIV 150,LightBlue);
    Line (x+Width*51 DIV 150,y+Width*133 DIV 150,x+Width*48 DIV 150,y+Width*132 DIV 150,LightBlue);
    Line (x+Width*55 DIV 150,y+Width*132 DIV 150,x+Width*55 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*58 DIV 150,y+Width*132 DIV 150,x+Width*60 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*61 DIV 150,y+Width*137 DIV 150,x+Width*61 DIV 150,y+Width*132 DIV 150,LightBlue);
    Line (x+Width*66 DIV 150,y+Width*132 DIV 150,x+Width*64 DIV 150,y+Width*133 DIV 150,LightBlue);
    Line (x+Width*64 DIV 150,y+Width*133 DIV 150,x+Width*67 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*67 DIV 150,y+Width*135 DIV 150,x+Width*64 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*68 DIV 150,y+Width*132 DIV 150,x+Width*69 DIV 150,y+Width*135 DIV 150,LightBlue);
    Plot (x+Width*70 DIV 150,y+Width*137 DIV 150,LightBlue);
END WritePlayExobius;

PROCEDURE DrawBoss4 (x, y, Width : CARDINAL);
BEGIN
    Disc (x+Width*50 DIV 150,y+Width*50 DIV 150,Width*50 DIV 150,Red);
    Disc (x+Width*51 DIV 150,y+Width*49 DIV 150,Width*48 DIV 150,LightRed);
    Disc (x+Width*52 DIV 150,y+Width*48 DIV 150,Width*46 DIV 150,LightestRed);
    Xs[0] := x+Width*93 DIV 150; Ys[0] := y+Width*24 DIV 150; Xs[1] := x+Width*88 DIV 150; Ys[1] := y+Width*2 DIV 150; Xs[2] := x+Width*80 DIV 150; Ys[2] := y+Width*9 DIV 150;
    Polygon (3, Xs, Ys, LightRed);
    Xs[0] := x+Width*7 DIV 150; Ys[0] := y+Width*24 DIV 150; Xs[1] := x+Width*12 DIV 150; Ys[1] := y+Width*2 DIV 150; Xs[2] := x+Width*20 DIV 150; Ys[2] := y+Width*10 DIV 150;
    Polygon (3, Xs, Ys, LightRed);
    Xs[0] := x+Width*90 DIV 150; Ys[0] := y+Width*20 DIV 150; Xs[1] := x+Width*87 DIV 150; Ys[1] := y+Width*6 DIV 150; Xs[2] := x+Width*82 DIV 150; Ys[2] := y+Width*11 DIV 150;
    Polygon (3, Xs, Ys, Red);
    Xs[0] := x+Width*10 DIV 150; Ys[0] := y+Width*21 DIV 150; Xs[1] := x+Width*12 DIV 150; Ys[1] := y+Width*6 DIV 150; Xs[2] := x+Width*19 DIV 150; Ys[2] := y+Width*12 DIV 150;
    Polygon (3, Xs, Ys, Red);
    Ellipse (x+Width*51 DIV 150,y+Width*74 DIV 150,Width*27 DIV 150,Width*10 DIV 150,Black,TRUE);
    Disc (x+Width*32 DIV 150,y+Width*30 DIV 150,Width*7 DIV 150,Black);
    Disc (x+Width*68 DIV 150,y+Width*30 DIV 150,Width*7 DIV 150,Black);
    Disc (x+Width*48 DIV 150,y+Width*50 DIV 150,Width*6 DIV 150,Black);
    Disc (x+Width*52 DIV 150,y+Width*50 DIV 150,Width*6 DIV 150,Black);
    Plot (x+Width*47 DIV 150,y+Width*50 DIV 150,Black);
    Plot (x+Width*53 DIV 150,y+Width*50 DIV 150,Black);
    Line (x+Width*50 DIV 150,y+Width*23 DIV 150,x+Width*50 DIV 150,y+Width*5 DIV 150,DarkestYellow);
    Line (x+Width*44 DIV 150,y+Width*25 DIV 150,x+Width*38 DIV 150,y+Width*17 DIV 150,DarkestYellow);
    Line (x+Width*38 DIV 150,y+Width*17 DIV 150,x+Width*30 DIV 150,y+Width*12 DIV 150,DarkestYellow);
    Line (x+Width*55 DIV 150,y+Width*26 DIV 150,x+Width*62 DIV 150,y+Width*17 DIV 150,DarkestYellow);
    Line (x+Width*62 DIV 150,y+Width*17 DIV 150,x+Width*71 DIV 150,y+Width*12 DIV 150,DarkestYellow);
    Line (x+Width*12 DIV 150,y+Width*42 DIV 150,x+Width*33 DIV 150,y+Width*51 DIV 150,15);
    Line (x+Width*33 DIV 150,y+Width*51 DIV 150,x+Width*6 DIV 150,y+Width*51 DIV 150,15);
    Line (x+Width*33 DIV 150,y+Width*51 DIV 150,x+Width*13 DIV 150,y+Width*58 DIV 150,15);
    Line (x+Width*69 DIV 150,y+Width*51 DIV 150,x+Width*96 DIV 150,y+Width*51 DIV 150,15);
    Line (x+Width*69 DIV 150,y+Width*51 DIV 150,x+Width*91 DIV 150,y+Width*42 DIV 150,15);
    Line (x+Width*90 DIV 150,y+Width*58 DIV 150,x+Width*69 DIV 150,y+Width*51 DIV 150,15);
    Circle (x+Width*47 DIV 150,y+Width*50 DIV 150,Width*1 DIV 150,21);
    Circle (x+Width*53 DIV 150,y+Width*50 DIV 150,Width*1 DIV 150,21);
    Line (x+Width*43 DIV 150,y+Width*101 DIV 150,x+Width*43 DIV 150,y+Width*119 DIV 150,DarkRed);
    Line (x+Width*57 DIV 150,y+Width*101 DIV 150,x+Width*57 DIV 150,y+Width*119 DIV 150,DarkRed);
    Line (x+Width*44 DIV 150,y+Width*101 DIV 150,x+Width*44 DIV 150,y+Width*119 DIV 150,Red);
    Line (x+Width*56 DIV 150,y+Width*101 DIV 150,x+Width*56 DIV 150,y+Width*119 DIV 150,Red);
    Rectangle (x+Width*45 DIV 150,y+Width*101 DIV 150,x+Width*48 DIV 150,y+Width*119 DIV 150,LightRed,TRUE);
    Rectangle (x+Width*54 DIV 150,y+Width*101 DIV 150,x+Width*55 DIV 150,y+Width*119 DIV 150,LightRed,TRUE);
    Rectangle (x+Width*49 DIV 150,y+Width*101 DIV 150,x+Width*54 DIV 150,y+Width*119 DIV 150,LightestRed,TRUE);
    Line (x+Width*50 DIV 150,y+Width*101 DIV 150,x+Width*50 DIV 150,y+Width*119 DIV 150,LightRed);
    Line (x+Width*53 DIV 150,y+Width*101 DIV 150,x+Width*53 DIV 150,y+Width*119 DIV 150,LightRed);
    Xs[0] := x+Width*43 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*23 DIV 150; Ys[1] := y+Width*145 DIV 150; Xs[2] := x+Width*77 DIV 150; Ys[2] := y+Width*145 DIV 150; Xs[3] := x+Width*57 DIV 150; Ys[3] := y+Width*120 DIV 150;
    Polygon (4, Xs, Ys, 40);
    Xs[0] := x+Width*58 DIV 150; Ys[0] := y+Width*120 DIV 150;
    Polygon (1, Xs, Ys, 40);
    Xs[0] := x+Width*58 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*77 DIV 150; Ys[1] := y+Width*144 DIV 150; Xs[2] := x+Width*79 DIV 150; Ys[2] := y+Width*134 DIV 150;
    Polygon (3, Xs, Ys, 40);
    Xs[0] := x+Width*42 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*23 DIV 150; Ys[1] := y+Width*144 DIV 150; Xs[2] := x+Width*21 DIV 150; Ys[2] := y+Width*134 DIV 150;
    Polygon (3, Xs, Ys, 40);
    WritePlayExobius(x,y,Width);
END DrawBoss4;

PROCEDURE KillBoss4;
VAR
  Explosions, Colour : CARDINAL;
BEGIN
 PlaneY := 175;
 WHILE (PlaneY>10) DO
     PlaneY := PlaneY - 1;
     Sound (Lib.RANDOM(15) + 20);
    FOR Explosions := 1 TO 50 DO
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
        |10 : Colour := LightestYellow
     END;
     Ellipse (Lib.RANDOM(320), Lib.RANDOM(200), Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
     Plot (Lib.RANDOM(320), Lib.RANDOM(200), Colour);
    END;
     IF (PlaneX<155) THEN
        PlaneX := PlaneX + 5;
     END;
     IF (PlaneX>155) THEN
        PlaneX := PlaneX - 5;
     END;
     DrawPlane (PlaneX, PlaneY, PlaneY DIV 3, PlaneY DIV 2);
     Delay (40);
     NoSound;
 END; (* WHILE *)
 ScreenComplete := TRUE;
END KillBoss4;

PROCEDURE Boss4;
CONST
        SpitMovement = 2;
        SpitHitY = 180;
        MouthY = 100;
        MouthX = 160;
VAR
  SpitX, SpitY, Boss4X, Boss4Y, Boss4Width, BossLives : CARDINAL;
BEGIN
    ScreenComplete := FALSE;
    ALLOCATE (BkAddress, MAX(CARDINAL));
    Rectangle (PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkRed, TRUE);
    Graph.GetImage (0, 0, 320, 200, BkAddress);
    FOR Boss4Width := 1 TO 150 BY 3 DO
        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
        DrawBoss4 ((160-Boss4Width DIV 2), (100-Boss4Width DIV 2), Boss4Width);
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
        CheckMouse;
    END;
    Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
    DrawBoss4 ((160-Boss4Width DIV 2), (100-Boss4Width DIV 2), Boss4Width);
    Graph.GetImage (0, 0, 320, 200, BkAddress);

(****************************************************************)

        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
        CheckMouse;
        DrawPlane (PlaneX, PlaneY, Width, Height);
        DrawBullet;
        IF (BulletY  > 99) THEN
                BulletY := BulletY - 1;
        END;
        BossLives := 10;
        Rectangle (0, 0, 319, 10, White, FALSE);
        Rectangle (1, 1, 318, 9, Black, TRUE);
        WHILE NOT GameOver AND NOT ScreenComplete DO
          IF NOT GameOver AND NOT ScreenComplete THEN
                 SpitY := MouthY;
                 SpitX := MouthX;
                 Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                 Rectangle (1, 1, 318, 9, Black, TRUE);
                 Rectangle (1, 1, BossLives*32, 9, Red, TRUE);
                 Rectangle (0, 0, 319, 10, White, FALSE);
                 Graph.GetImage (0, 0, 320, 200, BkAddress);
                 WHILE (SpitY < 200) AND NOT ScreenComplete DO
                        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                        Graph.GetImage (0, 0, 320, 200, BkAddress);
                        IF ((PlaneX+PlaneWidth DIV 2)>INTEGER(SpitX)) THEN
                           SpitX := SpitX + Lib.RANDOM(10) + 20
                        ELSE
                           IF (SpitX>10) THEN
                              SpitX := SpitX - Lib.RANDOM(25)
                           ELSE
                              SpitX := 2;
                           END;
                        END;
                        Ellipse (SpitX, SpitY, (SpitY - MouthY)*4 DIV 15, (SpitY - MouthY)*2 DIV 15, Blue, TRUE);
                        Ellipse (SpitX, SpitY, (SpitY + 1 - MouthY)*4 DIV 15, (SpitY + 2 - MouthY)*2 DIV 15, LightestBlue, FALSE);
                        IF (SpitY > SpitHitY) AND (PlaneX + (PlaneWidth DIV 2) > INTEGER(SpitX-30)) AND (PlaneX + (PlaneWidth DIV 2) < INTEGER(SpitX + 30)) THEN
                                Die;
                        END;
                        CheckMouse;
                        DrawPlane (PlaneX, PlaneY, Width, Height);
                        DrawBullet;
                        IF (BulletY  < 6) AND (BulletY > 0) THEN
                                BulletY := BulletY - 1;
                        END;
                        IF (BulletX > 100) AND (BulletX < 180) AND (BulletY < 3) THEN
                                Rectangle (0, 0, 320, 200, LightestWhite, TRUE);
                                BossLives := BossLives - 1;
                                BulletY := 50;
                                Delay (5);
                                Score := Score + 150;
                        END;
                        IF (BossLives = 0) THEN
                                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                                KillBoss4;
                                ScreenComplete := TRUE;
                        END;
                        Delay (GameSpeed);
                        SpitY := SpitY + 1 + (SpitY - MouthY) DIV 2;
                END;    (* This "END" From SpitY < 200 Check. *)
          END;          (* This "END" From ScreenComplete FOR Loop. *)
        END;            (* This "END" From ScreenComplete WHILE Loop. *)
        IF GameOver THEN
           G(110, 30); A(140, 30); M(170, 30); E(200, 30);
           O(110, 60); V(140, 60); E(170, 60); R(200, 60);
           Key := IO.RdKey();
        END;
        DEALLOCATE (BkAddress, MAX(CARDINAL));
END Boss4;

END Bosses.

