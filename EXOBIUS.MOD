IMPLEMENTATION MODULE Exobius;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT
    Str, Lib, IO, Graph, Window, Storage, MsMouse, Bosses;

FROM Graph IMPORT
    SetVideoMode, _MRES256COLOR, _DEFAULTMODE, Line, Polygon, Circle, Disc, Ellipse, Rectangle, Plot;

FROM Lib IMPORT
    Sound, NoSound, Delay;

TYPE
    BYTEPTR = POINTER TO BYTE;

PROCEDURE SetVGAMode;
VAR
    VideoMode : BOOLEAN;
BEGIN
    VideoMode := SetVideoMode(_MRES256COLOR);
    Graph.SetFillMask(SolidFill);
END SetVGAMode;

PROCEDURE SetTextMode;
VAR
    VideoMode : BOOLEAN;
BEGIN
    VideoMode := SetVideoMode(_DEFAULTMODE);
END SetTextMode;

PROCEDURE WaitVSync();
VAR
    MemValue : SHORTCARD;
BEGIN
    RETURN;
    (* This doesn't work, it spins forever *)
    (* Theoretically it should exit when 03DAH no longer has 3rd (8H) bit set *)
    MemValue := 8;
    WHILE (3 IN BITSET(MemValue)) DO
        MemValue := [03DAH:0 BYTEPTR]^;
        (*IO.WrChar([03DAH:0 BYTEPTR]^);*)
    END;
END WaitVSync;

PROCEDURE PutPixel(x, y : CARDINAL; color : BYTE);
BEGIN
    [0A000H:x+y*320 BYTEPTR]^ := color;
END PutPixel;

PROCEDURE SetPixel(pixPos : CARDINAL; Color : BYTE);
BEGIN
    [0A000H:pixPos BYTEPTR]^ := Color;
END SetPixel;

PROCEDURE GetPixel(x, y : CARDINAL) : SHORTCARD;
BEGIN
    RETURN [0A000H:x+y*320 BYTEPTR]^;
END GetPixel;

PROCEDURE ClearTheBuffer;
VAR
    Key : CHAR;
BEGIN
    WHILE IO.KeyPressed() DO
        Key := IO.RdChar();
    END;
END ClearTheBuffer;

PROCEDURE A (x, y : CARDINAL);
BEGIN
    Xs[0] := x+9; Xs[1] := x; Xs[2] := x+9; Xs[3] := x+19;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+8; Ys[3] := y+19;
    Polygon(4, Xs, Ys, LightGrey);
    Ys[0] := y+9; Ys[1] := y+19; Ys[2] := y+12; Ys[3] := y+19;
    Polygon(4, Xs, Ys, Grey);
END A;

PROCEDURE B (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+9; Xs[3] := x;
    Ys[0] := y; Ys[1] := y+4; Ys[2] := y+9; Ys[3] := y+9;
    Polygon(4, Xs, Ys, LightGrey);
    Ys[0] := y+19; Ys[1] := y+14; Ys[2] := y+9; Ys[3] := y+9;
    Polygon(4, Xs, Ys, Grey);
END B;

PROCEDURE C (x, y : CARDINAL);
BEGIN
    Xs[0] := x+19; Xs[1] := x+9; Xs[2] := x;
    Ys[0] := y; Ys[1] := y+9; Ys [2] := y+9;
    Polygon(3, Xs, Ys, LightGrey);
    Ys[0] := y+19;
    Polygon(3, Xs, Ys, Grey);
END C;

PROCEDURE D (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y+9;
    Polygon (3, Xs, Ys, LightGrey);
    Ys[0] := y+19;
    Polygon (3, Xs, Ys, Grey);
END D;

PROCEDURE E (x, y : CARDINAL);
BEGIN
    Xs [0] := x; Xs[1] := x+19; Xs[2] := x+9; Xs[3] := x+19; Xs[4] := x;
    Ys [0] := y; Ys[1] := y+3; Ys[2] := y+6; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, LightGrey);
    Ys [0] := y+19; Ys[1] := y+17; Ys[2] := y+13; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, Grey);
END E;

PROCEDURE F (x, y : CARDINAL);
BEGIN
    Xs [0] := x; Xs[1] := x+19; Xs[2] := x+9; Xs[3] := x+19; Xs[4] := x;
    Ys [0] := y; Ys[1] := y+3; Ys[2] := y+6; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, LightGrey);
    Xs [0] := x; Xs[1] := x+19; Xs[2] := x+9; Xs[3] := x;
    Ys [0] := y+9; Ys[1] := y+9; Ys[2] := y+13; Ys[3] := y+19;
    Polygon (4, Xs, Ys, Grey);
END F;

PROCEDURE G (x, y : CARDINAL);
BEGIN
    C (x,y);
    Xs[0] := x+9; Xs[1] := x+19; Xs[2] := x+19;
    Ys[0] := y+9; Ys[1] := y+9; Ys[2] := y+19;
    Polygon (3, Xs, Ys, LightGrey);
END G;

PROCEDURE H (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+19; Xs[4] := x;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, LightGrey);
    Ys[0] := y+19; Ys[1] := y+9; Ys[2] := y+19; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, Grey);
END H;

PROCEDURE I (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y;
    Polygon (3, Xs, Ys, Grey);
    Ys[0] := y+19; Ys[1] := y+9; Ys[2] := y+19;
    Polygon (3, Xs, Ys, LightGrey);
END I;

PROCEDURE J (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+19;
    Ys[0] := y; Ys[1] := y; Ys[2] := y+9;
    Polygon (3, Xs, Ys, LightGrey);
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+9;
    Ys[0] := y+9; Ys[1] := y+9; Ys[2] := y+19;
    Polygon (3, Xs, Ys, Grey);
END J;

PROCEDURE K (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+14; Xs[4] := x;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, LightGrey);
    Ys[0] := y+19; Ys[1] := y+9; Ys[2] := y+19; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, Grey);
    Line (x+13, y+9, x+18, y+18, Grey);
END K;

PROCEDURE L (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x; Xs[2] := x+4;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+14;
    Polygon (3, Xs, Ys, Grey);
    Xs[1] := x+19;
    Ys[0] := y+19; Ys[1] := y+19;
    Polygon (3, Xs, Ys, LightGrey);
END L;

PROCEDURE M (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x; Xs[2] := x+4;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+9;
    Polygon (3, Xs, Ys, LightGrey);
    Xs[0] := x+19; Xs[1] := x+19; Xs[2] := x+14;
    Polygon (3, Xs, Ys, LightGrey);
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+14; Xs[4] := x+9; Xs[5] := x+4;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+14; Ys[5] := y+9;
    Polygon (6, Xs, Ys, Grey);
END M;

PROCEDURE N (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x; Xs[2] := x+4;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+9;
    Polygon (3, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[1] := x+19; Xs[2] := x+14;
    Polygon (3, Xs, Ys, Grey);
    Xs[0] := x; Xs[1] := x+13; Xs[2] := x+19; Xs[3] := x+4;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y+19; Ys[3] := y+9;
    Polygon (4, Xs, Ys, LightGrey);
END N;

PROCEDURE O (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19;
    Ys[0] := y+9; Ys[1] := y; Ys[2] := y+9;
    Polygon (3, Xs, Ys, LightGrey);
    Ys[1] := y+19;
    Polygon (3, Xs, Ys, Grey);
END O;

PROCEDURE P (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+4; Xs[3] := x;
    Ys[0] := y; Ys[1] := y+4; Ys[2] := y+9; Ys[3] := y+19;
    Polygon (4, Xs, Ys, LightGrey);
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+4; Xs[3] := x;
    Ys[0] := y+4;Ys[1] := y+4; Ys[2] := y+9; Ys[3] := y+9;
    Polygon (4, Xs, Ys, Grey);
END P;

PROCEDURE Q (x, y : CARDINAL);
BEGIN
    O (x,y);
    Xs[0] := x+9; Xs[1] := x+19; Xs[2] := x+14;
    Ys[0] := y+9; Ys[1] := y+14; Ys[2] := y+19;
    Polygon (3, Xs, Ys, LightGrey);
END Q;

PROCEDURE R (x, y : CARDINAL);
BEGIN
    P (x,y);
    Xs[0] := x+4; Xs[1] := x+19; Xs[2] := x+19;
    Ys[0] := y+9; Ys[1] := y+14; Ys[2] := y+19;
    Polygon (3, Xs, Ys, LightGrey);
END R;

PROCEDURE S (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+19;
    Ys[0] := y+4; Ys[1] := y; Ys[2] := y+4;
    Polygon (3, Xs, Ys, LightGrey);
    Line (x, y+4, x+19, y+14, Grey);
    Xs[0] := x; Xs[1] := x; Xs[2] := x+19;
    Ys[0] := y+14; Ys[1] := y+19; Ys[2] := y+14;
    Polygon (3, Xs, Ys, LightGrey);
END S;

PROCEDURE T (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+9;Xs[3] := x+7;
    Ys[0] := y; Ys[1] := y; Ys[2] := y+19; Ys[3] := y+4;
    Polygon (4, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[3] := x+13;
    Polygon (4, Xs, Ys, LightGrey);
END T;

PROCEDURE U (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x; Xs[2] := x+9;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+19;
    Polygon (3, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[1] := x+19;
    Polygon(3, Xs, Ys, LightGrey);
END U;

PROCEDURE V (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+9;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+9;
    Polygon (3, Xs, Ys, Grey);
    Xs[0] := x+19;
    Polygon(3, Xs, Ys, LightGrey);
END V;

PROCEDURE W (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+18; Xs[4] := x+1;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, LightGrey);
    Xs[0] := x+4; Xs[1] := x+9; Xs[2] := x+14; Xs[3] := x+18; Xs[4] := x+1;
    Ys[0] := y+19; Ys[2] := y+19;
    Polygon (5, Xs, Ys, Grey);
END W;

PROCEDURE X (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+14; Xs[4] := x+4;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+9;
    Polygon (5, Xs, Ys, LightGrey);
    Ys[0] := y+19; Ys[2] := y+19;
    Polygon (5, Xs, Ys, Grey);
    Line (x+13, y+9, x+19, y+19, Grey);
END X;

PROCEDURE Y (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+9;Xs[3] := x+7;
    Ys[0] := y; Ys[1] := y+4; Ys[2] := y+19; Ys[3] := y+4;
    Polygon (4, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[3] := x+13;
    Polygon (4, Xs, Ys, LightGrey);
END Y;

PROCEDURE Z (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+9;
    Ys[0] := y; Ys[1] := y; Ys[2] := y+4;
    Polygon (3, Xs, Ys, Grey);
    Ys[0] := y+19; Ys[1] := y+19; Ys[2] := y+14;
    Polygon (3, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[1] := x+9; Xs[2] := x; Xs[3] := x+9;
    Ys[0] := y; Ys[1] := y+4; Ys[2] := y+19; Ys[3] := y+14;
    Polygon (4, Xs, Ys, LightGrey);
END Z;

PROCEDURE DrawPlane(x, y, Width : CARDINAL);
VAR
    Xs, Ys : ARRAY [0..3] OF CARDINAL;
    x9, x13, x14, x15, x16, x17, x18, x25,
    x32, x33, x34, x35, x36, x37,
    Height, y8, y9, y10, y22, y25 : CARDINAL;
BEGIN
    x9 := x + (Width * 9 DIV 50);
    x13 := x + (Width * 13 DIV 50);
    x14 := x + (Width * 14 DIV 50);
    x15 := x + (Width * 15 DIV 50);
    x16 := x + (Width * 16 DIV 50);
    x17 := x + (Width * 17 DIV 50);
    x18 := x + (Width * 18 DIV 50);
    x25 := x + (Width DIV 2);
    x32 := x + (Width * 32 DIV 50);
    x33 := x + (Width * 33 DIV 50);
    x34 := x + (Width * 34 DIV 50);
    x35 := x + (Width * 35 DIV 50);
    x36 := x + (Width * 36 DIV 50);
    x37 := x + (Width * 37 DIV 50);
    Height := Width DIV 2;
    y8 := y + (Height * 8 DIV 25);
    y9 := y + (Height * 9 DIV 25);
    y10 := y + (Height * 10 DIV 25);
    y22 := y + (Height * 22 DIV 25);
    y25 := y + Height;

    (* Main ship body *)
    Xs[0] := x; Ys[0] := y25;
    Xs[1] := x25; Ys[1] := y + (Height * 20 DIV 25);
    Xs[2] := x25; Ys[2] := y;
    Xs[3] := x; Ys[3] := y25;
    Polygon(4, Xs, Ys, DarkBlue);
    Xs[0] := x + Width; Xs[3] := x + Width;
    Polygon(4, Xs, Ys, LightBlue);

    (* Left engine *)
    Line(x18, y22, x18, y9, LightestWhite);
    Line(x17, y22, x18, y9, LightWhite);
    Line(x16, y22, x18, y9, White);
    Line(x15, y22, x17, y9, DarkWhite);                     Plot(x17, y8, DarkWhite);
    Line(x14, y22, x16, y9, DarkestWhite);
    Line(x13, y22, x16, y9, LightestGrey);                  Plot(x16, y8, DarkestGrey);
    Line(x + (Width * 12 DIV 50), y22, x15, y9, LightGrey);
    Line(x + (Width * 11 DIV 50), y22, x15, y9, Grey);      Plot(x15, y8, LightGrey);
    Line(x + (Width * 10 DIV 50), y22, x14, y9, DarkGrey);
    Line(x9, y22, x14, y9, DarkGrey);
    Line(x + (Width * 8 DIV 50), y22, x13, y10, DarkestGrey);
    Ellipse(x13, y22, Width DIV 10, Width DIV 25, Yellow, TRUE);

    (* Right engine *)
    Line(x32, y22, x32, y9, DarkestGrey);
    Line(x33, y22, x32, y9, DarkGrey);
    Line(x34, y22, x32, y9, Grey);
    Line(x35, y22, x32, y9, LightGrey);                     Plot(x33, y8, LightGrey);
    Line(x36, y22, x34, y9, LightestGrey);
    Line(x37, y22, x34, y9, DarkestWhite);                  Plot(x34, y8, DarkestWhite);
    Line(x + (Width * 38 DIV 50), y22, x35, y9, DarkWhite);
    Line(x + (Width * 39 DIV 50), y22, x35, y9, DarkWhite); Plot(x35, y8, DarkWhite);
    Line(x + (Width * 40 DIV 50), y22, x36, y9, White);
    Line(x + (Width * 41 DIV 50), y22, x36, y9, LightWhite);
    Line(x + (Width * 42 DIV 50), y22, x37, y10, LightestWhite);
    Ellipse(x37, y22, Width DIV 10, Width DIV 25, Yellow, TRUE);
END DrawPlane;

PROCEDURE DrawPlane5025();
VAR
    Xs, Ys : ARRAY [0..3] OF CARDINAL;
    x9, x13, x14, x15, x16, x17, x18, x25,
    x32, x33, x34, x35, x36, x37,
    y8, y9, y10, y22, y25 : CARDINAL;
BEGIN
    x9 := PlaneX + 9; x13 := PlaneX + 13; x14 := PlaneX + 14; x15 := PlaneX + 15; x16 := PlaneX + 16; x17 := PlaneX + 17; x18 := PlaneX + 18;
    x25 := PlaneX + 25; x32 := PlaneX + 32; x33 := PlaneX + 33; x34 := PlaneX + 34; x35 := PlaneX + 35; x36 := PlaneX + 36; x37 := PlaneX + 37;
    y8 := PlaneY + 8; y9 := PlaneY + 9; y10 := PlaneY + 10; y22 := PlaneY + 22; y25 := PlaneY + 25;

    (* Main ship body *)
    Xs[0] := PlaneX; Ys[0] := y25; Xs[1] := x25; Ys[1] := PlaneY + 20; Xs[2] := x25; Ys[2] := PlaneY; Xs[3] := PlaneX; Ys[3] := y25;
    Polygon(4, Xs, Ys, DarkBlue);
    Xs[0] := PlaneX + 50; Xs[3] := PlaneX + 50;
    Polygon(4, Xs, Ys, LightBlue);

    (* Left engine *)
    Line(x18, y22, x18, y9, LightestWhite);
    Line(x17, y22, x18, y9, LightWhite);
    Line(x16, y22, x18, y9, White);
    Line(x15, y22, x17, y9, DarkWhite);             Plot(x17, y8, DarkWhite);
    Line(x14, y22, x16, y9, DarkestWhite);
    Line(x13, y22, x16, y9, LightestGrey);          Plot(x16, y8, DarkestGrey);
    Line(PlaneX + 12, y22, x15, y9, LightGrey);
    Line(PlaneX + 11, y22, x15, y9, Grey);          Plot(x15, y8, LightGrey);
    Line(PlaneX + 10, y22, x14, y9, DarkGrey);
    Line(x9, y22, x14, y9, DarkGrey);
    Line(PlaneX + 8, y22, x13, y10, DarkestGrey);
    Ellipse(x13, y22, 5, 2, Yellow, TRUE);

    (* Right engine *)
    Line(x32, y22, x32, y9, DarkestGrey);
    Line(x33, y22, x32, y9, DarkGrey);
    Line(x34, y22, x32, y9, Grey);
    Line(x35, y22, x32, y9, LightGrey);             Plot(x33, y8, LightGrey);
    Line(x36, y22, x34, y9, LightestGrey);
    Line(x37, y22, x34, y9, DarkestWhite);          Plot(x34, y8, DarkestWhite);
    Line(PlaneX + 39, y22, x35, y9, DarkWhite);     Plot(x35, y8, DarkWhite);
    Line(PlaneX + 38, y22, x35, y9, DarkWhite);
    Line(PlaneX + 40, y22, x36, y9, White);
    Line(PlaneX + 41, y22, x36, y9, LightWhite);
    Line(PlaneX + 42, y22, x37, y10, LightestWhite);
    Ellipse(x37, y22, 5, 2, Yellow, TRUE);
END DrawPlane5025;

PROCEDURE CheckSpecialKeys;
VAR
    TextPos : Graph.TextCoords;
BEGIN
    IF (IO.KeyPressed()) THEN
        Key := IO.RdKey();
        IF (Key="q") OR (Key="Q") THEN
            GameOver := TRUE;
        ELSIF (Key="p") OR (Key="P") THEN
            TextPos := Graph.SetTextPosition(25, 19);
            Graph.OutText('PAUSED');
            Key := IO.RdKey();
            Rectangle(140, 190, 180, 199, Black, TRUE);
        END;
    END;
END CheckSpecialKeys;

PROCEDURE CheckMouseAndSpecialKeys;
BEGIN
    MsMouse.GetStatus(MouseButtons);
    MsMouse.GetMotion(MouseMove);
    CheckSpecialKeys();
END CheckMouseAndSpecialKeys;

PROCEDURE CheckMouse;
VAR
    DeltaX : CARDINAL;
BEGIN
    CheckMouseAndSpecialKeys();
    IF (MouseButtons.left_pressed) OR (MouseButtons.right_pressed) OR (MouseButtons.middle_pressed) THEN
        BulletX := PlaneX + 25;
        BulletY := 5;
    END;
    DeltaX := ABS(MouseMove.horiz) DIV PlaneMoveDiv;
    IF (MouseMove.horiz < 0) THEN
        (* Moving left *)
        IF (PlaneX < PlaneXMin + DeltaX) THEN
            PlaneX := PlaneXMin;
        ELSE
            PlaneX := PlaneX - DeltaX;
        END;
    ELSIF (MouseMove.horiz > 0) THEN
        (* Moving right *)
        IF (PlaneX > PlaneXMax - DeltaX) THEN
            PlaneX := PlaneXMax;
        ELSE
            PlaneX := PlaneX + DeltaX;
        END;
    END;
END CheckMouse;

PROCEDURE BlowUpEnemy;
CONST
    SoundDelay = 30;
VAR
    BlowUpX, BlowUpYOffset : CARDINAL;
BEGIN;
    IF (BulletX <= 50) AND (OneAlive) THEN
        BlowUpX := Enemy1X;
        OneAlive := FALSE;
    ELSIF (BulletX >= 55) AND (BulletX <= 100) AND (TwoAlive) THEN
        BlowUpX := Enemy2X;
        TwoAlive := FALSE;
    ELSIF (BulletX >= 100) AND (BulletX <= 160) AND (ThreeAlive) THEN
        BlowUpX := Enemy3X;
        ThreeAlive := FALSE;
    ELSIF (BulletX >= 160) AND (BulletX <= 210) AND (FourAlive) THEN
        BlowUpX := Enemy4X;
        FourAlive := FALSE;
    ELSIF (BulletX >= 210) AND (BulletX <= 260) AND (FiveAlive) THEN
        BlowUpX := Enemy5X;
        FiveAlive := FALSE;
    ELSIF (BulletX >= 260) AND (SixAlive) THEN
        BlowUpX := Enemy6X;
        SixAlive := FALSE;
    ELSE
        RETURN;
    END;

    (* If it got here, there's a valid enemy to blow up *)
    BlowUpYOffset := (EnemyY - 100) DIV 3;
    Sound(30);
    Disc(BlowUpX + BlowUpYOffset, EnemyY + BlowUpYOffset, BlowUpYOffset DIV 2, LightRed);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(25);
    Disc(BlowUpX + BlowUpYOffset, EnemyY + BlowUpYOffset, BlowUpYOffset DIV 3, LightestRed);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(21);
    Disc(BlowUpX + BlowUpYOffset, EnemyY + BlowUpYOffset, BlowUpYOffset DIV 4, DarkestYellow);
    Lib.Delay(SoundDelay);
    NoSound;
    Score := Score + 10;
END BlowUpEnemy;

PROCEDURE Update3DBullet;
VAR
    NewBulletX : CARDINAL;
    Dist : INTEGER;
BEGIN
    IF (BulletY > 0) AND (BulletY <= 6 ) THEN
        BulletY := BulletY - 1;
    END;

    CASE BulletY OF
        |5: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*70) DIV 2)) * (BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*70) DIV 2)) * (160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 170, 4, LightestYellow);
            IF (EnemyY >= 158) THEN
                BlowUpEnemy;
            END;
        |4: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*45) DIV 2)) * (BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*45) DIV 2)) * (160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 145, 3, LightYellow);
            IF (EnemyY >= 132) THEN
                BlowUpEnemy;
            END;
        |3: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*20) DIV 2)) * (BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*20) DIV 2)) * (160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 120, 2, Yellow);
            IF (EnemyY >= 113) THEN
                BlowUpEnemy;
            END;
        |2: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*5) DIV 2)) * (BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*5) DIV 2)) * (160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 105, 1, DarkYellow);
            IF (EnemyY >= 103) THEN
                BlowUpEnemy;
            END;
        |1: IF (BulletX >= 160) THEN
                Dist := (10 + ((3*1) DIV 2)) * (BulletX-160) DIV 160;
                NewBulletX := 160 + Dist;
            ELSIF (BulletX < 160) THEN
                Dist := (10 + ((3*1) DIV 2)) * (160-BulletX) DIV 160;
                NewBulletX := 160 - Dist;
            END;
            Disc(NewBulletX, 101, 1, DarkestYellow);
            IF (EnemyY >= 100) THEN
                BlowUpEnemy;
            END;
     END;
END Update3DBullet;

PROCEDURE Die;
CONST
    SoundDelay = 50;
BEGIN
    Sound(200);
    Ellipse(PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, Red, TRUE);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(150);
    Ellipse(PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, LightestRed, TRUE);
    Lib.Delay(SoundDelay);
    NoSound;
    Sound(120);
    Ellipse(PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, Yellow, TRUE);
    Lib.Delay(SoundDelay);
    Sound(100);
    Ellipse(PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, LightYellow, TRUE);
    Lib.Delay(SoundDelay);
    Sound(60);
    Ellipse(PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, LightestYellow, TRUE);
    Lib.Delay(SoundDelay);
    Sound(80);
    Ellipse(PlaneX + (PlaneWidth DIV 2), PlaneY*(PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, White, TRUE);
    Lib.Delay(SoundDelay);
    NoSound;
    Lives := Lives + 1;
    IF (Lives = 5) THEN
        Lives := 0;
        IF (Cheat = FALSE) THEN
            GameOver := TRUE;
        END;
    END;
    OneAlive := FALSE;
    PlaneX := PlaneXMin;
END Die;

PROCEDURE DrawGameOver;
BEGIN
    ClearTheBuffer;
    Rectangle(100, 20, 230, 90, DarkestRed, TRUE);
    Rectangle(99, 19, 231, 91, DarkRed, FALSE);
    Rectangle(98, 18, 232, 92, Red, FALSE);
    Rectangle(97, 17, 233, 93, LightRed, FALSE);
    Rectangle(96, 16, 234, 94, LightestRed, FALSE);
    G(110, 30); A(140, 30); M(170, 30); E(200, 30);
    O(110, 60); V(140, 60); E(170, 60); R(200, 60);
    Key := IO.RdKey();
END DrawGameOver;

PROCEDURE CheckDeath1;
BEGIN
    IF ((OneAlive) AND (PlaneX < 50)) THEN
        Die;
    END;
    IF (TwoAlive) AND (PlaneX > 55) AND (PlaneX < 100) THEN
        Die;
    END;
    IF (ThreeAlive) AND (PlaneX > 110) AND (PlaneX < 155) THEN
        Die;
    END;
    IF (FourAlive) AND (PlaneX > 165) AND (PlaneX < 210)THEN
        Die;
    END;
    IF (FiveAlive) AND (PlaneX > 216) AND (PlaneX < 260) THEN
        Die;
    END;
    IF (SixAlive) AND (PlaneX > 260) THEN
        Die;
    END;
END CheckDeath1;

PROCEDURE FinishScreen;
BEGIN
    Rectangle(0, 0, 320, 10, White, FALSE);
    FOR PlaneY := 175 TO 100 BY -2 DO
        IF (PlaneX < 155) THEN
            PlaneX := PlaneX + 5;
        END;
        IF (PlaneX > 155) THEN
            PlaneX := PlaneX - 5;
        END;
        Graph.PutImage(0, 100, GroundAddress, Graph._GPSET);
        DrawPlane(PlaneX, PlaneY, (PlaneY - 100) DIV 2);
        Delay(40);
    END;
    Graph.ClearScreen(Graph._GCLEARSCREEN);
END FinishScreen;

END Exobius.
