IMPLEMENTATION MODULE Screens3;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, Exobius;
FROM Graph IMPORT SetClipRgn, GetImage, PutImage, Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Sprites IMPORT DrawMaces,DrawIceRocks, DrawSnowMen, DrawSnowBalls, DrawSkiiers, DrawGlowWorms;
FROM Exobius IMPORT
    PlaneWidth, PlaneHeight,
    EnemyYStart, CollisionY,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite, LightBlue,
    PlaneX, BulletX, BulletY, PlaneY,
    Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X, Enemy6X,
    OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive, SixAlive,
    Enemies, Xs, Ys,
    Count, Lives, EnemyY,
    ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
    Update3DBullet, DrawPlane, CheckMouse, CheckMouseAndSpecialKeys, Die,
    FinishScreen, CheckDeath1,
    BkAddress, DrawGameOver;

PROCEDURE DrawEnemies3;
BEGIN
    Enemy1X := 160 - ((10+(3*(EnemyY-100) DIV 2)) DIV 1);
    Enemy2X := 160 - ((10+(3*(EnemyY-100) DIV 2))*2 DIV 3);
    Enemy3X := 160 - ((10+(3*(EnemyY-100) DIV 2)) DIV 3);
    Enemy4X := 160;
    Enemy5X := 160 + ((10+(3*(EnemyY-100) DIV 2)) DIV 3);
    Enemy6X := 160 + ((10+(3*(EnemyY-100) DIV 2))*2 DIV 3);
    IF OneAlive THEN
        CASE Enemies OF
            |1: DrawIceRocks (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSnowMen (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawSnowBalls (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawSkiiers (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSnowMen (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawSnowBalls (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSnowMen (Enemy1X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF TwoAlive THEN
        CASE Enemies OF
            |1: DrawIceRocks (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSnowMen (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawSnowBalls (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawSkiiers (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSnowMen (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawSnowBalls (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSnowMen (Enemy2X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF ThreeAlive THEN
        CASE Enemies OF
            |1: DrawIceRocks (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSnowMen (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawSnowBalls (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawSkiiers (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSnowMen (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawSnowBalls (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSnowMen (Enemy3X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF FourAlive THEN
        CASE Enemies OF
            |1: DrawIceRocks (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSnowMen (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawSnowBalls (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawSkiiers (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSnowMen (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawSnowBalls (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSnowMen (Enemy4X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF FiveAlive THEN
        CASE Enemies OF
            |1: DrawIceRocks (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSnowMen (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawSnowBalls (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawSkiiers (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSnowMen (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawSnowBalls (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSnowMen (Enemy5X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
    IF SixAlive THEN
        CASE Enemies OF
            |1: DrawIceRocks (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |2: DrawSnowMen (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |3: DrawSnowBalls (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |4: DrawSkiiers (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |5: DrawSnowMen (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |6: DrawMaces (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |7: DrawSnowBalls (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
            |8: DrawSnowMen (Enemy6X, EnemyY, (EnemyY - EnemyYStart) DIV 3);
                ScreenComplete := TRUE;
        END;
    END;
END DrawEnemies3;

PROCEDURE DrawSnowFlake (x, y, Width : CARDINAL);
VAR
    FlakeDots : CARDINAL;
BEGIN
    Line (x+Width DIV 2, y, x+Width DIV 2, y+Width, White);
    Line (x, y+Width DIV 3, x+Width, y+Width*2 DIV 3, White);
    Line (x, y+Width*2 DIV 3, x+Width, y+Width DIV 3, White);
    FOR FlakeDots := 1 TO (Width*2) DO
        Plot (x + Lib.RANDOM(Width), y + Lib.RANDOM(Width), White);
    END;
END DrawSnowFlake;

PROCEDURE BlankGround3;
VAR
    SnowFlakes : CARDINAL;
BEGIN
    Graph.PutImage(0, 0, BkAddress, Graph._GPSET);
    FOR SnowFlakes := 1 TO 50 DO
        DrawSnowFlake (Lib.RANDOM(320), Lib.RANDOM(200), Lib.RANDOM(10));
    END
END BlankGround3;

PROCEDURE DrawCloud(CloudX, CloudY, Width : CARDINAL);
VAR
    Piece, Ywidth : CARDINAL;
BEGIN
    Ywidth := Width DIV 2;
    FOR Piece := 1 TO 6 DO
        Disc (CloudX + Lib.RANDOM(Width), CloudY + Ywidth*5 DIV 6, Width DIV 3, LightWhite);
    END;
    FOR Piece := 1 TO 4 DO
        Disc (CloudX + Width DIV 4 + Lib.RANDOM(Width), CloudY + Ywidth DIV 2, Width DIV 3, LightWhite);
    END;
    Disc (CloudX + Width DIV 3 + Lib.RANDOM(Width DIV 4), CloudY + Ywidth DIV 6, Width DIV 3, LightWhite);
    Disc (CloudX + Width DIV 3 + Lib.RANDOM(Width DIV 4), CloudY + Ywidth DIV 6, Width DIV 3, LightWhite);
END DrawCloud;

PROCEDURE Screen3;
VAR
    DotX, DotY, GroundDots, RectY, CloudCount : CARDINAL;
BEGIN
   DrawPlane (PlaneX, PlaneY, PlaneWidth);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 200 - RectY, Black ,TRUE);
   END;
   DrawPlane (PlaneX, PlaneY, PlaneWidth);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 200 - RectY, Grey ,TRUE);
   END;
   DrawPlane (PlaneX, PlaneY, PlaneWidth);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 200 - RectY, DarkestWhite ,TRUE);
   END;
   DrawPlane (PlaneX, PlaneY, PlaneWidth);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 200 - RectY, White ,TRUE);
   END;
   DrawPlane (PlaneX, PlaneY, PlaneWidth);
   FOR RectY := 100 TO 0 BY -10 DO
       Rectangle (RectY, RectY, 320 - RectY, 100, LightBlue, TRUE);
       Rectangle (RectY, 100, 320 - RectY, 200 - RectY, LightestWhite ,TRUE);
   END;
   Rectangle (0, 0, 320, 100, LightBlue, TRUE);

   GameOver := FALSE;
   BulletY := 0;
   ScreenComplete := FALSE;
   Enemies := 1;
   EnemyY := 100;
   Storage.ALLOCATE(BkAddress, 320*200);

   (* Main Program Starts *)

   CheckMouseAndSpecialKeys;
   FOR CloudCount := 1 TO 5 DO
       DrawCloud (Lib.RANDOM(290), Lib.RANDOM(70), Lib.RANDOM(30));
   END;
   Graph.GetImage (0, 0, 320, 200, BkAddress);
   WHILE NOT GameOver AND NOT ScreenComplete DO
         FOR GroundDots := 1 TO 20 DO
            DotX := Lib.RANDOM (70) + 125;
            DotY := Lib.RANDOM (100) + 100;
            Plot (DotX, DotY, Lib.RANDOM(7) + 16);
            Lib.Delay (GameSpeed);
            Plot (DotX, DotY, LightBlue);
            CheckMouse;
            BlankGround3;
            DrawPlane(PlaneX, PlaneY, PlaneWidth);
            Update3DBullet;
            Lib.Delay (GameSpeed);
         END;   (* This "END" from Ground Dots *)
         OneAlive   := TRUE;
         TwoAlive   := TRUE;
         ThreeAlive := TRUE;
         FourAlive  := TRUE;
         FiveAlive  := TRUE;
         SixAlive   := TRUE;
         FOR EnemyY := 101 TO 200 BY 2 DO
          IF NOT (GameOver) THEN
            CheckMouse;
            BlankGround3;
            DrawPlane (PlaneX, PlaneY, PlaneWidth);
            Update3DBullet;
            DrawEnemies3;
            IF (BulletY > 99) THEN
               BulletY := BulletY - 1;
            END;
            IF (EnemyY > CollisionY) THEN
               CheckDeath1;
            END;
            Lib.Delay (GameSpeed);
          END;
         END;                      (* This "END" From Enemy Movement. *)
         Enemies := Enemies + 1;
     END;                          (* This "END" From GameOver/ScreenComplete Check. *)
     IF GameOver THEN
        DrawGameOver;
     END;
     Storage.DEALLOCATE(BkAddress, 320*200);
END Screen3;

END Screens3.
