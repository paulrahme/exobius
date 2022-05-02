IMPLEMENTATION MODULE Screens6;
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

FROM Sprites IMPORT
  DrawBoomGuards, DrawSpinners, DrawFlyTraps, DrawMaces, DrawPlants,
  DrawIceRocks, DrawSnowMen, DrawSnowBalls, DrawSkiiers, DrawGlowWorms;

PROCEDURE DrawBorders;
VAR
  TunnelDots : CARDINAL;
BEGIN
  Graph.ClearScreen (Graph._GCLEARSCREEN);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  FOR TunnelDots := 1 TO 40 DO
      Plot (RANDOM(320), RANDOM(15), DarkBrown);
      Plot (RANDOM(15), RANDOM(200), DarkBrown);
      Plot (320-RANDOM(15), RANDOM(200), DarkBrown);
      Plot (RANDOM(320), 200-RANDOM(15), DarkBrown);
      IF (TunnelDots MOD 2 = 0) THEN
         Plot (RANDOM(320), RANDOM(23), DarkestBrown);
         Plot (RANDOM(23), RANDOM(200), DarkestBrown);
         Plot (320-RANDOM(23), RANDOM(200), DarkestBrown);
         Plot (RANDOM(320), 200-RANDOM(23), DarkestBrown);
      END;
  END;
END DrawBorders;

PROCEDURE GoStraight;
VAR
  GoingStraight : CARDINAL;
BEGIN
  FOR GoingStraight := 1 TO 100 DO
      IF NOT (GameOver) AND NOT (ScreenComplete) THEN
         CheckMouse;
         DrawBorders;
         CASE (GoingStraight MOD 9) OF
              | 0 : Rectangle (20, 20, 300, 180, DarkestGrey, FALSE);
              | 1 : Rectangle (17, 17, 302, 182, DarkestGrey, FALSE);
              | 2 : Rectangle (15, 15, 305, 185, DarkestGrey, FALSE);
              | 3 : Rectangle (12, 12, 307, 187, DarkestBrown, FALSE);
              | 4 : Rectangle (10, 10, 310, 190, DarkestBrown, FALSE);
              | 5 : Rectangle (7, 7, 312, 192, DarkestBrown, FALSE);
              | 6 : Rectangle (5, 5, 315, 195, DarkBrown, FALSE);
              | 7 : Rectangle (2, 2, 317, 197, DarkBrown, FALSE);
              | 8 : Rectangle (0, 0, 319, 199, Brown, FALSE);
         END;
         DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
         Delay (GameSpeed);
      END;
  END;
END GoStraight;

PROCEDURE SplitInTwo;
VAR
  BrownColour, Split : CARDINAL;
BEGIN
    FOR Split := 1 TO 9 DO
        CASE Split OF
             | 1,2,3 : BrownColour := DarkestGrey;
             | 4,5,6 : BrownColour := DarkestBrown;
             | 7,8,9 : BrownColour := DarkBrown;
        END;
        DrawBorders;
        Line (160, 20 - Split*2, 160, 180 + Split*2, BrownColour);
        CheckMouse;
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
        IF (Graph.Point (PlaneX + 25, PlaneY - 2) <> Black) THEN
           Die;
        END;
        Delay (GameSpeed*5);
    END;
END SplitInTwo;

PROCEDURE GoInTwo;
VAR
  TunnelDots, SplitMove : CARDINAL;
BEGIN
    FOR SplitMove := 1 TO 100 DO
      IF NOT GameOver THEN
        CheckMouse;
        DrawBorders;
        Line (160, 0, 160, 200, Brown);
        FOR TunnelDots := 1 TO 80 DO
            Plot (RANDOM(46) + 137, RANDOM(200), DarkestBrown);
            Plot (RANDOM(20) + 150, RANDOM(200), DarkBrown);
        END;
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
        Delay (GameSpeed);
        IF (PlaneX>125) AND (PlaneX<185) THEN
           Die;
        END;
      END;
    END;
END GoInTwo;

PROCEDURE BlockOffRight;
VAR
  TheFall, TunnelDots : CARDINAL;
BEGIN
    FOR TheFall := 100 TO 200 BY 10 DO
        DrawBorders;
        Rectangle (320 - (TheFall*8 DIV 10), 200 - TheFall, 160 + (TheFall*8 DIV 10), TheFall, Brown, TRUE);
        Line (160, 0, 160, 200, Brown);
        FOR TunnelDots := 1 TO 80 DO
            Plot (RANDOM(46) + 137, RANDOM(200), DarkestBrown);
            Plot (RANDOM(20) + 150, RANDOM(200), DarkBrown);
        END;
        Rectangle (320 - (TheFall*8 DIV 10), 200 - TheFall, 160 + (TheFall*8 DIV 10), TheFall, Brown, TRUE);
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
        Delay (GameSpeed);
        IF (PlaneX>125) AND (PlaneX<185) THEN
           Die;
        END;
    END;
END BlockOffRight;

PROCEDURE LavaFall;
VAR
  FallingSound, TunnelDots, Lines, LineY : CARDINAL;
BEGIN
    FallingSound := 3500;
    Rectangle (160, 0, 320, 200, Brown, TRUE);
    Rectangle (0, 100, 159, 200, Black, TRUE);
    FOR Lines := 1 TO 10 DO
        FOR LineY := 200 TO 0 BY -3 DO
            Sound (FallingSound);
            IF (Lines=1) THEN
               Rectangle (0, LineY, 160, LineY + 5, Brown, TRUE);
            END;
            IF (Lines=2) THEN
               Rectangle (0, 0, 160, 50, Brown, TRUE);
            END;
            Rectangle (0, LineY, 320, LineY + 3, DarkGrey, TRUE);
            Rectangle (0, LineY + 4, 320, LineY + 15, Brown, TRUE);
            DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
            IF (FallingSound>20) THEN
               FallingSound := FallingSound - 8;
            END;
            Delay (2);
            NoSound;
        END;
        Rectangle (0, 0, 320, 50, Brown, TRUE);
    END;
    FOR LineY := 200 TO 0 BY -3 DO
        Rectangle (160, LineY, 320, LineY + 5, Red, TRUE);
        Delay (2);
    END;
    Die;
    FOR Lines := 1 TO 10 DO
        FOR LineY := 1 TO 200 BY 3 DO
            IF (Lines=10) THEN
               Rectangle (0, 0, 160, LineY, Black, TRUE);
            END;
            Rectangle (0, LineY, 320, LineY + 3, DarkGrey, TRUE);
            Rectangle (0, LineY + 4, 320, LineY + 15, Brown, TRUE);
            DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
        END;
        Rectangle (0, 0, 320, 50, Brown, TRUE);
    END;
END LavaFall;

PROCEDURE WindingTunnel;
CONST
    WindingTime = 100;
VAR
  TunnelDots, Wind, LeftSide : CARDINAL;
BEGIN
  LeftSide := 1;
  WHILE (PlaneX <> 65) DO
        Rectangle (PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, Black, TRUE);
        IF PlaneX < 65 THEN
           PlaneX := PlaneX + INTEGER(RANDOM(3))
        ELSIF (PlaneX > 65) THEN
           PlaneX := PlaneX - INTEGER(RANDOM(3));
        END;
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  END;
  PlaneX := 65;
  ClearTheBuffer;
  FOR Wind := 1 TO WindingTime DO
    IF NOT GameOver THEN
      Rectangle (0, 0, LeftSide, 200, Brown, TRUE);
      Rectangle (LeftSide, 0, LeftSide + 160, 200, Black, TRUE);
      Rectangle (LeftSide + 160, 0, 320, 200, Brown, TRUE);
      FOR TunnelDots := 1 TO 40 DO
          Plot (LeftSide + RANDOM(160), RANDOM(15), DarkBrown);
          Plot (LeftSide + RANDOM(15), RANDOM(200), DarkBrown);
          Plot (LeftSide + 160 - RANDOM(15), RANDOM(200), DarkBrown);
          Plot (LeftSide + RANDOM(160), 200-RANDOM(15), DarkBrown);
          IF (TunnelDots MOD 2 = 0) THEN
             Plot (LeftSide + RANDOM(160), RANDOM(23), DarkestBrown);
             Plot (LeftSide + RANDOM(23), RANDOM(200), DarkestBrown);
             Plot (LeftSide + 160 - RANDOM(23), RANDOM(200), DarkestBrown);
             Plot (LeftSide + RANDOM(320), 200-RANDOM(23), DarkestBrown);
          END;
      END;
      CheckMouse;
      DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
      IF (LeftSide<10) THEN
         LeftSide := LeftSide + 10
      ELSIF (LeftSide>150) THEN
         LeftSide := LeftSide - 10;
      END;
      LeftSide := LeftSide + RANDOM(20) - 10;
      Delay (GameSpeed);
      IF (PlaneX < INTEGER(LeftSide+15)) OR (PlaneX > INTEGER(LeftSide + 145)) THEN
         Die;
         PlaneX := LeftSide + 55;
      END;
    END;
  END;
  IF NOT GameOver THEN
     WHILE (LeftSide<>80) DO
        IF (LeftSide<80) THEN
           LeftSide := LeftSide + RANDOM(3)
        ELSIF (LeftSide>80) THEN
           LeftSide := LeftSide - RANDOM(3);
        END;
        Rectangle (0, 0, LeftSide, 200, Brown, TRUE);
        Rectangle (LeftSide, 0, LeftSide + 160, 200, Black, TRUE);
        Rectangle (LeftSide + 160, 0, 320, 200, Brown, TRUE);
        FOR Wind := 1 TO 40 DO
            Plot (LeftSide + RANDOM(160), RANDOM(15), DarkBrown);
            Plot (LeftSide + RANDOM(15), RANDOM(200), DarkBrown);
            Plot (LeftSide + 160 - RANDOM(15), RANDOM(200), DarkBrown);
            Plot (LeftSide + RANDOM(160), 200-RANDOM(15), DarkBrown);
            IF (Wind MOD 2 = 0) THEN
               Plot (LeftSide + RANDOM(160), RANDOM(23), DarkestBrown);
               Plot (LeftSide + RANDOM(23), RANDOM(200), DarkestBrown);
               Plot (LeftSide + 160 - RANDOM(23), RANDOM(200), DarkestBrown);
               Plot (LeftSide + RANDOM(320), 200-RANDOM(23), DarkestBrown);
            END;
        END;
        IF (PlaneX < 145) THEN
           PlaneX := PlaneX + INTEGER(RANDOM(3))
        ELSIF (PlaneX > 145) THEN
           PlaneX := PlaneX - INTEGER(RANDOM(3));
        END;
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
      END;
    FOR LeftSide := 80 TO 0 BY -1 DO
      Rectangle (LeftSide, 0, 320 - LeftSide, 200, Black, TRUE);
        IF (PlaneX < 145) THEN
           PlaneX := PlaneX + INTEGER(RANDOM(3))
        ELSIF (PlaneX > 145) THEN
           PlaneX := PlaneX - INTEGER(RANDOM(3));
        END;
      DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    END;
  END;
END WindingTunnel;

PROCEDURE OpenUpTunnel;
VAR
  RectangleSize, GoingStraight, TunnelDots : CARDINAL;
BEGIN
  RectangleSize := 0;
  FOR GoingStraight := 1 TO 50 DO
      IF NOT (GameOver) AND NOT (ScreenComplete) THEN
         CheckMouse;
         DrawBorders;
         CASE (GoingStraight MOD 9) OF
              | 0 : Rectangle (20, 20, 300, 180, DarkestGrey, FALSE);
              | 1 : Rectangle (17, 17, 302, 182, DarkestGrey, FALSE);
              | 2 : Rectangle (15, 15, 305, 185, DarkestGrey, FALSE);
              | 3 : Rectangle (12, 12, 307, 187, DarkestBrown, FALSE);
              | 4 : Rectangle (10, 10, 310, 190, DarkestBrown, FALSE);
              | 5 : Rectangle (7, 7, 312, 192, DarkestBrown, FALSE);
              | 6 : Rectangle (5, 5, 315, 195, DarkBrown, FALSE);
              | 7 : Rectangle (2, 2, 317, 197, DarkBrown, FALSE);
              | 8 : Rectangle (0, 0, 319, 199, Brown, FALSE);
         END;
         DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
         IF RectangleSize < 98 THEN
            RectangleSize := GoingStraight*2;
         END;
         Rectangle (160 - (RectangleSize * 8 DIV 5), 100, 161 + (RectangleSize * 8 DIV 5), 101 + RectangleSize, DarkBrown, TRUE);
         FOR TunnelDots := 1 TO GoingStraight DO
             Plot (RANDOM(320), RANDOM(200), DarkestBrown);
         END;
         Delay (GameSpeed);
      END;
  END;
  IF (GraphicsCard <> 1) THEN
     Rectangle (0, 0, 320, 100, DarkestGrey, TRUE);
     Rectangle (0, 100, 320, 200, DarkBrown, TRUE);
  END;
END OpenUpTunnel;

PROCEDURE Screen6;
VAR
  RectY, Count, TunnelDots : CARDINAL;
BEGIN
  PlaneInMemory := FALSE;
  Rectangle (0, 100, 320, 200, DarkBrown, TRUE);
  FOR PlaneY := 200 TO 175 BY -1 DO
      PlaneX := (200-PlaneY)*29 DIV 5;
      Width := (160 - PlaneX)*3;
      Height := Width DIV 2;
      Rectangle (0, 170, 320, 200, DarkBrown, TRUE);
      DrawPlane (PlaneX, PlaneY, Width, Height);
      PlaneInMemory := FALSE;
      Lib.Delay (40);
  END;
  PlaneX := 145; PlaneY := 175;
  FOR RectY := 100 TO 0 BY (-10) DO
      Rectangle (RectY, RectY, 320-RectY, 200-RectY, DarkestBrown, TRUE);
      IF (RectY<90) THEN
         Rectangle (RectY+10, RectY+10, 310-RectY, 190-RectY, Black, TRUE);
      END;
      DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  END;
  Graph.ClearScreen (Graph._GCLEARSCREEN);
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  Graph.GetImage (PlaneX, PlaneY, PlaneX+PlaneWidth, PlaneY+PlaneHeight, PlaneAddress);
  PlaneInMemory := TRUE;
  Graph.ClearScreen (Graph._GCLEARSCREEN);
  FOR TunnelDots := 1 TO 50 DO
      Plot (RANDOM(320), RANDOM(15), DarkBrown);
      Plot (RANDOM(15), RANDOM(200), DarkBrown);
      Plot (320-RANDOM(15), RANDOM(200), DarkBrown);
      Plot (RANDOM(320), 200-RANDOM(15), DarkBrown);
      Plot (RANDOM(320), RANDOM(23), DarkestBrown);
      Plot (RANDOM(23), RANDOM(200), DarkestBrown);
      Plot (320-RANDOM(23), RANDOM(200), DarkestBrown);
      Plot (RANDOM(320), 200-RANDOM(23), DarkestBrown);
  END;
  DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
  ClearTheBuffer;
  ScreenComplete := FALSE;
  GameOver := FALSE;
  GoStraight;
  SplitInTwo;
  GoInTwo;
  BlockOffRight;
  IF (PlaneX>160) THEN
     LavaFall;
  END;
  WindingTunnel;
  GoStraight;
  IF NOT GameOver THEN
     OpenUpTunnel;
  END;
  IF GameOver THEN
     DrawGameOver;
  END;

END Screen6;

END Screens6.
