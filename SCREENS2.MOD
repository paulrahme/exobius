IMPLEMENTATION MODULE Screens2;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, Exobius;
FROM Graph IMPORT SetClipRgn, GetImage, PutImage, Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc, Point;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Sprites IMPORT DrawGlowWorms;
FROM Exobius IMPORT
    PutPixel, SetPixel,
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
    PlaneX, BulletX, BulletY, OldBulletX, OldBulletY, PlaneY,
    OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive, SixAlive,
    Enemies, Xs, Ys, Count, Lives, EnemyY,
    BkAddress, BkSize,
    ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
    DrawPlane, CheckMouse, CheckSpecialKeys, CheckMouseAndSpecialKeys, Die, DrawGameOver,
    FinishScreen, Key, CheckDeath1,
    DrawGameOver;

PROCEDURE BlowUpEnemy2 (x, y : CARDINAL);
CONST
    SoundDelay = 20;
BEGIN
    Sound(100);
    Disc(x + 10, y + 10, 10, LightestYellow);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(90);
    Disc(x + 10, y + 10, 10, LightYellow);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(80);
    Disc(x + 10, y + 10, 10, Yellow);
    NoSound;
    Sound(70);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, DarkYellow);
    NoSound;
    Sound(60);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, DarkestYellow);
    NoSound;
    Sound(50);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, LightestRed);
    NoSound;
    Sound(40);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, LightRed);
    NoSound;
    Sound(30);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, Red);
    NoSound;
    Sound(25);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, DarkRed);
    NoSound;
    Sound(22);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 10, DarkestRed);
    NoSound;
    Sound(20);
    Lib.Delay(SoundDelay);
    NoSound;
    Rectangle (x, y, x + 20, y + 35, Black, TRUE);
END BlowUpEnemy2;

PROCEDURE UpBullet;
BEGIN
    IF (BulletY < 60000) THEN
        IF (OldBulletX > 0) THEN
            Rectangle(OldBulletX - 1, OldBulletY, OldBulletX + 1, OldBulletY + 16, Black, FALSE);
            Line(OldBulletX, OldBulletY, OldBulletX, OldBulletY + 16, Black);
        END;

        (* Just fired? *)
        IF (BulletY = 5) THEN
            BulletY := 170;
            BulletX := PlaneX + (PlaneWidth DIV 2);
            OldBulletX := BulletX;
        END;

        (* Reached the top of the screen? Else move upwards *)
        IF (BulletY < 10) THEN
            Rectangle(BulletX - 1, BulletY, BulletX + 1, BulletY + 16, Black, FALSE);
            Line(BulletX, BulletY, BulletX, BulletY + 16, Black);
            BulletY := 65000;
        ELSE
            BulletY := BulletY - 10;
            (* Draw bullet *)
            Rectangle(BulletX - 1, BulletY + 1, BulletX + 1, BulletY + 9, LightBlue, FALSE);
            Line(BulletX, BulletY, BulletX, BulletY + 10, LightWhite);
        END;
        OldBulletY := BulletY;
    END;
END UpBullet;

PROCEDURE Screen2;
CONST
    GlowCount = 18;
    GlowWidth = 20;
    GlowHeight = 30;
VAR
    RoofDots, RoofSize, RectY, NewRectY, FadeCount, FadeCountInc, GlowSize, GlowIdx, GlowsAlive, MoveRnd, GX, GY : CARDINAL;
    GlowAddress, RoofAddress : ADDRESS;
    GlowXs, GlowYs : ARRAY[0..GlowCount] OF CARDINAL;
    OldPlaneX : INTEGER;
    DotColour : BYTE;
BEGIN
    ScreenComplete := FALSE;
    Graph.ClearScreen (Graph._GCLEARSCREEN);

    (* Draw cave interior *)
    DotColour := BYTE(White);
    FOR RoofDots := 1 TO 60000 DO
        SetPixel(Lib.RANDOM(64000), DotColour);
    END;
    CheckSpecialKeys();
    IF (NOT GameOver) THEN
        DotColour := BYTE(DarkestWhite);
        FOR RoofDots := 1 TO 20000 DO
            PutPixel(40 + Lib.RANDOM(240), 50 + Lib.RANDOM(100), DotColour);
        END;
    END;
    CheckSpecialKeys();
    IF (NOT GameOver) THEN
        DotColour := BYTE(LightGrey);
        FOR RoofDots := 1 TO 5000 DO
            PutPixel(70 + Lib.RANDOM(180), 50 + Lib.RANDOM(100), DotColour);
        END;
    END;
    CheckSpecialKeys();
    IF (NOT GameOver) THEN
        DotColour := BYTE(DarkGrey);
        FOR RoofDots := 1 TO 500 DO
            PutPixel(130 + Lib.RANDOM(60), 80 + Lib.RANDOM(40), DotColour);
        END;
    END;
    CheckSpecialKeys();
    IF (NOT GameOver) THEN
        DotColour := BYTE(DarkestGrey);
        FOR RoofDots := 1 TO 200 DO
            PutPixel(150 + Lib.RANDOM(20), 80 + Lib.RANDOM(40), DotColour);
        END;
    END;
    CheckSpecialKeys();

    (* Fly in plane *)
    IF (NOT GameOver) THEN
        Rectangle (158, 98, 162, 102, Black, TRUE);
        SetClipRgn (0, 0, 320, 199);
        BkSize := CARDINAL(Graph.ImageSize(0, 150, 320, 200));
        Storage.ALLOCATE(BkAddress, BkSize);
        GetImage(0, 150, 320, 200, BkAddress);
        FOR PlaneY := 200 TO 175 BY -1 DO
            PlaneX := 145 - (PlaneY - 175);
            DrawPlane(PlaneX, PlaneY, PlaneY - 125);
            Lib.Delay(50);
            Graph.PutImage(0, 150, BkAddress, Graph._GPSET);
        END;
        Storage.DEALLOCATE(BkAddress, BkSize);
        CheckSpecialKeys();
    END;

    (* Darken cave *)
    IF (NOT GameOver) THEN
        PlaneX := 145; OldPlaneX := PlaneX; PlaneY := 175; BulletY := 65520; RectY := 100;
        FadeCountInc := 1;
        FOR FadeCount := 1 TO 4000 DO
            IF (FadeCount > 2500) THEN
                IF (FadeCountInc < 100) THEN
                    FadeCountInc := FadeCountInc + 1;
                END;
                FadeCount := FadeCount + FadeCountInc;
                IF (FadeCount > 4000) THEN
                    FadeCount := 4000;
                END;
            END;
            NewRectY := 100 + (FadeCount DIV 40);
            IF (NewRectY > RectY) THEN
                RectY := NewRectY;
                Rectangle(200 - RectY, 200 - RectY, 120 + RectY, RectY, Black, TRUE);
            END;
            IF (NewRectY < 175) THEN
                Disc(Lib.RANDOM(320), Lib.RANDOM(200), 5,  Black);
                IF (FadeCount MOD 20 = 0) THEN
                    DrawPlane(PlaneX, PlaneY, PlaneWidth);
                END;
            ELSE
                IF (RectY MOD 5 = 0) THEN
                    DrawPlane(PlaneX, PlaneY, PlaneWidth);
                END;
            END;
        END;
        CheckSpecialKeys();
    END;

    (* Draw enemies *)
    GlowSize := CARDINAL(Graph.ImageSize(0, 0, GlowWidth, GlowHeight));
    Storage.ALLOCATE(GlowAddress, GlowSize);
    IF (NOT GameOver) THEN
        GlowsAlive := GlowCount;
        FOR GY := 0 TO 2 DO
            FOR GX := 0 TO 5 DO
                GlowIdx := (GY * 6) + GX;
                GlowXs[GlowIdx] := 45 + (GX * 45);
                GlowYs[GlowIdx] := GY * 35;
            END;
        END;
        DrawGlowWorms(GlowXs[0], GlowYs[0]);
        GetImage(GlowXs[0], GlowYs[0], GlowXs[0] + GlowWidth, GlowYs[0] + GlowHeight, GlowAddress);
    END;
    CheckMouseAndSpecialKeys();

    (* Main game loop *)
    WHILE NOT ScreenComplete AND NOT GameOver DO
        (* Update player *)
        OldPlaneX := PlaneX;
        CheckMouse();
        Rectangle(CARDINAL(OldPlaneX), PlaneY, CARDINAL(OldPlaneX) + PlaneWidth, PlaneY + PlaneHeight, Black, TRUE);
        DrawPlane(PlaneX, PlaneY, PlaneWidth);
        UpBullet;

        (* Draw enemies *)
        FOR GlowIdx := 0 TO (GlowCount - 1) DO
            GX := GlowXs[GlowIdx]; GY := GlowYs[GlowIdx];
            (* Enemy alive? *)
            IF (GY < 65000) THEN
                IF (GY > 170) THEN
                    (* At the bottom of the screen - move towards the plane *)
                    IF (GX < CARDINAL(PlaneX)) THEN
                        GX := GX + 1;
                    ELSIF (GX > CARDINAL(PlaneX) + PlaneWidth) THEN
                        GX := GX - 1;
                    END;
                ELSE
                    MoveRnd := Lib.RANDOM(12);
                    IF ((MoveRnd = 1) OR (MoveRnd = 2)) AND NOT (GX > 280) THEN
                        GX := GX + 1;
                    ELSIF ((MoveRnd = 3) OR (MoveRnd = 4)) AND (GX > 20) THEN
                        GX := GX - 1;
                    END;
                    IF (MoveRnd = 5) THEN
                        HLine(GX, GY, GX + GlowWidth, Black);
                        GY := GY + 1;
                    END;
                END;

                PutImage(GX, GY, GlowAddress, Graph._GPSET);
                Plot(GX + 5 + Lib.RANDOM(10), GY + 12 + Lib.RANDOM(8), 14);
                Plot(GX + 5 + Lib.RANDOM(10), GY + 12 + Lib.RANDOM(8), 68);

                (* Hit by bullet? *)
                IF (BulletY < GY + 10) AND (BulletX > GX) AND (BulletX < GX + GlowWidth) THEN
                    BlowUpEnemy2(GX, GY);
                    BulletY := 65000;
                    GY := 65000;
                    GlowsAlive := GlowsAlive - 1;
                (* Hit player? *)
                ELSIF (GY > PlaneY - 25) AND (GX > PlaneX - 15) AND (GX < PlaneX + PlaneWidth + 15) THEN
                    Disc(GX + (GlowWidth DIV 2), GY + (GlowHeight DIV 2), 10, DarkestRed);
                    OldPlaneX := PlaneX;
                    Die;
                    IF NOT GameOver THEN
                        Rectangle(CARDINAL(OldPlaneX), PlaneY, CARDINAL(OldPlaneX) + PlaneWidth, PlaneY + PlaneHeight, Black, TRUE);
                        Rectangle(GX, GY, GX + GlowWidth, GY + GlowHeight, Black, TRUE);
                        GY := 65000;
                        GlowsAlive := GlowsAlive - 1;
                    END;
                END;
            END;
            GlowXs[GlowIdx] := GX; GlowYs[GlowIdx] := GY;
        END;
        IF (GlowsAlive = 0) THEN
            ScreenComplete := TRUE;
        END;
    END; (* Main game loop *)

    Storage.DEALLOCATE(GlowAddress, GlowSize);

    IF GameOver THEN
        DrawGameOver;
    END;
END Screen2;

END Screens2.
