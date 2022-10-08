IMPLEMENTATION MODULE Intro1;

IMPORT Graph, IO, Lib, Exobius, Storage;

FROM Graph IMPORT
    ClearScreen, _GCLEARSCREEN,
    Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;

FROM IO IMPORT KeyPressed;

FROM Lib IMPORT
    Delay;

FROM Exobius IMPORT
    PutPixel,
    Black,
    DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    DrawPlane, PlaneX, PlaneY,
    Count, GameSpeed,
    A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;

CONST
    NoteDelay = 125;

PROCEDURE DrawInfiniteSoftwarePair(XPos : CARDINAL);
BEGIN
    CASE XPos OF
        |40:  I(XPos, 40); S(XPos, 120);
        |70:  N(XPos, 40); O(XPos, 120);
        |100: F(XPos, 40); F(XPos, 120);
        |130: I(XPos, 40); T(XPos, 120);
        |160: N(XPos, 40); W(XPos, 120);
        |190: I(XPos, 40); A(XPos, 120);
        |220: T(XPos, 40); R(XPos, 120);
        |250: E(XPos, 40); E(XPos, 120);
    END;
END DrawInfiniteSoftwarePair;

PROCEDURE DrawInfiniteSoftwareAll;
BEGIN
    DrawInfiniteSoftwarePair(40);
    DrawInfiniteSoftwarePair(70);
    DrawInfiniteSoftwarePair(100);
    DrawInfiniteSoftwarePair(130);
    DrawInfiniteSoftwarePair(160);
    DrawInfiniteSoftwarePair(190);
    DrawInfiniteSoftwarePair(220);
    DrawInfiniteSoftwarePair(250);
END DrawInfiniteSoftwareAll;

PROCEDURE InfiniteSoftware() : BOOLEAN;
VAR
    LetterXs, RectYs : ARRAY[0..7] OF CARDINAL;
BEGIN
    (* Draw letters in pairs on each beat *)
    LetterXs[0] := 40; LetterXs[1] := 250; LetterXs[2] := 70; LetterXs[3] := 220;
    LetterXs[4] := 100; LetterXs[5] := 190; LetterXs[6] := 130; LetterXs[7] := 160;
    FOR Count := 0 TO 7 DO
        DrawInfiniteSoftwarePair(LetterXs[Count]);
        Delay(NoteDelay);
        IF (KeyPressed()) THEN RETURN FALSE; END;
    END;

    (* Fill in bg segments on each beat *)
    RectYs[0] := 175; RectYs[1] := 0; RectYs[2] := 150; RectYs[3] := 25;
    RectYs[4] := 125; RectYs[5] := 50; RectYs[6] := 100; RectYs[7] := 75;
    FOR Count := 0 TO 7 DO
        Rectangle(0, RectYs[Count], 320, RectYs[Count] + 25, Grey, TRUE);
        IF (Count > 0) THEN
            Rectangle(0, RectYs[Count-1], 320, RectYs[Count-1] + 25, LightWhite, TRUE);
        END;
        DrawInfiniteSoftwareAll();
        Lib.Delay(NoteDelay);
        IF (KeyPressed()) THEN RETURN FALSE; END;
    END;

    Rectangle(0, 0, 319, 199, LightestWhite, TRUE);
    RETURN TRUE;
END InfiniteSoftware;

PROCEDURE SpinRectangle() : BOOLEAN;
CONST
    SpinningDelay = 3;
VAR
    Width, HalfHeight, ScaledHalfHeight, PrevScaledHalfHeight, Left, Right, Top, Bottom : CARDINAL;
    Growing : BOOLEAN;
BEGIN
    HalfHeight := 100; Top := 0; Bottom := 200; Growing := FALSE;
    ScaledHalfHeight := HalfHeight;
    FOR Width := 320 TO 2 BY -1 DO
        Left := (320 - Width) DIV 2; Right := (320 + Width) DIV 2;
        Line(Left - 1, Top, Left - 1, Bottom, Black);
        Line(Left, Top, Left, Bottom, Black);
        Line(Right, Top, Right, Bottom, Black);
        Line(Right + 1, Top, Right + 1, Bottom, Black);
        
        (* Alternate growing/shrinking the height *)
        PrevScaledHalfHeight := ScaledHalfHeight;
        IF Growing THEN
            HalfHeight := (HalfHeight * 5) DIV 4;
            IF (HalfHeight > 100) THEN
                HalfHeight := 100;
                Growing := FALSE;
            END;
            ScaledHalfHeight := (HalfHeight * Width) DIV 320;
            Rectangle(Left, 100 - ScaledHalfHeight, Right, 100 - PrevScaledHalfHeight, LightestWhite, TRUE);
            Rectangle(Left, 100 + PrevScaledHalfHeight, Right, 100 + ScaledHalfHeight, LightestWhite, TRUE);
        ELSE
            HalfHeight := (HalfHeight * 3) DIV 4;
            IF (HalfHeight < 5) THEN
                HalfHeight := 5;
                Growing := TRUE;
            END;
            ScaledHalfHeight := (HalfHeight * Width) DIV 320;
            Rectangle(Left, 100 - PrevScaledHalfHeight, Right, 100 - ScaledHalfHeight, Black, TRUE);
            Rectangle(Left, 100 + ScaledHalfHeight, Right, 100 + PrevScaledHalfHeight, Black, TRUE);
        END;
        Lib.Delay(GameSpeed);
        IF (KeyPressed()) THEN RETURN FALSE; END;
    END;
    RETURN TRUE;
END SpinRectangle;

PROCEDURE DrawStars;
BEGIN
    FOR Count := 1 TO 35 DO
        Plot (Lib.RANDOM (320), Lib.RANDOM(200) , (Lib.RANDOM(15))+15);
    END;
END DrawStars;

PROCEDURE MakeDiamond() : BOOLEAN;
CONST
    DiamondDelay = 1;
BEGIN
    DrawStars;
    FOR Count := 160 TO 320 DO
        Plot (Count, 100, LightestWhite);   Plot (320-Count, 100, LightestWhite);
        Plot (Count-2, 99, LightWhite);     Plot (320-Count+2, 99, LightWhite);
        Plot (Count-2, 101, LightWhite);    Plot (320-Count+2, 101, LightWhite);
        Plot (Count-4, 98, White);          Plot (320-Count+4, 98, White);
        Plot (Count-4, 102, White);         Plot (320-Count+4, 102, White);
        Plot (Count-6, 97, LightestBlue);   Plot (320-Count+6, 97, LightestBlue);
        Plot (Count-6, 103, LightestBlue);  Plot (320-Count+6, 103, LightestBlue);
        Plot (Count-8, 96, DarkWhite);      Plot (320-Count+8, 96, DarkWhite);
        Plot (Count-8, 104, DarkWhite);     Plot (320-Count+8, 104, DarkWhite);
        Plot (Count-10, 95, DarkestWhite);  Plot (320-Count+10, 95, DarkestWhite);
        Plot (Count-10, 105, DarkestWhite); Plot (320-Count+10, 105, DarkestWhite);
        Plot (Count-12, 94, DarkGrey);      Plot (320-Count+12, 94, DarkGrey);
        Plot (Count-12, 106, DarkGrey);     Plot (320-Count+12, 106, DarkGrey);
        Plot (Count-12, 93, DarkestGrey);   Plot (320-Count+12, 93, DarkestGrey);
        Plot (Count-12, 107, DarkestGrey);  Plot (320-Count+12, 107, DarkestGrey);
        Lib.Delay(DiamondDelay);
    END;
    RETURN (NOT KeyPressed());
END MakeDiamond;

PROCEDURE ExoLogo() : BOOLEAN;
BEGIN
    E(60, 90); X(90, 90); O(120, 90); B(150, 90); I(180, 90); U(210, 90); S(240, 90);
    FOR Count := 50 TO 270 DO
        Rectangle(Count - 1, 70, Count, 130, Black, TRUE);
        PutPixel(Count, 70 + Lib.RANDOM(19), DarkYellow);
        PutPixel(Count, 70 + Lib.RANDOM(19), Yellow);
        PutPixel(Count, 70 + Lib.RANDOM(19), LightYellow);
        PutPixel(Count, 130 - Lib.RANDOM(19), LightYellow);
        PutPixel(Count, 130 - Lib.RANDOM(19), Yellow);
        PutPixel(Count, 130 - Lib.RANDOM(19), DarkYellow);
        IF (Count < 80) THEN E(60, 90);
        ELSIF (Count < 110) THEN X(90, 90);
        ELSIF (Count < 140) THEN O(120, 90);
        ELSIF (Count < 170) THEN B(150, 90);
        ELSIF (Count < 200) THEN I(180, 90);
        ELSIF (Count < 230) THEN U(210, 90);
        ELSE S(240, 90);
        END;
        Lib.Delay(GameSpeed);
        IF (KeyPressed()) THEN RETURN FALSE; END;
    END;
    Rectangle(269, 70, 270, 130, Black, FALSE);

    FOR Count := 1 TO 5 DO
        Lib.Delay(500);
        IF (KeyPressed()) THEN RETURN FALSE; END;
    END;

    RETURN TRUE;
END ExoLogo;

PROCEDURE WriteMyName() : BOOLEAN;
CONST
    GravityAccel = 0.2;
    TerminalVelocity = 3.0;
    NameLeft = 95; NameRight = 235; NameHeight = 50;
VAR
    NameY, NameVelocity : REAL;
    NameYCard, Bounces, NameImageSize : CARDINAL;
    NameAddress : ADDRESS;
BEGIN
    Bounces := 0;
    NameY := 1.0; NameYCard := CARDINAL(NameY);
    NameVelocity := TerminalVelocity;
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawStars;
    Rectangle(95, NameYCard - 1, NameRight, NameYCard + NameHeight, Black, TRUE);
    P(105, NameYCard); A(135, NameYCard); U(165, NameYCard); L(195, NameYCard);
    R(95, NameYCard+30); A(125, NameYCard+30); H(155, NameYCard+30); M(185, NameYCard+30); E(215, NameYCard+30);
    NameImageSize := CARDINAL(Graph.ImageSize(NameLeft, 0, NameRight, NameHeight + 1));
    Storage.ALLOCATE(NameAddress, NameImageSize);
    Graph.GetImage(NameLeft, NameYCard - 1, NameRight, NameYCard + NameHeight, NameAddress);

    WHILE (Bounces < 3) AND NOT (KeyPressed()) DO
        IF (NameVelocity < TerminalVelocity) THEN NameVelocity := NameVelocity + GravityAccel; END;
        NameY := NameY + NameVelocity; NameYCard := CARDINAL(NameY);

        IF (NameVelocity > 0.0) THEN
            Rectangle(NameLeft, NameYCard - CARDINAL(NameVelocity), NameRight, NameYCard, Black, TRUE);
        ELSE
            Rectangle(NameLeft, NameYCard + NameHeight, NameRight, NameYCard + NameHeight + CARDINAL(TerminalVelocity), Black, TRUE);
        END;

        IF (NameY > 124.9) THEN
            NameY := 125.0;
            NameVelocity := -NameVelocity;
            Bounces := Bounces + 1;
        END;
        NameYCard := CARDINAL(NameY);

        Graph.PutImage(NameLeft, NameYCard, NameAddress, Graph._GPSET);
        B(135 ,95); Y(165, 95);
        Lib.Delay(GameSpeed * 2);

        IF (KeyPressed()) THEN Bounces := 1000; END;
    END;

    Storage.DEALLOCATE(NameAddress, NameImageSize);
    IF (Bounces < 900) THEN
        DrawStars;
        FOR Count := 1 TO 5 DO
            Lib.Delay(1000);
            IF (KeyPressed()) THEN RETURN FALSE; END;
        END;
    END;
    RETURN TRUE;
END WriteMyName;

PROCEDURE FillAtmosFear(ColData : ARRAY OF CHAR; AtmosX : CARDINAL);
CONST
    LogoBottom = 145;
VAR
    YOffset : CARDINAL;
    Color : BYTE;
BEGIN
    FOR YOffset := 0 TO 15 DO
        CASE (ColData[YOffset]) OF
            |'0': Color := 0; (* Black *)
            |'1': Color := 28; (* White *)
            |'2': Color := 23; (* Grey *)
        END;
        PutPixel(AtmosX, LogoBottom - YOffset, Color);
    END;
END FillAtmosFear;

PROCEDURE WriteAtmosFear() : BOOLEAN;
CONST
    MusicByHalfWidth = 100.0;
    LettersY = 95;
    LogoTop = 130; LogoBottom = 145;
VAR
    LetterOffsetX, RectangleX, RectangleY, RectY2, TopCornerOffset, AtmosX, BeamColor : CARDINAL;
    MusicByProgress : REAL;
BEGIN
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    DrawStars;
    MusicByProgress := -1.0;
    WHILE (MusicByProgress < 1.0) DO
        Rectangle(50, LettersY, 300, LettersY + 20, Black, TRUE);

        M(150 - CARDINAL(MusicByProgress * 105.0), LettersY);
        U(150 - CARDINAL(MusicByProgress * 75.0), LettersY);
        S(150 - CARDINAL(MusicByProgress * 45.0), LettersY);
        I(150 - CARDINAL(MusicByProgress * 15.0), LettersY);

        C(150 + CARDINAL(MusicByProgress * 15.0), LettersY);
        (* leave gap for space *)
        B(150 + CARDINAL(MusicByProgress * 75.0), LettersY);
        Y(150 + CARDINAL(MusicByProgress * 105.0), LettersY);

        IF (KeyPressed()) THEN RETURN FALSE; END;
        MusicByProgress := MusicByProgress + 0.015;
    END;
    Lib.Delay(500);

    RectangleY := 120; RectY2 := 120;
    FOR RectangleX := 160 TO 210 DO
        RectangleY := 120 + ((RectangleX - 160) DIV 5);
        RectY2 := 120 + ((RectangleX - 160) DIV 2);
        Rectangle(90, 120, 230, 158, Black, TRUE);

        TopCornerOffset := (RectangleX - 160) DIV 5;
        HLine(320 - RectangleX + TopCornerOffset, RectangleY, RectangleX - TopCornerOffset, White);
        HLine(320 - RectangleX, RectY2, RectangleX, White);
        Line(320 - RectangleX + TopCornerOffset, RectangleY, 320 - RectangleX, RectY2, White);
        Line(RectangleX - TopCornerOffset, RectangleY, RectangleX, RectY2, White);

        Lib.Delay(GameSpeed);
        IF (KeyPressed()) THEN RETURN FALSE; END;
    END;
    Rectangle(90, 120, 230, 158, Black, TRUE);
    HLine(120, LogoTop, 200, White);
    HLine(110, LogoBottom, 210, White);
    Line(110, LogoBottom, 120, LogoTop, White);
    Line(210, LogoBottom, 200, LogoTop, White);
    Lib.Delay (200);

    IF (KeyPressed()) THEN RETURN FALSE; END;
    Line(120, LogoTop, 130, LogoBottom, White);
    Line(200, LogoTop, 190, LogoBottom, White);
    Lib.Delay(500);
    IF (KeyPressed()) THEN RETURN FALSE; END;
    Line(130, LogoBottom, 140, LogoTop, White);
    Line(190, LogoBottom, 180, LogoTop, White);
    Lib.Delay(500);
    IF (KeyPressed()) THEN RETURN FALSE; END;
    Line(140, LogoTop, 150, LogoBottom, White);
    Line(180, LogoTop, 170, LogoBottom, White);
    Lib.Delay(500);
    IF (KeyPressed()) THEN RETURN FALSE; END;
    Line(150, LogoBottom, 160, LogoTop, White);
    Line(170, LogoBottom, 160, LogoTop, White);
    Lib.Delay(500);
    IF (KeyPressed()) THEN RETURN FALSE; END;

    FOR AtmosX := 110 TO 210 DO
        IF (AtmosX MOD 2 = 0) THEN BeamColor := Blue; ELSE BeamColor := LightestBlue; END;
        Line(AtmosX + 3, LogoTop - 1, AtmosX + 3, LogoBottom + 1, Grey);
        Line(AtmosX + 2, LogoTop - 3, AtmosX + 2, LogoBottom + 3, LightBlue);
        Line(AtmosX + 1, LogoTop - 5, AtmosX + 1, LogoBottom + 5, BeamColor);
        Line(AtmosX, LogoTop - 5, AtmosX, LogoBottom + 5, Black);
        CASE AtmosX OF
            |110:   FillAtmosFear("1000000000000000", AtmosX);
            |111:   FillAtmosFear("1110000000000000", AtmosX);
            |112:   FillAtmosFear("1221000000000000", AtmosX);
            |113:   FillAtmosFear("1002110000000000", AtmosX);
            |114:   FillAtmosFear("1000221000000000", AtmosX);
            |115:   FillAtmosFear("1000002110000000", AtmosX);
            |116:   FillAtmosFear("1000000221000000", AtmosX);
            |117:   FillAtmosFear("1220000002110000", AtmosX);
            |118:   FillAtmosFear("1222200000221000", AtmosX);
            |119:   FillAtmosFear("1222220200002110", AtmosX);
            |120:   FillAtmosFear("1222220222002221", AtmosX);
            |121:   FillAtmosFear("1222220200002111", AtmosX);
            |122:   FillAtmosFear("1222200000221221", AtmosX);
            |123:   FillAtmosFear("1220000002112001", AtmosX);
            |124:   FillAtmosFear("1000000221220001", AtmosX);
            |125:   FillAtmosFear("1000002112220001", AtmosX);
            |126:   FillAtmosFear("1000221222220001", AtmosX);
            |127:   FillAtmosFear("1002112222220001", AtmosX);
            |128:   FillAtmosFear("1221220002220001", AtmosX);
            |129:   FillAtmosFear("1112000000000001", AtmosX);
            |130:   FillAtmosFear("1000000000000001", AtmosX);
            |131:   FillAtmosFear("1112000000000001", AtmosX);
            |132:   FillAtmosFear("1221220002220001", AtmosX);
            |133:   FillAtmosFear("1002112222220001", AtmosX);
            |134:   FillAtmosFear("1000221222220001", AtmosX);
            |135:   FillAtmosFear("1000002112220001", AtmosX);
            |136:   FillAtmosFear("1220000221220001", AtmosX);
            |137:   FillAtmosFear("1222000002112001", AtmosX);
            |138:   FillAtmosFear("1022220000021221", AtmosX);
            |139:   FillAtmosFear("1000000000222111", AtmosX);
            |140:   FillAtmosFear("1000000022222221", AtmosX);
            |141:   FillAtmosFear("1000000000222111", AtmosX);
            |142:   FillAtmosFear("1022220000021221", AtmosX);
            |143:   FillAtmosFear("1222000002112001", AtmosX);
            |144:   FillAtmosFear("1220000221220001", AtmosX);
            |145:   FillAtmosFear("1000002112000001", AtmosX);
            |146:   FillAtmosFear("1000221220000001", AtmosX);
            |147:   FillAtmosFear("1002112000000001", AtmosX);
            |148:   FillAtmosFear("1221220000020001", AtmosX);
            |149:   FillAtmosFear("1112000002220001", AtmosX);
            |150:   FillAtmosFear("1200000222220001", AtmosX);
            |151:   FillAtmosFear("1112000002220001", AtmosX);
            |152:   FillAtmosFear("1221220000020001", AtmosX);
            |153:   FillAtmosFear("1002112000000001", AtmosX);
            |154:   FillAtmosFear("1002221220000001", AtmosX);
            |155:   FillAtmosFear("1002222112000001", AtmosX);
            |156:   FillAtmosFear("1002220021220001", AtmosX);
            |157:   FillAtmosFear("1002220000112001", AtmosX);
            |158:   FillAtmosFear("1002220000001221", AtmosX);
            |159:   FillAtmosFear("1002220020000111", AtmosX);
            |160:   FillAtmosFear("1002220022000221", AtmosX);
            |161:   FillAtmosFear("1002200022200111", AtmosX);
            |162:   FillAtmosFear("1000000022001221", AtmosX);
            |163:   FillAtmosFear("1000000022112001", AtmosX);
            |164:   FillAtmosFear("1000002221220001", AtmosX);
            |165:   FillAtmosFear("1000002112000001", AtmosX);
            |166:   FillAtmosFear("1000021220000001", AtmosX);
            |167:   FillAtmosFear("1200112000020001", AtmosX);
            |168:   FillAtmosFear("1221200002220001", AtmosX);
            |169:   FillAtmosFear("1110000002220001", AtmosX);
            |170:   FillAtmosFear("1000022002220001", AtmosX);
            |171:   FillAtmosFear("1112222002220001", AtmosX);
            |172:   FillAtmosFear("1221222002220001", AtmosX);
            |173:   FillAtmosFear("1002112002220001", AtmosX);
            |174:   FillAtmosFear("1000221002220001", AtmosX);
            |175:   FillAtmosFear("1000002112220001", AtmosX);
            |176:   FillAtmosFear("1000000021220001", AtmosX);
            |177:   FillAtmosFear("1000200002110001", AtmosX);
            |178:   FillAtmosFear("1000220000021221", AtmosX);
            |179:   FillAtmosFear("1000220020002111", AtmosX);
            |180:   FillAtmosFear("1000220022000221", AtmosX);
            |181:   FillAtmosFear("1000220022000111", AtmosX);
            |182:   FillAtmosFear("1000220022001221", AtmosX);
            |183:   FillAtmosFear("1000220022112001", AtmosX);
            |184:   FillAtmosFear("1000220021220001", AtmosX);
            |185:   FillAtmosFear("1000220112000001", AtmosX);
            |186:   FillAtmosFear("1000221200000001", AtmosX);
            |187:   FillAtmosFear("1002110000020001", AtmosX);
            |188:   FillAtmosFear("1221000000220001", AtmosX);
            |189:   FillAtmosFear("1112222200220001", AtmosX);
            |190:   FillAtmosFear("1222222220220001", AtmosX);
            |191:   FillAtmosFear("1112222200220001", AtmosX);
            |192:   FillAtmosFear("1221000000220001", AtmosX);
            |193:   FillAtmosFear("1002110000020001", AtmosX);
            |194:   FillAtmosFear("1000221200000001", AtmosX);
            |195:   FillAtmosFear("1000002112000001", AtmosX);
            |196:   FillAtmosFear("1000000221220001", AtmosX);
            |197:   FillAtmosFear("1220000002112001", AtmosX);
            |198:   FillAtmosFear("1222000000021221", AtmosX);
            |199:   FillAtmosFear("1222220000002111", AtmosX);
            |200:   FillAtmosFear("1222200022000221", AtmosX);
            |201:   FillAtmosFear("1222002020002110", AtmosX);
            |202:   FillAtmosFear("1220022000021000", AtmosX);
            |203:   FillAtmosFear("1200022200110000", AtmosX);
            |204:   FillAtmosFear("1000222221000000", AtmosX);
            |205:   FillAtmosFear("1000222110000000", AtmosX);
            |206:   FillAtmosFear("1002221000000000", AtmosX);
            |207:   FillAtmosFear("1002110000000000", AtmosX);
            |208:   FillAtmosFear("1221000000000000", AtmosX);
            |209:   FillAtmosFear("1110000000000000", AtmosX);
            |210:   FillAtmosFear("1000000000000000", AtmosX);
        END;
        Lib.Delay(GameSpeed * 2);
        IF (KeyPressed()) THEN RETURN FALSE; END;
    END;
    Rectangle(211, LogoTop - 5, 214, LogoBottom + 5, Black, TRUE);

    FOR Count := 1 TO 4 DO
        Delay(500);
        IF (KeyPressed()) THEN RETURN FALSE; END;
    END;

    RETURN TRUE;
END WriteAtmosFear;

PROCEDURE ReadyForWriting(LetterString : ARRAY OF CHAR; WritingAddress : ADDRESS) : BOOLEAN;
VAR
    NoOfPieces, WriteX, WriteY, LetterX, LetterY, WritingSize, PieceX,
    Colour, BitMapCount : CARDINAL;
BEGIN
    FOR Count := 1 TO 5 DO
        PieceX := 0;
        FOR LetterX := 33 TO 300 BY 5 DO
            CASE LetterString[PieceX] OF
                |'0': Colour := Black;
                |'1': Colour := Lib.RANDOM (7) + 104;
                HLine (LetterX, 199, LetterX + 5, Colour);
            END;
            PieceX := PieceX + 1;
        END;
        FOR WriteY := 161 TO 199 DO
            Graph.GetImage (0, WriteY, 320, WriteY, WritingAddress);
            Graph.PutImage (0, WriteY-1, WritingAddress, Graph._GPSET);
        END;
        HLine (0, 199, 320, Black);
        FOR BitMapCount := 1 TO 2 DO
            FOR WriteY := 2 TO 160 DO
                WriteX := Lib.RANDOM(320);
                IF (WriteY MOD 2=1) THEN
                    Graph.GetImage(0, WriteY, WriteX, WriteY, WritingAddress);
                    Graph.PutImage(1, WriteY-1, WritingAddress, Graph._GPSET);
                    Graph.GetImage(WriteX+1, WriteY, 320, WriteY, WritingAddress);
                    Graph.PutImage(WriteX+1, WriteY-1, WritingAddress, Graph._GPSET)
                ELSE
                    Graph.GetImage(WriteX, WriteY, 320, WriteY, WritingAddress);
                    Graph.PutImage(WriteX-1, WriteY-1, WritingAddress, Graph._GPSET);
                    Graph.GetImage(0, WriteY, WriteX-1, WriteY, WritingAddress);
                    Graph.PutImage(0, WriteY-1, WritingAddress, Graph._GPSET);
                END;
            END;
        END;
    END;
    RETURN (NOT KeyPressed());
END ReadyForWriting;

PROCEDURE WriteThinks() : BOOLEAN;
VAR
    WritingAddress : ADDRESS;
    NotSkipped : BOOLEAN;
    RepeatCount : CARDINAL;
BEGIN
    Graph.ClearScreen (Graph._GCLEARSCREEN);

    Storage.ALLOCATE(WritingAddress, CARDINAL(Graph.ImageSize(0, 0, 320, 0)));
    NotSkipped := TRUE;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000011111001000100111110011001001000100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100001000010101001001000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001111100001000010101001110000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100001000010101001001000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100111110010011001000100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000011111001000100111110011111001000100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000010001001000100001000010000001001000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000010101001000100001000010000001110000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000010011001000100001000010000001001000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000011111001111100111110011111001000100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000011111001000100111110011001001000100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100001000010101001001000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001111100001000010101001110000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100001000010101001001000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100111110010011001000100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("011110011111001111000111110011111000111100100010011111", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("100000000100001000100100010000100001000000100010000100", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("011100000100001111000111110000100001011100111110000100", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000010000100001001000100010000100001000100100010000100", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("111100000100001000100100010011111000111100100010000100", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000011111001000100111110011001001000100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100001000010101001001000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001111100001000010101001110000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100001000010101001001000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000100001000100111110010011001000100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000010000001111100011110011111000111100000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000010000001000100100000000100001000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000010000001000100101110000100001000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000010000001000100100010000100001000000000000000", WritingAddress); END;
    IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000011111001111100011110011111000111100000000000", WritingAddress); END;
    FOR RepeatCount := 0 TO 30 DO
        IF (NotSkipped) THEN NotSkipped := ReadyForWriting("000000000000000000000000000000000000000000000000000000", WritingAddress); END;
    END;
    Storage.DEALLOCATE (WritingAddress, CARDINAL(Graph.ImageSize(0, 0, 320, 0)));
    RETURN (NOT NotSkipped);
END WriteThinks;

PROCEDURE PlayTitleSequence;
VAR
    NotSkipped : BOOLEAN;
BEGIN
    ClearScreen(_GCLEARSCREEN);
    NotSkipped := InfiniteSoftware();
    IF (NotSkipped) THEN
        NotSkipped := SpinRectangle();
    END;
    IF (NotSkipped) THEN
        NotSkipped := MakeDiamond();
    END;
    IF (NotSkipped) THEN
        NotSkipped := ExoLogo();
    END;
    IF (NotSkipped) THEN
        NotSkipped := WriteMyName();
    END;
    IF (NotSkipped) THEN
        NotSkipped := WriteAtmosFear();
    END;
    IF (NotSkipped) THEN
        NotSkipped := WriteThinks();
    END;
END PlayTitleSequence;

END Intro1.
