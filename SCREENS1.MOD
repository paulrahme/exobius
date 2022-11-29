IMPLEMENTATION MODULE Screens1;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, Exobius;
FROM Graph IMPORT ClearScreen, _GCLEARSCREEN, SetClipRgn, Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point;
FROM Lib IMPORT Delay, RANDOM;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Sprites IMPORT DrawBoomGuards, DrawSpinners, DrawFlyTraps, DrawMaces, DrawPlants;
FROM Exobius IMPORT
    PlaneX, PlaneY, PlaneStartX, PlaneStartY, BulletX, BulletY,
    PutPixel, GetPixel,
    PlaneWidth, PlaneHeight,
    EnemyYStart, CollisionY,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X, Enemy6X,
    OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive, SixAlive,
    Enemies, Xs, Ys,
    Count, Lives, EnemyY,
    ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
    Update3DBullet, DrawPlane, DrawPlane5025, CheckMouse, CheckMouseAndSpecialKeys, Die, DrawGameOver,
    FinishScreen,
    CheckSpecialKeys, ClearTheBuffer, DrawGameOver;

CONST
    MountY = 140;
    NumGroundDots = 32;
    GroundDotsMoveSpeedDiv = 3; (* Larger = slower movement *)

TYPE
    GroundDot = RECORD
        CurrX, FinalXOffset, YOffset : CARDINAL;
        XOffsetIsOnRight : BOOLEAN;
    END;

VAR
    GroundDots : ARRAY[0..NumGroundDots] OF GroundDot;

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

PROCEDURE CheckDeath1;
VAR
    Dead : BOOLEAN;
BEGIN
    IF (PlaneX < 53) THEN Dead := OneAlive;
    ELSIF (PlaneX < 106) THEN Dead := TwoAlive;
    ELSIF (PlaneX < 160) THEN Dead := ThreeAlive;
    ELSIF (PlaneX < 213) THEN Dead := FourAlive;
    ELSIF (PlaneX < 266) THEN Dead := FiveAlive;
    ELSE Dead := SixAlive;
    END;

    IF (Dead) THEN
        Die();
        OneAlive := FALSE;
    END;
END CheckDeath1;

PROCEDURE DrawMountain(x, y, radius : CARDINAL);
BEGIN
    Ellipse (x, y, radius - (radius*2 DIV 9), radius, DarkBrown, TRUE);
    Ellipse (x, y, radius - (radius*3 DIV 9), radius, Brown, FALSE);
    Ellipse (x, y, radius - (radius*7 DIV 18),radius, Brown, FALSE);
    Ellipse (x, y, radius - (radius*4 DIV 9), radius, Brown, TRUE);
    Ellipse (x, y, radius - (radius*5 DIV 9), radius, LightBrown, FALSE);
    Ellipse (x, y, radius - (radius*11 DIV 18),radius, LightBrown, FALSE);
    Ellipse (x, y, radius - (radius*2 DIV 3), radius, LightBrown, TRUE);
    Ellipse (x, y, radius - (radius*7 DIV 9), radius, LightestBrown, FALSE);
    Ellipse (x, y, radius - (radius*15 DIV 18), radius, LightestBrown, FALSE);
    Ellipse (x, y, radius - (radius*8 DIV 9), radius, LightestBrown, TRUE);
END DrawMountain;

PROCEDURE DrawMountains();
VAR
    MountX, MtRadius, MtPointX, MtPointY : CARDINAL;
    GotPixel : SHORTCARD;
BEGIN
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

    FOR Count := 1 TO 20 DO
        MtRadius := Lib.RANDOM(50) + 40;
        MountX := Lib.RANDOM(320);
        DrawMountain(MountX, MountY, MtRadius);
    END;

    MountX := 160;
    MtRadius := 70;
    DrawMountain(MountX, MountY, MtRadius);

    FOR Count := 1 TO 4000 DO
        MtPointX := Lib.RANDOM(319);
        MtPointY := Lib.RANDOM(50) + 50;
        GotPixel := GetPixel(MtPointX, MtPointY);
        IF (GotPixel = LightestBrown) OR (GotPixel = LightBrown) OR (GotPixel = Brown) OR (GotPixel = DarkBrown) OR (GotPixel = DarkestBrown) THEN
            Plot(MtPointX, MtPointY, Lib.RANDOM(7) + 16);
        END;
    END;

    SetClipRgn(0, 0, 320, 200);
END DrawMountains;

PROCEDURE UpdateGroundDots();
VAR
    DotIdx, XOffset, YOffsetMult : CARDINAL;
    Color : BYTE;
    Dot : GroundDot;
BEGIN
    FOR DotIdx := 0 TO (NumGroundDots-1) DO
        WITH GroundDots[DotIdx] DO
            (* Erase previous dot *)
            PutPixel(CurrX, 100 + YOffset, LightBrown);

            (* Update y position *)
            YOffset := (YOffset * 4) DIV 3;
            IF (YOffset > 99) THEN
                FinalXOffset := Lib.RANDOM(150) + 5;
                YOffset := Lib.RANDOM(10) + 3;
            END;

            (* Calculate X perspective using final X and current y *)
            YOffsetMult := YOffset + 8;                         (* convert to 100 -> 0 for perspective calc *)
            XOffset := (FinalXOffset * YOffsetMult) DIV 118;    (* starts at just under 1/16th distance from centre, ends at full distance *)
            IF XOffsetIsOnRight THEN
                CurrX := 160 + XOffset;
            ELSE
                CurrX := 160 - XOffset;
            END;

            (* Dot's colour - "random" from final X *)
            IF ODD(FinalXOffset) THEN
                Color := LightestBrown;
            ELSE
                Color := Brown;
            END;

            (* Draw new dot *)
            PutPixel(CurrX, 98 + YOffset, Color);
        END;
    END;
END UpdateGroundDots;

PROCEDURE Screen1;
VAR
    FrameBetweenWaves, DotIdx : CARDINAL;
    LineXStart : INTEGER;
BEGIN
    ClearScreen(_GCLEARSCREEN);

    DrawMountains();
    (* Draw grass *)

    Rectangle(0, 100, 320, 200, LightGreen, TRUE);
    FOR Count := 1 TO 1000 DO
        Plot(Lib.RANDOM(320), Lib.RANDOM(25) + 100, DarkestGreen);
        Plot(Lib.RANDOM(320), Lib.RANDOM(40) + 100, DarkestGreen);
        Plot(Lib.RANDOM(320), Lib.RANDOM(40) + 120, DarkGreen);
        Plot(Lib.RANDOM(320), Lib.RANDOM(40) + 140, Green);
        Plot(Lib.RANDOM(320), Lib.RANDOM(40) + 160, LightestGreen);
    END;
    (* Draw path *)
    Xs[0] := 0; Xs[1] := 150; Xs[2] := 170; Xs[3] := 319;
    Ys[0] := 199; Ys[1] := 100; Ys[2] := 100; Ys[3] := 199;
    Polygon(4, Xs, Ys, DarkestBrown);
    (* Draw mountain entrance *)
    Rectangle(150, 87, 170, 100, Black, TRUE);

    (* Screen is now ready; Set up for action *)

    (* Fly in plane *)
    IF (NOT GameOver) THEN
        FOR PlaneY := 199 TO PlaneStartY BY -1 DO
            Rectangle(135, 175, 135 + PlaneWidth, 175 + PlaneHeight, DarkestBrown, TRUE);
            PlaneX := 135 - (PlaneY - 175);
            DrawPlane(PlaneX, PlaneY, PlaneY - 125);
            Lib.Delay(50);
            CheckSpecialKeys();
            IF (GameOver) THEN PlaneY := PlaneStartY; END;
        END;
    END;

    (* Flash the ground *)
    Polygon (4, Xs, Ys, DarkestBrown);
    DrawPlane5025();
    Lib.Delay (20);
    Polygon (4, Xs, Ys, Brown);
    DrawPlane5025();
    Lib.Delay (20);
    Polygon (4, Xs, Ys, DarkestBrown);
    DrawPlane5025();
    Lib.Delay (20);
    Polygon (4, Xs, Ys, Brown);
    DrawPlane5025();
    Lib.Delay (20);
    Polygon (4, Xs, Ys, LightBrown);
    DrawPlane5025();
    Lib.Delay (20);
    Rectangle (0, 101, 320, 200, LightGreen, TRUE);
    Polygon (4, Xs, Ys, Brown);
    DrawPlane5025();
    Lib.Delay (20);
    Polygon (4, Xs, Ys, LightBrown);
    Line (150, 100, 0, 200, Brown);
    Line (149, 100 ,0, 199, Brown);
    Line (170, 100, 320, 200, DarkBrown);
    Line (171, 100, 320, 199, DarkBrown);
    Line (148, 100, 0, 198, DarkestBrown);
    Line (172, 100, 320, 198, DarkestBrown);

    FOR DotIdx := 0 TO (NumGroundDots-1) DO
        WITH GroundDots[DotIdx] DO
            CurrX := 160;
            FinalXOffset := Lib.RANDOM(150) + 5;
            XOffsetIsOnRight := ODD(DotIdx);
            YOffset := Lib.RANDOM(90) + 5;
        END;
    END;

    (* Gameplay Starts *)

    DrawPlane5025();
    ScreenComplete := FALSE;
    Enemies := 1;
    BulletY := 0;

    WHILE NOT GameOver AND NOT ScreenComplete DO
        (* Between waves of enemies *)
        FOR FrameBetweenWaves := 1 TO 20 DO
            CheckMouse();
            Polygon(4, Xs, Ys, LightBrown);
            UpdateGroundDots();
            Update3DBullet();
            DrawPlane5025();
            Lib.Delay(GameSpeed);
        END;

        (* Draw wave of enemies *)
        OneAlive := TRUE; TwoAlive := TRUE; ThreeAlive := TRUE; FourAlive := TRUE; FiveAlive := TRUE; SixAlive := TRUE;
        FOR EnemyY := 101 TO 200 DO
            IF (GameOver=FALSE) AND (ScreenComplete=FALSE) THEN
                CheckMouse;
                Polygon(4, Xs, Ys, LightBrown);
                UpdateGroundDots();
                DrawEnemies1();
                Update3DBullet();
                DrawPlane5025();
                IF (BulletY > 99) THEN
                    BulletY := BulletY - 1;
                END;
                IF (EnemyY > CollisionY) THEN
                    CheckDeath1;
                END;
                Lib.Delay(GameSpeed);
            END;
        END;
        Enemies := Enemies + 1;
    END;


    IF GameOver THEN
        DrawGameOver;
    END;
END Screen1;

END Screens1.
