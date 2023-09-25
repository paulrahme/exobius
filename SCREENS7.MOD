IMPLEMENTATION MODULE Screens7;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Exobius;
FROM Graph IMPORT Rectangle, Line, Circle, Ellipse, Plot, Point;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Exobius IMPORT
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, PlaneY, PlaneStartX, PlaneStartY, PlaneWidth, PlaneHeight, DrawPlane5025,
    ClearTheBuffer, CheckSpecialKeys, CheckMouse,
    GameSpeed, Die, GameOver, DrawGameOver;

VAR
    PillarColours : ARRAY[0..13] OF CARDINAL;

PROCEDURE CreateLookupTable();
BEGIN
    PillarColours[0] := DarkestGrey;    PillarColours[1] := DarkGrey;
    PillarColours[2] := Grey;           PillarColours[3] := LightGrey;
    PillarColours[4] := LightestGrey;   PillarColours[5] := DarkestWhite;
    PillarColours[6] := DarkWhite;      PillarColours[7] := White;
    PillarColours[8] := LightWhite;     PillarColours[9] := LightestWhite;
    PillarColours[10] := LightWhite;    PillarColours[11] := White;
    PillarColours[12] := DarkWhite;     PillarColours[13] := DarkestWhite;
END CreateLookupTable;

PROCEDURE DrawPillarBottom(x, y : CARDINAL);
VAR
    PillarX, PillarY, PillarColour : CARDINAL;
BEGIN
    FOR PillarX := 0 TO 27 DO
        PillarColour := PillarColours[PillarX DIV 2];
        CASE PillarX OF
            | 0, 27 : PillarY := y;
            | 1, 26 : PillarY := y + 1;
            | 2, 3, 25, 24 : PillarY := y + 2;
            | 4, 5, 6, 7, 8, 23, 22, 21, 20, 19 : PillarY := y + 3;
            | 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 : PillarY := y + 4;
        END;
        IF (PillarY<200) THEN
            Line(x + ((y-100)*PillarX DIV 100), 200-PillarY, x + ((y-100)*PillarX DIV 100), PillarY, PillarColour)
        ELSE
            Line(x + ((y-100)*PillarX DIV 100), 0, x + ((y-100)*PillarX DIV 100), 200, PillarColour);
        END;
    END;
END DrawPillarBottom;

PROCEDURE DrawPillarTop(x, y : CARDINAL);
VAR
    PillarX, PillarColour, LineX : CARDINAL;
BEGIN
    FOR PillarX := 0 TO 27 DO
        LineX := x + (y * PillarX DIV 200);
        Line(LineX, y, LineX, 200, PillarColours[PillarX DIV 2]);
    END;
    Ellipse(x + (y*14 DIV 200), y, y*14 DIV 200, y*5 DIV 200, White, TRUE);
END DrawPillarTop;

PROCEDURE Screen7;
CONST
    NoOfPillars = 16;
    NoOfCircles = 200;
    NewNoOfPillars = 35;
    PlaneCenterX = 135;
VAR
    PillarCount, Pillar1X, Pillar2X, Pillar3X, Pillar4X, Pillar5X, Pillar1Y,
    Pillar2Y, Pillar3Y, Pillar4Y, Pillar5Y, StarColour, CircleRadius,
    Stars, BlueCircles, CircleColour, OldPlaneX : CARDINAL;
    PlaneOnPillars : BOOLEAN;
BEGIN
    ClearTheBuffer();
    CreateLookupTable();
    PlaneX := PlaneCenterX; PlaneY := 175;
    Rectangle(0, 0, 320, 100, DarkestGrey, TRUE);
    Rectangle(0, 100, 320, 200, DarkBrown, TRUE);
    DrawPlane5025();

    (* Bring intro pillar towards plane *)
    FOR Pillar1Y := 105 TO 200 DO
        Rectangle(130, 100, 190, Pillar1Y, DarkBrown, TRUE);
        DrawPillarTop(PlaneX + 10, Pillar1Y);
        DrawPlane5025();
        Delay(GameSpeed);
        
        CheckSpecialKeys();
        IF GameOver THEN
            Pillar1Y := 200;
        END;
    END;

    (* Bounce plane up into the sky *)
    IF NOT (GameOver) THEN
        FOR PillarCount := 90 TO 200 BY 4 DO
            Rectangle(0, 98, 320, PillarCount, Black, TRUE);
            DrawPlane5025();
            NoSound();
            Sound(PillarCount*5);
        END;
        NoSound();
    END;

    PillarCount := 0; PlaneOnPillars := TRUE;
    Pillar1X := PlaneX + 10; Pillar2X := Pillar1X; Pillar3X := Pillar1X; Pillar4X := Pillar1X; Pillar5X := Pillar1X;

    (* Bouncing on tops of pillars *)
    WHILE (PlaneOnPillars) AND (PillarCount < NoOfPillars) AND NOT (GameOver) DO
        PillarCount := PillarCount + 1;
        Pillar5X := Pillar4X; Pillar4X := Pillar3X; Pillar3X := Pillar2X;
        Pillar2X := Pillar1X; Pillar1X := (RANDOM(11)+1)*25;
        FOR Pillar1Y := 80 TO 100 DO
            CheckMouse();
            IF (PillarCount < 2) THEN
                PlaneX := PlaneCenterX;
            END;
            Pillar2Y := Pillar1Y + 20; Pillar3Y := Pillar2Y + 20; Pillar4Y := Pillar3Y + 20; Pillar5Y := Pillar4Y + 20;
            Graph.ClearScreen(Graph._GCLEARSCREEN);
            FOR Stars := 1 TO 15 DO
                CASE (RANDOM(5)) OF
                    |1: StarColour := Blue;
                    |2: StarColour := White;
                    |3: StarColour := Grey;
                    |4: StarColour := Yellow;
                    |5: StarColour := LightestWhite;
                END;
                Plot(RANDOM(320), RANDOM(200), StarColour);
            END;
            IF (Pillar1Y < 85) THEN
                Rectangle(Pillar1X, Pillar1Y, Pillar1X + 1, 200, DarkestGrey, TRUE);
            ELSIF (Pillar1Y < 92) THEN
                Rectangle(Pillar1X, Pillar1Y, Pillar1X + 3, 200, Grey, TRUE);
            ELSE (* Pillar1Y >= 92) *)
                DrawPillarTop(Pillar1X, Pillar1Y);
            END;
            DrawPillarTop(Pillar2X, Pillar2Y);
            DrawPillarTop(Pillar3X, Pillar3Y);
            DrawPillarTop(Pillar4X, Pillar4Y);
            DrawPillarTop(Pillar5X, Pillar5Y);
            IF (Pillar1Y < 85) THEN PlaneY := PlaneY - 10;
            ELSIF (Pillar1Y < 88) THEN PlaneY := PlaneY - 6;
            ELSIF (Pillar1Y < 94) THEN PlaneY := PlaneY + 4;
            ELSIF (Pillar1Y < 95) THEN PlaneY := PlaneY + 6;
            ELSIF (Pillar1Y < 100) THEN PlaneY := PlaneY + 10;
            END;
            IF (Pillar1Y=100) THEN
                PlaneY := 175;
                IF (Point (PlaneX + 25, PlaneY + 8) <> White) THEN
                    PlaneOnPillars := FALSE;
                END;
            END;
            DrawPlane5025();
            Delay(GameSpeed * 2);
        END;
    END; (* Bouncing on tops of pillars *)

    IF NOT (GameOver) THEN
        (* Successfully bounced on all pillars? *)
        IF (PlaneOnPillars) THEN
            (* Bounce up into space *)
            FOR Pillar2Y := 120 TO 200 BY 5 DO
                NoSound;
                Sound((Pillar2Y-100)*20);
                Graph.ClearScreen(Graph._GCLEARSCREEN);
                FOR Stars := 1 TO 15 DO
                    CASE (RANDOM(5)) OF
                        |1: StarColour := Blue;
                        |2: StarColour := White;
                        |3: StarColour := Grey;
                        |4: StarColour := Yellow;
                        |5: StarColour := LightestWhite;
                    END;
                    Plot (RANDOM(320), RANDOM(200), StarColour);
                END;
                DrawPillarTop(Pillar2X, Pillar2Y);
                DrawPillarTop(Pillar3X, Pillar2Y+20);
                DrawPillarTop(Pillar4X, Pillar2Y+40);
                DrawPillarTop(Pillar5X, Pillar2Y+60);
                DrawPlane5025();
            END;
            NoSound();

            (* Circle fly-through *)
            FOR BlueCircles := 1 TO NoOfCircles DO
                IF NOT (GameOver) THEN
                    Graph.ClearScreen (Graph._GCLEARSCREEN);
                    FOR Stars := 1 TO 15 DO
                        CASE (RANDOM(5)) OF
                            |1: StarColour := Blue;
                            |2: StarColour := White;
                            |3: StarColour := Grey;
                            |4: StarColour := Yellow;
                            |5: StarColour := LightestWhite;
                        END;
                        Plot(RANDOM(320), RANDOM(200), StarColour);
                    END;
                    CircleRadius := (BlueCircles + 20) MOD 10;
                    IF (CircleRadius = 0) THEN
                        CircleRadius := 10;
                    END;
                    WHILE (CircleRadius < 200) DO
                        IF (CircleRadius < 40) THEN
                            CircleColour := DarkGrey
                        ELSIF (CircleRadius < 80) THEN
                            CircleColour := DarkestBlue
                        ELSIF (CircleRadius < 120) THEN
                            CircleColour := DarkBlue
                        ELSIF (CircleRadius < 160) THEN
                            CircleColour := Blue
                        ELSE (* CircleRadius >= 160 *)
                            CircleColour := LightBlue;
                        END;
                        Circle(160, 100, CircleRadius, CircleColour);
                        CircleRadius := CircleRadius*2;
                    END;
                    OldPlaneX := PlaneX;
                    CheckMouse();
                    PlaneX := OldPlaneX;
                    DrawPlane5025();
                    IF (PlaneX<145) THEN
                        PlaneX := PlaneX + RANDOM(5);
                    ELSE
                        PlaneX := PlaneX - RANDOM(5);
                    END;
                END;
            END; (* Circle fly-through *)
        ELSE (* Fell off pillars, navigate along ground *)
            Graph.ClearScreen(Graph._GCLEARSCREEN);
            FOR PillarCount := 200 TO 100 BY -8 DO
                Rectangle(0, PillarCount, 320, 201, DarkBrown, TRUE);
                DrawPlane5025();
                NoSound();
                Sound(PillarCount*5);
            END;
            NoSound();
            Rectangle (0, 100, 320, 200, DarkBrown, TRUE);
            PillarCount := 0;
            Pillar1X := (RANDOM(11)+1)*25; Pillar2X := (RANDOM(11)+1)*25;
            Pillar3X := (RANDOM(11)+1)*25; Pillar4X := (RANDOM(11)+1)*25;
            Pillar5X := (RANDOM(11)+1)*25;
            WHILE (PillarCount < NewNoOfPillars) AND NOT (GameOver) DO
                PillarCount := PillarCount + 1;
                Pillar5X := Pillar4X; Pillar4X := Pillar3X; Pillar3X := Pillar2X;
                Pillar2X := Pillar1X; Pillar1X := (RANDOM(11)+1)*25;
                FOR Stars := 1 TO 15 DO
                    CASE (RANDOM(5)) OF
                        |1: StarColour := LightBlue;
                        |2: StarColour := White;
                        |3: StarColour := Grey;
                        |4: StarColour := LightestYellow;
                        |5: StarColour := LightestWhite;
                    END;
                    Plot(RANDOM(320), RANDOM(100), StarColour);
                END;
                FOR Pillar1Y := 100 TO 118 BY 2 DO
                    IF NOT (GameOver) THEN
                        Delay(GameSpeed*2);
                        Pillar2Y := Pillar1Y + 20; Pillar3Y := Pillar2Y + 20;
                        Pillar4Y := Pillar3Y + 20; Pillar5Y := Pillar4Y + 20;
                        IF (Pillar1Y<105) THEN
                            Rectangle(Pillar1X, 200 - Pillar1Y, Pillar1X + 1, Pillar1Y, DarkestGrey, TRUE);
                        ELSIF (Pillar1Y>104) AND (Pillar1Y<112) THEN
                            Rectangle(Pillar1X, 200 - Pillar1Y, Pillar1X + 3, Pillar1Y, Grey, TRUE);
                        ELSIF (Pillar1Y>111) THEN
                            DrawPillarBottom(Pillar1X, Pillar1Y);
                        END;
                        DrawPillarBottom(Pillar2X, Pillar2Y);
                        DrawPillarBottom(Pillar3X, Pillar3Y);
                        DrawPillarBottom(Pillar4X, Pillar4Y);
                        DrawPillarBottom(Pillar5X, Pillar5Y);
                        IF (Point(PlaneX + 25, PlaneY - 2) <> DarkBrown) THEN
                            OldPlaneX := PlaneX;
                            Die();
                            Rectangle(OldPlaneX, PlaneY, OldPlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkBrown, TRUE);
                        END;
                        OldPlaneX := PlaneX;
                        CheckMouse();
                        Rectangle(OldPlaneX, PlaneY, OldPlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkBrown, TRUE);
                        IF (Graph.Point(315, 195) = Black) THEN
                            Rectangle(250, 190, 320, 200, DarkBrown, TRUE);
                        END;
                        DrawPlane5025();
                    END;
                END;
                Rectangle(Pillar5X, 0, Pillar5X + 27, 100, Black, TRUE);
                Rectangle(Pillar5X, 100, Pillar5X + 27, 200, DarkBrown, TRUE);
            END; (* WHILE PillarCount *)

            IF NOT GameOver THEN
                FOR PillarCount := 100 TO 300 BY 8 DO
                    Rectangle(0, 0, 320, PillarCount, Black, TRUE);
                    DrawPlane5025();
                    NoSound();
                    Sound(PillarCount*5);
                END;
            END;
            NoSound();
        END; (* Fell off pillars, navigate along ground *)
    END; (* NOT GameOver *)

    IF GameOver THEN
        DrawGameOver();
    END;
END Screen7;

END Screens7.
