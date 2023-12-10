IMPLEMENTATION MODULE Bosses4;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Storage, Exobius;
FROM Graph IMPORT Point, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;
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
    PlaneX, PlaneY, PlaneWidth, BulletX, BulletY, OldBulletX, Lives,
    Boss1Lives, Boss2Lives, Boss3Lives, OneAlive, TwoAlive, ThreeAlive,
    ScreenComplete, GameOver,
    DrawPlane, DrawPlane5025, CheckMouse, Die, DrawGameOver, TextPos;

CONST
    Boss1X = 0;
    Boss2X = 110;
    Boss3X = 220;
    BossMove = 2;
    BossIdleY = 30;
    BossDipY = 100;
    BossLives = 20;
VAR
    BossAddressA, BossAddressB, BossAddressC : ADDRESS;
    Boss1Y, Boss2Y, Boss3Y : CARDINAL;

PROCEDURE DrawBoss4(X1, Y1, X2, Y2, X3, Y3, Frame : CARDINAL);
VAR
    BossAddress : ADDRESS;
BEGIN
    CASE Frame OF
        |0: BossAddress := BossAddressA;
        |1: BossAddress := BossAddressB;
        |2: BossAddress := BossAddressC;
    END;

    IF OneAlive THEN Graph.PutImage(X1, Y1, BossAddress, Graph._GPSET); END;
    IF TwoAlive THEN Graph.PutImage(X2, Y2, BossAddress, Graph._GPSET); END;
    IF ThreeAlive THEN Graph.PutImage(X3, Y3, BossAddress, Graph._GPSET); END;
END DrawBoss4;

PROCEDURE DrawBarGraphs;
BEGIN
    Rectangle(0, 0, 102, 10, White, FALSE);
    Rectangle(1, 1, 101, 9, Black, TRUE);
    IF OneAlive THEN
        Rectangle(1, 1, 1 + (Boss1Lives * 5), 9, Red, TRUE);
    END;

    Rectangle(110, 0, 212, 10, White, FALSE);
    Rectangle(111, 1, 211, 9, Black, TRUE);
    IF TwoAlive THEN
        Rectangle(111, 1, 111 + (Boss2Lives * 5), 9, Red, TRUE);
    END;

    Rectangle(217, 0, 319, 10, White, FALSE);
    Rectangle(218, 1, 318, 9, Black, TRUE);
    IF ThreeAlive THEN
        Rectangle(218, 1, 218 + (Boss3Lives * 5), 9, Red, TRUE);
    END;
END DrawBarGraphs;

PROCEDURE MakeBossRunAway(x, y : CARDINAL);
CONST
    UpdateFrames = 50;
VAR
    BossRadiusMult : CARDINAL;
    Progress, StartOffsetX, StartOffsetY : INTEGER;
BEGIN
    (* Centre of boss *)
    x := x + 50; StartOffsetX := INTEGER(x) - 159;
    y := y + 50; StartOffsetY := INTEGER(y) - 99;

    FOR Progress := UpdateFrames TO 0 BY -1 DO
        Rectangle(x - 30, y - 30, x + 30, y + 30, Black, TRUE);
        x := (CARDINAL(159 + (StartOffsetX * Progress DIV UpdateFrames)));
        y := (CARDINAL(99 + (StartOffsetY * Progress DIV UpdateFrames)));
        BossRadiusMult := Progress;
        IF (BossRadiusMult < 10) THEN BossRadiusMult := 10; END;
        Disc(x, y, 20 * BossRadiusMult DIV UpdateFrames, DarkGreen);
        Disc(x + 5 * BossRadiusMult DIV UpdateFrames, y - 5 * BossRadiusMult DIV UpdateFrames, 7 * BossRadiusMult DIV UpdateFrames, LightGreen);

        Rectangle(0, PlaneY, 319, 199, Black, TRUE);
        CheckMouse();
        DrawPlane5025();
        Delay(GameSpeed);
    END;
END MakeBossRunAway;

PROCEDURE BlowUpBoss(x, y : CARDINAL);
VAR
    Explosions, Colour : CARDINAL;
BEGIN
    DrawBarGraphs();
    TextPos := Graph.SetTextPosition (3, 2 + (x DIV 8));
    Graph.OutText("Extra Life!");
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
        MakeBossRunAway(x, y);
    END;
    IF (Lives > 0) THEN
        Lives := Lives - 1;
    END;
END BlowUpBoss;

PROCEDURE HurtBoss;
CONST
    BossFlashDelay = 8;
BEGIN
    IF (BulletX < 105) THEN
        IF OneAlive THEN
            Boss1Lives := Boss1Lives - 1;
            IF (Boss1Lives=0) THEN
                OneAlive := FALSE;
                BlowUpBoss(Boss1X, Boss1Y);
                RETURN;
            ELSE
                Disc(Boss1X + 50, Boss1Y + 50, 18, LightestWhite);
                Sound(440); Delay(BossFlashDelay); NoSound;
                Sound(220); Delay(BossFlashDelay); NoSound;
                Sound(50); Delay (BossFlashDelay); NoSound;
            END;
        END;
    ELSIF (BulletX < 220) THEN
        IF TwoAlive THEN
            Boss2Lives := Boss2Lives - 1;
            IF (Boss2Lives = 0) THEN
                TwoAlive := FALSE;
                BlowUpBoss(Boss2X, Boss2Y);
            ELSE
                Disc(Boss2X + 50, Boss2Y + 50, 18, LightestWhite);
                Sound(440); Delay(BossFlashDelay); NoSound;
                Sound(220); Delay(BossFlashDelay); NoSound;
                Sound(50); Delay (BossFlashDelay); NoSound;
            END;
        END;
    ELSE
        IF ThreeAlive THEN
            Boss3Lives := Boss3Lives - 1;
            IF (Boss3Lives = 0) THEN
                  ThreeAlive := FALSE;
                  BlowUpBoss(Boss3X, Boss3Y);
            ELSE
                  Disc(Boss3X + 50, Boss3Y + 50, 18, LightestWhite);
                  Sound(440); Delay(BossFlashDelay); NoSound;
                  Sound(220); Delay(BossFlashDelay); NoSound;
                  Sound(50); Delay (BossFlashDelay); NoSound;
            END;
         END;
    END;
    DrawBarGraphs();
END HurtBoss;

PROCEDURE DrawBossBullet;
CONST
    BulletY5 = 170;
    BulletY4 = 150;
    BulletY3 = 135;
VAR
    Dist : INTEGER;
BEGIN
    CASE BulletY OF
        |5: Disc(OldBulletX, BulletY5, 4, Black);
            Disc(OldBulletX, BulletY4, 3, Black);
            Disc(OldBulletX, BulletY3, 2, Black);
            OldBulletX := BulletX;
            Disc(BulletX, BulletY5, 4, LightYellow);
            BulletY := 4;
        |4: Disc(BulletX, BulletY5, 4, Black);
            Disc(BulletX, BulletY4, 3, Yellow);
            BulletY := 3;
        |3: Disc(BulletX, BulletY4, 3, Black);
            Disc(BulletX, BulletY3, 2, Yellow);
            BulletY := 2;
        |2: Disc(BulletX, BulletY3, 2, Black);
            HurtBoss;
            BulletY := 0;
    END;
END DrawBossBullet;

PROCEDURE FinishScreenBoss4;
BEGIN
    FOR PlaneY := 175 TO BossDipY BY -2 DO
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
END FinishScreenBoss4;

PROCEDURE Boss4;
VAR
    BossFall, LeftBehind, BossSize, BossAnimFrame : CARDINAL;
BEGIN
    PlaneX := 135; PlaneY := 174;
    Boss1Lives := BossLives; Boss2Lives := BossLives; Boss3Lives := BossLives;
    OneAlive := TRUE; TwoAlive := TRUE; ThreeAlive := TRUE;

    BossSize := CARDINAL(Graph.ImageSize(0, 0, 100, 100));
    BossAddressA := BkAddress; (* First one can use existing alloc *)
    Storage.ALLOCATE(BossAddressB, BossSize);
    Storage.ALLOCATE(BossAddressC, BossSize);

    (* Draw + capture boss frame 1 *)
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane5025();
    DrawSpinners(Boss1X, 0, 98);
    Graph.GetImage(Boss1X, 0, Boss1X + 100, 100, BossAddressA);
    Graph.PutImage(Boss2X, 0, BossAddressA, Graph._GPSET);
    Graph.PutImage(Boss3X, 0, BossAddressA, Graph._GPSET);

    (* Draw + capture boss frame 2 *)
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane5025();
    DrawSpinners(Boss1X, 1, 98);
    Graph.GetImage(Boss1X, 1, Boss1X + 100, 101, BossAddressB);
    Graph.PutImage(Boss2X, 1, BossAddressB, Graph._GPSET);
    Graph.PutImage(Boss3X, 1, BossAddressB, Graph._GPSET);

    (* Draw + capture boss frame 3 *)
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawPlane5025();
    DrawSpinners(Boss1X, 2, 98);
    Graph.GetImage(Boss1X, 2, Boss1X + 100, 102, BossAddressC);
    Graph.PutImage(Boss2X, 2, BossAddressC, Graph._GPSET);
    Graph.PutImage(Boss3X, 2, BossAddressC, Graph._GPSET);

    (* Bring them down the screen *)
    FOR BossFall := 3 TO BossIdleY DO
        Rectangle(0, BossFall - 2, 319, BossFall, Black, TRUE);
        DrawBoss4(Boss1X, BossFall, Boss2X, BossFall, Boss3X, BossFall, BossAnimFrame);
        BossAnimFrame := (BossAnimFrame + 1) MOD 3;
        Delay(GameSpeed);
    END;
    Rectangle(0, BossFall - 2, 319, BossFall, Black, TRUE);

    (* THE ACTION BEGINS!! *)
    CheckMouse();
    PlaneX := 135; BulletY := 0;
    ScreenComplete := FALSE;
    Boss1Y := BossFall; Boss2Y := BossFall; Boss3Y := BossFall;
    LeftBehind := 1;
    DrawBarGraphs();

    WHILE NOT (GameOver OR ScreenComplete) DO
        (* Move downward *)
        WHILE ((BossFall < BossDipY) AND NOT (ScreenComplete) AND NOT (GameOver)) DO
            IF (NOT GameOver) AND (NOT ScreenComplete) THEN
                IF (LeftBehind > 0) THEN
                    Rectangle(Boss1X, Boss1Y - 1, Boss1X + 100, Boss1Y + BossMove, Black, TRUE);
                    Boss1Y := BossFall;
                END;
                IF (LeftBehind <> 1) THEN
                    Rectangle(Boss2X, Boss2Y - 1, Boss2X + 100, Boss2Y + BossMove, Black, TRUE);
                    Boss2Y := BossFall;
                END;
                IF (LeftBehind < 2) THEN
                    Rectangle(Boss3X, Boss3Y - 1, Boss3X + 100, Boss3Y + BossMove, Black, TRUE);
                    Boss3Y := BossFall;
                END;
                BossAnimFrame := (BossAnimFrame + 1) MOD 3;
                Rectangle(0, PlaneY - 2, 319, 199, Black, TRUE);
                CheckMouse();
                DrawPlane5025();
                DrawBossBullet();
                DrawBoss4(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y, BossAnimFrame);
                BossFall := BossFall + BossMove;
                IF (BulletY=4) THEN
                    Disc (PlaneX + (PlaneWidth DIV 2), PlaneY - 4, 4, Black);
                END;
                IF (Point(PlaneX + 10, PlaneY - 2) <> Black) OR
                   (Point(PlaneX + 40, PlaneY - 2) <> Black) OR
                   (Point(PlaneX + 25, PlaneY - 2) <> Black) THEN
                    Die;
                    CASE LeftBehind OF
                        |0: PlaneX := 30;
                        |1: PlaneX := 135;
                        |2: PlaneX := 190;
                    END;
                END;
                Delay(GameSpeed * 2);
            END; (* IF Statement *)
        END; (* BossFall *)

        (* Move back upward *)
        WHILE ((BossFall > BossIdleY) AND NOT (ScreenComplete) AND NOT (GameOver)) DO
            IF (NOT GameOver) AND (NOT ScreenComplete) THEN
                IF (LeftBehind > 0) THEN
                    Rectangle(Boss1X, Boss1Y + 100 - BossMove, Boss1X + 100, Boss1Y + 101, Black, TRUE);
                    Boss1Y := BossFall;
                END;
                IF (LeftBehind <> 1) THEN
                    Rectangle(Boss2X, Boss2Y + 100 - BossMove, Boss2X + 100, Boss2Y + 101, Black, TRUE);
                    Boss2Y := BossFall;
                END;
                IF (LeftBehind < 2) THEN
                    Rectangle(Boss3X, Boss3Y + 100 - BossMove, Boss3X + 100, Boss3Y + 101, Black, TRUE);
                    Boss3Y := BossFall;
                END;
                BossAnimFrame := (BossAnimFrame + 1) MOD 3;
                Rectangle(0, PlaneY - 1, 319, 199, Black, TRUE);
                CheckMouse();
                DrawPlane5025();
                DrawBoss4(Boss1X, Boss1Y, Boss2X, Boss2Y, Boss3X, Boss3Y, BossAnimFrame);
                DrawBossBullet();
                BossFall := BossFall - BossMove;
                IF (BulletY=4) THEN
                    Disc(PlaneX + (PlaneWidth DIV 2), PlaneY - 4, 4, Black);
                END;
                IF (Point(PlaneX + 10, PlaneY - 2) <> Black) OR
                   (Point(PlaneX + 40, PlaneY - 2) <> Black) OR
                   (Point(PlaneX + 25, PlaneY - 2) <> Black) THEN
                    Die;
                    CASE LeftBehind OF
                        |0: PlaneX := 30;
                        |1: PlaneX := 135;
                        |2: PlaneX := 190;
                    END;
                END;
                Delay(GameSpeed * 2);
            END; (* IF Statement *)
        END; (* BossFall *)

        (* Pseudo-random because Lib.RANDOM seems to pick the middle one most of the time *)
        LeftBehind := (Boss1Lives + Boss2Lives + Boss3Lives + PlaneX) MOD 3;
    END; (* ScreenComplete Check *)
    
    IF (ScreenComplete) THEN
       FinishScreenBoss4();
    ELSE
       DrawGameOver();
    END;
    
    (* Deallocate - skip BossAddressA since that reuses the pre-alloc'd BkAddress *)
    Storage.DEALLOCATE(BossAddressC, BossSize);
    Storage.DEALLOCATE(BossAddressB, BossSize);
END Boss4;

END Bosses4.
