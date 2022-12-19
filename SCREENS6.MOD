IMPLEMENTATION MODULE Screens6;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Lib, Exobius;
FROM Graph IMPORT SetClipRgn, Rectangle, Line, HLine, Circle, Disc, Plot, Point;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Exobius IMPORT
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    PlaneX, PlaneY, PlaneWidth, BulletX, BulletY, Update3DBullet,
    Count, Lives, Enemy1X, EnemyY, Boss1Lives,
    ScreenComplete, GameOver, GameSpeed, Die, DrawGameOver,
    DrawPlane, DrawPlane5025, CheckMouse, CheckMouseAndSpecialKeys;

CONST
    NumArches = 32;
    ArchWidth = 140;
    ArchWoodThickness = 20;
    ArchMaxDist = 300;
    ArchMinMoveSpeed = 1;
    BossLives = 20;
    BossY = 130;
    BossRadius = 5;

TYPE
    Arch = RECORD
        FinalLeft, FinalRight, Distance, Color : CARDINAL;
    END;

PROCEDURE TransferArchData(VAR archSrc, archDest : Arch);
BEGIN
    archDest.FinalLeft := archSrc.FinalLeft;
    archDest.FinalRight := archSrc.FinalRight;
    archDest.Distance := archSrc.Distance;
END TransferArchData;

PROCEDURE SetupNextArch(VAR prevArch, newArch : Arch);
BEGIN
    IF (prevArch.FinalLeft < ArchWoodThickness + 2) OR (prevArch.FinalRight < 159 + ArchWoodThickness + 2) THEN
        newArch.FinalLeft := prevArch.FinalLeft + 20;
    ELSIF (prevArch.FinalRight > 319 - ArchWoodThickness - 2) OR (prevArch.FinalLeft > 159 - ArchWoodThickness - 2) THEN
        newArch.FinalLeft := prevArch.FinalLeft - 20;
    ELSE
        newArch.FinalLeft := prevArch.FinalLeft + Lib.RANDOM(40) - 20;
    END;
    newArch.FinalRight := newArch.FinalLeft + ArchWidth;
    newArch.Distance := ArchMaxDist;
END SetupNextArch;

PROCEDURE CheckPlayerCollision(arch : Arch);
BEGIN
    IF (PlaneX < arch.FinalLeft) OR (PlaneX + PlaneWidth > arch.FinalRight) THEN
        Die();
        PlaneX := ((arch.FinalLeft + arch.FinalRight) DIV 2) - (PlaneWidth DIV 2);
    END;
END CheckPlayerCollision;

PROCEDURE UpdateAndDrawArch(VAR arch : Arch);
VAR
    Left, Right, DistMult, Top, Bottom, Thickness, MoveDistance : CARDINAL;
BEGIN
    (* Base movement *)
    MoveDistance := ArchMinMoveSpeed;
    IF (arch.Distance < ArchMaxDist) THEN
        MoveDistance := MoveDistance + (ArchMaxDist - arch.Distance) * 1 DIV 7;
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

    (* Draw arch *)
    Rectangle(Left - Thickness, Top - Thickness, Right + Thickness, Top, arch.Color, TRUE);
    Rectangle(Left - Thickness, Top, Left, Bottom, arch.Color, TRUE);
    Rectangle(Right, Top, Right + Thickness, Bottom, arch.Color, TRUE);
    SetClipRgn(Left, Top, Right, Bottom);
END UpdateAndDrawArch;

PROCEDURE DrawBoss();
BEGIN
    Disc(Enemy1X, BossY, BossRadius, DarkGreen);
    Disc(Enemy1X + 2, BossY - 2, 3, LightGreen);
END DrawBoss;

PROCEDURE DrawBossHealthBar();
BEGIN
    Rectangle(0, 0, 319, 10, White, FALSE);
    Rectangle(1, 1, 318 * Boss1Lives DIV BossLives, 9, Red, TRUE);
END DrawBossHealthBar;

PROCEDURE CheckBulletAgainstBoss();
CONST
    BossFlashDelay = 4;
BEGIN
    IF (BulletY > 0) AND (BulletY < 3) AND (BulletX > Enemy1X - 10) AND (BulletX < Enemy1X + 10) THEN
        Boss1Lives := Boss1Lives - 1;
        Disc(Enemy1X, BossY, BossRadius, LightestWhite);
        Sound(440); Delay(BossFlashDelay); NoSound;
        Sound(220); Delay(BossFlashDelay); NoSound;
        Sound(50); Delay(BossFlashDelay); NoSound;
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
            Color := 31 - (ArchIdx DIV 2);
        END;
    END;

    Boss1Lives := BossLives;
    Enemy1X := 160;
    EnemyY := 0; (* Don't try automatically checking bullet against enemies *)
    WHILE (Boss1Lives > 0) AND NOT GameOver DO
        SetClipRgn(0, 0, 319, 199);
        CheckMouse();
        Graph.ClearScreen(Graph._GCLEARSCREEN);
        DrawPlane5025();
        DrawBossHealthBar();

        (* Closest arch passed? *)
        IF (Arches[0].Distance < 15) THEN
            FOR ArchIdx := 1 TO NumArches - 1 DO
                TransferArchData(Arches[ArchIdx], Arches[ArchIdx - 1]);
            END;
            SetupNextArch(Arches[NumArches - 2], Arches[NumArches - 1]);
        END;

        (* Update & draw all arches - note this leaves the clip region inside the last one *)
        FOR ArchIdx := 0 TO NumArches - 1 DO
            UpdateAndDrawArch(Arches[ArchIdx]);
        END;
        
        (* Update boss *)
        SetClipRgn(0, 0, 319, 199);
        Enemy1X := (Arches[5].FinalLeft + Arches[5].FinalRight) DIV 2;
        DrawBoss();

        (* Bullet + collision checks *)
        Update3DBullet();
        CheckBulletAgainstBoss();
        CheckPlayerCollision(Arches[0]);

        Delay(GameSpeed * 3);
    END;
    SetClipRgn(0, 0, 319, 199);

    IF GameOver THEN
        DrawGameOver;
    END;

END Screen6;

END Screens6.
