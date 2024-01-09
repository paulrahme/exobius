IMPLEMENTATION MODULE Bosses9;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Storage, Exobius;
FROM Graph IMPORT Point, Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Exobius IMPORT
    PlaneWidth, PlaneHeight, Xs, Ys, BkAddress,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, PlaneY, PlaneStartX, PlaneStartY, DrawPlane5025, DrawPlane,
    CheckMouse, Count, GameOver, ScreenComplete, GameSpeed, Update3DBullet,
    Die, DrawGameOver, BulletX, BulletY, Score;

PROCEDURE WritePlayExobius(x, y, Width : CARDINAL);
BEGIN
    Line(x+Width*59 DIV 150, y+Width*120 DIV 150, x+Width*79 DIV 150, y+Width*133 DIV 150, Red);
    Line(x+Width*41 DIV 150, y+Width*120 DIV 150, x+Width*21 DIV 150, y+Width*133 DIV 150, DarkRed);
    Line(x+Width*42 DIV 150, y+Width*122 DIV 150, x+Width*40 DIV 150, y+Width*127 DIV 150, Blue);
    Line(x+Width*42 DIV 150, y+Width*122 DIV 150, x+Width*44 DIV 150, y+Width*124 DIV 150, Blue);
    Line(x+Width*44 DIV 150, y+Width*124 DIV 150, x+Width*42 DIV 150, y+Width*125 DIV 150, Blue);
    Line(x+Width*46 DIV 150, y+Width*123 DIV 150, x+Width*45 DIV 150, y+Width*127 DIV 150, Blue);
    Line(x+Width*47 DIV 150, y+Width*127 DIV 150, x+Width*46 DIV 150, y+Width*127 DIV 150, Blue);
    Line(x+Width*50 DIV 150, y+Width*127 DIV 150, x+Width*51 DIV 150, y+Width*123 DIV 150, Blue);
    Line(x+Width*54 DIV 150, y+Width*127 DIV 150, x+Width*52 DIV 150, y+Width*123 DIV 150, Blue);
    Line(x+Width*51 DIV 150, y+Width*123 DIV 150, x+Width*53 DIV 150, y+Width*125 DIV 150, Blue);
    Line(x+Width*55 DIV 150, y+Width*123 DIV 150, x+Width*57 DIV 150, y+Width*125 DIV 150, Blue);
    Line(x+Width*57 DIV 150, y+Width*125 DIV 150, x+Width*58 DIV 150, y+Width*123 DIV 150, Blue);
    Line(x+Width*58 DIV 150, y+Width*123 DIV 150, x+Width*59 DIV 150, y+Width*127 DIV 150, Blue);
    Line(x+Width*35 DIV 150, y+Width*132 DIV 150, x+Width*31 DIV 150, y+Width*138 DIV 150, LightBlue);
    Line(x+Width*35 DIV 150, y+Width*132 DIV 150, x+Width*37 DIV 150, y+Width*132 DIV 150, LightBlue);
    Line(x+Width*36 DIV 150, y+Width*135 DIV 150, x+Width*33 DIV 150, y+Width*135 DIV 150, LightBlue);
    Line(x+Width*31 DIV 150, y+Width*138 DIV 150, x+Width*35 DIV 150, y+Width*138 DIV 150, LightBlue);
    Line(x+Width*39 DIV 150, y+Width*132 DIV 150, x+Width*40 DIV 150, y+Width*138 DIV 150, LightBlue);
    Line(x+Width*42 DIV 150, y+Width*132 DIV 150, x+Width*36 DIV 150, y+Width*138 DIV 150, LightBlue);
    Line(x+Width*45 DIV 150, y+Width*132 DIV 150, x+Width*43 DIV 150, y+Width*135 DIV 150, LightBlue);
    Line(x+Width*43 DIV 150, y+Width*136 DIV 150, x+Width*44 DIV 150, y+Width*137 DIV 150, LightBlue);
    Line(x+Width*44 DIV 150, y+Width*137 DIV 150, x+Width*46 DIV 150, y+Width*135 DIV 150, LightBlue);
    Line(x+Width*46 DIV 150, y+Width*135 DIV 150, x+Width*46 DIV 150, y+Width*132 DIV 150, LightBlue);
    Line(x+Width*48 DIV 150, y+Width*132 DIV 150, x+Width*48 DIV 150, y+Width*138 DIV 150, LightBlue);
    Line(x+Width*48 DIV 150, y+Width*138 DIV 150, x+Width*51 DIV 150, y+Width*137 DIV 150, LightBlue);
    Line(x+Width*51 DIV 150, y+Width*137 DIV 150, x+Width*49 DIV 150, y+Width*135 DIV 150, LightBlue);
    Line(x+Width*49 DIV 150, y+Width*135 DIV 150, x+Width*51 DIV 150, y+Width*133 DIV 150, LightBlue);
    Line(x+Width*51 DIV 150, y+Width*133 DIV 150, x+Width*48 DIV 150, y+Width*132 DIV 150, LightBlue);
    Line(x+Width*55 DIV 150, y+Width*132 DIV 150, x+Width*55 DIV 150, y+Width*137 DIV 150, LightBlue);
    Line(x+Width*58 DIV 150, y+Width*132 DIV 150, x+Width*60 DIV 150, y+Width*137 DIV 150, LightBlue);
    Line(x+Width*61 DIV 150, y+Width*137 DIV 150, x+Width*61 DIV 150, y+Width*132 DIV 150, LightBlue);
    Line(x+Width*66 DIV 150, y+Width*132 DIV 150, x+Width*64 DIV 150, y+Width*133 DIV 150, LightBlue);
    Line(x+Width*64 DIV 150, y+Width*133 DIV 150, x+Width*67 DIV 150, y+Width*135 DIV 150, LightBlue);
    Line(x+Width*67 DIV 150, y+Width*135 DIV 150, x+Width*64 DIV 150, y+Width*137 DIV 150, LightBlue);
    Line(x+Width*68 DIV 150, y+Width*132 DIV 150, x+Width*69 DIV 150, y+Width*135 DIV 150, LightBlue);
    Plot(x+Width*70 DIV 150, y+Width*137 DIV 150, LightBlue);
END WritePlayExobius;

PROCEDURE DrawBossFlashing(Width : CARDINAL);
VAR
    x, y : CARDINAL;
BEGIN
    x := 183 - Width DIV 2;
    y := 100 - Width DIV 2;
    
    (* Head *)
    Disc(x+Width*50 DIV 150, y+Width*50 DIV 150, Width*50 DIV 150, LightestWhite);

    
    (* Neck *)
    Rectangle(x+Width*45 DIV 150, y+Width*101 DIV 150, x+Width*55 DIV 150, y+Width*119 DIV 150, LightestWhite, TRUE);

    (* Base *)
    Xs[0] := x+Width*42 DIV 150; Ys[0] := y+Width*120 DIV 150;
    Xs[1] := x+Width*21 DIV 150; Ys[1] := y+Width*134 DIV 150;
    Xs[2] := x+Width*23 DIV 150; Ys[2] := y+Width*145 DIV 150;
    Xs[3] := x+Width*77 DIV 150; Ys[3] := y+Width*145 DIV 150;
    Xs[4] := x+Width*79 DIV 150; Ys[4] := y+Width*134 DIV 150;
    Xs[5] := x+Width*58 DIV 150; Ys[5] := y+Width*120 DIV 150;
    Polygon(6, Xs, Ys, LightestWhite);
END DrawBossFlashing;

PROCEDURE DrawBoss9(Width : CARDINAL);
VAR
    x, y : CARDINAL;
BEGIN
    x := 183 - Width DIV 2;
    y := 100 - Width DIV 2;

    (* Head *)
    Disc(x+Width*50 DIV 150, y+Width*50 DIV 150, Width*50 DIV 150, Red);
    Disc(x+Width*51 DIV 150, y+Width*49 DIV 150, Width*48 DIV 150, LightRed);
    Disc(x+Width*52 DIV 150, y+Width*48 DIV 150, Width*46 DIV 150, LightestRed);
    Xs[0] := x+Width*93 DIV 150; Ys[0] := y+Width*24 DIV 150; Xs[1] := x+Width*88 DIV 150; Ys[1] := y+Width*2 DIV 150; Xs[2] := x+Width*80 DIV 150; Ys[2] := y+Width*9 DIV 150;
    Polygon(3, Xs, Ys, LightRed);
    Xs[0] := x+Width*7 DIV 150; Ys[0] := y+Width*24 DIV 150; Xs[1] := x+Width*12 DIV 150; Ys[1] := y+Width*2 DIV 150; Xs[2] := x+Width*20 DIV 150; Ys[2] := y+Width*10 DIV 150;
    Polygon(3, Xs, Ys, LightRed);
    Xs[0] := x+Width*90 DIV 150; Ys[0] := y+Width*20 DIV 150; Xs[1] := x+Width*87 DIV 150; Ys[1] := y+Width*6 DIV 150; Xs[2] := x+Width*82 DIV 150; Ys[2] := y+Width*11 DIV 150;
    Polygon(3, Xs, Ys, Red);
    Xs[0] := x+Width*10 DIV 150; Ys[0] := y+Width*21 DIV 150; Xs[1] := x+Width*12 DIV 150; Ys[1] := y+Width*6 DIV 150; Xs[2] := x+Width*19 DIV 150; Ys[2] := y+Width*12 DIV 150;
    Polygon(3, Xs, Ys, Red);
    Ellipse(x+Width*51 DIV 150, y+Width*74 DIV 150, Width*27 DIV 150, Width*10 DIV 150, Black, TRUE);
    Disc(x+Width*32 DIV 150, y+Width*30 DIV 150, Width*7 DIV 150, Black);
    Disc(x+Width*68 DIV 150, y+Width*30 DIV 150, Width*7 DIV 150, Black);
    Disc(x+Width*48 DIV 150, y+Width*50 DIV 150, Width*6 DIV 150, Black);
    Disc(x+Width*52 DIV 150, y+Width*50 DIV 150, Width*6 DIV 150, Black);
    Plot(x+Width*47 DIV 150, y+Width*50 DIV 150, Black);
    Plot(x+Width*53 DIV 150, y+Width*50 DIV 150, Black);

    (* Neck *)
    Line(x+Width*50 DIV 150, y+Width*23 DIV 150, x+Width*50 DIV 150, y+Width*5 DIV 150, DarkestYellow);
    Line(x+Width*44 DIV 150, y+Width*25 DIV 150, x+Width*38 DIV 150, y+Width*17 DIV 150, DarkestYellow);
    Line(x+Width*38 DIV 150, y+Width*17 DIV 150, x+Width*30 DIV 150, y+Width*12 DIV 150, DarkestYellow);
    Line(x+Width*55 DIV 150, y+Width*26 DIV 150, x+Width*62 DIV 150, y+Width*17 DIV 150, DarkestYellow);
    Line(x+Width*62 DIV 150, y+Width*17 DIV 150, x+Width*71 DIV 150, y+Width*12 DIV 150, DarkestYellow);
    Line(x+Width*12 DIV 150, y+Width*42 DIV 150, x+Width*33 DIV 150, y+Width*51 DIV 150, 15);
    Line(x+Width*33 DIV 150, y+Width*51 DIV 150, x+Width*6 DIV 150, y+Width*51 DIV 150, 15);
    Line(x+Width*33 DIV 150, y+Width*51 DIV 150, x+Width*13 DIV 150, y+Width*58 DIV 150, 15);
    Line(x+Width*69 DIV 150, y+Width*51 DIV 150, x+Width*96 DIV 150, y+Width*51 DIV 150, 15);
    Line(x+Width*69 DIV 150, y+Width*51 DIV 150, x+Width*91 DIV 150, y+Width*42 DIV 150, 15);
    Line(x+Width*90 DIV 150, y+Width*58 DIV 150, x+Width*69 DIV 150, y+Width*51 DIV 150, 15);
    Circle(x+Width*47 DIV 150, y+Width*50 DIV 150, Width*1 DIV 150, 21);
    Circle(x+Width*53 DIV 150, y+Width*50 DIV 150, Width*1 DIV 150, 21);
    Line(x+Width*43 DIV 150, y+Width*101 DIV 150, x+Width*43 DIV 150, y+Width*119 DIV 150, DarkRed);
    Line(x+Width*57 DIV 150, y+Width*101 DIV 150, x+Width*57 DIV 150, y+Width*119 DIV 150, DarkRed);
    Line(x+Width*44 DIV 150, y+Width*101 DIV 150, x+Width*44 DIV 150, y+Width*119 DIV 150, Red);
    Line(x+Width*56 DIV 150, y+Width*101 DIV 150, x+Width*56 DIV 150, y+Width*119 DIV 150, Red);
    Rectangle(x+Width*45 DIV 150, y+Width*101 DIV 150, x+Width*48 DIV 150, y+Width*119 DIV 150, LightRed, TRUE);
    Rectangle(x+Width*54 DIV 150, y+Width*101 DIV 150, x+Width*55 DIV 150, y+Width*119 DIV 150, LightRed, TRUE);
    Rectangle(x+Width*49 DIV 150, y+Width*101 DIV 150, x+Width*54 DIV 150, y+Width*119 DIV 150, LightestRed, TRUE);
    Line(x+Width*50 DIV 150, y+Width*101 DIV 150, x+Width*50 DIV 150, y+Width*119 DIV 150, LightRed);
    Line(x+Width*53 DIV 150, y+Width*101 DIV 150, x+Width*53 DIV 150, y+Width*119 DIV 150, LightRed);

    (* Base *)
    Xs[0] := x+Width*43 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*23 DIV 150; Ys[1] := y+Width*145 DIV 150; Xs[2] := x+Width*77 DIV 150; Ys[2] := y+Width*145 DIV 150; Xs[3] := x+Width*57 DIV 150; Ys[3] := y+Width*120 DIV 150;
    Polygon(4, Xs, Ys, LightRed);
    Xs[0] := x+Width*58 DIV 150; Ys[0] := y+Width*120 DIV 150;
    Polygon(1, Xs, Ys, LightRed);
    Xs[0] := x+Width*58 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*77 DIV 150; Ys[1] := y+Width*144 DIV 150; Xs[2] := x+Width*79 DIV 150; Ys[2] := y+Width*134 DIV 150;
    Polygon(3, Xs, Ys, Red);
    Xs[0] := x+Width*42 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*23 DIV 150; Ys[1] := y+Width*144 DIV 150; Xs[2] := x+Width*21 DIV 150; Ys[2] := y+Width*134 DIV 150;
    Polygon(3, Xs, Ys, Red);
    WritePlayExobius(x, y, Width);
END DrawBoss9;

PROCEDURE KillBoss9;
VAR
    Explosions, Colour : CARDINAL;
BEGIN
    PlaneY := 175;
    WHILE (PlaneY>10) DO
        PlaneY := PlaneY - 1;
        Sound(Lib.RANDOM(15) + 20);
        FOR Explosions := 1 TO 50 DO
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
                |10: Colour := LightestYellow
            END;
            Ellipse(Lib.RANDOM(320), Lib.RANDOM(200), Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
            Plot(Lib.RANDOM(319), Lib.RANDOM(199), Colour);
        END;
        IF (PlaneX<155) THEN
            PlaneX := PlaneX + 5;
        END;
        IF (PlaneX > 155) THEN
            PlaneX := PlaneX - 5;
        END;
        DrawPlane(PlaneX, PlaneY, PlaneY DIV 3);
        Delay(40);
        NoSound();
    END; (* WHILE *)
    ScreenComplete := TRUE;
END KillBoss9;

PROCEDURE Boss9;
CONST
    SpitMovement = 2;
    SpitHitY = 180;
    MouthY = 100;
    MouthX = 160;
    Boss9Health = 20;
VAR
    SpitX, SpitY, SpitYOffset, BossWidth, BossLives : CARDINAL;
BEGIN
    ScreenComplete := FALSE;

    (* Intro - approaching boss *)
    Rectangle(0, 100, 319, 199, DarkRed, TRUE);
    Graph.GetImage(100, 40, 220, 160, BkAddress);
    FOR BossWidth := 1 TO 150 BY 3 DO
        Rectangle(PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkRed, TRUE);
        CheckMouse();
        Graph.PutImage(100, 40, BkAddress, Graph._GPSET);
        DrawBoss9(BossWidth);
        DrawPlane5025();
        Delay(GameSpeed);
    END;
    BossWidth := 150;
    Graph.PutImage(100, 40, BkAddress, Graph._GPSET);
    DrawBoss9(BossWidth);
    Rectangle(PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkRed, TRUE);
    Graph.GetImage(0, 100, 319, 199, BkAddress);
    DrawPlane5025();
    Rectangle(1, 1, 319, 9, Red, TRUE);
    Rectangle(0, 0, 319, 10, White, FALSE);

    (****************************************************************)

    BossLives := Boss9Health;
    WHILE NOT GameOver AND NOT ScreenComplete DO
        SpitX := MouthX;
        SpitY := MouthY;
        SpitYOffset := 0;
        Graph.PutImage(0, 100, BkAddress, Graph._GPSET);

        WHILE (SpitY < 200) AND NOT ScreenComplete AND NOT GameOver DO
            Graph.PutImage(0, 100, BkAddress, Graph._GPSET);
            SpitY := SpitY + 1 + SpitYOffset DIV 15;
            SpitYOffset := SpitY - MouthY;
            IF (SpitYOffset > 10) THEN
                IF (SpitX < PlaneX + (PlaneWidth DIV 2)) THEN
                    SpitX := SpitX + Lib.RANDOM(SpitY DIV 10);
                ELSIF (SpitX > 20) THEN
                    SpitX := SpitX - Lib.RANDOM(SpitY DIV 10);
                END;
            END;
            Ellipse(SpitX, SpitY, SpitYOffset * 4 DIV 15, SpitYOffset * 2 DIV 15, Blue, TRUE);
            Ellipse(SpitX, SpitY, (SpitYOffset + 1) * 4 DIV 15, (SpitYOffset + 2) * 2 DIV 15, LightestBlue, FALSE);
            CheckMouse();
            DrawPlane(PlaneX, PlaneY, PlaneWidth);
            Update3DBullet(FALSE);
            IF (BulletX > 80) AND (BulletX < 240) AND (BulletY = 1) THEN
                DrawBossFlashing(BossWidth);
                BossLives := BossLives - 1;
                DrawBoss9(BossWidth);
                Delay(GameSpeed);
                Score := Score + 150;
                Rectangle(319 * BossLives DIV Boss9Health, 1, 319, 9, Black, TRUE);
                IF (BossLives = 0) THEN
                    Graph.PutImage(0, 100, BkAddress, Graph._GPSET);
                    KillBoss9();
                    ScreenComplete := TRUE;
                END;
            END;
            IF (SpitY > SpitHitY) AND (PlaneX + (PlaneWidth DIV 2) + 20 > SpitX) AND (PlaneX + (PlaneWidth DIV 2) < SpitX + 20) THEN
                Die();
                IF (SpitX < PlaneWidth) THEN PlaneX := 265; END;
            END;
            Delay(GameSpeed);
        END; (* WHILE (SpitY < 200)... *)
    END; (* WHILE NOT GameO... *)

    IF GameOver THEN
        DrawGameOver();
    END;
END Boss9;

END Bosses9.
