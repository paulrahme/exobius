IMPLEMENTATION MODULE Screens2;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Storage, Exobius;
FROM Graph IMPORT GetImage, PutImage, Rectangle, Line, HLine, Disc, Plot;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Sprites IMPORT DrawGlowWorms;
FROM Exobius IMPORT
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    PlaneX, PlaneStartX, PlaneStartY, BulletX, BulletY, OldBulletX, StartBulletCooldown, PlaneY,
    BkAddress, PutPixel, SetPixel,
    CheckMouse, CheckSpecialKeys, CheckMouseAndSpecialKeys,
    PlaneWidth, PlaneHeight, DrawPlane, DrawPlane5025, DrawLives, UpdateScore, HudY, HudBg,
    ScreenComplete, GameOver, GameSpeed, Lives, Die, DrawGameOver;

VAR
    OldBulletY : CARDINAL;

PROCEDURE BlowUpEnemy2(x, y : CARDINAL);
CONST
    SoundDelay = 16;
BEGIN
    Sound(100);
    Disc(x + 10, y + 10, 5, LightYellow);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(90);
    Disc(x + 10, y + 10, 6, DarkYellow);
    NoSound;
    Sound(70);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 7, DarkestYellow);
    NoSound;
    Sound(60);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 8, LightestRed);
    NoSound;
    Sound(50);
    Lib.Delay(SoundDelay);
    Disc(x + 10, y + 10, 9, LightRed);
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
    IF (BulletY > 0) AND (BulletY < 200) THEN
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
            StartBulletCooldown();
        ELSE
            BulletY := BulletY - 4;
            (* Draw bullet *)
            Rectangle(BulletX - 1, BulletY + 1, BulletX + 1, BulletY + 9, LightBlue, FALSE);
            Line(BulletX, BulletY, BulletX, BulletY + 10, LightWhite);
        END;
        OldBulletY := BulletY;
    END;
END UpBullet;

PROCEDURE PlayCaveIntro();
VAR
    RoofDots, FadeCount, FadeCountInc, RectY, NewRectY : CARDINAL;
    DotColour : BYTE;
BEGIN
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
        CheckSpecialKeys();
    END;
    IF (NOT GameOver) THEN
        DotColour := BYTE(LightGrey);
        FOR RoofDots := 1 TO 5000 DO
            PutPixel(70 + Lib.RANDOM(180), 50 + Lib.RANDOM(100), DotColour);
        END;
        CheckSpecialKeys();
    END;
    IF (NOT GameOver) THEN
        DotColour := BYTE(DarkGrey);
        FOR RoofDots := 1 TO 500 DO
            PutPixel(130 + Lib.RANDOM(60), 80 + Lib.RANDOM(40), DotColour);
        END;
        CheckSpecialKeys();
    END;
    IF (NOT GameOver) THEN
        DotColour := BYTE(DarkestGrey);
        FOR RoofDots := 1 TO 200 DO
            PutPixel(150 + Lib.RANDOM(20), 80 + Lib.RANDOM(40), DotColour);
        END;
        CheckSpecialKeys();
    END;

    (* Fly in plane *)
    IF (NOT GameOver) THEN
        Rectangle(158, 98, 162, 102, Black, TRUE);
        GetImage(0, 150, 320, 200, BkAddress);
        FOR PlaneY := 200 TO PlaneStartY BY -1 DO
            PlaneX := PlaneStartX - (PlaneY - PlaneStartY);
            DrawPlane(PlaneX, PlaneY, PlaneY - 125);
            Lib.Delay(50);
            Graph.PutImage(0, 150, BkAddress, Graph._GPSET);
        END;
        CheckSpecialKeys();
    END;
    PlaneY := PlaneStartY;

    (* Darken cave *)
    PlaneX := PlaneStartX;
    IF (NOT GameOver) THEN
        FadeCountInc := 1;
        RectY := 100;
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
                    DrawPlane5025();
                END;
            ELSE
                IF (RectY MOD 5 = 0) THEN
                    DrawPlane5025();
                END;
            END;
        END;
        CheckSpecialKeys();
    END;
END PlayCaveIntro;

PROCEDURE Screen2;
CONST
    GlowCount = 18;
    GlowWidth = 20;
    GlowHeight = 30;
VAR
    GlowSize, GlowIdx, GlowsAlive, MoveRnd, GX, GY : CARDINAL;
    GlowAddress : ADDRESS;
    GlowXs, GlowYs : ARRAY[0..GlowCount] OF CARDINAL;
    OldPlaneX : INTEGER;
BEGIN
    ScreenComplete := FALSE;
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    PlayCaveIntro();

    OldPlaneX := PlaneX; BulletX := 1000; OldBulletX := 1000; BulletY := 0; OldBulletY := 0;
    IF (NOT GameOver) THEN
        (* Draw enemies *)
        GlowSize := CARDINAL(Graph.ImageSize(0, 0, GlowWidth, GlowHeight));
        Storage.ALLOCATE(GlowAddress, GlowSize);
        GlowsAlive := GlowCount;
        FOR GY := 0 TO 2 DO
            FOR GX := 0 TO 5 DO
                GlowIdx := (GY * 6) + GX;
                GlowXs[GlowIdx] := 45 + (GX * 45);
                GlowYs[GlowIdx] := 8 + (GY * 35);
            END;
        END;
        DrawGlowWorms(GlowXs[0], GlowYs[0]);
        HudY := 0; HudBg := 0;
        DrawLives();
        UpdateScore(0);
        GetImage(GlowXs[0], GlowYs[0], GlowXs[0] + GlowWidth, GlowYs[0] + GlowHeight, GlowAddress);
        CheckMouseAndSpecialKeys();

        (* Main game loop *)
        WHILE NOT ScreenComplete AND NOT GameOver DO
            (* Update player *)
            OldPlaneX := PlaneX;
            CheckMouse();
            Rectangle(CARDINAL(OldPlaneX), PlaneY, CARDINAL(OldPlaneX) + PlaneWidth, PlaneY + PlaneHeight, Black, TRUE);
            DrawPlane(PlaneX, PlaneY, PlaneWidth);
            UpBullet();

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
                    IF (BulletY > 0) AND (BulletY < GY + 10) AND (BulletX > GX) AND (BulletX < GX + GlowWidth) THEN
                        UpdateScore(20);
                        BlowUpEnemy2(GX, GY);
                        StartBulletCooldown();
                        GY := 65000;
                        GlowsAlive := GlowsAlive - 1;
                    (* Hit player? *)
                    ELSIF (GY > PlaneY - 25) AND (GX > PlaneX - 15) AND (GX < PlaneX + PlaneWidth + 15) THEN
                        Disc(GX + (GlowWidth DIV 2), GY + (GlowHeight DIV 2), 10, DarkestRed);
                        OldPlaneX := PlaneX;
                        Die();
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
            Lib.Delay(GameSpeed DIV 2);
        END; (* Main game loop *)

        Storage.DEALLOCATE(GlowAddress, GlowSize);
    END;

    IF GameOver THEN
        DrawGameOver;
    END;
END Screen2;

END Screens2.
