IMPLEMENTATION MODULE Screens4;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT
  Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius;

FROM Graph IMPORT
  SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point, GetImage;

FROM Lib IMPORT
  Sound, NoSound, Delay;

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
  Enemy6X, Enemies,
  BulletX, BulletY, OldBulletX, OldBulletY,
  PlaneY, Width, Height, CoverRectangleX,
  Count, Lives, EnemyY,  NegPlaneAddress, WritingAddress,  BkColour,
  OldBkColor,  Xs, Ys,  OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive,
  SixAlive, ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
  DrawBullet, DrawPlane, CheckMouse, CheckKeyboard, Die, A, B,
  C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
  FinishScreen1, Key, PlaneXMove, CheckDeath1, Score, Screen,
  PlaneInMemory, PlaneAddress, BkAddress, BkSize, ClearTheBuffer, Cheat,
  GraphicsCard, HighDetail, DrawGameOver;

FROM Sprites IMPORT
  DrawBoomGuards, DrawSpinners, DrawFlyTraps, DrawMaces, DrawPlants,
  DrawIceRocks, DrawSnowMen, DrawSnowBalls, DrawSkiiers, DrawGlowWorms;

VAR
  NumberOfWaterDots, RectY, HitCounts, EnemyX : CARDINAL;
  TextPos : Graph.TextCoords;
  RectX : INTEGER;

PROCEDURE RandomBrown(VAR BrownColour : CARDINAL);
BEGIN
   CASE Lib.RANDOM(5) OF
      | 1 : BrownColour := LightestBrown;
      | 2 : BrownColour := LightBrown;
      | 3 : BrownColour := Brown;
      | 4 : BrownColour := DarkBrown;
      | 5 : BrownColour := DarkestBrown;
   END;
END RandomBrown;

PROCEDURE Die4;
VAR
   Count : CARDINAL;
BEGIN
    Graph.GetImage (0, 190, 320, 200, BkAddress);
    Rectangle (0, 190, 320, 200, Blue, TRUE);
    Circle (PlaneX + 10, PlaneY + 5, 2, LightestBlue);
    Circle (PlaneX + 10, PlaneY + 5, 4, LightestBlue);
    TextPos := Graph.SetTextPosition (25, 25);
    Graph.OutText ('PLOP!');
    FOR Count := 1 TO 6 DO
         CASE Count OF
              | 1 : Sound (30);
              | 2 : Sound (40);
              | 3 : Sound (60);
              | 4 : Sound (100);
              | 5 : Sound (150);
              | 6 : Sound (240);
         END;
         Delay (50);
         NoSound;
    END;
    Graph.PutImage (0, 190, BkAddress, Graph._GPSET);
    Lives := Lives + 1;
    IF (Lives=3) THEN
       Lives := 0;
       IF (Cheat=FALSE) THEN
          GameOver := TRUE;
       END;
    ELSE
       PlaneX := 0;
       CASE GraphicsCard OF
            | 2,3 : WHILE (Point(PlaneX, 195)=Blue) OR (Point(PlaneX, 195)=LightestBlue) DO
                          PlaneX := PlaneX + 1;
                    END;
            | 1 : WHILE (Point(PlaneX, 195)=Blue) DO
                        PlaneX := PlaneX + 1;
                  END;
       END;
       PlaneX := PlaneX + 9;
    END;
END Die4;

PROCEDURE DrawBridgePiece4(x, y, BrownColour : CARDINAL);
VAR
  BridgeDots : CARDINAL;
BEGIN
     RandomBrown (BrownColour);
     Rectangle (x, y, x + 20, y + 10, BrownColour, TRUE);
     Rectangle (x, y, x + 20, y + 10, DarkGrey, FALSE);
     HLine (x, y + 9, x + 20, DarkestGrey);
     FOR BridgeDots := 1 TO 15 DO
         Plot (Lib.RANDOM(20) + x, Lib.RANDOM(10) + y, DarkGrey);
     END;
END DrawBridgePiece4;

PROCEDURE Screen4;
CONST
    NoOfBridges = 100;
VAR
  LineSpeed, LineXEnd, LineY, WaterDots, BrownColour, BridgesDrawn, DotX,
     DotY, RectangleX : CARDINAL;
  LineXStart : INTEGER;

BEGIN
     PlaneX := 150; PlaneY := 174; LineSpeed := 156; ScreenComplete := FALSE;
     IF HighDetail THEN
        NumberOfWaterDots := 250
     ELSE
        NumberOfWaterDots := 25;
     END;
     ClearTheBuffer;
     LineXStart := 150; LineXEnd := 170;
     Rectangle (0, 0, 320, 100, LightBlue, TRUE);
     Rectangle (0, 100, 320, 200, LightestWhite, TRUE);
     FOR LineY := 100 TO 200 DO
          IF (LineY MOD 2 = 0) THEN
           LineXStart := LineXStart - 3;
           LineXEnd := LineXEnd + 3;
           IF (LineXStart < 0) THEN
              LineXStart := 0;
           END;
        END;
        HLine (0, LineY, LineXStart, Blue);
        HLine (LineXEnd, LineY, 320, Blue);
        FOR WaterDots := 1 TO 5 DO
            Plot (Lib.RANDOM(LineXStart), LineY, LightestBlue);
            Plot (Lib.RANDOM(LineXStart) + LineXEnd, LineY, LightestBlue);
        END;
        RandomBrown(BrownColour);
        HLine (LineXStart, LineY, LineXEnd, BrownColour);
        DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
     END;
     Lib.Delay (50);
     PlaneInMemory := FALSE;
     FOR LineY := 100 TO 0 BY -1 DO
         Rectangle (0, LineY, 320, 200, Blue, TRUE);
         Xs[0] := 150; Xs[1] := 150 - (LineY*3 DIV 2); Xs[2] := 170 + (LineY*3 DIV 2); Xs[3] := 170;
         Ys[0] := LineY; Ys[1] := 200; Ys[2] := 200; Ys[3] := LineY;
         Polygon (4, Xs, Ys, DarkestBrown);
         DrawPlane (PlaneX, PlaneY, (LineY*3 DIV 10) + 20, (LineY*3 DIV 20) + 10);
     END;
     RectangleX := 150;
     FOR RectY := 0 TO 180 BY 10 DO
         DrawBridgePiece4 (RectangleX, RectY, BrownColour);
     END;
     Line (RectangleX, 0, RectangleX, 200, DarkestGrey);
     PlaneY := 190;
     DrawPlane (PlaneX, PlaneY, 20, 10);
     Storage.ALLOCATE (BkAddress, CARDINAL(Graph.ImageSize(0, 0, 320, 190)));
     RectY := 0; BridgesDrawn := 0; PlaneX := 150;
		WHILE NOT (GameOver OR ScreenComplete) DO
		        FOR WaterDots := 1 TO NumberOfWaterDots DO
		            DotX := Lib.RANDOM(320);
		            DotY := Lib.RANDOM(150);
                            IF (Point(DotX, DotY)=Blue) THEN
                               Plot (DotX, DotY, LightestBlue);
                            END;
                        END;
			Graph.GetImage (0, 0, 320, 190, BkAddress);
			CheckMouse;
			Graph.PutImage (0, 10, BkAddress, Graph._GPSET);
                        Rectangle (0, 0, 320, 9, Blue, TRUE);
                        RectangleX := RectangleX + Lib.RANDOM(10) - 5;
                        DrawBridgePiece4 (RectangleX, RectY, BrownColour);
			IF (BridgesDrawn = NoOfBridges) THEN
				ScreenComplete := TRUE;
			END;
			DrawPlane (PlaneX, PlaneY, 20, 10);
			BridgesDrawn := BridgesDrawn + 1;
			CASE GraphicsCard OF
			   | 1 : IF (Point(PlaneX+10, PlaneY-1) = Blue) THEN
                                    Die4;
                                 END;
			   | 2, 3 : IF (Point(PlaneX+10, PlaneY-1) = Blue) OR (Point(PlaneX+10, PlaneY-1) = LightestBlue) THEN
                                       Die4;
                                    END;
                        END;
                        Delay (GameSpeed);
		END;
		IF GameOver THEN
                   DrawGameOver;
                END;
                RectX := INTEGER(RectangleX);
END Screen4;

PROCEDURE DrawBridgePiece5 (x, y : CARDINAL);
VAR
  BridgeDots : CARDINAL;
BEGIN
    Rectangle (x, y, x+20, y+10, LightGrey, TRUE);
    Rectangle (x, y, x+20, y+10, DarkGrey, FALSE);
    HLine (x, y+9, x+20, DarkestGrey);
    FOR BridgeDots := 1  TO 15 DO
        Plot (x + Lib.RANDOM(19), y + Lib.RANDOM(9), White);
    END;
END DrawBridgePiece5;

PROCEDURE Screen5;
VAR
  LineX, LineY, DotX, DotY, WaterDots, BridgesDrawn, BridgeDots : CARDINAL;
BEGIN
    ScreenComplete := FALSE; RectY := 0; BridgesDrawn := 0;
    WHILE (RectX <> 150) AND (GameOver=FALSE) DO
          IF (RectX < 150) THEN
             RectX := RectX + 2
          ELSE
             RectX := RectX - 2;
          END;
          IF (RectX = 149) THEN
             RectX := RectX + 1;
          END;
          Graph.GetImage (0, 0, 320, 190, BkAddress);
          Rectangle (0, 0, 320, 9, Blue, TRUE);
          DrawBridgePiece5 (RectX, RectY);
          Graph.PutImage (0, 10, BkAddress, Graph._GPSET);
          FOR WaterDots := 1 TO NumberOfWaterDots DO
	      DotX := Lib.RANDOM(320);
	      DotY := Lib.RANDOM(180);
              IF (Point(DotX, DotY)=Blue) THEN
                 Plot (DotX, DotY, LightestBlue);
              END;
          END;
	  CheckMouse;
	  DrawPlane (PlaneX, PlaneY, 20, 10);
	  CASE GraphicsCard OF
	       | 1 : IF (Point(PlaneX+10, PlaneY-1) = Blue) THEN
                        Die4;
                     END;
	       | 2, 3 : IF (Point(PlaneX+10, PlaneY-1) = Blue) OR (Point(PlaneX+10, PlaneY-1) = LightestBlue) THEN
                           Die4;
                        END;
          END;
          Delay (GameSpeed);
    END;
    WHILE NOT (GameOver OR ScreenComplete) DO
	  FOR WaterDots := 1 TO NumberOfWaterDots DO
              DotX := Lib.RANDOM(320);
	      DotY := Lib.RANDOM(180);
              IF (Point(DotX, DotY)=Blue) THEN
                 Plot (DotX, DotY, LightestBlue);
              END;
          END;
	  Graph.GetImage (0, 0, 320, 190, BkAddress);
	  CheckMouse;
	  Graph.PutImage (0, 10, BkAddress, Graph._GPSET);
          Rectangle (0, 0, 320, 9, Blue, TRUE);
          DrawBridgePiece5 (RectX, RectY);
	  IF (BridgesDrawn = 30) THEN
	     ScreenComplete := TRUE;
	  END;
	  DrawPlane (PlaneX, PlaneY, 20, 10);
	  BridgesDrawn := BridgesDrawn + 1;
	  CASE GraphicsCard OF
	       | 1 : IF (Point(PlaneX+10, PlaneY-1) = Blue) THEN
                        Die4;
                     END;
	       | 2, 3 : IF (Point(PlaneX+10, PlaneY-1) = Blue) OR (Point(PlaneX+10, PlaneY-1) = LightestBlue) THEN
                           Die4;
                        END;
          END;
          Delay (GameSpeed);
    END;
    IF NOT GameOver THEN
        PlaneInMemory := FALSE; PlaneY := 175;
        FOR LineY := 2 TO 100 BY 2 DO
            Rectangle (0, LineY, 320, 200, Blue, TRUE);
            HLine (0, LineY - 1, 320, LightBlue);
            HLine (0, LineY - 2, 320, LightBlue);
            Xs[0] := 150; Xs[1] := 150 - (LineY*3 DIV 2); Xs[2] := 170 + (LineY*3 DIV 2); Xs[3] := 170;
            Ys[0] := LineY; Ys[1] := 200; Ys[2] := 200; Ys[3] := LineY;
            Polygon (4, Xs, Ys, DarkWhite);
            DrawPlane (PlaneX, PlaneY, (LineY*3 DIV 10) + 20, (LineY*3 DIV 20) + 10);
        END;
        Polygon (4, Xs, Ys, LightGrey);
        FOR BridgeDots := 1 TO 50 DO
            DotX := Lib.RANDOM(320);
            DotY := Lib.RANDOM (100) + 100;
            IF Point(DotX, DotY) = LightGrey THEN
               Plot (DotX, DotY, DarkGrey);
            END;
        END;
        PlaneInMemory := TRUE;
        FOR LineY := 100 TO 200 DO
            HLine (0, LineY, 320, LightWhite);
            DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
            Plot (Lib.RANDOM(320), Lib.RANDOM(100)+100, DarkGrey);
        END;
    END;
    Rectangle (0, 0, 320, 100, Blue, TRUE);
    Rectangle (0, 100, 320, 200, White, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay (20);
    Rectangle (0, 0, 320, 100, LightBlue, TRUE);
    Rectangle (0, 100, 320, 200, DarkWhite, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay(20);
    Rectangle (0, 0, 320, 100, Blue, TRUE);
    Rectangle (0, 100, 320, 200, DarkestWhite, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay(20);
    Rectangle (0, 0, 320, 100, DarkBlue, TRUE);
    Rectangle (0, 100, 320, 200, LightestGrey, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay(20);
    Rectangle (0, 0, 320, 100, Blue, TRUE);
    Rectangle (0, 100, 320, 200, LightGrey, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay(20);
    Rectangle (0, 0, 320, 100, DarkBlue, TRUE);
    Rectangle (0, 100, 320, 200, Grey, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay(20);
    Rectangle (0, 0, 320, 100, DarkestBlue, TRUE);
    Rectangle (0, 100, 320, 200, DarkGrey, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay(20);
    Rectangle (0, 0, 320, 100, Black, TRUE);
    Rectangle (0, 100, 320, 200, DarkestGrey, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay(20);
    Rectangle (0, 100, 320, 200, Black, TRUE);
    DrawPlane (PlaneX, PlaneY, PlaneWidth, PlaneHeight);
    Delay(20);
    IF GameOver THEN
       DrawGameOver;
    END;
    Storage.DEALLOCATE (BkAddress,CARDINAL(Graph.ImageSize (0, 10, 320, 190)));
END Screen5;

END Screens4.
