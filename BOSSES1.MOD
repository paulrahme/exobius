IMPLEMENTATION MODULE Bosses1;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius, Font;
FROM Graph IMPORT Point, SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Sprites IMPORT DrawSpinners;
FROM Screens8 IMPORT DrawStars8, DrawPlanet, PlanetRadius;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Exobius IMPORT
    SolidFill, PlaneWidth, PlaneHeight,
    EnemyYStart, PlaneXMin, CollisionY,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue, DarkestRed,
    DarkRed, Red, LightRed, LightestRed, DarkestBrown, DarkBrown,
    Brown, LightBrown, LightestBrown, DarkestGreen, DarkGreen, Green, LightGreen,
    LightestGreen, DarkestYellow, DarkYellow, Yellow, LightYellow,
    LightestYellow, PlaneX,  Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X,
    Enemy6X, Enemies, BulletX, BulletY, PlaneY, CoverRectangleX,
    Count, Lives, EnemyY, BkColour,
    OldBkColor,  Xs, Ys, OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive,
    SixAlive, ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
    Update3DBullet, DrawPlane, CheckMouse, Die,
    FinishScreen, Key, PlaneXMove, Score,
    BkAddress, DrawGameOver, TextPos;

CONST
    Boss1X = 0;
    Boss2X = 110;
    Boss3X = 220;
VAR
    Boss1Y, Boss2Y, Boss3Y, Boss3Y3, Boss1Lives, Boss2Lives, Boss3X3 : CARDINAL;
    Boss3Lives : INTEGER;
    BossAddressA, BossAddressB, BossAddressC : ADDRESS;
    OneDead, TwoDead, ThreeDead, BossDiving : BOOLEAN;

PROCEDURE DrawBoss1 (x, y : CARDINAL);
CONST
    MouthY = 60;
BEGIN
    Disc (x + 50, y + 60, 40, DarkestRed);
    Disc (x + 52, y + 58, 36, DarkRed);
    Disc (x + 54, y + 56, 32, Red);
    Disc (x + 56, y + 54, 28, LightRed);
    Disc (x + 58, y + 52, 24, LightestRed);
    Disc (x + 60, y + 50, 20, DarkestYellow);
    Disc (x + 62, y + 48, 16, DarkYellow);
    Disc (x + 64, y + 46, 12, Yellow);
    Disc (x + 66, y + 44, 8, LightYellow);
    Disc (x + 68, y + 42, 4, LightestYellow);
    Plot (x + 69, y + 41, LightestWhite);
    Disc (x + 50, y + 10, 10, DarkestGreen);
    Disc (x + 51, y + 9, 8, DarkGreen);
    Disc (x + 52, y + 8, 6, Green);
    Disc (x + 53, y + 7, 4, LightGreen);
    Disc (x + 54, y + 6, 2, LightestGreen);
    Plot (x + 55, y + 5, LightestWhite);
    Disc (x + 46, y + 2, 2, Black);
    Disc (x + 54, y + 2, 2, Black);
    Line (x + 47, y + 0, x + 50, y + 4, Grey);
    Line (x + 53, y + 0, x + 50, y + 4, Grey);
    Line (x + 45, y + MouthY, x + 55, y + MouthY, Black);
    Disc (x + 50, y + 60, 3, Black);
END DrawBoss1;

PROCEDURE KillBoss1;
VAR
    Explosions, Colour : CARDINAL;
BEGIN
    Rectangle (0, 0, 319, 10, White, FALSE);
    FOR Explosions := 1 TO 500 DO
        Sound (Lib.RANDOM(15) + 20);
        CASE (Lib.RANDOM(10)) OF
            |1: Colour := DarkestRed;
            |2: Colour := DarkRed;
            |3: Colour := Red;
            |4: Colour := LightRed;
            |5: Colour := LightestRed;
            |6: Colour := DarkestYellow;
            |7: Colour := DarkYellow;
            |8: Colour := Yellow;
            |9: Colour := LightYellow;
            |10: Colour := LightestYellow;
        END;
        Ellipse (Lib.RANDOM(100) + 109, Lib.RANDOM(100) + 49, Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
        Plot (Lib.RANDOM(100) + 109, Lib.RANDOM(100) + 49, Colour);
        NoSound;
    END;
    ScreenComplete := TRUE;
    IF (Lives>0) THEN
        Lives := Lives - 1;
    END;
END KillBoss1;

PROCEDURE Boss1;
CONST
        SpitX = 160;
        SpitMovement = 2;
        SpitHitY = 150;
        MouthY = 65;
        BossFallSpeed = 5;
VAR
        SpitCount, BossFall, SpitY, BossLives, GroundLines, GroundLineX : CARDINAL;
BEGIN
        EnemyY := 99;
        ScreenComplete := FALSE;
        PlaneX := PlaneXMin;
        Xs[0] := 0; Xs[1] := 112; Xs[2] := 208; Xs[3] := 320;
        Ys[0] := 200; Ys[1] := 151; Ys[2] := 151; Ys[3] := 200;
        Polygon (4, Xs, Ys, LightBrown);
        Graph.GetImage (120, 0, 200, 150, BkAddress);
        FOR BossFall := 0 TO 50  BY BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;
        FOR BossFall := 50 TO 25 BY -BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;
        FOR BossFall := 25 TO 50  BY BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;
        FOR BossFall := 50 TO 40 BY -BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;
        FOR BossFall := 40 TO 50  BY BossFallSpeed DO
                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                Disc (160, BossFall + 60, 40, Red);
                Disc (160, BossFall + 10, 10, Green);
                TextPos := Graph.SetTextPosition (23, 17);
                Graph.OutText ("DANGER!");
        END;

        (* The Action Begins !! *)

        Graph.PutImage(0, 0, BkAddress, Graph._GPSET);
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
        DrawBoss1 (110, BossFall);
        Rectangle (0, 0, 319, 10, White, FALSE);
        Rectangle (1, 1, 318, 9, Black, TRUE);
        Disc (160, MouthY, 5, Black);   (* Open Boss' Mouth *)
        Graph.GetImage (0, 0, 320, 200, BkAddress);
        CheckMouse;
        DrawPlane (PlaneX, PlaneY, PlaneWidth);
        Update3DBullet;
        IF (BulletY  > 99) THEN
                BulletY := BulletY - 1;
        END;
        BossLives := 8;
        WHILE NOT GameOver AND NOT ScreenComplete DO
                 SpitY := MouthY;
                 WHILE (SpitY < 200) AND NOT (ScreenComplete) AND NOT (GameOver) DO
                        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                        Rectangle (1, 1, 318, 9, Black, TRUE);
                        Rectangle (1, 1, BossLives*50, 9, Red, TRUE);
                        Graph.GetImage (0, 0, 320, 200, BkAddress);
                        Ellipse (SpitX, SpitY, (SpitY - MouthY)*4 DIV 5, (SpitY - MouthY)*2 DIV 5, Blue, TRUE);
                        Ellipse (SpitX, SpitY, (SpitY + 1 - MouthY)*4 DIV 5, (SpitY + 2 - MouthY)*2 DIV 5, LightestBlue, FALSE);
                        IF (SpitY > SpitHitY) AND (PlaneX > 20) AND (PlaneX < 220) THEN
                                Die;
                        END;
                        CheckMouse;
                        DrawPlane (PlaneX, PlaneY, PlaneWidth);
                        Update3DBullet;
                        IF (BulletX > 140) AND (BulletX < 170) AND (BulletY < 3) THEN
                                Disc (160, 110, 40, LightestWhite);
                                BossLives := BossLives - 1;
                                BulletY := 50;
                                Delay (5);
                                Score := Score + 150;
                        END;
                        IF (BossLives = 0) THEN
                                KillBoss1;
                                TextPos := Graph.SetTextPosition (1, 15);
                                Graph.OutText ("Extra Life!");
                                ScreenComplete := TRUE;
                        END;
                        Delay (GameSpeed DIV 2);
                        SpitY := SpitY + 1 + (SpitY - MouthY) DIV 2;
                END;    (* This "END" From SpitY < 200 Check. *)
        END;            (* This "END" From ScreenComplete Check. *)
        IF ScreenComplete AND NOT GameOver THEN
           FinishScreen;
        END;
        IF GameOver THEN
           G(110, 30); A(140, 30); M(170, 30); E(200, 30);
           O(110, 60); V(140, 60); E(170, 60); R(200, 60);
           Key := IO.RdKey();
        END;
END Boss1;


END Bosses1.
