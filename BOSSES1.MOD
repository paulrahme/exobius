IMPLEMENTATION MODULE Bosses1;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Str, Lib;
FROM Graph IMPORT Point, Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Sprites IMPORT DrawSpinners;
FROM Exobius IMPORT
    PlaneXMin,
    Black,
    DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, BulletX, BulletY, Lives, HudY, HudBg,
    Xs, Ys,
    ScreenComplete, GameOver, GameSpeed,
    Update3DBullet, StartBulletCooldown, DrawPlane, DrawPlane5025, DrawLives, CheckMouse, Die,
    FinishScreen, Key, Score, BkAddress, DrawGameOver, TextPos;

PROCEDURE DrawBoss1(y : CARDINAL);
BEGIN
    Disc(160, y - 40, 40, DarkestRed);
    Disc(162, y - 42, 36, DarkRed);
    Disc(164, y - 44, 32, Red);
    Disc(166, y - 46, 28, LightRed);
    Disc(168, y - 48, 24, LightestRed);
    Disc(170, y - 50, 20, DarkestYellow);
    Disc(172, y - 52, 16, DarkYellow);
    Disc(174, y - 54, 12, Yellow);
    Disc(176, y - 56, 8, LightYellow);
    Disc(178, y - 58, 4, LightestYellow);
    Plot(179, y - 59, LightestWhite);

    IF (y > 100) THEN
        Disc(160, y - 90, 10, DarkestGreen);
        Disc(161, y - 91, 8, DarkGreen);
        Disc(162, y - 92, 6, Green);
        Disc(163, y - 93, 4, LightGreen);
        Disc(164, y - 94, 2, LightestGreen);
        Plot(165, y - 95, LightestWhite);

        Disc(156, y - 94, 2, DarkestRed);
        Disc(164, y - 94, 2, DarkestRed);
        Line(156, y - 98, 160, y - 95, DarkestGrey);
        Line(165, y - 98, 161, y - 95, DarkestGrey);
    END;
END DrawBoss1;

PROCEDURE KillBoss1;
VAR
    Explosions, Colour : CARDINAL;
BEGIN
    TextPos := Graph.SetTextPosition(1, 15);
    Graph.OutText("Extra Life!");
    ScreenComplete := TRUE;
    Lives := Lives + 1;
    FOR Explosions := 1 TO 200 DO
        Sound(Lib.RANDOM(15) + 20);
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
        Ellipse(120 + Lib.RANDOM(80), 60 + Lib.RANDOM(80), Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
        Plot(120 + Lib.RANDOM(80), 60 + Lib.RANDOM(80), Colour);
        Delay(GameSpeed DIV 4);
        NoSound();
    END;
    Rectangle(0, 0, 319, 10, 176, TRUE);
    DrawLives();
END KillBoss1;

PROCEDURE Boss1;
CONST
    GravityAccel = 0.2; TerminalVelocity = 3.0;
    BossFinalY = 150.0;
    BkFallingLeft = 120; BkFallingTop = 0; BkFallingRight = 200; BkFallingBottom = 199;
    BkSpittingLeft = 100; BkSpittingTop = 60; BkSpittingRight = 220; BkSpittingBottom = 170;
    SpitX = 160;
    SpitMovement = 2;
    SpitHitY = 170;
    MouthY = 65;
VAR
    BounceY, BounceVelocity : REAL;
    BounceYCard, Bounces, SpitCount, SpitY, BossLives, GroundLineX : CARDINAL;
BEGIN
    ScreenComplete := FALSE;
    Bounces := 0;
    BounceY := 61.0; BounceYCard := CARDINAL(BounceY);
    BounceVelocity := TerminalVelocity;

    Xs[0] := 0;     Xs[1] := 75;   Xs[2] := 244;   Xs[3] := 319;
    Ys[0] := 199;   Ys[1] := 151;   Ys[2] := 151;   Ys[3] := 199;
    Polygon(4, Xs, Ys, LightBrown);
    Graph.GetImage(BkFallingLeft, BkFallingTop, BkFallingRight, BkFallingBottom, BkAddress);

    WHILE (Bounces < 3) DO
        IF (BounceVelocity < TerminalVelocity) THEN BounceVelocity := BounceVelocity + GravityAccel; END;
        BounceY := BounceY + BounceVelocity; BounceYCard := CARDINAL(BounceY);
        Graph.PutImage(BkFallingLeft, BkFallingTop, BkAddress, Graph._GPSET);
        IF (BounceY > BossFinalY - 0.1) THEN
            BounceY := BossFinalY;
            BounceVelocity := -BounceVelocity;
            Bounces := Bounces + 1;
        END;
        BounceYCard := CARDINAL(BounceY);
        DrawBoss1(BounceYCard);
        TextPos := Graph.SetTextPosition(23, 17);
        Graph.OutText("DANGER!");

        CheckMouse();
        Lib.Delay(GameSpeed);
    END;

    (* The Action Begins !! *)

    PlaneX := PlaneXMin;
    Graph.PutImage(BkFallingLeft, BkFallingTop, BkAddress, Graph._GPSET);

    (* Draw boss with open Mouth & add hole in stomach *)
    DrawBoss1(BounceYCard);
    Disc(160, MouthY, 5, Black);
    HLine(155, BounceYCard - 50, 165, Black);
    Disc(160, BounceYCard - 50, 3, Black);
    (* Boss's health bar *)
    Rectangle(0, 0, 319, 10, White, FALSE);
    Rectangle(1, 1, 318, 9, Red, TRUE);
    Graph.GetImage(BkSpittingLeft, BkSpittingTop, BkSpittingRight, BkSpittingBottom, BkAddress);

    CheckMouse();
    DrawPlane5025();
    Update3DBullet(FALSE);
    BossLives := 8;
    WHILE NOT GameOver AND NOT ScreenComplete DO
        SpitY := MouthY;
        WHILE (SpitY < 200) AND NOT (ScreenComplete) AND NOT (GameOver) DO
            Polygon(4, Xs, Ys, LightBrown);
            Graph.PutImage(BkSpittingLeft, BkSpittingTop, BkAddress, Graph._GPSET);
            Ellipse(SpitX, SpitY, (SpitY - MouthY) * 2 DIV 3, (SpitY - MouthY) DIV 4, Blue, TRUE);
            Ellipse(SpitX, SpitY, (SpitY + 1 - MouthY) * 2 DIV 3, (SpitY + 2 - MouthY) DIV 4, LightestBlue, FALSE);
            IF (SpitY > SpitHitY) AND (PlaneX > 50) AND (PlaneX < 219) THEN
                Die();
            END;
            CheckMouse();
            DrawPlane5025();
            Update3DBullet(FALSE);
            IF (BulletY = 1) AND (BulletX > 130) AND (BulletX < 179) THEN
                Disc(160, 110, 40, LightestWhite);
                BossLives := BossLives - 1;
                Rectangle(1 + (BossLives * 40), 1, 318, 9, Black, TRUE);
                StartBulletCooldown();
                Delay(5);
                Score := Score + 150;
                IF (BossLives = 0) THEN
                    KillBoss1();
                END;
            END;
            Delay(GameSpeed);
            SpitY := SpitY + 1 + (SpitY - MouthY) DIV 12;
        END;
    END;
    IF ScreenComplete THEN
        Polygon(4, Xs, Ys, LightBrown);
        FinishScreen();
    ELSE
        DrawGameOver();
    END;
END Boss1;

END Bosses1.
