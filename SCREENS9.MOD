
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
    Count, GameOver, GameSpeed, Die, DrawLives, UpdateScore, HudY, HudBg, DrawGameOver;

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

PROCEDURE DrawSkyPortion(LeftX, RightX : CARDINAL);
BEGIN
    Rectangle(LeftX, 0, RightX, 8, 184, TRUE);
    Rectangle(LeftX, 9, RightX, 15, 183, TRUE);
    Rectangle(LeftX, 16, RightX, 21, 182, TRUE);
    Rectangle(LeftX, 22, RightX, 27, 181, TRUE);
    Rectangle(LeftX, 28, RightX, 34, 180, TRUE);
    Rectangle(LeftX, 35, RightX, 41, 179, TRUE);
    Rectangle(LeftX, 42, RightX, 48, 178, TRUE);
    Rectangle(LeftX, 49, RightX, 55, 177, TRUE);
    Rectangle(LeftX, 56, RightX, 62, 176, TRUE);
    Rectangle(LeftX, 63, RightX, 69, 177, TRUE);
    Rectangle(LeftX, 70, RightX, 76, 178, TRUE);
    Rectangle(LeftX, 77, RightX, 83, 179, TRUE);
    Rectangle(LeftX, 84, RightX, 90, 180, TRUE);
    Rectangle(LeftX, 91, RightX, 97, 181, TRUE);
    Rectangle(LeftX, 98, RightX, 104, 182, TRUE);
    Rectangle(LeftX, 105, RightX, 199, DarkRed, TRUE);
    DrawLives();
    UpdateScore(0);
END DrawSkyPortion;

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
    HudY := 0; HudBg := 184;
    DrawSkyPortion(0, 319);

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
                    Die();
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
        DrawSkyPortion(Pillar5X - 13, Pillar5X + 13);
        NoSound();
        IF (GameOver) THEN
            DrawGameOver();
        END;
    END;
END Screen9;

END Screens9.
