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
    PlaneX, PlaneY, BulletX, BulletY, Update3DBullet,
    Count, Lives, Enemy1X, EnemyY, Boss1Lives,
    ScreenComplete, GameOver, GameSpeed, Die, DrawGameOver,
    DrawPlane, DrawPlane5025, CheckMouse, CheckMouseAndSpecialKeys;

CONST
    NumArches = 8;
    ArchWidth = 120;
    ArchWoodThickness = 20;
    ArchMaxDist = 200;
    BossLives = 20;
    BossY = 110;
    BossRadius = 5;

TYPE
    Arch = RECORD
        FinalLeft, FinalRight, Distance : CARDINAL;
    END;

PROCEDURE TransferArchData(archSrc, archDest : Arch);
BEGIN
    archDest.FinalLeft := archSrc.FinalLeft;
    archDest.FinalRight := archSrc.FinalRight;
    archDest.Distance := archSrc.Distance;
END TransferArchData;

PROCEDURE SetupNextArch(newArch, prevArch : Arch);
BEGIN
    IF (prevArch.FinalLeft < 20) THEN
        newArch.FinalLeft := prevArch.FinalLeft + 20;
    ELSIF (prevArch.FinalRight > 299) THEN
        newArch.FinalLeft := prevArch.FinalLeft - 20;
    ELSE
        newArch.FinalLeft := prevArch.FinalLeft + Lib.RANDOM(40) - 20;
    END;
    newArch.FinalRight := newArch.FinalLeft + ArchWidth;
    newArch.Distance := ArchMaxDist;
END SetupNextArch;

PROCEDURE UpdateArch(arch : Arch);
BEGIN
    arch.Distance := (arch.Distance * 9) DIV 10;
END UpdateArch;

PROCEDURE DrawArch(arch : Arch);
VAR
    Left, Right : INTEGER;
    DistMult, Top, Bottom, Thickness : CARDINAL;
BEGIN
    (* Too far away to draw? *)
    IF (arch.Distance > ArchMaxDist) THEN RETURN; END;

    (* Calculate screen perspective for edges + beam thickness *)
    DistMult := ArchMaxDist - arch.Distance;
    Left := 160 + ((arch.FinalLeft - 160) * DistMult DIV ArchMaxDist);
    Right := 160 + ((arch.FinalRight - 160) * DistMult DIV ArchMaxDist);
    Top := 100 - (100 * DistMult DIV ArchMaxDist);
    IF (Top > 98) THEN Top := 98; END;
    Bottom := 199 - Top;
    Thickness := ArchWoodThickness * DistMult DIV ArchMaxDist;

    (* Draw arch *)
    Rectangle(CARDINAL(Left) - Thickness, Top - Thickness, CARDINAL(Right) + Thickness, Top, Brown, TRUE);
    Rectangle(CARDINAL(Left) - Thickness, Top, CARDINAL(Left), Bottom, Brown, TRUE);
    Rectangle(CARDINAL(Right), Top, CARDINAL(Right) + Thickness, Bottom, Brown, TRUE);
    SetClipRgn(CARDINAL(Left), Top, CARDINAL(Right), Bottom);
END DrawArch;

PROCEDURE DrawBoss();
BEGIN
END DrawBoss;

PROCEDURE CheckBulletAgainstBoss();
CONST
    BossFlashDelay = 4;
BEGIN
    IF (BulletY < 3) AND (BulletX > Enemy1X - 5) AND (BulletX < Enemy1X + 5) THEN
        Boss1Lives := Boss1Lives - 1;
        Disc(Enemy1X, BossY, BossRadius, LightestWhite);
        Sound(440); Delay(BossFlashDelay); NoSound;
        Sound(220); Delay(BossFlashDelay); NoSound;
        Sound(50); Delay(BossFlashDelay); NoSound;
    END;
END CheckBulletAgainstBoss;

PROCEDURE Screen6;
VAR
    Arches : ARRAY[0..NumArches-1] OF Arch;
    CurrArch : Arch;
    ArchIdx : CARDINAL;
BEGIN
    FOR ArchIdx := 0 TO NumArches - 1 DO
        CurrArch := Arches[ArchIdx];
        CurrArch.FinalLeft := 100 * (ArchIdx DIV NumArches);
        CurrArch.FinalRight := 319 - CurrArch.FinalLeft;
        CurrArch.Distance := ArchMaxDist + (ArchMaxDist * ArchIdx DIV NumArches);
    END;

    Boss1Lives := BossLives;
    Enemy1X := 160;
    EnemyY := 0; (* Don't try automatically checking bullet against enemies *)
    WHILE (Boss1Lives > 0) DO
        Graph.ClearScreen(Graph._GCLEARSCREEN);
        SetClipRgn(0, 0, 319, 199);
        CheckMouse();
        DrawPlane5025();

        (* Closest arch passed? *)
        IF (Arches[0].Distance < 10) THEN
            FOR ArchIdx := 0 TO NumArches - 2 DO
                TransferArchData(Arches[ArchIdx], Arches[ArchIdx + 1]);
            END;
            SetupNextArch(Arches[NumArches - 1], Arches[NumArches - 2]);
        END;

        (* Update & draw all arches - note this leaves the clip region inside the last one *)
        FOR ArchIdx := 0 TO NumArches - 1 DO
            CurrArch := Arches[ArchIdx];
            UpdateArch(CurrArch);
            DrawArch(CurrArch);
        END;

        DrawBoss();
        Update3DBullet();
        CheckBulletAgainstBoss();
    END;

    IF GameOver THEN
        DrawGameOver;
    END;

END Screen6;

END Screens6.
