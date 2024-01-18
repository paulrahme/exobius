IMPLEMENTATION MODULE Bosses7;
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
    PlaneX, PlaneY, PlaneWidth, PlaneHeight, BulletX, BulletY, Lives,
    GameOver, GameSpeed,
    Update3DBullet, Clear3DBullet, StartBulletCooldown, DrawPlane5025, CheckMouse, Die,
    FinishScreen, Score,
    DrawGameOver, TextPos;

CONST
    BossHoleY = 130; BossHoleWidth = 52; BossHoleHeight = 26; BossHoleHalfHeight = 13;
    BossMouthY = 110; BossHalfWidth = 12; BossHeight = 30;
    BossSpitColliderRadius = 40;

VAR
    BossState, StateProgress, BossX, SpitX, SpitY : CARDINAL;
    SpitXOffset : INTEGER;

PROCEDURE KillBoss;
VAR
    Explosions, Colour : CARDINAL;
BEGIN
    TextPos := Graph.SetTextPosition(1, 15);
    Graph.OutText("Extra Life!");
    IF (Lives > 0) THEN
        Lives := Lives + 1;
    END;
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
END KillBoss;

PROCEDURE DrawBossHead(OffsetY : CARDINAL; Spitting : BOOLEAN);
VAR
    BossY : CARDINAL;
BEGIN
    IF NOT (Spitting) THEN
        Rectangle(BossX - BossHalfWidth, BossHoleY - 50, BossX + BossHalfWidth, 99, Black, TRUE);
        Rectangle(BossX - BossHalfWidth, 100, BossX + BossHalfWidth, BossHoleY + BossHoleWidth DIV 2, DarkBrown, TRUE);
        Ellipse(BossX, BossHoleY, BossHoleHeight, BossHoleHalfHeight, Black, TRUE);
    END;

    IF (OffsetY > 0) THEN
        BossY := BossHoleY - OffsetY;
        Rectangle(BossX - 3, BossY, BossX + 3, BossHoleY, DarkBlue, TRUE);
        Line(BossX - 3, BossY, BossX - 3, BossHoleY, DarkestBlue);
        Line(BossX + 3, BossY, BossX + 3, BossHoleY, LightBlue);
        Disc(BossX, BossY, BossHalfWidth, Blue);
        Disc(BossX + 3, BossY - 3, BossHalfWidth - 3, LightBlue);
        
        IF (Spitting) THEN
            Ellipse(BossX, BossY, 9, 3, DarkRed, TRUE);
        END;
    END;
END DrawBossHead;

PROCEDURE UpdateAndDrawBoss() : BOOLEAN;
BEGIN
    CASE (BossState) OF
     |0: (* Idle, between appearances *)
        RETURN TRUE;

     |1: (* Hole opening *)
        StateProgress := StateProgress + 2;
        Ellipse(BossX, BossHoleY, StateProgress DIV 2, StateProgress DIV 4, Black, TRUE);
        RETURN (StateProgress >= BossHoleWidth);

     |2: (* Rising out of hole *)
        StateProgress := StateProgress + 5;
        DrawBossHead(StateProgress, FALSE);
        IF (StateProgress >= BossHeight) THEN
            StateProgress := BossHeight;
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END;

     |3: (* Spitting *)
        IF (StateProgress = 0) THEN
            SpitXOffset := INTEGER(RANDOM(240)) - 120;
            SpitY := BossMouthY;
        END;
        DrawBossHead(BossHeight, TRUE);
        StateProgress := StateProgress + 1;
        RETURN (StateProgress >= 10);

     |4: (* Lowering back into hole *)
        StateProgress := StateProgress + 3;
        DrawBossHead(BossHeight - StateProgress, FALSE);
        RETURN (StateProgress >= BossHeight);

     |5: (* Light hole closing *)
        StateProgress := StateProgress + 4;
        Ellipse(BossX, BossHoleY, StateProgress DIV 2, StateProgress DIV 4, LightBrown, TRUE);
        RETURN (StateProgress >= BossHoleWidth);

     |6: (* Darker hole closing *)
        StateProgress := StateProgress + 4;
        Ellipse(BossX, BossHoleY, StateProgress DIV 2, StateProgress DIV 4, DarkBrown, TRUE);
        RETURN (StateProgress >= BossHoleWidth + 1);

    END;
END UpdateAndDrawBoss;

PROCEDURE Boss7;
VAR
    BossLives, SpitYDiffWidth, SpitYDiffHeight : CARDINAL;
BEGIN
    BossLives := 16; BossState := 0; StateProgress := 0;
    BossX := 160; SpitX := 160; SpitYDiffWidth := 1; SpitYDiffHeight := 1;
    Rectangle(0, 100, 319, 199, DarkBrown, TRUE);

    (* Boss's health bar *)
    Rectangle(0, 0, 319, 10, White, FALSE);
    Rectangle(1, 1, 318, 9, Red, TRUE);

    WHILE NOT GameOver AND (BossLives > 0) DO
        (* Update plane *)
        Rectangle(PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkBrown, TRUE);
        CheckMouse();
        DrawPlane5025();

        (* Update boss *)
        IF (UpdateAndDrawBoss()) THEN
            IF (BossState >= 6) THEN
                BossState := 0;
            ELSE
                BossState := BossState + 1;
            END;
            StateProgress := 0;
        END;

        (* Update player's shot *)
        IF (BulletY > 0) THEN
            Clear3DBullet(DarkBrown);
            Update3DBullet(FALSE);
            IF (BossState = 3) AND (BulletY = 1) AND (BulletX > BossX - BossHalfWidth) AND (BulletX < BossX + BossHalfWidth) THEN
                Disc(BossX, BossHoleY - BossHeight, BossHalfWidth, LightestWhite);
                BossLives := BossLives - 1;
                Rectangle(1 + (BossLives * 20), 1, 318, 9, Black, TRUE);
                StartBulletCooldown();
                Sound(30); Delay(5); NoSound();
                Score := Score + 150;
                IF (BossLives = 0) THEN
                    KillBoss();
                END;
            END;
        END;

        (* Update boss's shot *)
        IF (SpitY > 0) THEN
            IF (SpitY > BossHoleY + BossHoleHalfHeight) THEN
                Rectangle(SpitX - SpitYDiffWidth - 2, SpitY - SpitYDiffHeight - 2, SpitX + SpitYDiffWidth + 2, SpitY + SpitYDiffHeight + 2, DarkBrown, TRUE);
            END;
            SpitY := SpitY + 1 + (SpitY - BossMouthY) DIV 9;
            SpitYDiffWidth := (SpitY - BossMouthY) DIV 5;
            SpitYDiffHeight := SpitYDiffWidth DIV 2;
            SpitX := CARDINAL(160 + (SpitXOffset * INTEGER(SpitYDiffWidth) DIV 50));
            Ellipse(SpitX, SpitY, SpitYDiffWidth, SpitYDiffHeight, Blue, TRUE);
            Ellipse(SpitX, SpitY, SpitYDiffWidth + 1, SpitYDiffHeight + 1, LightestBlue, FALSE);
            IF (SpitY > 200) THEN
                Rectangle(SpitX - SpitYDiffWidth - 2, SpitY - SpitYDiffHeight - 2, SpitX + SpitYDiffWidth + 2, SpitY + SpitYDiffHeight + 2, DarkBrown, TRUE);
                SpitY := 0;
            ELSIF (SpitY > PlaneY) AND (PlaneX > SpitX - BossSpitColliderRadius) AND (PlaneX < SpitX + BossSpitColliderRadius) THEN
                Die(0);
                Rectangle(0, PlaneY - 20, 319, 199, DarkBrown, TRUE);
                SpitY := 0;
            END;
        END;

        Delay(GameSpeed);
    END;

    IF NOT GameOver THEN
        Rectangle(PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkBrown, TRUE);
        FinishScreen();
    ELSE
        DrawGameOver();
    END;
END Boss7;

END Bosses7.
