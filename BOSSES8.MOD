IMPLEMENTATION MODULE Bosses8;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Exobius;
FROM Graph IMPORT Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Screens8 IMPORT DrawStars8, DrawPlanet, PlanetRadius, PlanetRadiusScaleDiv;
FROM Exobius IMPORT
    Black,
    DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    BulletY, PlaneY, PlaneStartY, PlaneWidth, PlaneHeight, Lives,
    Xs, Ys, ScreenComplete, GameOver, GameSpeed,
    PlaneX, PlaneY, DrawPlane, DrawPlane5025, CheckMouse, Die,
    BkAddress, DrawGameOver, FinishScreen, TextPos;

CONST
    PlanetBkLeft = 140; PlanetBkTop = 40; PlanetBkRight = 220; PlanetBkBottom = 160;
    Boss8Width = 75; Boss8Height = 30;
VAR
    Boss8X, Boss8Y : CARDINAL;
    Boss8Lives : INTEGER;
    BossDiving : BOOLEAN;

PROCEDURE DrawBoss8;
VAR
    WingColour, WingColour2, WingTip : CARDINAL;
BEGIN
    Xs[0] := Boss8X + 40; Ys[0] := Boss8Y + 15; Xs[1] := Boss8X + 50; Ys[1] := Boss8Y + 30; Xs[2] := Boss8X + 60; Ys[2] := Boss8Y + 15;
    Polygon(3, Xs, Ys, Red);
    Xs[0] := Boss8X + 45; Ys[0] := Boss8Y + 15; Xs[1] := Boss8X + 50; Ys[1] := Boss8Y + 24; Xs[2] := Boss8X + 55; Ys[2] := Boss8Y + 15;
    Polygon(3, Xs, Ys, Red);
    Disc(Boss8X + 43, Boss8Y + 10, 2, Blue);
    Disc(Boss8X + 57, Boss8Y + 10, 2, Blue);
    IF NOT BossDiving THEN
        Xs[0] := Boss8X + 40; Ys[0] := Boss8Y + 14; Xs[1] := Boss8X + 50; Ys[1] := Boss8Y + 4; Xs[2] := Boss8X + 60; Ys[2] := Boss8Y + 14;
        Polygon(3, Xs, Ys, LightestRed);
    END;
    Line(Boss8X + 50, Boss8Y + 7, Boss8X + 50, Boss8Y + 14, Red);
    Line(Boss8X + 48, Boss8Y + 9, Boss8X + 47, Boss8Y + 14, Red);
    Line(Boss8X + 52, Boss8Y + 9, Boss8X + 53, Boss8Y + 14, Red);
    CASE (Boss8X MOD 10) OF
         |0,9,10,11: WingTip := Boss8Y;     WingColour := DarkestGrey; WingColour2 := LightWhite;
         |1,2,18,19: WingTip := Boss8Y+2;   WingColour := Grey;        WingColour2 := DarkWhite;
         |3,4,16,17: WingTip := Boss8Y+4;   WingColour := LightGrey;   WingColour2 := LightestGrey;
         |5,6,14,15: WingTip := Boss8Y+6;   WingColour := DarkWhite;   WingColour2 := Grey;
         |7,8,12,13: WingTip := Boss8Y+8;   WingColour := LightWhite;  WingColour2 := DarkGrey;
    END;
    Xs[0] := Boss8X; Xs[1] := Boss8X + 25; Xs[2] := Boss8X + 25;
    Ys[0] := Boss8Y + 30; Ys[1] := WingTip; Ys[2] := WingTip + 20;
    Polygon(3, Xs, Ys, WingColour);
    Xs[0] := Boss8X + 100; Xs[1] := Boss8X + 75; Xs[2] := Boss8X + 75;
    Polygon(3, Xs, Ys, WingColour);
    Xs[0] := Boss8X + 25; Xs[1] := Boss8X + 25; Xs[2] := Boss8X + 50; Xs[3] := Boss8X + 40;
    Ys[0] := WingTip; Ys[1] := WingTip + 20; Ys[2] := Boss8Y + 30; Ys[3] := Boss8Y + 15;
    Polygon(4, Xs, Ys, WingColour2);
    Xs[0] := Boss8X + 75; Xs[1] := Boss8X + 75; Xs[2] := Boss8X + 50; Xs[3] := Boss8X + 60;
    Polygon(4, Xs, Ys, WingColour2);
END DrawBoss8;

PROCEDURE HurtBoss8;
BEGIN
    Sound(100);
    Xs[0] := Boss8X; Xs[1] := Boss8X + 25; Xs[2] := Boss8X + 50; Xs[3] := Boss8X + 75;
    Xs[4] := Boss8X + 100; Xs[5] := Boss8X + 75; Xs[6] := Boss8X + 50; Xs[7] := Boss8X + 25;
    Ys[0] := Boss8Y + 30; Ys[1] := Boss8Y; Ys[2] := Boss8Y + 15; Ys[3] := Boss8Y;
    Ys[4] := Boss8Y + 30; Ys[5] := Boss8Y + 20; Ys[6] := Boss8Y + 30; Ys[7] := Boss8Y + 20;
    Polygon(8, Xs, Ys, LightestWhite);
    Boss8Lives := Boss8Lives - 1;
    IF (Boss8Lives = 0) THEN
       ScreenComplete := TRUE;
    END;
    Rectangle(1 + (Boss8Lives * 4), 1, 318, 9, Black, TRUE);
    NoSound();
END HurtBoss8;

PROCEDURE KillBoss8;
VAR
    Explosions, Colour : CARDINAL;
BEGIN
    TextPos := Graph.SetTextPosition (1, 15);
    Graph.OutText ("Extra Life!");
    ScreenComplete := TRUE;
    FOR Explosions := 200 TO 0 BY -1 DO
        Sound (Explosions);
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
        Ellipse(Lib.RANDOM(100) + CARDINAL(Boss8X), Lib.RANDOM(30) + Boss8Y, Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
        Plot(Lib.RANDOM(100) + CARDINAL(Boss8X), Lib.RANDOM(30) + Boss8Y, Colour);
        Delay(10);
        NoSound();
    END;
END KillBoss8;

PROCEDURE DrawBoss8Bullet;
CONST
    PlaneHalfWidth = 25;
VAR
    BossLeft, BossRight : CARDINAL;
BEGIN
    Line(PlaneX + PlaneHalfWidth, PlaneY - 1, PlaneX + PlaneHalfWidth, 12, White);
    Line(PlaneX + PlaneHalfWidth - 1, PlaneY - 1, PlaneX + PlaneHalfWidth, 12, LightBlue);
    Line(PlaneX + PlaneHalfWidth + 1, PlaneY - 1, PlaneX + PlaneHalfWidth, 12, LightBlue);
    IF (Boss8X < 30) THEN BossLeft := 0; ELSE BossLeft := Boss8X - 30; END;
    IF (Boss8X > 239) THEN BossRight := 319; ELSE BossRight := Boss8X + 80; END;
    IF (PlaneX > BossLeft) AND (PlaneX < BossRight) THEN
       HurtBoss8();
    END;
END DrawBoss8Bullet;

PROCEDURE DrawAllBoss8Things;
BEGIN
    Rectangle(PlaneX, PlaneY, PlaneWidth, PlaneHeight, Black, TRUE);
    IF (Boss8X > PlanetBkLeft - Boss8Width) AND (Boss8X < PlanetBkRight) AND ((Boss8Y > PlanetBkBottom) OR (Boss8Y < PlanetBkTop - Boss8Height)) THEN
        Rectangle(Boss8X, Boss8Y, Boss8Width, Boss8Height, Black, TRUE);
    END;
    Graph.PutImage(PlanetBkLeft, PlanetBkTop, BkAddress, Graph._GPSET);
    DrawPlane5025();
    DrawBoss8();
    IF (BulletY = 5) THEN
        BulletY := 0;
        DrawBoss8Bullet();
    END;
    (*DrawStars8;*)
END DrawAllBoss8Things;

PROCEDURE Boss8;
VAR
    Boss8Move : CARDINAL;
CONST
    BossHealth = 80;
    BossDiveDownSpeed = 15; BossDiveUpSpeed = 10;
    BossYTop = 20;
BEGIN
    Boss8Lives := BossHealth; BossDiving := FALSE; Boss8X := 160;
    GameOver := FALSE; ScreenComplete := FALSE; BulletY := 0;
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    PlanetRadius := 50 * PlanetRadiusScaleDiv;
    DrawPlanet();
    Rectangle(1, 1, 318, 9, Red, TRUE);
    Rectangle(60, 40, 220, 160, White, FALSE);
    Graph.GetImage(PlanetBkLeft, PlanetBkTop, PlanetBkRight, PlanetBkBottom, BkAddress);

    (* Boss rises *)
    FOR Boss8Y := 200 TO BossYTop BY -BossDiveUpSpeed DO
    DrawAllBoss8Things();
    END;

    WHILE NOT (GameOver) AND NOT (ScreenComplete) DO
        IF NOT (GameOver) AND NOT (ScreenComplete) THEN
            Delay(GameSpeed);
            Boss8Move := Lib.RANDOM(5) + 1;
            IF (PlaneX < Boss8X) THEN
                Boss8X := Boss8X - Boss8Move;
            ELSIF (PlaneX > Boss8X) THEN
                Boss8X := Boss8X + Boss8Move;
            END;
            CheckMouse();
            DrawAllBoss8Things();
            IF (PlaneX > Boss8X - 10) AND (PlaneX <= Boss8X + Boss8Width - 10) THEN
                Boss8Y := BossYTop; BossDiving := TRUE;
                WHILE (Boss8Y < PlaneStartY) AND NOT (GameOver) AND NOT (ScreenComplete) DO
                    Boss8Y := Boss8Y + BossDiveDownSpeed;
                    CheckMouse();
                    DrawAllBoss8Things();
                    IF (Boss8Y > 140) AND (PlaneX > Boss8X - 35) AND (PlaneX < Boss8X + 85) THEN
                        Die();
                    END;
                    Delay(GameSpeed);
                END;
                Boss8Y := 180;
                WHILE (Boss8Y > BossYTop) AND NOT (GameOver) AND NOT (ScreenComplete) DO
                    Boss8Y := Boss8Y - BossDiveUpSpeed; IF (Boss8Y < BossYTop) THEN Boss8Y := BossYTop; END;
                    CheckMouse();
                    DrawAllBoss8Things();
                    IF (Boss8Y > 140) AND (PlaneX > Boss8X - 35) AND (PlaneX < Boss8X + 85) THEN
                        Die;
                    END;
                    Delay(GameSpeed);
                END;
            END;
            BossDiving := FALSE;
        END;
    END;

    IF (ScreenComplete) THEN
        IF (Lives > 0) THEN Lives := Lives - 1; END;
        KillBoss8();
        FinishScreen();
    ELSIF (GameOver) THEN
        DrawGameOver();
    END;
END Boss8;

END Bosses8.
