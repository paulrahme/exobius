IMPLEMENTATION MODULE Screens;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT
    Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius;

FROM Graph IMPORT
    SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon,
    Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point, GetImage, PutImage;

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
    DrawBullet, DrawPlane, CheckMouse, CheckMouseAndSpecialKeys, CheckKeyboard, Die,
    A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
    FinishScreen1, Key, PlaneXMove, CheckDeath1, Score, Screen,
    PlaneAddress, BkAddress, BkSize, ClearTheBuffer, Cheat,
    MouseOrNot, GraphicsCard, HighDetail;

FROM Sprites IMPORT
    DrawBoomGuards, DrawSpinners, DrawFlyTraps, DrawMaces, DrawPlants,
    DrawIceRocks, DrawSnowMen, DrawSnowBalls, DrawSkiiers, DrawGlowWorms;

VAR
    HitCounts, EnemyX, OldBulletX, OldBulletY : CARDINAL;

PROCEDURE DrawGameOverSign;
BEGIN
    ClearTheBuffer;
    G(110, 30); A(140, 30); M(170, 30); E(200, 30);
    O(110, 60); V(140, 60); E(170, 60); R(200, 60);
    Key := IO.RdKey();
END DrawGameOverSign;

PROCEDURE BlankGround1;
BEGIN
    Graph.PutImage (0, 100, GroundAddress, Graph._GPSET);
END BlankGround1;

PROCEDURE DrawEnemies1;
BEGIN
  Enemy1X := 160 - ((10+(3*(EnemyY-100) DIV 2)) DIV 1);
  Enemy2X := 160 - ((10+(3*(EnemyY-100) DIV 2))*2 DIV 3);
  Enemy3X := 160 - ((10+(3*(EnemyY-100) DIV 2)) DIV 3);
  Enemy4X := 160;
  Enemy5X := 160 + ((10+(3*(EnemyY-100) DIV 2)) DIV 3);
  Enemy6X := 160 + ((10+(3*(EnemyY-100) DIV 2))*2 DIV 3);
  IF OneAlive THEN
     CASE Enemies OF
       | 1 : DrawBoomGuards (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSpinners (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawPlants (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawFlyTraps (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSpinners (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawSpinners (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF TwoAlive THEN
     CASE Enemies OF
       | 1 : DrawBoomGuards (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSpinners (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawPlants (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawFlyTraps (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSpinners (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawPlants (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSpinners (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 9 : DrawSpinners (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       |10 : DrawSpinners (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF ThreeAlive THEN
     CASE Enemies OF
       | 1 : DrawBoomGuards (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSpinners (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawPlants (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawFlyTraps (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSpinners (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawPlants (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSpinners (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 9 : DrawSpinners (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       |10 : DrawSpinners (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF FourAlive THEN
     CASE Enemies OF
       | 1 : DrawBoomGuards (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSpinners (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawPlants (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawFlyTraps (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSpinners (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawPlants (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSpinners (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 9 : DrawSpinners (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       |10 : DrawSpinners (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF FiveAlive THEN
     CASE Enemies OF
       | 1 : DrawBoomGuards (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSpinners (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawPlants (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawFlyTraps (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSpinners (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawPlants (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSpinners (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 9 : DrawSpinners (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       |10 : DrawSpinners (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF SixAlive THEN
     CASE Enemies OF
       | 1 : DrawBoomGuards (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSpinners (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawPlants (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawFlyTraps (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSpinners (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawPlants (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSpinners (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 9 : DrawSpinners (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       |10 : DrawSpinners (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
END DrawEnemies1;

PROCEDURE Screen1;
CONST
  MountY = 140;
VAR
  GroundDots, MtPointX, MtPointY, MountX, MtRadius, DotX, DotY,
     LineSpeed, LineXEnd, LineY, GroundLines, GroundLineX : CARDINAL;
  LineXStart : INTEGER;

BEGIN
  Screen := 1;
  Lives := 0;
  GameOver := FALSE;
  BulletY := 0;
  PlaneX := 145;
  EnemyY := 100;
  SetClipRgn (0, 0, 320, 101);
  Rectangle (0,0,320,15,176,TRUE);
  Rectangle (0,16,319,30,104,TRUE);
  Rectangle (0,31,319,45,1,TRUE);
  Rectangle (0,46,319,60,55,TRUE);
  Rectangle (0,61,319,75,80,TRUE);
  Line (0,13,320,13,104);
  Line (0,10,319,10,104);
  Line (0,5,319,5,104);
  Line (0,17,319,17,176);
  Line (0,20,319,20,176);
  Line (0,29,319,29,1);
  Line (0,26,319,26,1);
  Line (0,32,319,32,104);
  Line (0,35,319,35,104);
  Line (0,44,319,44,55);
  Line (0,41,319,41,55);
  Line (0,47,319,47,1);
  Line (0,50,319,50,1);
  Line (0,59,320,59,80);
  Line (0,56,320,56,80);
  Line (0,62,319,62,55);
  Line (0,65,320,65,55);
  Rectangle (0,76,319,90,29,TRUE);
  Line (0,74,320,74,29);
  Line (0,71,319,71,29);
  Line (0,77,319,77,80);
  Line (0,80,320,80,80);
  Rectangle (0,91,319,100,30,TRUE);
  Line (0,89,319,89,30);
  Line (0,86,319,86,30);
  Line (0,92,319,92,29);
  Line (0,95,320,95,29);
  FOR Count := 1 TO 25 DO
     MountX := Lib.RANDOM(320);
     MtRadius := Lib.RANDOM(50) + 40;
     Graph.TrueDisc (MountX, MountY, MtRadius, DarkestBrown);
     Ellipse (MountX, MountY, MtRadius - (MtRadius*2 DIV 9), MtRadius, DarkBrown, TRUE);
     Ellipse (MountX, MountY, MtRadius - (MtRadius*3 DIV 9), MtRadius, Brown, FALSE);
     Ellipse (MountX, MountY, MtRadius - (MtRadius*7 DIV 18),MtRadius, Brown, FALSE);
     Ellipse (MountX, MountY, MtRadius - (MtRadius*4 DIV 9), MtRadius, Brown, TRUE);
     Ellipse (MountX, MountY, MtRadius - (MtRadius*5 DIV 9), MtRadius, LightBrown, FALSE);
     Ellipse (MountX, MountY, MtRadius -(MtRadius*11 DIV 18),MtRadius, LightBrown, FALSE);
     Ellipse (MountX, MountY, MtRadius - (MtRadius*2 DIV 3), MtRadius, LightBrown, TRUE);
     Ellipse (MountX, MountY, MtRadius - (MtRadius*7 DIV 9), MtRadius, LightestBrown, FALSE);
     Ellipse (MountX, MountY, MtRadius -(MtRadius*15 DIV 18), MtRadius, LightestBrown, FALSE);
     Ellipse (MountX, MountY, MtRadius - (MtRadius*8 DIV 9), MtRadius, LightestBrown, TRUE);
  END;
  MountX := 160;
  MtRadius := 70;
  Graph.TrueDisc (MountX, MountY, MtRadius, DarkestBrown);
  Ellipse (MountX, MountY, MtRadius - (MtRadius*2 DIV 9), MtRadius, DarkBrown, TRUE);
  Ellipse (MountX, MountY, MtRadius - (MtRadius*3 DIV 9), MtRadius, Brown, FALSE);
  Ellipse (MountX, MountY, MtRadius - (MtRadius*7 DIV 18),MtRadius, Brown, FALSE);
  Ellipse (MountX, MountY, MtRadius - (MtRadius*4 DIV 9), MtRadius, Brown, TRUE);
  Ellipse (MountX, MountY, MtRadius - (MtRadius*5 DIV 9), MtRadius, LightBrown, FALSE);
  Ellipse (MountX, MountY, MtRadius -(MtRadius*11 DIV 18),MtRadius, LightBrown, FALSE);
  Ellipse (MountX, MountY, MtRadius - (MtRadius*2 DIV 3), MtRadius, LightBrown, TRUE);
  Ellipse (MountX, MountY, MtRadius - (MtRadius*7 DIV 9), MtRadius, LightestBrown, FALSE);
  Ellipse (MountX, MountY, MtRadius -(MtRadius*15 DIV 18), MtRadius, LightestBrown, FALSE);
  Ellipse (MountX, MountY, MtRadius - (MtRadius*8 DIV 9), MtRadius, LightestBrown, TRUE);
  SetClipRgn (0, 0, 320, 200);
  FOR Count := 1 TO 4000 DO
      MtPointX := Lib.RANDOM(320);
      MtPointY := Lib.RANDOM(50) + 50;
      IF (Graph.Point(MtPointX, MtPointY) = LightestBrown) OR (Graph.Point(MtPointX, MtPointY) = LightBrown) OR (Graph.Point(MtPointX, MtPointY) = Brown) OR (Graph.Point(MtPointX, MtPointY) = DarkBrown) OR (Graph.Point(MtPointX, MtPointY) = DarkestBrown) THEN
         Plot (MtPointX, MtPointY, Lib.RANDOM(7) + 16);
      END;
  END;
  Rectangle (0, 100, 320, 200, LightGreen, TRUE);
  FOR Count := 1 TO 1000 DO
     Plot (Lib.RANDOM(320), Lib.RANDOM(25) + 100, DarkestGreen);
     Plot (Lib.RANDOM(320), Lib.RANDOM(40) + 100, DarkestGreen);
     Plot (Lib.RANDOM(320), Lib.RANDOM(40) + 120, DarkGreen);
     Plot (Lib.RANDOM(320), Lib.RANDOM(40) + 140, Green);
     Plot (Lib.RANDOM(320), Lib.RANDOM(40) + 160, LightestGreen);
  END;
  Xs[0] := 0; Xs[1] := 150; Xs[2] := 170; Xs[3] := 320;
  Ys[0] := 200; Ys[1] := 100; Ys[2] := 100; Ys[3] := 200;
  Polygon (4, Xs, Ys, DarkestBrown);
  Rectangle (150, 87, 170, 100, Black, TRUE);

  (* Screen is now ready; Set up for action *)

  PlaneX := 135; PlaneY := 174; LineSpeed := 156;
  ClearTheBuffer;
  FOR Count := 1 TO 8 DO
     LineXStart := 150; LineXEnd := 170;
     FOR LineY := 100 TO 200 DO
      IF NOT IO.KeyPressed() THEN
        IF (LineY MOD 2 = 0) THEN
           LineXStart := LineXStart - 3;
           LineXEnd := LineXEnd + 3;
           IF (LineXStart < 0) THEN
              LineXStart := 0;
           END;
        END;
        HLine (LineXStart, LineY, LineXEnd, LightestBrown);
        Lib.Delay (LineSpeed);
        HLine (LineXStart, LineY, LineXEnd, DarkestBrown);
        IF (LineSpeed < 3) AND (Count < 6) THEN
           LineSpeed := 4;
        END;
        IF (LineSpeed < 2) AND (Count >= 6) THEN
           LineSpeed := 2;
        END;
        IF (Count <> 3) THEN
           LineSpeed := LineSpeed - 2;
        END;
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
      END;
     END;
  END;
  Polygon (4, Xs, Ys, DarkestBrown);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  Lib.Delay (20);
  Polygon (4, Xs, Ys, Brown);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  Lib.Delay (20);
  Polygon (4, Xs, Ys, DarkestBrown);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  Lib.Delay (20);
  Polygon (4, Xs, Ys, Brown);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  Lib.Delay (20);
  Polygon (4, Xs, Ys, LightBrown);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  Lib.Delay (20);
  Rectangle (0, 101, 320, 200, LightGreen, TRUE);
  Polygon (4, Xs, Ys, Brown);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  Lib.Delay (20);
  Polygon (4, Xs, Ys, LightBrown);
  Line (150, 100, 0, 200, Brown);
  Line (149, 100 ,0, 199, Brown);
  Line (170, 100, 320, 200, DarkBrown);
  Line (171, 100, 320, 199, DarkBrown);
  Line (148, 100, 0, 198, DarkestBrown);
  Line (172, 100, 320, 198, DarkestBrown);
  GroundSize := CARDINAL(Graph.ImageSize (0, 100, 320, 200));
  Storage.ALLOCATE (GroundAddress, GroundSize);
  Graph.GetImage (0, 100, 320, 200, GroundAddress);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  Lib.Delay (20);
  ScreenComplete := FALSE;
  Enemies := 1;

  (* Main Program Starts *)

  MsMouse.Cursor (MsMouse._MS_HIDE);
  MsMouse.GetStatus (MouseButtons);
  MsMouse.GetMotion (MouseMove);
  MouseMove.horiz := 0;
  WHILE NOT GameOver AND NOT ScreenComplete DO
        FOR GroundDots := 1 TO 20 DO
           DotX := Lib.RANDOM (70) + 125;
           DotY := Lib.RANDOM (100) + 100;
           IF (Graph.Point (DotX, DotY) = LightBrown) THEN
              Plot (DotX, DotY, Lib.RANDOM(7) + 16);
              Lib.Delay (GameSpeed);
              Plot (DotX, DotY, LightBrown);
           END;
           CASE MouseOrNot OF
                | 1 : CheckKeyboard;
                | 2 : CheckMouse;
           END;
           IF (PlaneX < PlaneXMin) THEN
              PlaneX := PlaneXMin;
           END;
           IF (PlaneX > PlaneXMax) THEN
              PlaneX := PlaneXMax;
           END;
           BlankGround1;
           IF (HighDetail) THEN
              FOR GroundLines := 1 TO 30 DO
                  GroundLineX := RANDOM(80);
                  Line (GroundLineX DIV 16 + 150, 100, GroundLineX, 200, LightestBrown);
                  Line (GroundLineX DIV 16 + 155, 100, GroundLineX+80, 200, LightestBrown);
                  Line (GroundLineX DIV 16 + 160, 100, GroundLineX+160, 200, LightestBrown);
                  Line (GroundLineX DIV 16 + 165, 100, GroundLineX+240, 200, LightestBrown);
                  GroundLineX := RANDOM(150);
                  Line (GroundLineX, 100, 0, 100 + GroundLineX*3 DIV 5, LightestGreen);
                  Line (320-GroundLineX, 100, 320, 100 + GroundLineX*3 DIV 5, LightestGreen);
                  GroundLineX := RANDOM(150);
                  Line (GroundLineX, 100, 0, 100 + GroundLineX*3 DIV 5, Green);
                  Line (320-GroundLineX, 100, 320, 100 + GroundLineX*3 DIV 5, Green);
                  GroundLineX := RANDOM(80);
                  Line (GroundLineX DIV 16 + 150, 100, GroundLineX, 200, Brown);
                  Line (GroundLineX DIV 16 + 155, 100, GroundLineX+80, 200, Brown);
                  Line (GroundLineX DIV 16 + 160, 100, GroundLineX+160, 200, Brown);
                  Line (GroundLineX DIV 16 + 165, 100, GroundLineX+240, 200, Brown);
              END;
           END;
           DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
           DrawBullet;
           IF (BulletY < 6 ) AND (BulletY > 0) THEN
              BulletY := BulletY - 1;
           END;
           Lib.Delay (GameSpeed);
        END;   (* This "END" from Ground Dots *)
        OneAlive   := TRUE;
        TwoAlive   := TRUE;
        ThreeAlive := TRUE;
        FourAlive  := TRUE;
        FiveAlive  := TRUE;
        SixAlive   := TRUE;
        FOR EnemyY := 101 TO 200 DO
         IF (GameOver=FALSE) AND (ScreenComplete=FALSE) THEN
           CASE MouseOrNot OF
                | 2 : CheckMouse;
                | 1 : CheckKeyboard;
           END;
           BlankGround1;
           IF (HighDetail) THEN
              DrawEnemies1;
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
           END;
           DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
           DrawBullet;
           DrawEnemies1;
           IF (BulletY > 99) THEN
              BulletY := BulletY - 1;
           END;
           IF (EnemyY > CollisionY) THEN
              CheckDeath1;
           END;
           IF (BulletY < 6) AND (BulletY > 0) THEN
              BulletY := BulletY - 1;
           END;
           Lib.Delay (GameSpeed);
         END;                          (* This "END" From IF Statement*)
        END;                      (* This "END" From Enemy Movement. *)
        Enemies := Enemies + 1;
    END;                          (* This "END" From GameOver/ScreenComplete Check. *)
    IF GameOver THEN
       G(110, 30); A(140, 30); M(170, 30); E(200, 30);
       O(110, 60); V(140, 60); E(170, 60); R(200, 60);
       Key := IO.RdKey();
    END;
END Screen1;

PROCEDURE BlowUpEnemy2 (x, y : CARDINAL);
CONST
    SoundDelay = 20;
BEGIN
    Sound(100);
    Disc(x + 10, y + 10, 10, LightestYellow);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(90);
    Disc(x + 10, y + 10, 10, LightYellow);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(80);
    Disc(x + 10, y + 10, 10, Yellow);
    NoSound;
    Sound(70);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, DarkYellow);
    NoSound;
    Sound(60);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, DarkestYellow);
    NoSound;
    Sound(50);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, LightestRed);
    NoSound;
    Sound(40);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, LightRed);
    NoSound;
    Sound(30);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, Red);
    NoSound;
    Sound(25);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, DarkRed);
    NoSound;
    Sound(22);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, DarkestRed);
    NoSound;
    Sound(20);
    Lib.Delay(SoundDelay);
    NoSound;
    Rectangle (x, y, x + 20, y + 35, Black, TRUE);
    Score := Score + 20;
END BlowUpEnemy2;

PROCEDURE UpBullet;
BEGIN
    IF (BulletY < 60000) THEN
        IF (OldBulletX > 0) THEN
            Rectangle(OldBulletX - 1, OldBulletY, OldBulletX + 1, OldBulletY + 16, Black, FALSE);
            Line(OldBulletX, OldBulletY, OldBulletX, OldBulletY + 16, Black);
        END;

        (* Just fired? *)
        IF (BulletY = 5) THEN
            BulletY := 170;
            BulletX := PlaneX + (Width DIV 2);
            OldBulletX := BulletX;
        END;

        (* Reached the top of the screen? Else move upwards *)
        IF (BulletY < 10) THEN
            Rectangle(BulletX - 1, BulletY, BulletX + 1, BulletY + 16, Black, FALSE);
            Line(BulletX, BulletY, BulletX, BulletY + 16, Black);
            BulletY := 65000;
        ELSE
            BulletY := BulletY - 10;
            (* Draw bullet *)
            Rectangle(BulletX - 1, BulletY + 1, BulletX + 1, BulletY + 9, LightBlue, FALSE);
            Line(BulletX, BulletY, BulletX, BulletY + 10, LightWhite);
        END;
        OldBulletY := BulletY;
    END;
END UpBullet;

PROCEDURE Screen2;
CONST
    GlowCount = 18;
    GlowWidth = 20;
    GlowHeight = 30;
VAR
    RoofDots, RoofSize, RectY, NewRectY, FadeCount, FadeCountInc, GlowSize, GlowIdx, GlowsAlive, MoveRnd, GX, GY : CARDINAL;
    GlowAddress, RoofAddress : ADDRESS;
    GlowXs, GlowYs : ARRAY[0..GlowCount] OF CARDINAL;
    OldPlaneX : INTEGER;
BEGIN
    Screen := 2;
    ScreenComplete := FALSE;
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    HitCounts := 0;

    (* Draw cave interior *)
    FOR RoofDots := 1 TO 60000 DO
        Plot (Lib.RANDOM (320), Lib.RANDOM (200), White);
    END;
    FOR RoofDots := 1 TO 20000 DO
        Plot (Lib.RANDOM (240) + 40, Lib.RANDOM (100) + 50, DarkestWhite);
    END;
    FOR RoofDots := 1 TO 5000 DO
        Plot (Lib.RANDOM (180) + 70, Lib.RANDOM (100) + 50, LightGrey);
    END;
    FOR RoofDots := 1 TO 500 DO
        Plot (Lib.RANDOM (60) + 130, Lib.RANDOM (40) + 80, DarkGrey);
    END;
    FOR RoofDots := 1 TO 200 DO
        Plot (Lib.RANDOM (20) + 150, Lib.RANDOM (40) + 80, DarkestGrey);
    END;

    CheckMouseAndSpecialKeys;

    (* Fly in plane *)
    Rectangle (158, 98, 162, 102, Black, TRUE);
    SetClipRgn (0, 0, 320, 199);
    BkSize := CARDINAL(Graph.ImageSize(0, 150, 320, 200));
    Storage.ALLOCATE(BkAddress, BkSize);
    GetImage(0, 150, 320, 200, BkAddress);
    FOR PlaneY := 200 TO 175 BY -1 DO
        PlaneX := 145 - (PlaneY - 175);
        Width := PlaneY - 125;
        Height := Width DIV 2;
        DrawPlane(PlaneX, PlaneY, Width, Height);
        Lib.Delay(50);
        Graph.PutImage(0, 150, BkAddress, Graph._GPSET);
    END;
    Storage.DEALLOCATE(BkAddress, BkSize);
    CheckMouseAndSpecialKeys;

    (* Darken cave *)
    PlaneX := 145; OldPlaneX := PlaneX; PlaneY := 175; Width := 50; Height := 25; BulletY := 65520; RectY := 100;
    FadeCountInc := 1;
    FOR FadeCount := 1 TO 4000 DO
        IF (FadeCount > 2500) THEN
            IF (FadeCountInc < 100) THEN
                FadeCountInc := FadeCountInc + 1;
            END;
            FadeCount := FadeCount + FadeCountInc;
            IF (FadeCount > 4000) THEN
                FadeCount := 4000;
            END;
        END;
        NewRectY := 100 + (FadeCount DIV 40);
        IF (NewRectY > RectY) THEN
            RectY := NewRectY;
            Rectangle(200 - RectY, 200 - RectY, 120 + RectY, RectY, Black, TRUE);
        END;
        IF (NewRectY < 175) THEN
            Disc(Lib.RANDOM(320), Lib.RANDOM(200), 5,  Black);
            IF (FadeCount MOD 20 = 0) THEN
                DrawPlane(PlaneX, PlaneY, Width, Height);
            END;
        ELSE
            IF (RectY MOD 5 = 0) THEN
                DrawPlane(PlaneX, PlaneY, Width, Height);
            END;
        END;
    END;
    GetImage(145, 175, 195, 200, PlaneAddress);
    CheckMouseAndSpecialKeys;

    (* Draw enemies *)
    GlowsAlive := GlowCount;
    FOR GY := 0 TO 2 DO
        FOR GX := 0 TO 5 DO
            GlowIdx := (GY * 6) + GX;
            GlowXs[GlowIdx] := 45 + (GX * 45);
            GlowYs[GlowIdx] := GY * 35;
        END;
    END;
    GlowSize := CARDINAL(Graph.ImageSize(0, 0, GlowWidth, GlowHeight));
    Storage.ALLOCATE(GlowAddress, GlowSize);
    DrawGlowWorms(GlowXs[0], GlowYs[0]);
    GetImage(GlowXs[0], GlowYs[0], GlowXs[0] + GlowWidth, GlowYs[0] + GlowHeight, GlowAddress);

    (* Main game loop *)
    WHILE NOT ScreenComplete AND NOT GameOver DO
       (* Update player *)
        OldPlaneX := PlaneX;
        CASE MouseOrNot OF
             | 2 : CheckMouse;
             | 1 : CheckKeyboard;
        END;
        Rectangle(CARDINAL(OldPlaneX), CARDINAL(PlaneY), CARDINAL(OldPlaneX) + CARDINAL(Width), CARDINAL(PlaneY) + CARDINAL(Height), Black, TRUE);
        DrawPlane(PlaneX, PlaneY, Width, Height);
        UpBullet;

        (* Draw enemies *)
        FOR GlowIdx := 0 TO (GlowCount - 1) DO
            GX := GlowXs[GlowIdx]; GY := GlowYs[GlowIdx];
            (* Enemy alive? *)
            IF (GY < 65000) THEN
                IF (GY > 170) THEN
                    (* At the bottom of the screen - move towards the plane *)
                    IF (GX < CARDINAL(PlaneX)) THEN
                        GX := GX + 1;
                    ELSIF (GX > CARDINAL(PlaneX) + PlaneWidth) THEN
                        GX := GX - 1;
                    END;
                ELSE
                    MoveRnd := Lib.RANDOM(12);
                    IF ((MoveRnd = 1) OR (MoveRnd = 2)) AND NOT (GX > 280) THEN
                        GX := GX + 1;
                    ELSIF ((MoveRnd = 3) OR (MoveRnd = 4)) AND (GX > 20) THEN
                        GX := GX - 1;
                    END;
                    IF (MoveRnd = 5) THEN
                        HLine(GX, GY, GX + GlowWidth, Black);
                        GY := GY + 1;
                    END;
                END;

                PutImage(GX, GY, GlowAddress, Graph._GPSET);
                Plot(GX + 5 + Lib.RANDOM(10), GY + 12 + Lib.RANDOM(8), 14);
                Plot(GX + 5 + Lib.RANDOM(10), GY + 12 + Lib.RANDOM(8), 68);

                (* Hit by bullet? *)
                IF (BulletY < GY + 10) AND (BulletX > GX) AND (BulletX < GX + GlowWidth) THEN
                    BlowUpEnemy2(GX, GY);
                    BulletY := 65000;
                    GY := 65000;
                    GlowsAlive := GlowsAlive - 1;
                (* Hit player? *)
                ELSIF (GY > PlaneY - 25) AND (INTEGER(GX) > PlaneX - 15) AND (INTEGER(GX) < PlaneX + PlaneWidth + 15) THEN
                    Disc(GX + (GlowWidth DIV 2), GY + (GlowHeight DIV 2), 10, DarkestRed);
                    OldPlaneX := PlaneX;
                    Die;
                    IF NOT GameOver THEN
                        Rectangle(CARDINAL(OldPlaneX), CARDINAL(PlaneY), CARDINAL(OldPlaneX) + CARDINAL(Width), CARDINAL(PlaneY) + CARDINAL(Height), Black, TRUE);
                        Rectangle(GX, GY, GX + GlowWidth, GY + GlowHeight, Black, TRUE);
                        GY := 65000;
                        GlowsAlive := GlowsAlive - 1;
                    END;
                END;
            END;
            GlowXs[GlowIdx] := GX; GlowYs[GlowIdx] := GY;
        END;
        IF (GlowsAlive = 0) THEN
            ScreenComplete := TRUE;
        END;
    END; (* Main game loop *)

    Storage.DEALLOCATE(GlowAddress, GlowSize);

    IF GameOver THEN
        G(110, 30); A(140, 30); M(170, 30); E(200, 30);
        O(110, 60); V(140, 60); E(170, 60); R(200, 60);
        Key := IO.RdKey();
    END;
END Screen2;

PROCEDURE DrawEnemies3;
BEGIN
  Enemy1X := 160 - ((10+(3*(EnemyY-100) DIV 2)) DIV 1);
  Enemy2X := 160 - ((10+(3*(EnemyY-100) DIV 2))*2 DIV 3);
  Enemy3X := 160 - ((10+(3*(EnemyY-100) DIV 2)) DIV 3);
  Enemy4X := 160;
  Enemy5X := 160 + ((10+(3*(EnemyY-100) DIV 2)) DIV 3);
  Enemy6X := 160 + ((10+(3*(EnemyY-100) DIV 2))*2 DIV 3);
  IF OneAlive THEN
     CASE Enemies OF
       | 1 : DrawIceRocks (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSnowMen (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawSnowBalls (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawSkiiers (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSnowMen (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawSnowBalls (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSnowMen (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF TwoAlive THEN
     CASE Enemies OF
       | 1 : DrawIceRocks (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSnowMen (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawSnowBalls (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawSkiiers (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSnowMen (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawSnowBalls (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSnowMen (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF ThreeAlive THEN
     CASE Enemies OF
       | 1 : DrawIceRocks (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSnowMen (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawSnowBalls (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawSkiiers (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSnowMen (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawSnowBalls (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSnowMen (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF FourAlive THEN
     CASE Enemies OF
       | 1 : DrawIceRocks (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSnowMen (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawSnowBalls (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawSkiiers (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSnowMen (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawSnowBalls (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSnowMen (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF FiveAlive THEN
     CASE Enemies OF
       | 1 : DrawIceRocks (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSnowMen (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawSnowBalls (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawSkiiers (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSnowMen (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawSnowBalls (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSnowMen (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
  IF SixAlive THEN
     CASE Enemies OF
       | 1 : DrawIceRocks (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 2 : DrawSnowMen (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 3 : DrawSnowBalls (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 4 : DrawSkiiers (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 5 : DrawSnowMen (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 6 : DrawMaces (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 7 : DrawSnowBalls (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
       | 8 : DrawSnowMen (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
             ScreenComplete := TRUE;
     END;
   END;
END DrawEnemies3;

PROCEDURE DrawSnowFlake (x, y, Width : CARDINAL);
VAR
  FlakeDots : CARDINAL;
BEGIN
    Line (x+Width DIV 2, y, x+Width DIV 2, y+Width, White);
    Line (x, y+Width DIV 3, x+Width, y+Width*2 DIV 3, White);
    Line (x, y+Width*2 DIV 3, x+Width, y+Width DIV 3, White);
    FOR FlakeDots := 1 TO (Width*2) DO
        Plot (x + Lib.RANDOM(Width), y + Lib.RANDOM(Width), White);
    END;
END DrawSnowFlake;

PROCEDURE BlankGround3;
VAR
  SnowFlakes : CARDINAL;
BEGIN
    IF HighDetail THEN
       Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
       FOR SnowFlakes := 1 TO 50 DO
           DrawSnowFlake (Lib.RANDOM(320), Lib.RANDOM(200), Lib.RANDOM(10));
       END
    ELSE
       Rectangle (0, 100, 320, 200, LightestWhite, TRUE);
    END;
END BlankGround3;

PROCEDURE DrawCloud(CloudX, CloudY, Width : CARDINAL);
VAR
  Piece, Ywidth : CARDINAL;
BEGIN
    Ywidth := Width DIV 2;
    FOR Piece := 1 TO 6 DO
        Disc (CloudX + Lib.RANDOM(Width), CloudY + Ywidth*5 DIV 6, Width DIV 3, LightWhite);
    END;
    FOR Piece := 1 TO 4 DO
        Disc (CloudX + Width DIV 4 + Lib.RANDOM(Width), CloudY + Ywidth DIV 2, Width DIV 3, LightWhite);
    END;
    Disc (CloudX + Width DIV 3 + Lib.RANDOM(Width DIV 4), CloudY + Ywidth DIV 6, Width DIV 3, LightWhite);
    Disc (CloudX + Width DIV 3 + Lib.RANDOM(Width DIV 4), CloudY + Ywidth DIV 6, Width DIV 3, LightWhite);
END DrawCloud;

PROCEDURE Screen3;
VAR
  DotX, DotY, GroundDots, RectY, CloudCount : CARDINAL;

BEGIN
   DrawPlane (PlaneX, PlaneY, Width, Height);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 200 - RectY, Black ,TRUE);
   END;
   DrawPlane (PlaneX, PlaneY, Width, Height);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 200 - RectY, Grey ,TRUE);
   END;
   DrawPlane (PlaneX, PlaneY, Width, Height);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 200 - RectY, DarkestWhite ,TRUE);
   END;
   DrawPlane (PlaneX, PlaneY, Width, Height);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 200 - RectY, White ,TRUE);
   END;
   DrawPlane (PlaneX, PlaneY, Width, Height);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 100, LightBlue, TRUE);
       Rectangle (RectY, 100, 320 - RectY, 200 - RectY, LightestWhite ,TRUE);
   END;
   Rectangle (0, 0, 320, 100, LightBlue, TRUE);

   Screen := 3;
   GameOver := FALSE;
   BulletY := 0;
   ScreenComplete := FALSE;
   Enemies := 1;
   EnemyY := 100;
   Storage.ALLOCATE (BkAddress, MAX(CARDINAL));

   (* Main Program Starts *)

   MsMouse.Cursor (MsMouse._MS_HIDE);
   MsMouse.GetStatus (MouseButtons);
   MsMouse.GetMotion (MouseMove);
   MouseMove.horiz := 0;
   FOR CloudCount := 1 TO 5 DO
       DrawCloud (Lib.RANDOM(290), Lib.RANDOM(70), Lib.RANDOM(30));
   END;
   Graph.GetImage (0, 0, 320, 200, BkAddress);
   WHILE NOT GameOver AND NOT ScreenComplete DO
         FOR GroundDots := 1 TO 20 DO
            DotX := Lib.RANDOM (70) + 125;
            DotY := Lib.RANDOM (100) + 100;
            Plot (DotX, DotY, Lib.RANDOM(7) + 16);
            Lib.Delay (GameSpeed);
            Plot (DotX, DotY, LightBlue);
            CASE MouseOrNot OF
                 | 2 : CheckMouse;
                 | 1 : CheckKeyboard;
            END;
            IF (PlaneX < PlaneXMin) THEN
               PlaneX := PlaneXMin;
            END;
            IF (PlaneX > PlaneXMax) THEN
               PlaneX := PlaneXMax;
            END;
            BlankGround3;
            DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
            DrawBullet;
            IF (BulletY < 6 ) AND (BulletY > 0) THEN
               BulletY := BulletY - 1;
            END;
            Lib.Delay (GameSpeed);
         END;   (* This "END" from Ground Dots *)
         OneAlive   := TRUE;
         TwoAlive   := TRUE;
         ThreeAlive := TRUE;
         FourAlive  := TRUE;
         FiveAlive  := TRUE;
         SixAlive   := TRUE;
         FOR EnemyY := 101 TO 200 BY 2 DO
          IF NOT (GameOver) THEN
            CASE MouseOrNot OF
                 | 2 : CheckMouse;
                 | 1 : CheckKeyboard;
            END;
            BlankGround3;
            DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
            DrawBullet;
            DrawEnemies3;
            IF (BulletY > 99) THEN
               BulletY := BulletY - 1;
            END;
            IF (EnemyY > CollisionY) THEN
               CheckDeath1;
            END;
            IF (BulletY < 6) AND (BulletY > 0) THEN
               BulletY := BulletY - 1;
            END;
            Lib.Delay (GameSpeed);
          END;
         END;                      (* This "END" From Enemy Movement. *)
         Enemies := Enemies + 1;
     END;                          (* This "END" From GameOver/ScreenComplete Check. *)
     IF GameOver THEN
        G(110, 30); A(140, 30); M(170, 30); E(200, 30);
        O(110, 60); V(140, 60); E(170, 60); R(200, 60);
        ClearTheBuffer;
        Key := IO.RdKey();
     END;
     Storage.DEALLOCATE (BkAddress, MAX(CARDINAL));
END Screen3;

END Screens.
