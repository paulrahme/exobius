IMPLEMENTATION MODULE Screens4;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, Exobius, Font;
FROM Graph IMPORT Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point, GetImage;
FROM Lib IMPORT Sound, NoSound, Delay;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Exobius IMPORT
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue, DarkestRed,
    DarkRed, Red, LightRed, LightestRed, DarkestBrown, DarkBrown,
    Brown, LightBrown, LightestBrown, DarkestGreen, DarkGreen, Green, LightGreen,
    LightestGreen, DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, PlaneY, PlaneWidth, PlaneHeight, PlaneStartX, PlaneStartY, Xs, Ys, Lives, ScreenComplete, GameOver, GameSpeed,
    GetPixel, PutPixel, DrawPlane, DrawPlane5025, CheckMouse, CheckMouseAndSpecialKeys,
    BkAddress, ClearTheBuffer, Cheat, DrawGameOver, TextPos;
FROM Sprites IMPORT RandomBrown;

CONST
    SmallPlaneWidth = 20;
    SmallPlaneHeight = 10;
    ScrollSpeed = 4;

PROCEDURE DrawBridgePiece4(x, y : CARDINAL);
VAR
    BrownColor, BridgeDots : CARDINAL;
BEGIN
    Rectangle(x, y, x + 40, y + ScrollSpeed - 1, DarkGrey, FALSE);
    Rectangle(x + 1, y + 1, x + 39, y + ScrollSpeed - 2, RandomBrown(), FALSE);
    HLine(x, y + ScrollSpeed, x + 40, DarkestGrey);
    FOR BridgeDots := 1 TO 10 DO
        PutPixel(x + Lib.RANDOM(40), y + Lib.RANDOM(ScrollSpeed), DarkGrey);
    END;
END DrawBridgePiece4;

PROCEDURE Die4;
CONST
    PlopSoundDelay = 50;
VAR
    PixelColour : SHORTCARD;
BEGIN
    Graph.GetImage(0, 190, 319, 200, BkAddress);
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
    IF (Lives = 0) THEN
        Lives := 0;
        IF (Cheat=FALSE) THEN
            GameOver := TRUE;
        END;
    ELSE
        Lives := Lives - 1;
        PlaneX := 0;
        PixelColour := Blue;
        WHILE (PixelColour = Blue) OR (PixelColour = LightestBlue) DO
            PlaneX := PlaneX + 1;
            PixelColour := GetPixel(PlaneX, 185);
        END;
        PlaneX := PlaneX + 10;
        CheckMouseAndSpecialKeys();
    END;
END Die4;

PROCEDURE Screen4;
CONST
    WaterDistance = 2500; TotalDistance = 5000;
    NoOfRandomDots = 40;
    PuddleHalfWidthMin = 4; PuddleHalfWidthMax = 20; PuddleHalfLengthMin = 8; PuddleHalfLengthMax = 20;
VAR
    LineSpeed, LineXEnd, LineY, Dots, Distance, DotX, DotY, RectX, RectY,
        PuddleX, PuddleHalfWidth, PuddleLeftX, PuddleLength, BehindPlaneSize : CARDINAL;
    LineXStart : INTEGER;
    BehindPlaneAddress : ADDRESS;
BEGIN
    PlaneX := 150; PlaneY := PlaneStartY; LineSpeed := 156; ScreenComplete := FALSE;
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
        FOR Dots := 1 TO 5 DO
            Plot(Lib.RANDOM(LineXStart), LineY, LightestBlue);
            Plot(LineXEnd + Lib.RANDOM(50), LineY, LightestBlue);
        END;
        HLine(LineXStart, LineY, LineXEnd, RandomBrown());
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

    (* Construct initial bridge pieces *)
    RectX := 140;
    FOR RectY := 0 TO 180 BY ScrollSpeed DO
        DrawBridgePiece4(RectX, RectY);
    END;
    Line(RectX, 0, RectX, 200, DarkestGrey);
    BehindPlaneSize := CARDINAL(Graph.ImageSize(0, 0, SmallPlaneWidth, SmallPlaneHeight));
    Storage.ALLOCATE(BehindPlaneAddress, BehindPlaneSize);
    CheckMouse();
    PlaneX := RectX + 10; PlaneY := 190;
    GetImage(PlaneX, PlaneY, PlaneX + SmallPlaneWidth, PlaneY + SmallPlaneHeight, BehindPlaneAddress);
    DrawPlane(PlaneX, PlaneY, SmallPlaneWidth);

    (* Main loop *)
    RectY := 0; Distance := 0; PlaneX := 150;
    PuddleHalfWidth := PuddleHalfWidthMin; PuddleX := PuddleHalfWidthMax + 2; PuddleLength := 0;
    WHILE NOT (GameOver OR ScreenComplete) DO
        (* Increase distance travelled *)
        Distance := Distance + ScrollSpeed;

        IF (Distance < WaterDistance) THEN
            (* Add water dots *)
            FOR Dots := 1 TO NoOfRandomDots DO
                DotX := Lib.RANDOM(319);
                DotY := ScrollSpeed + Lib.RANDOM(100);
                IF (GetPixel(DotX, DotY) = Blue) THEN
                    PutPixel(DotX, DotY, LightestBlue);
                END;
            END;

            (* Draw next bridge piece *)
            IF (RectX < 100) THEN
                RectX := RectX + 6;
            ELSIF (RectX > 220) THEN
                RectX := RectX - 6;
            ELSE
                RectX := RectX - 6 + Lib.RANDOM(12);
            END;
            IF (Distance < WaterDistance - 100) THEN
                Rectangle(0, 0, 319, ScrollSpeed, Blue, TRUE);
            ELSE
                Rectangle(0, 0, 319, ScrollSpeed, LightBrown, TRUE);
            END;
            DrawBridgePiece4(RectX, RectY);
        ELSE
            (* Add ground dots *)
            FOR DotY := 1 TO ScrollSpeed DO
                DotX := Lib.RANDOM(319);
                IF (GetPixel(DotX, DotY) = LightBrown) THEN
                    PutPixel(DotX, DotY, DarkestBrown);
                END;
                DotX := Lib.RANDOM(319);
                IF (GetPixel(DotX, DotY) = LightBrown) THEN
                    PutPixel(DotX, DotY, DarkBrown);
                END;
                DotX := Lib.RANDOM(319);
                IF (GetPixel(DotX, DotY) = LightBrown) THEN
                    PutPixel(DotX, DotY, LightestBrown);
                END;
            END;

            (* Update ground with water puddles *)
            PuddleLength := PuddleLength + ScrollSpeed;
            FOR RectY := (ScrollSpeed - 1) TO 0 BY -1 DO
                IF (PuddleLength < PuddleHalfLengthMin) THEN
                    PuddleHalfWidth := PuddleHalfWidth + Lib.RANDOM(2) + 1;
                ELSIF (PuddleLength < PuddleHalfLengthMax) THEN
                    PuddleHalfWidth := PuddleHalfWidth + Lib.RANDOM(4) - 1;
                ELSE
                    PuddleHalfWidth := PuddleHalfWidth + Lib.RANDOM(4) - 2;
                END;

                IF (PuddleHalfWidth > PuddleHalfWidthMax) THEN
                    PuddleHalfWidth := PuddleHalfWidth - 1;
                ELSIF (PuddleHalfWidth <= PuddleHalfWidthMin) THEN
                    PuddleHalfWidth := PuddleHalfWidthMin;
                    PuddleX := Lib.RANDOM(260) + 30;
                    PuddleLength := 0;
                END;

                PuddleLeftX := PuddleX - PuddleHalfWidth;
                HLine(0, RectY, PuddleLeftX, LightBrown);
                HLine(PuddleLeftX, RectY, PuddleX + PuddleHalfWidth, Blue);
                HLine(PuddleX + PuddleHalfWidth, RectY, 319, LightBrown);
                PutPixel(PuddleLeftX + Lib.RANDOM(PuddleHalfWidth * 2), RectY, DarkBlue);
                PutPixel(PuddleLeftX + Lib.RANDOM(PuddleHalfWidth * 2), RectY, LightBlue);
            END;
        END;

        (* Hide plane, scroll up *)
        Graph.PutImage(PlaneX, PlaneY, BehindPlaneAddress, Graph._GPSET);
        Graph.GetImage(0, 0, 104, 198, BkAddress);
        Graph.PutImage(0, ScrollSpeed, BkAddress, Graph._GPSET);
        Graph.GetImage(215, 0, 319, 198, BkAddress);
        Graph.PutImage(215, ScrollSpeed, BkAddress, Graph._GPSET);
        Graph.GetImage(105, 0, 214, 198, BkAddress);
        Graph.PutImage(105, ScrollSpeed, BkAddress, Graph._GPSET);

        (* Update + draw plane *)
        CheckMouse();
        GetImage(PlaneX, PlaneY, PlaneX + SmallPlaneWidth, PlaneY + SmallPlaneHeight, BehindPlaneAddress);
        DrawPlane(PlaneX, PlaneY, SmallPlaneWidth);

        (* Finished screen / Dead? *)
        IF (Distance >= TotalDistance) THEN
            ScreenComplete := TRUE;
        ELSIF (Point(PlaneX+10, PlaneY-1) = Blue) OR (Point(PlaneX+10, PlaneY-1) = LightestBlue) THEN
            Die4;
        END;

        Delay(GameSpeed);
    END;
    Storage.DEALLOCATE(BehindPlaneAddress, BehindPlaneSize);

    IF ScreenComplete THEN
        PlaneX := 160 - (PlaneWidth DIV 2); PlaneY := PlaneStartY;
        (* Perspective shift back to 3D view *)
        FOR LineY := 0 TO 100 DO
            IF (LineY > 0) THEN
                HLine(0, LineY - 1, 319, Black);
            END;
            Xs[0] := 140; Xs[1] := 140 - (LineY*4 DIV 3); Xs[2] := 319 - Xs[1]; Xs[3] := 319 - Xs[0];
            Ys[0] := LineY; Ys[1] := 200; Ys[2] := 200; Ys[3] := LineY;
            Polygon(4, Xs, Ys, Brown);
            Xs[2] := 0; Xs[3] := 0;
            Polygon(4, Xs, Ys, Black);
            Xs[0] := 319 - Xs[0]; Xs[1] := 319 - Xs[1]; Xs[2] := 319 - Xs[2]; Xs[3] := 319 - Xs[3];
            Polygon(4, Xs, Ys, Black);
            DrawPlane(PlaneX, PlaneY, SmallPlaneWidth + (LineY DIV 4));
            Lib.Delay(GameSpeed DIV 5);
            CheckMouseAndSpecialKeys();
            IF GameOver THEN LineY := 100; END;
        END;
    END;

    IF GameOver THEN
        DrawGameOver;
    END;
END Screen4;

END Screens4.
