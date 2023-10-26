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
    PutPixel, Count, ClearTheBuffer, CheckSpecialKeys, CheckMouse,
    GameSpeed, Die, GameOver, DrawGameOver;

CONST
    PillarZDiff = 25;
    PillarsVisible = 6;

VAR
    PillarColours : ARRAY[0..27] OF CARDINAL;

PROCEDURE CreateLookupTable();
BEGIN
    PillarColours[0] := DarkestGrey;    PillarColours[1] := DarkestGrey;
    PillarColours[2] := DarkGrey;       PillarColours[3] := DarkGrey;
    PillarColours[4] := Grey;           PillarColours[5] := Grey;
    PillarColours[6] := LightGrey;      PillarColours[7] := LightGrey;
    PillarColours[8] := LightestGrey;   PillarColours[9] := LightestGrey;
    PillarColours[10] := DarkestWhite;  PillarColours[11] := DarkestWhite;
    PillarColours[12] := DarkWhite;     PillarColours[13] := DarkWhite;
    PillarColours[14] := LightWhite;    PillarColours[15] := LightWhite;
    PillarColours[16] := LightestWhite; PillarColours[17] := LightestWhite;
    PillarColours[18] := White;         PillarColours[19] := White;
    PillarColours[20] := DarkestWhite;  PillarColours[21] := DarkestWhite;
    PillarColours[22] := LightGrey;     PillarColours[23] := LightGrey;
    PillarColours[24] := DarkGrey;      PillarColours[25] := DarkGrey;
    PillarColours[25] := DarkestGrey;   PillarColours[27] := DarkestGrey;
END CreateLookupTable;
(*
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
*)
PROCEDURE DrawStars(NumStars : BYTE);
VAR
    Stars : BYTE;
BEGIN
    FOR Stars := 1 TO NumStars DO
        PutPixel(RANDOM(319), RANDOM(199), Stars);
    END;
END DrawStars;

PROCEDURE FlyThroughSpace;
CONST
    NoOfCircles = 200;
VAR
    CircleRadius, BlueCircles, CircleColour, OldPlaneX : CARDINAL;
BEGIN
    (* Bounce up into space *)
    FOR Count := 120 TO 200 BY 5 DO
        NoSound();
        Sound((Count-100)*20);
        Graph.ClearScreen(Graph._GCLEARSCREEN);
        DrawStars(15);
        DrawPlane5025();
    END;
    NoSound();

    (* Circle fly-through *)
    FOR BlueCircles := 1 TO NoOfCircles DO
        IF NOT (GameOver) THEN
            Graph.ClearScreen(Graph._GCLEARSCREEN);
            DrawStars(15);
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
END FlyThroughSpace;

PROCEDURE DrawPillar3D(PillarIdx : CARDINAL; MidOffsetX : INTEGER; ZOffset : CARDINAL; DrawFromGroundPerspective : BOOLEAN);
CONST
    PillarHeightDiff = 15;
VAR
    DrawX : INTEGER;
    BottomY, TopY, PillarWidth, DrawStartX, LineX, Height : CARDINAL;
BEGIN
    DrawX := MidOffsetX; (* MidOffsetX * INTEGER(ZOffset) DIV INTEGER(PillarZDiff * PillarsVisible); *)
    DrawX := 160 + DrawX;
    IF (DrawX < -145) THEN
        DrawX := -145;
    ELSIF (DrawX > 145) THEN
        DrawX := 145;
    END;

    (* Height *)
    IF (PillarIdx < PillarsVisible) THEN
        Height := PillarIdx * PillarHeightDiff;
    ELSE
        Height := PillarsVisible * PillarHeightDiff;
    END;
    
    (* Bottom + Top *)
    IF (DrawFromGroundPerspective) THEN
        BottomY := 199 - ZOffset;
        IF (BottomY < Height) THEN TopY := 0; ELSE TopY := BottomY - Height; END;
        IF (BottomY > 199) THEN BottomY := 199; END;
        PillarWidth := BottomY * 14 DIV 100;
    ELSE
        IF (ZOffset > 199) THEN TopY := 0; ELSE TopY := 199 - ZOffset; END;
        IF (TopY > 199 - Height) THEN BottomY := 199; ELSE BottomY := TopY + Height; END;
        PillarWidth := TopY * 14 DIV 100;
    END;

    (* Draw *)
    DrawStartX := CARDINAL(DrawX) - (PillarWidth DIV 2);
    FOR LineX := 0 TO PillarWidth DO
        Line(DrawStartX + LineX, TopY, DrawStartX + LineX, BottomY, PillarColours[LineX]);
    END;
    IF (TopY > 0) THEN
        Ellipse(CARDINAL(DrawX), TopY, PillarWidth DIV 2, TopY * 5 DIV 200, White, TRUE);
    END;
END DrawPillar3D;

PROCEDURE Screen7;
CONST
    NoOfPillars = 30;
    PlaneCenterX = 135;
    BounceInitialVelocity = 40;
    PlaneGravAccel = 1;
VAR
    NextPillarIdx, NextPillarZ, PillarCount, HorizonHeight, OldPlaneX, ZMoveCount : CARDINAL;
    BounceHeight, BounceVelocity : INTEGER;
    PillarXs : ARRAY[0..NoOfPillars] OF INTEGER;
BEGIN
    ClearTheBuffer();
    CreateLookupTable();

    (* Initialise variables *)
    PlaneX := PlaneCenterX; PlaneY := 175;
    FOR Count := 0 TO (NoOfPillars - 1) DO
        IF (Count < 5) THEN
            PillarXs[Count] := 0;
        ELSE
            PillarXs[Count] := INTEGER(RANDOM(290)) - 145;
        END;
    END;
    HorizonHeight := 100;
    NextPillarIdx := 0; NextPillarZ := PillarZDiff; ZMoveCount := 0;
    BounceHeight := 0; BounceVelocity := BounceInitialVelocity;

    (* Set up starting screen *)
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    Rectangle(0, HorizonHeight, 319, 199, DarkBrown, TRUE);
    DrawPlane5025();

    (* Bouncing on tops of pillars *)
    WHILE (NextPillarIdx < NoOfPillars) AND NOT (GameOver) DO
        Rectangle(0, 0, 319, HorizonHeight - 1, Black, TRUE);
        Rectangle(0, HorizonHeight, 319, 199, DarkBrown, TRUE);
        FOR PillarCount := PillarsVisible TO 0 BY -1 DO
            DrawPillar3D(NextPillarIdx + PillarCount, PillarXs[NextPillarIdx + PillarCount], (PillarCount * PillarZDiff) + NextPillarZ, FALSE);
        END;

        (* Update plane movement *)
        IF (BounceVelocity > -BounceInitialVelocity) THEN
            BounceVelocity := BounceVelocity - PlaneGravAccel;
        END;
        BounceHeight := BounceHeight + BounceVelocity;
        PlaneY := PlaneStartY - (BounceHeight DIV 10);
        CheckMouse();
        DrawPlane5025();

        (* Update next pillar to come onscreen from the horizon *)
        IF (ZMoveCount > 0) THEN
            ZMoveCount := ZMoveCount - 1;
        ELSE
            ZMoveCount := 2;
            NextPillarZ := NextPillarZ - 1;
            IF (NextPillarZ < 2) THEN
                NextPillarIdx := NextPillarIdx + 1;
                NextPillarZ := PillarZDiff;
                BounceHeight := 0; BounceVelocity := BounceInitialVelocity;
            END;
        END;
        Delay(GameSpeed DIV 5);
    END; (* Bouncing on tops of pillars *)

    IF NOT (GameOver) THEN
        (* Successfully bounced on all pillars? *)
        IF (PillarCount >= NoOfPillars) THEN 
            FlyThroughSpace();
        END;
    END;

    IF GameOver THEN
        DrawGameOver();
    END;
END Screen7;

END Screens7.
