IMPLEMENTATION MODULE Screens7;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Exobius, Storage;
FROM Graph IMPORT Rectangle, Line, HLine, Circle, Ellipse, Plot, Point, GetImage, PutImage;
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
    PutPixel, Count, ClearTheBuffer, CheckSpecialKeys, CheckMouseAndSpecialKeys, CheckMouse,
    GameSpeed, Die, GameOver, DrawGameOver;

CONST
    NoOfPillars = 30;
    PillarZDiff = 25;
    PillarsVisible = 6;

TYPE
    StarPos = RECORD
        X, Y : CARDINAL;
        Color : BYTE;
    END;

VAR
    PillarColours : ARRAY[0..27] OF CARDINAL;
    PillarYOffsets : ARRAY[0..14] OF CARDINAL;

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

    PillarYOffsets[0] := 0;
    PillarYOffsets[1] := 1;
    PillarYOffsets[2] := 2; PillarYOffsets[3] := 2;
    PillarYOffsets[4] := 3; PillarYOffsets[5] := 3; PillarYOffsets[6] := 3; PillarYOffsets[7] := 3; PillarYOffsets[8] := 3;
    PillarYOffsets[9] := 4; PillarYOffsets[10] := 4; PillarYOffsets[11] := 4; PillarYOffsets[12] := 4; PillarYOffsets[13] := 4; PillarYOffsets[14] := 4;
END CreateLookupTable;

PROCEDURE FlyThroughSpace;
CONST
    NoOfCircles = 400;
VAR
    CircleRadius, BlueCircles, CircleColour, StarCount : CARDINAL;
    Stars : ARRAY[0..15] OF StarPos;
BEGIN
    (* Prepare star positions *)
    FOR StarCount := 0 TO 15 DO
        WITH Stars[StarCount] DO
            X := RANDOM(319);
            Y := RANDOM(199);
            Color := BYTE(StarCount);
        END;
    END;

    (* Bounce up into space *)
    FOR Count := 1 TO 50 DO
        NoSound();
        Sound((Count)*30);
        Graph.ClearScreen(Graph._GCLEARSCREEN);
        FOR StarCount := 0 TO 15 DO
            WITH Stars[StarCount] DO
                Y := Y + Count;
                IF (Y > 199) THEN Y := RANDOM(Count); END;
                PutPixel(X, Y, Color);
            END;
        END;
        DrawPlane5025();
        Delay(GameSpeed);
    END;
    NoSound();

    (* Circle fly-through *)
    FOR BlueCircles := 1 TO NoOfCircles DO
        IF NOT (GameOver) THEN
            Graph.ClearScreen(Graph._GCLEARSCREEN);
            FOR StarCount := 0 TO 15 DO
                PutPixel(RANDOM(319), RANDOM(199), BYTE(StarCount));
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
            CheckMouseAndSpecialKeys();
            IF (PlaneX < PlaneStartX) THEN
                PlaneX := PlaneX + RANDOM(5);
            ELSE
                PlaneX := PlaneX - RANDOM(5);
            END;
            IF (PlaneY < PlaneStartY) THEN
                PlaneY := PlaneY + 1;
            END;
            DrawPlane5025();
        END;
    END; (* Circle fly-through *)
END FlyThroughSpace;

PROCEDURE DrawPillar3D(PillarIdx : CARDINAL; MidOffsetX : INTEGER; ZOffset : CARDINAL; DrawFromAirPerspective : BOOLEAN);
CONST
    PillarHeightDiff = 5;
    PillarMaxHeight = 90;
VAR
    DrawX : INTEGER;
    BottomY, TopY, PillarWidth, DrawStartX, DrawOffsetY, LineX, Height : CARDINAL;
BEGIN
    DrawX := MidOffsetX;
    IF (DrawX < -145) THEN
        DrawX := -145;
    ELSIF (DrawX > 145) THEN
        DrawX := 145;
    END;
    DrawX := 160 + DrawX;

    (* Bottom + Top *)
    IF (DrawFromAirPerspective) THEN
        Height := PillarIdx * PillarHeightDiff; IF (Height > PillarMaxHeight) THEN Height := PillarMaxHeight; END;
        IF (ZOffset > 199) THEN TopY := 0; ELSE TopY := 199 - ZOffset; END;
        IF (TopY > 199 - Height) THEN BottomY := 199; ELSE BottomY := TopY + Height; END;
        PillarWidth := TopY * 14 DIV 100;
    ELSE
        ZOffset := ZOffset DIV 2;
        BottomY := 199 - ZOffset;
        TopY := ZOffset;
        PillarWidth := (BottomY - 100) * 27 DIV 100;
    END;

    (* Draw *)
    DrawStartX := CARDINAL(DrawX) - (PillarWidth DIV 2);
    FOR LineX := 0 TO PillarWidth DO
        IF (LineX < PillarWidth DIV 2) THEN
            DrawOffsetY := PillarYOffsets[LineX];
        ELSE
            DrawOffsetY := PillarYOffsets[PillarWidth - LineX];
        END;
        IF (TopY < DrawOffsetY) THEN DrawOffsetY := 0; END;
        Line(DrawStartX + LineX, TopY - DrawOffsetY, DrawStartX + LineX, BottomY + DrawOffsetY, PillarColours[LineX]);
    END;
    IF (DrawFromAirPerspective) THEN
        Ellipse(CARDINAL(DrawX), TopY, PillarWidth DIV 2, TopY * 5 DIV 200, White, TRUE);
        (* Last Pillar? *)
        IF (PillarIdx = NoOfPillars - 1) THEN
            FOR BottomY := 0 TO PillarWidth DO
                HLine(DrawStartX, TopY - BottomY * 2, DrawStartX + PillarWidth, PillarColours[BottomY]);
            END;
        END;
    END;
END DrawPillar3D;

PROCEDURE Screen7;
CONST
    LockedMovementBounces = 4;
    PlaneCenterX = 135;
    BounceInitialVelocity = 36;
    PlaneGravAccel = 1;
VAR
    NextPillarIdx, NextPillarZ, PillarCount, ZMoveCount, DrawPillarIdx, DrawX, BehindPlaneSize : CARDINAL;
    BounceHeight, BounceVelocity, PlanePillarDiffX : INTEGER;
    PillarXs : ARRAY[0..NoOfPillars] OF INTEGER;
    BehindPlaneAddress : ADDRESS;
BEGIN
    ClearTheBuffer();
    CreateLookupTable();

    (* Initialise variables *)
    PlaneX := PlaneCenterX; PlaneY := 175;
    FOR Count := 0 TO (NoOfPillars - 1) DO
        IF (Count < PillarsVisible) THEN
            PillarXs[Count] := 0;
        ELSIF (Count < PillarsVisible * 2) THEN
            PillarXs[Count] := INTEGER(RANDOM(120)) - 60;
        ELSE
            PillarXs[Count] := INTEGER(RANDOM(260)) - 130;
        END;
    END;
    NextPillarIdx := 0; NextPillarZ := PillarZDiff; ZMoveCount := 0;
    PlaneInAir := TRUE; BounceHeight := 0; BounceVelocity := BounceInitialVelocity;

    (* Set up starting screen *)
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane5025();

    (* Bouncing on / driving between pillars *)
    WHILE (NextPillarIdx < NoOfPillars) AND NOT (GameOver) DO
        IF (PlaneInAir) THEN
            Graph.ClearScreen(Graph._GCLEARSCREEN);
        ELSE
            Rectangle(PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkBrown, TRUE);
        END;

        FOR PillarCount := PillarsVisible TO 0 BY -1 DO
            DrawPillarIdx := NextPillarIdx + PillarCount;
            IF (DrawPillarIdx < NoOfPillars) THEN
                DrawPillar3D(NextPillarIdx + PillarCount, PillarXs[NextPillarIdx + PillarCount], (PillarCount * PillarZDiff) + NextPillarZ, PlaneInAir);
            END;
        END;

        (* Update bouncing movement *)
        IF (PlaneInAir) THEN
            IF (BounceVelocity > -BounceInitialVelocity) THEN
                BounceVelocity := BounceVelocity - PlaneGravAccel;
            END;
            BounceHeight := BounceHeight + BounceVelocity;
            PlaneY := PlaneStartY - (BounceHeight DIV 10);
        ELSIF NOT (BounceVelocity = 0) THEN (* Just fell off *)
            BounceVelocity := 0; BounceHeight := 0;
            BehindPlaneSize := CARDINAL(Graph.ImageSize(0, 0, PlaneWidth, PlaneHeight));
            Storage.ALLOCATE(BehindPlaneAddress, BehindPlaneSize);
            NoSound();
            FOR PlaneY := 0 TO PlaneStartY DO
                Sound((200 - PlaneY) * 2);
                GetImage(PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, BehindPlaneAddress);
                DrawPlane5025();
                Delay(2);
                Graph.PutImage(PlaneX, PlaneY, BehindPlaneAddress, Graph._GPSET);
            END;
            NoSound();
            Storage.DEALLOCATE(BehindPlaneAddress, BehindPlaneSize);
        END;

        (* Update horizontal movement *)
        CheckMouse();
        IF (NextPillarIdx < LockedMovementBounces) THEN PlaneX := PlaneCenterX; END;
        DrawPlane5025();

        (* Frame delay between pillar movement *)
        IF (ZMoveCount > 0) THEN
            ZMoveCount := ZMoveCount - 1;
        ELSE
            IF (PlaneInAir) THEN
                NoSound();
                IF (BounceVelocity > 0) AND (BounceVelocity > BounceInitialVelocity DIV 2) THEN
                    Sound(200 - CARDINAL(BounceVelocity + BounceInitialVelocity) * 2);
                END;
                ZMoveCount := 2;
            END;
            NextPillarZ := NextPillarZ - 1;
            
            (* Passing nearest pillar? *)
            IF (NextPillarZ < 2) THEN
                PlanePillarDiffX := INTEGER(PlaneX) - 135 - PillarXs[NextPillarIdx];
                IF (PlaneInAir) THEN (* In air, missed pillar? *)
                    IF (PlanePillarDiffX < -20) OR (PlanePillarDiffX > 20) THEN
                        PlaneInAir := FALSE;
                        Rectangle(0, 0, 319, 99, Black, TRUE);
                        Rectangle(0, 100, 319, 199, DarkBrown, TRUE);
                    END;
                ELSE (* On ground, hit pillar? *)
                    IF (PlanePillarDiffX > -30) AND (PlanePillarDiffX < 30) THEN
                        Die();
                        Rectangle(0, PlaneY, 319, 199, DarkBrown, TRUE);
                    END;
                END;

                (* Move onto next pillar *)
                IF (PlaneInAir) THEN
                    BounceHeight := 0; BounceVelocity := BounceInitialVelocity;
                ELSE
                    DrawX := CARDINAL(160 + PillarXs[NextPillarIdx]);
                    Rectangle(DrawX - 14, 0, DrawX + 14, 99, Black, TRUE);
                    Rectangle(DrawX - 14, 100, DrawX + 14, 199, DarkBrown, TRUE);
                END;
                NextPillarIdx := NextPillarIdx + 1;
                NextPillarZ := PillarZDiff;
            END;
        END;

        Delay(GameSpeed);
    END;
    NoSound();

    IF (GameOver) THEN
        DrawGameOver();
    END;
END Screen7;

END Screens7.
