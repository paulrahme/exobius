IMPLEMENTATION MODULE Bosses2;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Storage, Exobius;
FROM Graph IMPORT Point, SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Sprites IMPORT DrawSpinners;
FROM Screens8 IMPORT DrawStars8, DrawPlanet, PlanetRadius;
FROM Exobius IMPORT
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    GameSpeed, BkAddress,
    PlaneX, PlaneY, PlaneWidth, BulletX, BulletY, Lives,
    OneAlive, TwoAlive, ThreeAlive,
    ScreenComplete, GameOver,
    DrawPlane, DrawPlane5025, CheckMouse, Die, DrawGameOver, TextPos;

CONST
    Boss1X = 0;
    Boss2X = 110;
    Boss3X = 220;
    BossMove = 5;
VAR
    Boss1Y, Boss2Y, Boss3Y, Boss1Lives, Boss2Lives, Boss3Lives : CARDINAL;
    BossAddressA, BossAddressB, BossAddressC : ADDRESS;

PROCEDURE DrawBoss2(X1, Y1, X2, Y2, X3, Y3 : CARDINAL; BossAddress : ADDRESS);
BEGIN
    IF OneAlive THEN
        Graph.PutImage(X1, Y1, BossAddress, Graph._GPSET);
    END;
    IF TwoAlive THEN
        Graph.PutImage(X2, Y2, BossAddress, Graph._GPSET);
    END;
    IF ThreeAlive THEN
        Graph.PutImage(X3, Y3, BossAddress, Graph._GPSET);
    END;
END DrawBoss2;

PROCEDURE BlowUpBoss2(x, y : CARDINAL);
VAR
    Explosions, Colour : CARDINAL;
BEGIN
    TextPos := Graph.SetTextPosition (1, 15);
    Graph.OutText ("Extra Life!");
    FOR Explosions := 100 TO 0 BY -1 DO
        Sound(Explosions);
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
        Ellipse(Lib.RANDOM(100) + x, Lib.RANDOM(100) + y, Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
        Plot(Lib.RANDOM(100) + x, Lib.RANDOM(100) + y, Colour);
        Delay(GameSpeed);
        NoSound;
    END;
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    IF NOT (OneAlive OR TwoAlive OR ThreeAlive) THEN
        ScreenComplete := TRUE;
    END;
    IF (Lives > 0) THEN
        Lives := Lives - 1;
    END;
END BlowUpBoss2;

PROCEDURE DrawBarGraphs2;
BEGIN
    Rectangle(0, 0, 101, 10, White, FALSE);
    IF OneAlive THEN
        Rectangle(1, 1, 100, 9, Black, TRUE);
        Rectangle(1, 1, Boss1Lives*10, 9, Red, TRUE);
    END;

    Rectangle(110, 0, 211, 10, White, FALSE);
    IF TwoAlive THEN
        Rectangle(111, 1, 210, 9, Black, TRUE);
        Rectangle(111, 1, Boss2Lives*10 + 110, 9, Red, TRUE);
    END;

    Rectangle(220, 0, 318, 10, White, FALSE);
    IF ThreeAlive THEN
        Rectangle(221, 1, 319, 9, Black, TRUE);
        Rectangle(221, 1, Boss3Lives*10 + 220, 9, Red, TRUE);
    END;
END DrawBarGraphs2;

PROCEDURE HurtBoss2;
CONST
    Boss2FlashDelay = 8;
BEGIN
    IF (BulletX < 105) THEN
        IF OneAlive THEN
            Boss1Lives := Boss1Lives - 1;
            IF (Boss1Lives=0) THEN
                OneAlive := FALSE;
                BlowUpBoss2(Boss1X, Boss1Y);
                RETURN;
            ELSE
                Disc(Boss1X + 50, Boss1Y + 50, 18, LightestWhite);
                Sound(440); Delay(Boss2FlashDelay); NoSound;
                Sound(220); Delay(Boss2FlashDelay); NoSound;
                Sound(50); Delay (Boss2FlashDelay); NoSound;
            END;
        END;
    ELSIF (BulletX < 220) THEN
        IF TwoAlive THEN
            Boss2Lives := Boss2Lives - 1;
            IF (Boss2Lives = 0) THEN
                TwoAlive := FALSE;
                BlowUpBoss2(Boss2X, Boss2Y);
            ELSE
                Disc(Boss2X + 50, Boss2Y + 50, 18, LightestWhite);
                Sound(440); Delay(Boss2FlashDelay); NoSound;
                Sound(220); Delay(Boss2FlashDelay); NoSound;
                Sound(50); Delay (Boss2FlashDelay); NoSound;
            END;
        END;
    ELSE
        IF ThreeAlive THEN
            Boss3Lives := Boss3Lives - 1;
            IF (Boss3Lives = 0) THEN
                  ThreeAlive := FALSE;
                  BlowUpBoss2(Boss3X, Boss3Y);
            ELSE
                  Disc(Boss3X + 50, Boss3Y + 50, 18, LightestWhite);
                  Sound(440); Delay(Boss2FlashDelay); NoSound;
                  Sound(220); Delay(Boss2FlashDelay); NoSound;
                  Sound(50); Delay (Boss2FlashDelay); NoSound;
            END;
         END;
    END;
    DrawBarGraphs2;
END HurtBoss2;

PROCEDURE DrawBulletBoss2;
VAR
    NewBulletX : CARDINAL;
    Dist : INTEGER;
BEGIN
    CASE BulletY OF
        |5: Disc (PlaneX + (PlaneWidth DIV 2), PlaneY - 4, 4, LightYellow);
            BulletY := 4;
        |4: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*70) DIV 2)) * INTEGER(BulletX - 160) DIV 160;
                NewBulletX := 160 + ABS(Dist);
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*70) DIV 2)) * INTEGER(160 - BulletX) DIV 160;
                NewBulletX := 160 - ABS(Dist);
            END;
            Disc(NewBulletX, 150, 2, Yellow);
            Delay(3);
            Disc(NewBulletX, 150, 2, Black);
            BulletY := 3;
        |3: HurtBoss2;
            BulletY := 0;
    END;
END DrawBulletBoss2;

PROCEDURE FinishScreenBoss2;
BEGIN
    FOR PlaneY := 175 TO 100 BY -2 DO
        IF (PlaneX<155) THEN
            PlaneX := PlaneX + 5;
        END;
        IF (PlaneX>155) THEN
            PlaneX := PlaneX - 5;
        END;
        Graph.ClearScreen (Graph._GCLEARSCREEN);
        DrawPlane(PlaneX, PlaneY, ((PlaneY - 100) DIV 2));
        Delay(GameSpeed * 3);
    END;
    Graph.ClearScreen(Graph._GCLEARSCREEN);
END FinishScreenBoss2;

PROCEDURE Boss2;
VAR
    BossFall, LeftBehind, BossSize : CARDINAL;
BEGIN
    PlaneX := 145; PlaneY := 174;

    BossSize := CARDINAL(Graph.ImageSize(0, 0, 100, 100));
    BossAddressA := BkAddress; (* First one can use existing alloc *)
    Storage.ALLOCATE(BossAddressB, BossSize);
    Storage.ALLOCATE(BossAddressC, BossSize);

    (* Draw + capture boss frame 1 *)
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane5025();
    DrawSpinners(Boss1X, 0, 100);
    Graph.GetImage(Boss1X, 0, Boss1X + 100, 100, BossAddressA);
    Graph.PutImage(Boss2X, 0, BossAddressA, Graph._GPSET);
    Graph.PutImage(Boss3X, 0, BossAddressA, Graph._GPSET);

    (* Draw + capture boss frame 2 *)
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane5025();
    DrawSpinners(Boss1X, 1, 100);
    Graph.GetImage(Boss1X, 1, Boss1X + 100, 101, BossAddressB);
    Graph.PutImage(Boss2X, 1, BossAddressB, Graph._GPSET);
    Graph.PutImage(Boss3X, 1, BossAddressB, Graph._GPSET);

    (* Draw + capture boss frame 3 *)
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane5025();
    DrawSpinners(Boss1X, 2, 100);
    Graph.GetImage(Boss1X, 2, Boss1X + 100, 102, BossAddressC);
    Graph.PutImage(Boss2X, 2, BossAddressC, Graph._GPSET);
    Graph.PutImage(Boss3X, 2, BossAddressC, Graph._GPSET);

    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane5025();
    FOR BossFall := 3 TO 50 DO
        Rectangle(0, BossFall - 2, 319, BossFall, Black, TRUE);
        CASE (BossFall MOD 3) OF
            |0: DrawBoss2(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall, BossAddressA);
            |1: DrawBoss2(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall, BossAddressB);
            |2: DrawBoss2(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall, BossAddressC);
        END;
    END;

    (* THE ACTION BEGINS!! *)
    Boss1Lives := 10; Boss2Lives := 10; Boss3Lives := 10;
    OneAlive := TRUE; TwoAlive := TRUE; ThreeAlive := TRUE;
    ScreenComplete := FALSE;
    Boss1Y := BossFall; Boss2Y := BossFall; Boss3Y := BossFall;
    DrawBarGraphs2;
    WHILE NOT (GameOver OR ScreenComplete) DO
        BossFall := Boss1Y;
        LeftBehind := Lib.RANDOM(3);
        WHILE ((BossFall < 100) AND NOT (ScreenComplete) AND NOT (GameOver))DO
            IF (NOT GameOver) AND (NOT ScreenComplete) THEN
                IF (LeftBehind > 1) THEN
                    Rectangle(Boss1X, Boss1Y, Boss1X + 100, Boss1Y + BossFall, Black, TRUE);
                    Boss1Y := BossFall;
                END;
                IF (LeftBehind <> 2) THEN
                    Rectangle(Boss2X, Boss2Y, Boss2X + 100, Boss2Y + BossFall, Black, TRUE);
                    Boss2Y := BossFall;
                END;
                IF (LeftBehind < 3) THEN
                    Rectangle(Boss3X, Boss3Y, Boss3X + 100, Boss3Y + BossFall, Black, TRUE);
                    Boss3Y := BossFall;
                END;
                Rectangle(0, PlaneY - 2, 320, 200, Black, TRUE);
                DrawPlane5025();
                CASE (BossFall MOD 3) OF
                    |0: DrawBoss2(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y, BossAddressA);
                    |1: DrawBoss2(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y, BossAddressB);
                    |2: DrawBoss2(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y, BossAddressC);
                END;
                CheckMouse;
                DrawBulletBoss2;
                BossFall := BossFall + BossMove;
                IF (BulletY=4) THEN
                    Disc (PlaneX + (PlaneWidth DIV 2), PlaneY - 4, 4, Black);
                END;
                IF (Point (PlaneX + 10, PlaneY - 2) <> Black) OR
                   (Point (PlaneX + 40, PlaneY - 2) <> Black) OR
                   (Point (PlaneX + 25, PlaneY - 2) <> Black) THEN
                    Die;
                    CASE LeftBehind OF
                        |1: PlaneX := 30;
                        |2: PlaneX := 135;
                        |3: PlaneX := 190;
                    END;
                END;
                Delay((GameSpeed+1)*2);
            END; (* IF Statement *)
        END; (* BossFall *)
        WHILE ((BossFall > 50) AND NOT (ScreenComplete) AND NOT (GameOver))DO
            IF (NOT GameOver) AND (NOT ScreenComplete) THEN
                IF LeftBehind > 1 THEN
                    Rectangle (Boss1X, Boss1Y + 100, Boss1X + 100, Boss1Y + BossFall, Black, TRUE);
                    Boss1Y := BossFall;
                END;
                IF LeftBehind <> 2 THEN
                    Rectangle (Boss2X, Boss2Y + 100, Boss2X + 100, Boss2Y + BossFall, Black, TRUE);
                    Boss2Y := BossFall;
                END;
                IF LeftBehind < 3 THEN
                    Rectangle (Boss3X, Boss3Y + 100, Boss3X + 100, Boss3Y + BossFall, Black, TRUE);
                    Boss3Y := BossFall;
                END;
                Rectangle (0, PlaneY - 2, 320, 200, Black, TRUE);
                DrawPlane5025();
                CASE (BossFall MOD 3) OF
                    |0: DrawBoss2(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y, BossAddressA);
                    |1: DrawBoss2(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y, BossAddressB);
                    |2: DrawBoss2(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y, BossAddressC);
                END;
                CheckMouse;
                DrawBulletBoss2;
                BossFall := BossFall - BossMove;
                IF (BulletY=4) THEN
                    Disc(PlaneX + (PlaneWidth DIV 2), PlaneY - 4, 4, Black);
                END;
                IF (Point (PlaneX + 10, PlaneY - 2) <> Black) OR
                   (Point (PlaneX + 40, PlaneY - 2) <> Black) OR
                   (Point (PlaneX + 25, PlaneY - 2) <> Black) THEN
                    Die;
                    CASE LeftBehind OF
                        |1: PlaneX := 30;
                        |2: PlaneX := 135;
                        |3: PlaneX := 190;
                    END;
                END;
                Delay((GameSpeed+1)*2);
            END; (* IF Statement *)
        END; (* BossFall *)
        Graph.ClearScreen(Graph._GCLEARSCREEN);
        DrawBarGraphs2;
    END; (* ScreenComplete Check *)
    IF (ScreenComplete) THEN
       FinishScreenBoss2();
    ELSE
       DrawGameOver();
    END;
    
    (* Deallocate - skip BossAddressA since that reuses the pre-alloc'd BkAddress *)
    Storage.DEALLOCATE(BossAddressC, BossSize);
    Storage.DEALLOCATE(BossAddressB, BossSize);
END Boss2;

END Bosses2.
