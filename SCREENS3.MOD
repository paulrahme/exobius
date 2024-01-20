IMPLEMENTATION MODULE Screens3;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Storage, Exobius;
FROM Graph IMPORT GetImage, PutImage, Rectangle, Line, Disc, Plot;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Sprites IMPORT DrawMaces,DrawIceRocks, DrawSnowMen, DrawSnowBalls, DrawSkiiers;
FROM Exobius IMPORT
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite, LightBlue,
    PlaneX, BulletY, PlaneY,
    Enemies, Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X, Enemy6X,
    OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive, SixAlive,
    EnemyY, EnemyYStart, CollisionY,
    ScreenComplete, GameOver, GameSpeed,
    Update3DBullet, DrawPlane5025, DrawLives,
    BkAddress, CheckMouse, CheckMouseAndSpecialKeys, DrawGameOver;
FROM Screens1 IMPORT CheckDeath1;

PROCEDURE DrawEnemies3;
VAR
    EnemyXScale, EnemyWidth : CARDINAL;
BEGIN
    EnemyXScale := 10 + (3 * (EnemyY - 100) DIV 2);
    EnemyWidth := (EnemyY - EnemyYStart) DIV 3;

    IF OneAlive THEN
        Enemy1X := 160 - EnemyXScale;
        CASE Enemies OF
            |1: DrawIceRocks(Enemy1X, EnemyY, EnemyWidth);
            |2: DrawSnowMen(Enemy1X, EnemyY, EnemyWidth);
            |3: DrawSnowBalls(Enemy1X, EnemyY, EnemyWidth);
            |4: DrawSkiiers(Enemy1X, EnemyY, EnemyWidth);
            |5: DrawSnowMen(Enemy1X, EnemyY, EnemyWidth);
            |6: DrawMaces(Enemy1X, EnemyY, EnemyWidth);
            |7: DrawSnowBalls(Enemy1X, EnemyY, EnemyWidth);
            |8: DrawSnowMen(Enemy1X, EnemyY, EnemyWidth);
            |9: DrawSkiiers(Enemy1X, EnemyY, EnemyWidth);
                ScreenComplete := TRUE;
        END;
    END;

    IF TwoAlive THEN
        Enemy2X := 160 - (EnemyXScale*2 DIV 3);
        CASE Enemies OF
            |1: DrawIceRocks(Enemy2X, EnemyY, EnemyWidth);
            |2: DrawSnowMen(Enemy2X, EnemyY, EnemyWidth);
            |3: DrawSnowBalls(Enemy2X, EnemyY, EnemyWidth);
            |4: DrawSkiiers(Enemy2X, EnemyY, EnemyWidth);
            |5: DrawSnowMen(Enemy2X, EnemyY, EnemyWidth);
            |6: DrawMaces(Enemy2X, EnemyY, EnemyWidth);
            |7: DrawSnowBalls(Enemy2X, EnemyY, EnemyWidth);
            |8: DrawIceRocks(Enemy2X, EnemyY, EnemyWidth);
            |9: DrawSkiiers(Enemy2X, EnemyY, EnemyWidth);
                ScreenComplete := TRUE;
        END;
    END;

    IF ThreeAlive THEN
        Enemy3X := 160 - (EnemyXScale DIV 3);
        CASE Enemies OF
            |1: DrawIceRocks(Enemy3X, EnemyY, EnemyWidth);
            |2: DrawSnowMen(Enemy3X, EnemyY, EnemyWidth);
            |3: DrawSnowBalls(Enemy3X, EnemyY, EnemyWidth);
            |4: DrawSkiiers(Enemy3X, EnemyY, EnemyWidth);
            |5: DrawSnowMen(Enemy3X, EnemyY, EnemyWidth);
            |6: DrawMaces(Enemy3X, EnemyY, EnemyWidth);
            |7: DrawSnowBalls(Enemy3X, EnemyY, EnemyWidth);
            |8: DrawSnowMen(Enemy3X, EnemyY, EnemyWidth);
            |9: DrawSnowBalls(Enemy3X, EnemyY, EnemyWidth);
                ScreenComplete := TRUE;
        END;
    END;

    IF FourAlive THEN
        Enemy4X := 160;
        CASE Enemies OF
            |1: DrawIceRocks(Enemy4X, EnemyY, EnemyWidth);
            |2: DrawSnowMen(Enemy4X, EnemyY, EnemyWidth);
            |3: DrawSnowBalls(Enemy4X, EnemyY, EnemyWidth);
            |4: DrawSkiiers(Enemy4X, EnemyY, EnemyWidth);
            |5: DrawSnowMen(Enemy4X, EnemyY, EnemyWidth);
            |6: DrawMaces(Enemy4X, EnemyY, EnemyWidth);
            |7: DrawSnowBalls(Enemy4X, EnemyY, EnemyWidth);
            |8: DrawIceRocks(Enemy4X, EnemyY, EnemyWidth);
            |9: DrawSnowBalls(Enemy4X, EnemyY, EnemyWidth);
                ScreenComplete := TRUE;
        END;
    END;

    IF FiveAlive THEN
        Enemy5X := 160 + (EnemyXScale DIV 3);
        CASE Enemies OF
            |1: DrawIceRocks(Enemy5X, EnemyY, EnemyWidth);
            |2: DrawSnowMen(Enemy5X, EnemyY, EnemyWidth);
            |3: DrawSnowBalls(Enemy5X, EnemyY, EnemyWidth);
            |4: DrawSkiiers(Enemy5X, EnemyY, EnemyWidth);
            |5: DrawSnowMen(Enemy5X, EnemyY, EnemyWidth);
            |6: DrawMaces(Enemy5X, EnemyY, EnemyWidth);
            |7: DrawSnowBalls(Enemy5X, EnemyY, EnemyWidth);
            |8: DrawSnowMen(Enemy5X, EnemyY, EnemyWidth);
            |9: DrawSkiiers(Enemy5X, EnemyY, EnemyWidth);
                ScreenComplete := TRUE;
        END;
    END;

    IF SixAlive THEN
        Enemy6X := 160 + (EnemyXScale*2 DIV 3);
        CASE Enemies OF
            |1: DrawIceRocks(Enemy6X, EnemyY, EnemyWidth);
            |2: DrawSnowMen(Enemy6X, EnemyY, EnemyWidth);
            |3: DrawSnowBalls(Enemy6X, EnemyY, EnemyWidth);
            |4: DrawSkiiers(Enemy6X, EnemyY, EnemyWidth);
            |5: DrawSnowMen(Enemy6X, EnemyY, EnemyWidth);
            |6: DrawMaces(Enemy6X, EnemyY, EnemyWidth);
            |7: DrawSnowBalls(Enemy6X, EnemyY, EnemyWidth);
            |8: DrawIceRocks(Enemy6X, EnemyY, EnemyWidth);
            |9: DrawSkiiers(Enemy6X, EnemyY, EnemyWidth);
                ScreenComplete := TRUE;
        END;
    END;
END DrawEnemies3;

PROCEDURE DrawSnowFlake (x, y, Width : CARDINAL);
VAR
    FlakeDots : CARDINAL;
BEGIN
    Line(x+Width DIV 2, y, x+Width DIV 2, y+Width, White);
    Line(x, y+Width DIV 3, x+Width, y+Width*2 DIV 3, White);
    Line(x, y+Width*2 DIV 3, x+Width, y+Width DIV 3, White);
    FOR FlakeDots := 1 TO (Width*2) DO
        Plot(x + Lib.RANDOM(Width), y + Lib.RANDOM(Width), White);
    END;
END DrawSnowFlake;

PROCEDURE RefreshScenery;
VAR
    SnowFlakes : CARDINAL;
BEGIN
    PutImage(0, 9, BkAddress, Graph._GPSET);
    Rectangle(0, 100, 319, 199, LightestWhite, TRUE);
    FOR SnowFlakes := 1 TO 4 DO
        DrawSnowFlake(Lib.RANDOM(310), 9 + Lib.RANDOM(182), Lib.RANDOM(10));
    END
END RefreshScenery;

PROCEDURE DrawCloud(CloudX, CloudY, Width : CARDINAL);
VAR
    Piece, Ywidth : CARDINAL;
BEGIN
    Ywidth := Width DIV 2;
    FOR Piece := 1 TO 6 DO
        Disc(CloudX + Lib.RANDOM(Width), CloudY + Ywidth*5 DIV 6, Width DIV 3, LightWhite);
    END;
    FOR Piece := 1 TO 4 DO
        Disc(CloudX + Width DIV 4 + Lib.RANDOM(Width), CloudY + Ywidth DIV 2, Width DIV 3, LightWhite);
    END;
    Disc(CloudX + Width DIV 3 + Lib.RANDOM(Width DIV 4), CloudY + Ywidth DIV 6, Width DIV 3, LightWhite);
    Disc(CloudX + Width DIV 3 + Lib.RANDOM(Width DIV 4), CloudY + Ywidth DIV 6, Width DIV 3, LightWhite);
END DrawCloud;

PROCEDURE Screen3;
VAR
    DotX, DotY, GroundDots, RectY, CloudCount : CARDINAL;
BEGIN
    DrawPlane5025();
    FOR RectY := 100 TO 0 BY -10 DO
        Rectangle(RectY, RectY, 319 - RectY, 199 - RectY, Black, TRUE);
        Delay(GameSpeed);
    END;
    DrawPlane5025();
    FOR RectY := 100 TO 0 BY -10 DO
        Rectangle(RectY, RectY, 319 - RectY, 199 - RectY, Grey ,TRUE);
        Delay(GameSpeed);
    END;
    DrawPlane5025();
    FOR RectY := 100 TO 0 BY -10 DO
        Rectangle(RectY, RectY, 319 - RectY, 199 - RectY, DarkestWhite ,TRUE);
        Delay(GameSpeed);
    END;
    DrawPlane5025();
    FOR RectY := 100 TO 0 BY -10 DO
        Rectangle(RectY, RectY, 319 - RectY, 199 - RectY, White ,TRUE);
        Delay(GameSpeed);
    END;
    DrawPlane5025();
    FOR RectY := 100 TO 0 BY -10 DO
        Rectangle(RectY, RectY, 319 - RectY, 99, LightBlue, TRUE);
        Rectangle(RectY, 100, 319 - RectY, 199 - RectY, LightestWhite ,TRUE);
        Delay(GameSpeed);
    END;
    Rectangle(0, 0, 319, 99, LightBlue, TRUE);

    ScreenComplete := FALSE;
    BulletY := 0;
    Enemies := 1;

    (* Main loop *)
    CheckMouseAndSpecialKeys();
    FOR CloudCount := 1 TO 6 DO
        DrawCloud(Lib.RANDOM(290), 10 + Lib.RANDOM(60), Lib.RANDOM(30));
    END;
    GetImage(0, 9, 319, 99, BkAddress);
    DrawLives(0, LightBlue);
    WHILE NOT GameOver AND NOT ScreenComplete DO
        FOR GroundDots := 1 TO 20 DO
            DotX := Lib.RANDOM(70) + 125;
            DotY := Lib.RANDOM(100) + 100;
            Plot(DotX, DotY, Lib.RANDOM(7) + 16);
            Lib.Delay(GameSpeed);
            Plot(DotX, DotY, LightBlue);
            CheckMouse();
            RefreshScenery();
            DrawPlane5025();
            Update3DBullet(FALSE);
            Lib.Delay(GameSpeed);
        END;
        OneAlive := TRUE; TwoAlive := TRUE; ThreeAlive := TRUE; FourAlive := TRUE; FiveAlive := TRUE; SixAlive := TRUE;
        FOR EnemyY := 101 TO 200 DO
            IF NOT (GameOver) THEN
                CheckMouse();
                RefreshScenery();
                DrawPlane5025();
                DrawEnemies3();
                Update3DBullet(TRUE);
                IF (EnemyY > CollisionY) THEN
                    CheckDeath1(FALSE, LightBlue);
                END;
                Lib.Delay(GameSpeed);
            END;
        END;
        Enemies := Enemies + 1;
    END;
    IF GameOver THEN
        DrawGameOver;
    END;
END Screen3;

END Screens3.
