
IMPLEMENTATION MODULE Screens9;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, IO, Exobius;
FROM Graph IMPORT Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point, GetImage;
FROM Lib IMPORT NoSound, Delay, RANDOM;
FROM Exobius IMPORT
    PlaneWidth, PlaneHeight,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, PlaneY, PlaneStartX, PlaneStartY, DrawPlane5025, CheckMouse,
    Count, GameOver, GameSpeed,
    Die, DrawGameOver;

PROCEDURE DrawPillarBottom(x, y : CARDINAL);
VAR
    OffsetX, OffsetY : INTEGER;
    DrawX, PillarY, PillarColour : CARDINAL;
BEGIN
    FOR OffsetX := -13 TO 13 DO
        CASE OffsetX OF
            |-13,13: PillarY := y; PillarColour := DarkestBlue;
            |-12,12 : PillarY := y + 1; PillarColour := DarkBlue;
            |-11,-10,10,11 : PillarY := y + 2; PillarColour := Blue;
            |-9,-8,-7,-6,-5,5,6,7,8,9 : PillarY := y + 3; PillarColour := LightBlue;
            |-4,-3,-2,-1,0,1,2,3,4 : PillarY := y + 4; PillarColour := LightestBlue;
        END;
        OffsetY := y - 100;
        DrawX := CARDINAL(INTEGER(x) + (OffsetX * OffsetY DIV 100));
        IF (PillarY < 200) THEN
            Line(DrawX, 200 - PillarY, DrawX, PillarY, PillarColour);
        ELSE
            Line(DrawX, 0, DrawX, 200, PillarColour);
        END;
    END;
END DrawPillarBottom;

PROCEDURE DeletePillar(x : CARDINAL);
BEGIN
    Rectangle (x - 13, 0, x + 13, 6, 0, TRUE);
    Rectangle (x - 13, 7, x + 13, 13, 184, TRUE);
    Rectangle (x - 13, 14, x + 13, 20, 183, TRUE);
    Rectangle (x - 13, 28, x + 13, 34, 181, TRUE);
    Rectangle (x - 13, 21, x + 13, 28, 182, TRUE);
    Rectangle (x - 13, 35, x + 13, 41, 180, TRUE);
    Rectangle (x - 13, 42, x + 13, 48, 179, TRUE);
    Rectangle (x - 13, 49, x + 13, 55, 178, TRUE);
    Rectangle (x - 13, 56, x + 13, 62, 177, TRUE);
    Rectangle (x - 13, 63, x + 13, 69, 176, TRUE);
    Rectangle (x - 13, 70, x + 13, 76, 177, TRUE);
    Rectangle (x - 13, 77, x + 13, 83, 178, TRUE);
    Rectangle (x - 13, 84, x + 13, 90, 179, TRUE);
    Rectangle (x - 13, 91, x + 13, 97, 180, TRUE);
    Rectangle (x - 13, 98, x + 13, 104, 181, TRUE);
    Rectangle (x - 13, 105, x + 13, 200, DarkRed, TRUE);
END DeletePillar;

PROCEDURE Screen9;
CONST
    PlanetX = 160; PlanetY = 100;
    NoOfPillars = 50;
    NoOfCircles = 200;
VAR
    PillarCount, Pillar1X, Pillar2X, Pillar3X, Pillar4X, Pillar5X, Pillar1Y,
    Pillar2Y, Pillar3Y, Pillar4Y, Pillar5Y, Pillar6Y, OldPlaneX : CARDINAL;
BEGIN
    (* Zoom into planet *)
    FOR Count := 50 TO 250 BY 5 DO
        Disc(PlanetX, PlanetY, Count, DarkRed);
        Delay(GameSpeed);
    END;

    (* Draw ground and pan up to show horizon *)
    Rectangle(0, 0, 319, 199, DarkRed, TRUE);
    FOR Count := 0 TO 100 DO
        HLine(0, Count, 320, 178);
        Delay(GameSpeed);
    END;

    (* Draw faded sky *)
    Rectangle(0,0,319,6,0,TRUE);
    Rectangle(0,7,319,13,184,TRUE);
    Rectangle(0,14,319,20,183,TRUE);
    Rectangle(0,21,320,28,182,TRUE);
    Rectangle(0,28,319,34,181,TRUE);
    Rectangle(0,35,320,41,180,TRUE);
    Rectangle(0,42,320,48,179,TRUE);
    Rectangle(0,49,319,55,178,TRUE);
    Rectangle(0,56,319,62,177,TRUE);
    Rectangle(0,63,319,69,176,TRUE);
    Rectangle(0,70,319,76,177,TRUE);
    Rectangle(0,77,319,83,178,TRUE);
    Rectangle(0,84,319,90,179,TRUE);
    Rectangle(0,91,320,97,180,TRUE);
    Rectangle(0,98,319,104,181,TRUE);

    PlaneX := PlaneStartX; PlaneY := PlaneStartY;
    PillarCount := 0;
    Pillar1X := (RANDOM(11)+1)*25; Pillar2X := (RANDOM(11)+1)*25; Pillar3X := 325; Pillar4X := 325; Pillar5X := 325;
    WHILE (PillarCount < NoOfPillars) AND NOT (GameOver) DO
        PillarCount := PillarCount + 1;
        Pillar5X := Pillar4X; Pillar4X := Pillar3X; Pillar3X := Pillar2X; Pillar2X := Pillar1X;
        Pillar1X := (RANDOM(11)+1)*25;
        IF (PillarCount > NoOfPillars - 6) THEN
            Pillar1X := 325;
        END;
        FOR Pillar1Y := 100 TO 118 BY 2 DO
            IF NOT (GameOver) THEN
                Pillar2Y := Pillar1Y + 20; Pillar3Y := Pillar2Y + 20; Pillar4Y := Pillar3Y + 20; Pillar5Y := Pillar4Y + 20;
                IF (Pillar1Y < 110) THEN
                    Rectangle(Pillar1X, 200 - Pillar1Y, Pillar1X + 1, Pillar1Y, DarkestBlue, TRUE);
                ELSE
                    DrawPillarBottom(Pillar1X, Pillar1Y);
                END;
                DrawPillarBottom(Pillar2X, Pillar2Y);
                DrawPillarBottom(Pillar3X, Pillar3Y);
                DrawPillarBottom(Pillar4X, Pillar4Y);
                DrawPillarBottom(Pillar5X, Pillar5Y);
                IF (Point(PlaneX + 15, PlaneY - 4) <> DarkRed) OR (Point(PlaneX + 35, PlaneY - 4) <> DarkRed) THEN
                    OldPlaneX := PlaneX;
                    Die(0);
                    REPEAT
                        PlaneX := Lib.RANDOM(250);
                    UNTIL (Point(PlaneX + (PlaneWidth DIV 2), PlaneY - 1) = DarkRed);
                    Rectangle(OldPlaneX, PlaneY, OldPlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkRed, TRUE);
                END;
                OldPlaneX := PlaneX;
                CheckMouse();
                Rectangle(OldPlaneX, PlaneY, OldPlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkRed, TRUE);
                DrawPlane5025();
                Delay(GameSpeed);
            END;
        END;
        DeletePillar(Pillar5X);
        NoSound();
        IF (GameOver) THEN
            DrawGameOver();
        END;
    END;
END Screen9;

END Screens9.
