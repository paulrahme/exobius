IMPLEMENTATION MODULE Screens1;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT
    Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius;

FROM Graph IMPORT
    SetClipRgn, GetImage, PutImage,
    Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point;

FROM Lib IMPORT
    Sound, NoSound, Delay, RANDOM;

FROM Exobius IMPORT
    PlaneWidth, PlaneHeight,
    EnemyYStart, PlaneXMin, PlaneXMax, CollisionY,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    PlaneX, BulletX, BulletY, PlaneY, Width, Height, 
    Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X, Enemy6X,
    OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive, SixAlive,
    Enemies, Xs, Ys,
    Count, Lives, EnemyY,
    Screen, ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
    DrawBullet, DrawPlane, CheckMouse, CheckMouseAndSpecialKeys, CheckKeyboard, Die, DrawGameOver,
    FinishScreen1, Key, CheckDeath1,
    ClearTheBuffer, DrawGameOver, HighDetail;

FROM Sprites IMPORT
    DrawBoomGuards, DrawSpinners, DrawFlyTraps, DrawMaces, DrawPlants,
    DrawIceRocks, DrawSnowMen, DrawSnowBalls, DrawSkiiers, DrawGlowWorms;

PROCEDURE BlankGround1;
BEGIN
    Graph.PutImage(0, 100, GroundAddress, Graph._GPSET);
END BlankGround1;

PROCEDURE DrawEnemies1;
BEGIN
    Enemy1X := 160 - ((10 + (3*(EnemyY-100) DIV 2)) DIV 1);
    Enemy2X := 160 - ((10 + (3*(EnemyY-100) DIV 2))*2 DIV 3);
    Enemy3X := 160 - ((10 + (3*(EnemyY-100) DIV 2)) DIV 3);
    Enemy4X := 160;
    Enemy5X := 160 + ((10 + (3*(EnemyY-100) DIV 2)) DIV 3);
    Enemy6X := 160 + ((10 + (3*(EnemyY-100) DIV 2))*2 DIV 3);
    IF OneAlive THEN
        CASE Enemies OF
            |1: DrawBoomGuards(Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSpinners(Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawPlants(Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawFlyTraps(Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSpinners(Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces(Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawSpinners(Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF TwoAlive THEN
        CASE Enemies OF
            |1: DrawBoomGuards(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSpinners(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawPlants(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawFlyTraps(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSpinners(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawPlants(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSpinners(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |9: DrawSpinners(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |10:DrawSpinners(Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF ThreeAlive THEN
        CASE Enemies OF
            |1: DrawBoomGuards(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSpinners(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawPlants(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawFlyTraps(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSpinners(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawPlants(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSpinners(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |9: DrawSpinners(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |10:DrawSpinners(Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF FourAlive THEN
        CASE Enemies OF
            |1: DrawBoomGuards(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSpinners(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawPlants(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawFlyTraps(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSpinners(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawPlants(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSpinners(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |9: DrawSpinners(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |10:DrawSpinners(Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF FiveAlive THEN
        CASE Enemies OF
            |1: DrawBoomGuards(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSpinners(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawPlants(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawFlyTraps(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSpinners(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawPlants(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSpinners(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |9: DrawSpinners(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |10:DrawSpinners(Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF SixAlive THEN
        CASE Enemies OF
            |1: DrawBoomGuards(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSpinners(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawPlants(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawFlyTraps(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSpinners(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawPlants(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSpinners(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |9: DrawSpinners(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |10:DrawSpinners(Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
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
                DrawPlane(PlaneX, PlaneY, PlaneWidth, PlaneHeight);
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
            CheckMouse;
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
                CheckMouse;
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
        DrawGameOver;
    END;
END Screen1;

END Screens1.