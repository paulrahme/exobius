IMPLEMENTATION MODULE Screens4;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, Exobius, Font;
FROM Graph IMPORT SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point, GetImage;
FROM Lib IMPORT Sound, NoSound, Delay;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Exobius IMPORT
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue, DarkestRed,
    DarkRed, Red, LightRed, LightestRed, DarkestBrown, DarkBrown,
    Brown, LightBrown, LightestBrown, DarkestGreen, DarkGreen, Green, LightGreen,
    LightestGreen, DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, PlaneY, Xs, Ys, Lives, ScreenComplete, GameOver, GameSpeed,
    GetPixel, PutPixel, DrawPlane, DrawPlane5025, CheckMouse, CheckMouseAndSpecialKeys,
    BkAddress, ClearTheBuffer, Cheat, DrawGameOver, TextPos;

CONST
    SmallPlaneWidth = 20;
    SmallPlaneHeight = 10;

VAR
    RectY : CARDINAL;
    RectX : INTEGER;

PROCEDURE RandomBrown(VAR BrownColour : CARDINAL);
BEGIN
    CASE Lib.RANDOM(5) OF
        |1: BrownColour := LightestBrown;
        |2: BrownColour := LightBrown;
        |3: BrownColour := Brown;
        |4: BrownColour := DarkBrown;
        |5: BrownColour := DarkestBrown;
   END;
END RandomBrown;

PROCEDURE DrawBridgePiece4(x, y, BrownColour : CARDINAL);
VAR
    BridgeDots : CARDINAL;
BEGIN
    RandomBrown(BrownColour);
    Rectangle(x, y, x + 40, y + 9, DarkGrey, FALSE);
    Rectangle(x + 1, y + 1, x + 39, y + 8, BrownColour, TRUE);
    HLine(x, y + 10, x + 40, DarkestGrey);
    FOR BridgeDots := 1 TO 15 DO
        PutPixel(x + Lib.RANDOM(40), y + Lib.RANDOM(10), DarkGrey);
    END;
END DrawBridgePiece4;

PROCEDURE Die4;
CONST
    PlopSoundDelay = 50;
BEGIN
    Graph.GetImage(0, 190, 320, 200, BkAddress);
    Rectangle(0, 190, 320, 200, Blue, TRUE);
    Circle(PlaneX + 10, PlaneY + 5, 2, LightestBlue);
    Circle(PlaneX + 10, PlaneY + 5, 4, LightestBlue);
    TextPos := Graph.SetTextPosition (25, 25);
    Graph.OutText('PLOP!');
    Sound(30); Delay(PlopSoundDelay); NoSound();
    Sound(40); Delay(PlopSoundDelay); NoSound();
    Sound(60); Delay(PlopSoundDelay); NoSound();
    Sound(100); Delay(PlopSoundDelay); NoSound();
    Sound(150); Delay(PlopSoundDelay); NoSound();
    Sound(240); Delay(PlopSoundDelay); NoSound();
    Graph.PutImage(0, 190, BkAddress, Graph._GPSET);
    (*Lives := Lives + 1;*)
    IF (Lives=3) THEN
        Lives := 0;
        IF (Cheat=FALSE) THEN
            GameOver := TRUE;
        END;
    ELSE
        PlaneX := 0;
        WHILE (Point(PlaneX, 195) = Blue) OR (Point(PlaneX, 195) = LightestBlue) DO
            PlaneX := PlaneX + 1;
        END;
        PlaneX := PlaneX + SmallPlaneHeight;
    END;
END Die4;

PROCEDURE Screen4;
CONST
    LevelDistance = 1500;
    NoOfWaterDots = 40;
    ScrollSpeed = 2;
VAR
    LineSpeed, LineXEnd, LineY, WaterDots, BrownColour, Distance, DotX, DotY, RectangleX, BehindPlaneSize : CARDINAL;
    LineXStart : INTEGER;
    BehindPlaneAddress : ADDRESS;
BEGIN
    PlaneX := 150; PlaneY := 174; LineSpeed := 156; ScreenComplete := FALSE;
    ClearTheBuffer;
    LineXStart := 150; LineXEnd := 170;
    Rectangle(0, 0, 320, 100, LightBlue, TRUE);
    Rectangle(0, 100, 320, 200, LightestWhite, TRUE);

    (* Draw bridge pieces coming in *)
    FOR LineY := 100 TO 200 DO
        IF (LineY MOD 2 = 0) THEN
            LineXStart := LineXStart - 3;
            LineXEnd := LineXEnd + 3;
            IF (LineXStart < 0) THEN
                LineXStart := 0;
            END;
        END;
        HLine(0, LineY, LineXStart, Blue);
        HLine(LineXEnd, LineY, 320, Blue);
        FOR WaterDots := 1 TO 5 DO
            Plot(Lib.RANDOM(LineXStart), LineY, LightestBlue);
            Plot(Lib.RANDOM(LineXStart) + LineXEnd, LineY, LightestBlue);
        END;
        RandomBrown(BrownColour);
        HLine(LineXStart, LineY, LineXEnd, BrownColour);
        DrawPlane5025();
    END;
    Lib.Delay(GameSpeed * 5);

    (* Perspective shift to top view *)
    FOR LineY := 100 TO 0 BY -1 DO
        Xs[0] := 140; Xs[1] := 140 - (LineY*4 DIV 3); Xs[2] := 319 - Xs[1]; Xs[3] := 319 - Xs[0];
        Ys[0] := LineY; Ys[1] := 200; Ys[2] := 200; Ys[3] := LineY;
        Polygon(4, Xs, Ys, DarkestBrown);
        Xs[2] := 0; Xs[3] := 0;
        Polygon(4, Xs, Ys, Blue);
        Xs[0] := 319 - Xs[0]; Xs[1] := 319 - Xs[1]; Xs[2] := 319 - Xs[2]; Xs[3] := 319 - Xs[3];
        Polygon(4, Xs, Ys, Blue);
        DrawPlane(PlaneX, PlaneY, SmallPlaneWidth + (LineY*3 DIV 10));
        Lib.Delay(GameSpeed DIV 5);
        CheckMouseAndSpecialKeys();
        IF GameOver THEN LineY := 0; END;
    END;

    (* Construct bridge pieces *)
    RectangleX := 140;
    FOR RectY := 0 TO 180 BY 10 DO
        DrawBridgePiece4(RectangleX, RectY, BrownColour);
    END;
    Line(RectangleX, 0, RectangleX, 200, DarkestGrey);
    BehindPlaneSize := CARDINAL(Graph.ImageSize(0, 0, 20, 10));
    Storage.ALLOCATE(BehindPlaneAddress, BehindPlaneSize);
    CheckMouse();
    PlaneX := RectangleX + 10; PlaneY := 190;
    GetImage(PlaneX, PlaneY, PlaneX + SmallPlaneWidth, PlaneY + SmallPlaneHeight, BehindPlaneAddress);
    DrawPlane(PlaneX, PlaneY, SmallPlaneWidth);

    (* Main loop *)
    RectY := 0; Distance := 0; PlaneX := 150;
    WHILE NOT (GameOver OR ScreenComplete) DO
        FOR WaterDots := 1 TO NoOfWaterDots DO
            DotX := Lib.RANDOM(319);
            DotY := ScrollSpeed + Lib.RANDOM(100);
            IF (GetPixel(DotX, DotY) = Blue) THEN
                PutPixel(DotX, DotY, LightestBlue);
            END;
        END;
        Graph.PutImage(PlaneX, PlaneY, BehindPlaneAddress, Graph._GPSET);
        Graph.GetImage(0, 0, 104, 198, BkAddress);
        Graph.PutImage(0, ScrollSpeed, BkAddress, Graph._GPSET);
        Graph.GetImage(215, 0, 319, 198, BkAddress);
        Graph.PutImage(215, ScrollSpeed, BkAddress, Graph._GPSET);
        Graph.GetImage(105, 0, 214, 198, BkAddress);
        Graph.PutImage(105, ScrollSpeed, BkAddress, Graph._GPSET);
        CheckMouse();
        GetImage(PlaneX, PlaneY, PlaneX + SmallPlaneWidth, PlaneY + SmallPlaneHeight, BehindPlaneAddress);
        DrawPlane(PlaneX, PlaneY, SmallPlaneWidth);

        Distance := Distance + ScrollSpeed;

        (* Time to draw next bridge piece? *)
        IF (Distance MOD 10 = 0) THEN
            IF (RectangleX < 100) THEN
                RectangleX := RectangleX + 15;
            ELSIF (RectangleX > 220) THEN
                RectangleX := RectangleX - 15;
            ELSE
                RectangleX := RectangleX - 12 + Lib.RANDOM(24);
            END;
            Rectangle(0, 0, 319, 9, Blue, TRUE);
            DrawBridgePiece4(RectangleX, RectY, BrownColour);
        END;

        IF (Distance >= LevelDistance) THEN
            ScreenComplete := TRUE;
        END;

        IF (Point(PlaneX+10, PlaneY-1) = Blue) OR (Point(PlaneX+10, PlaneY-1) = LightestBlue) THEN
            Die4;
        END;

        Delay(GameSpeed);
    END;
    RectX := INTEGER(RectangleX);
    Storage.DEALLOCATE(BehindPlaneAddress, BehindPlaneSize);
    
    IF GameOver THEN
        DrawGameOver;
    END;
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
CONST
    NoOfWaterDots = 50;
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
          Graph.GetImage(100, 0, 219, 190, BkAddress);
          Rectangle (0, 0, 320, 9, Blue, TRUE);
          DrawBridgePiece5 (RectX, RectY);
          Graph.PutImage(100, 10, BkAddress, Graph._GPSET);
          FOR WaterDots := 1 TO NoOfWaterDots DO
	      DotX := Lib.RANDOM(320);
	      DotY := Lib.RANDOM(180);
              IF (Point(DotX, DotY)=Blue) THEN
                 Plot (DotX, DotY, LightestBlue);
              END;
          END;
	  CheckMouse;
	  DrawPlane(PlaneX, PlaneY, SmallPlaneWidth);
	  IF (Point(PlaneX+10, PlaneY-1) = Blue) OR (Point(PlaneX+10, PlaneY-1) = LightestBlue) THEN
        Die4;
     END;
     Delay (GameSpeed);
    END;
    WHILE NOT (GameOver OR ScreenComplete) DO
	  FOR WaterDots := 1 TO NoOfWaterDots DO
              DotX := Lib.RANDOM(320);
	      DotY := Lib.RANDOM(180);
              IF (Point(DotX, DotY)=Blue) THEN
                 Plot (DotX, DotY, LightestBlue);
              END;
          END;
	  Graph.GetImage (100, 0, 219, 190, BkAddress);
	  CheckMouse;
	  Graph.PutImage (100, 10, BkAddress, Graph._GPSET);
     Rectangle (0, 0, 320, 9, Blue, TRUE);
     DrawBridgePiece5 (RectX, RectY);
	  IF (BridgesDrawn = 30) THEN
	     ScreenComplete := TRUE;
	  END;
	  DrawPlane(PlaneX, PlaneY, 200);
	  BridgesDrawn := BridgesDrawn + 1;
	  IF (Point(PlaneX+10, PlaneY-1) = Blue) OR (Point(PlaneX+10, PlaneY-1) = LightestBlue) THEN
        Die4;
     END;
     Delay (GameSpeed);
    END;
    IF NOT GameOver THEN
        PlaneY := 175;
        FOR LineY := 2 TO 100 BY 2 DO
            Rectangle (0, LineY, 320, 200, Blue, TRUE);
            HLine (0, LineY - 1, 320, LightBlue);
            HLine (0, LineY - 2, 320, LightBlue);
            Xs[0] := 150; Xs[1] := 150 - (LineY*3 DIV 2); Xs[2] := 170 + (LineY*3 DIV 2); Xs[3] := 170;
            Ys[0] := LineY; Ys[1] := 200; Ys[2] := 200; Ys[3] := LineY;
            Polygon (4, Xs, Ys, DarkWhite);
            DrawPlane(PlaneX, PlaneY, SmallPlaneWidth + (LineY*3 DIV 10));
        END;
        Polygon (4, Xs, Ys, LightGrey);
        FOR BridgeDots := 1 TO 50 DO
            DotX := Lib.RANDOM(320);
            DotY := Lib.RANDOM (100) + 100;
            IF Point(DotX, DotY) = LightGrey THEN
               Plot (DotX, DotY, DarkGrey);
            END;
        END;
        FOR LineY := 100 TO 200 DO
            HLine (0, LineY, 320, LightWhite);
            DrawPlane5025();
            Plot (Lib.RANDOM(320), Lib.RANDOM(100)+100, DarkGrey);
        END;
    END;
    Rectangle (0, 0, 320, 100, Blue, TRUE);
    Rectangle (0, 100, 320, 200, White, TRUE);
    DrawPlane5025();
    Delay (20);
    Rectangle (0, 0, 320, 100, LightBlue, TRUE);
    Rectangle (0, 100, 320, 200, DarkWhite, TRUE);
    DrawPlane5025();
    Delay(20);
    Rectangle (0, 0, 320, 100, Blue, TRUE);
    Rectangle (0, 100, 320, 200, DarkestWhite, TRUE);
    DrawPlane5025();
    Delay(20);
    Rectangle (0, 0, 320, 100, DarkBlue, TRUE);
    Rectangle (0, 100, 320, 200, LightestGrey, TRUE);
    DrawPlane5025();
    Delay(20);
    Rectangle (0, 0, 320, 100, Blue, TRUE);
    Rectangle (0, 100, 320, 200, LightGrey, TRUE);
    DrawPlane5025();
    Delay(20);
    Rectangle (0, 0, 320, 100, DarkBlue, TRUE);
    Rectangle (0, 100, 320, 200, Grey, TRUE);
    DrawPlane5025();
    Delay(20);
    Rectangle (0, 0, 320, 100, DarkestBlue, TRUE);
    Rectangle (0, 100, 320, 200, DarkGrey, TRUE);
    DrawPlane5025();
    Delay(20);
    Rectangle (0, 0, 320, 100, Black, TRUE);
    Rectangle (0, 100, 320, 200, DarkestGrey, TRUE);
    DrawPlane5025();
    Delay(20);
    Rectangle (0, 100, 320, 200, Black, TRUE);
    DrawPlane5025();
    Delay(20);
    IF GameOver THEN
       DrawGameOver;
    END;
END Screen5;

END Screens4.
