IMPLEMENTATION MODULE Screens6;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Exobius;
FROM Graph IMPORT SetClipRgn, Rectangle, Line, HLine, Circle, Disc, Plot, Point, Ellipse;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Exobius IMPORT
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, PlaneY, PlaneStartX, PlaneStartY, PlaneWidth, BulletX, BulletY, Update3DBullet,
    Count, Lives, Enemy1X, EnemyY, Boss1Lives, HudY, HudBg,
    ScreenComplete, GameOver, FinishScreen, GameSpeed, Die, DrawGameOver, TextPos, DrawLives,
    DrawPlane, DrawPlane5025, CheckMouse, CheckMouseAndSpecialKeys;
FROM Sprites IMPORT RandomBrown;

CONST
    NumArches = 32;
    ArchWidth = 160;
    ArchWoodThickness = 20;
    ArchMaxDist = 300;
    ArchMinMoveSpeed = 1;
    BossLives = 50;
    BossY = 130;
    BossRadius = 5;

TYPE
    Arch = RECORD
        FinalLeft, FinalRight, Distance, ArchColor, FloorColor : CARDINAL;
    END;

PROCEDURE TransferArchData(VAR archSrc, archDest : Arch);
BEGIN
    archDest.FinalLeft := archSrc.FinalLeft;
    archDest.FinalRight := archSrc.FinalRight;
    archDest.Distance := archSrc.Distance;
    archDest.FloorColor := archSrc.FloorColor;
END TransferArchData;

PROCEDURE SetupNextArch(VAR prevArch, newArch : Arch);
BEGIN
    IF (prevArch.FinalLeft < 40) OR (prevArch.FinalRight < 200) THEN
        newArch.FinalLeft := prevArch.FinalLeft + 20;
    ELSIF (prevArch.FinalRight > 280) OR (prevArch.FinalLeft > 120) THEN
        newArch.FinalLeft := prevArch.FinalLeft - 20;
    ELSE
        newArch.FinalLeft := prevArch.FinalLeft + Lib.RANDOM(20) - 10;
    END;
    newArch.FinalRight := newArch.FinalLeft + ArchWidth;
    newArch.Distance := ArchMaxDist;
    newArch.FloorColor := RandomBrown();
END SetupNextArch;

PROCEDURE CheckPlayerCollision(arch : Arch);
BEGIN
    IF (PlaneX < arch.FinalLeft + 10) OR (PlaneX + PlaneWidth > arch.FinalRight - 10) THEN
        Die();
        PlaneX := ((arch.FinalLeft + arch.FinalRight) DIV 2) - (PlaneWidth DIV 2);
    END;
END CheckPlayerCollision;

PROCEDURE UpdateAndDrawArch(VAR arch : Arch; IsClosestArch : BOOLEAN);
VAR
    Left, Right, DistMult, Top, Bottom, Thickness, MoveDistance : CARDINAL;
BEGIN
    (* Base movement *)
    MoveDistance := ArchMinMoveSpeed;
    IF (arch.Distance < ArchMaxDist) THEN
        MoveDistance := MoveDistance + (ArchMaxDist - arch.Distance) DIV 7;
    END;
    IF (MoveDistance < arch.Distance) THEN
        arch.Distance := arch.Distance - MoveDistance;
    ELSE
        arch.Distance := 1;
    END;

    (* Too far away to draw? *)
    IF (arch.Distance >= ArchMaxDist) THEN RETURN; END;

    (* Calculate screen perspective for edges + beam thickness *)
    DistMult := ArchMaxDist - arch.Distance;
    Left := 160 - ((160 - arch.FinalLeft) * DistMult DIV ArchMaxDist);
    Right := 160 + ((arch.FinalRight - 160) * DistMult DIV ArchMaxDist);
    Top := 100 - (45 * DistMult DIV ArchMaxDist);
    IF (Top > 98) THEN Top := 98; END;
    Bottom := 100 + (100 - Top) * 2;
    Thickness := ArchWoodThickness * DistMult DIV ArchMaxDist;

    (* Ensure frontmost arch draws right to the bottom of the screen *)
        IF (IsClosestArch) THEN
        IF (Bottom > 180) THEN
            Bottom := 199;
        ELSE
            Rectangle(0, PlaneY, 319, 199, Black, TRUE);
        END;
    END;

    (* Draw arch *)
    Rectangle(Left - Thickness, Top - Thickness, Right + Thickness, Top, arch.ArchColor, TRUE);
    Rectangle(Left - Thickness, Top, Left, Bottom, arch.ArchColor, TRUE);
    Rectangle(Right, Top, Right + Thickness, Bottom, arch.ArchColor, TRUE);
    Rectangle(Left, Bottom - Thickness, Right, Bottom, arch.FloorColor, TRUE);
    SetClipRgn(Left, Top, Right, Bottom);
END UpdateAndDrawArch;

PROCEDURE DrawBoss();
BEGIN
    Disc(Enemy1X, BossY, BossRadius, DarkGreen);
    Disc(Enemy1X + 1, BossY - 1, 3, LightGreen);
END DrawBoss;

PROCEDURE DrawBossHealthBar();
VAR
    BarEndX : CARDINAL;
BEGIN
    Rectangle(0, 0, 319, 10, White, FALSE);
    BarEndX := 318 * Boss1Lives DIV BossLives;
    Rectangle(1, 1, BarEndX, 9, Red, TRUE);
    Rectangle(BarEndX, 1, 318, 9, Black, TRUE);
END DrawBossHealthBar;

PROCEDURE BlowUpBoss();
VAR
    Explosions, Colour : CARDINAL;
BEGIN
    Rectangle(0, 0, 319, 10, Black, TRUE);
    TextPos := Graph.SetTextPosition(1, 15);
    Graph.OutText("Extra Life!");
    Lives := Lives + 1;
    DrawLives();
    
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
        Ellipse(Enemy1X + Lib.RANDOM(BossRadius * 2) - BossRadius, BossY + Lib.RANDOM(BossRadius * 2) - BossRadius, Lib.RANDOM(4), Lib.RANDOM(4), Colour, TRUE);
        Delay(GameSpeed);
        NoSound;
    END;
    Rectangle(0, 0, 319, 20, Black, TRUE);
    DrawLives();
END BlowUpBoss;

PROCEDURE CheckBulletAgainstBoss();
CONST
    BossFlashDelay = 4;
BEGIN
    IF (BulletY > 0) AND (BulletY < 3) AND (BulletX > Enemy1X - 10) AND (BulletX < Enemy1X + 10) THEN
        Boss1Lives := Boss1Lives - 1;
        DrawBossHealthBar();
        IF (Boss1Lives = 0) THEN
            ScreenComplete := TRUE;
            BlowUpBoss();
        ELSE
            Disc(Enemy1X, BossY, BossRadius, LightestWhite);
            Sound(440); Delay(BossFlashDelay); NoSound;
            Sound(220); Delay(BossFlashDelay); NoSound;
            Sound(50); Delay(BossFlashDelay); NoSound;
        END;
        BulletY := 0;
    END;    
END CheckBulletAgainstBoss;

PROCEDURE Screen6;
VAR
    Arches : ARRAY[0..NumArches-1] OF Arch;
    ArchIdx : CARDINAL;
BEGIN
    FOR ArchIdx := 0 TO NumArches - 1 DO
        WITH Arches[ArchIdx] DO
            FinalLeft := 20 + (80 * ArchIdx DIV NumArches);
            FinalRight := 319 - FinalLeft;
            Distance := ArchMaxDist + (ArchIdx * ArchMinMoveSpeed);
            ArchColor := 31 - (ArchIdx DIV 2);
            FloorColor := RandomBrown();
        END;
    END;

    ScreenComplete := FALSE;
    PlaneX := PlaneStartX; PlaneY := PlaneStartY;
    CheckMouseAndSpecialKeys();
    Boss1Lives := BossLives;
    Enemy1X := 160;
    EnemyY := 0; (* Don't try automatically checking bullet against enemies *)
    HudY := 0; HudBg := 0;
    DrawBossHealthBar();
    WHILE NOT ScreenComplete AND NOT GameOver DO
        (* Closest arch passed? *)
        IF (Arches[0].Distance < 15) THEN
            FOR ArchIdx := 1 TO NumArches - 1 DO
                TransferArchData(Arches[ArchIdx], Arches[ArchIdx - 1]);
            END;
            SetupNextArch(Arches[NumArches - 2], Arches[NumArches - 1]);
        END;

        (* Update & draw all arches, resetting clip region before + after *)
        SetClipRgn(0, 0, 319, 199);
        FOR ArchIdx := 0 TO NumArches - 1 DO
            UpdateAndDrawArch(Arches[ArchIdx], ArchIdx = 0);
        END;
        SetClipRgn(0, 0, 319, 199);

        (* Update plane *)
        CheckMouse();
        DrawPlane5025();

        (* Update boss *)
        Enemy1X := (Arches[5].FinalLeft + Arches[5].FinalRight) DIV 2;
        DrawBoss();

        (* Bullet + collision checks *)
        Update3DBullet(FALSE);
        CheckBulletAgainstBoss();
        CheckPlayerCollision(Arches[0]);

        Delay(GameSpeed * 3);
    END;
    SetClipRgn(0, 0, 319, 199);

    IF GameOver THEN
        DrawGameOver;
    ELSE
        FOR ArchIdx := 0 TO NumArches - 1 DO
            UpdateAndDrawArch(Arches[ArchIdx], ArchIdx = 0);
        END;
        SetClipRgn(0, 0, 319, 199);
        FinishScreen();
    END;

END Screen6;

END Screens6.
