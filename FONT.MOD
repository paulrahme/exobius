IMPLEMENTATION MODULE Font;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, IO;
FROM Graph IMPORT Polygon, Line, HLine, Rectangle;
FROM Exobius IMPORT PutPixel, Yellow;

VAR
    FXs, FYs : ARRAY[0..5] OF CARDINAL;

PROCEDURE DrawFontTest;
VAR
  Key : CHAR;
BEGIN
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    A(10, 10); B(35, 10); C(60, 10); D(85, 10); E(110, 10); F(135, 10); G(160, 10); H(185, 10); I(210, 10); J(235, 10); K(260, 10); L(285, 10);
    M(10, 35); N(35, 35); O(60, 35); P(85, 35); Q(110, 35); R(135, 35); S(160, 35); T(185, 35); U(210, 35); V(235, 35); W(260, 35); X(285, 35);
    Y(135, 60); Z(165, 60);
    Key := IO.RdKey();
END DrawFontTest;

PROCEDURE A(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 10; FXs[2] := x + 20; FXs[3] := x + 10;
    FYs[0] := y + 20; FYs[1] := y + 7; FYs[2] := y + 20; FYs[3] := y + 12;
    Polygon(4, FXs, FYs, 19);
    FYs[1] := y + 1; FYs[3] := y + 7;
    Polygon(4, FXs, FYs, 21);
    Line(x, y + 20, x + 10, y + 12, 18);
    Line(x + 10, y + 12, x + 20, y + 20, 18);
    Line(x, y + 20, x + 10, y, 19);
    Line(x + 10, y, x + 20, y + 20, 22);
    Line(x, y + 20, x + 10, y + 8, 20);
    Line(x + 10, y + 8, x + 20, y + 20, 20);
END A;  

PROCEDURE B(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x + 9; FXs[3] := x;
    FYs[0] := y; FYs[1] := y + 4; FYs[2] := y + 9; FYs[3] := y + 9;
    Polygon(4,FXs, FYs, 21);
    FYs[0] := y+19; FYs[1] := y + 14; FYs[2] := y + 9; FYs[3] := y + 9;
    Polygon(4,FXs, FYs, 19);
    HLine(x, y + 9, x + 9, 20);
    Line(x, y + 19, x + 19, y + 14, 18);
    Line(x + 9, y + 9, x + 19, y + 4, 20);
    Line(x + 9, y + 9, x + 19, y + 4, 20);
    Line(x, y, x + 19, y + 4, 22);
END B;

PROCEDURE C(x, y : CARDINAL);
BEGIN
    FXs[0] := x + 19; FXs[1] := x + 10; FXs[2] := x;
    FYs[0] := y; FYs[1] := y + 9; FYs [2] := y + 9;
    Polygon(3, FXs, FYs, 21);
    FXs[1] := x + 9; FYs[0] := y + 19;
    Polygon(3, FXs, FYs, 19);
    Line(x, y + 9, x + 19, y + 19, 18);
    Line(x, y + 9, x + 19, y, 20);
    Line(x + 10, y + 9, x + 19, y, 20);
    Line(x + 10, y + 10, x + 19, y + 19, 20);
    HLine(x, y + 9, x + 9, 20);
END C;

PROCEDURE D(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x;
    FYs[0] := y; FYs[1] := y + 9; FYs[2] := y + 9;
    Polygon(3, FXs, FYs, 21);
    FYs[0] := y + 19;
    Polygon(3, FXs, FYs, 19);
    HLine(x + 1, y + 9, x + 18, 20);
    Line(x, y, x, y + 19, 20);
    Line(x, y + 19, x + 19, y + 9, 18);
    Line(x, y, x + 19, y + 9, 22);
END D;

PROCEDURE E(x, y : CARDINAL);
BEGIN
    FXs [0] := x; FXs[1] := x + 19; FXs[2] := x + 6; FXs[3] := x + 19; FXs[4] := x;
    FYs [0] := y; FYs[1] := y + 3; FYs[2] := y + 6; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 21);
    FYs [0] := y + 19; FYs[1] := y + 16; FYs[2] := y + 13; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 19);
    HLine(x + 1, y + 9, x + 18, 20);
    Line(x, y, x, y + 19, 20);
    Line(x, y + 19, x + 19, y + 16, 18);
    Line(x + 6, y + 13, x + 19, y + 9, 18);
    Line(x + 6, y + 6, x + 19, y + 3, 20);
    Line(x + 6, y + 13, x + 19, y + 16, 22);
    Line(x + 6, y + 6, x + 19, y + 9, 22);
    Line(x, y, x + 19, y + 3, 22);
END E;

PROCEDURE F(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x + 6; FXs[3] := x + 19; FXs[4] := x;
    FYs[0] := y; FYs[1] := y + 3; FYs[2] := y + 6; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 21);
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x + 6; FXs[3] := x;
    FYs[0] := y + 9; FYs[1] := y + 9; FYs[2] := y + 13; FYs[3] := y + 19;
    Polygon(4, FXs, FYs, 19);
    HLine(x + 1, y + 9, x + 18, 20);
    Line(x, y, x, y + 19, 20);
    Line(x, y + 19, x + 6, y + 13, 18);
    Line(x + 6, y + 13, x, y + 19, 18);
    Line(x + 6, y + 13, x + 19, y + 9, 18);
    Line(x + 6, y + 6, x + 19, y + 3, 20);
    Line(x + 6, y + 6, x + 19, y + 9, 22);
    Line(x, y, x + 19, y + 3, 22);
END F;

PROCEDURE G(x, y : CARDINAL);
BEGIN
    C (x,y);
    FXs[0] := x + 14; FXs[1] := x + 19; FXs[2] := x + 19;
    FYs[0] := y + 9; FYs[1] := y + 9; FYs[2] := y + 19;
    Polygon(3, FXs, FYs, 21);
    Line(x + 14, y + 9, x + 18, y + 18, 20);
    HLine(x + 14, y + 9, x + 18, 22);
    Line(x + 19, y + 9, x + 19, y + 19, 20);
END G;

PROCEDURE H(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 19; FXs[3] := x + 19; FXs[4] := x;
    FYs[0] := y; FYs[1] := y + 9; FYs[2] := y; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 21);
    FYs[0] := y + 19; FYs[1] := y + 9; FYs[2] := y + 19; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 19);
    Line(x, y, x, y + 9, 20);
    Line(x, y + 9, x, y + 19, 18);
    Line(x, y, x + 9, y + 9, 22);
    Line(x + 9, y + 9, x + 19, y, 22);
    Line(x, y + 19, x + 9, y + 9, 18);
    Line(x + 9, y + 9, x + 19, y + 19, 18);
    Line(x + 19, y, x + 19, y + 9, 22);
    Line(x + 19, y + 9, x + 19, y + 19, 20);
    HLine(x + 1, y + 9, x + 18, 20);
END H;

PROCEDURE I(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 18;
    FYs[0] := y; FYs[1] := y + 9; FYs[2] := y;
    Polygon(3, FXs, FYs, 19);
    FYs[0] := y + 18; FYs[1] := y + 9; FYs[2] := y + 18;
    Polygon(3, FXs, FYs, 21);
    Line(x, y, x + 9, y + 9, 18);
    Line(x + 9, y + 9, x, y + 18, 20);
    Line(x + 18, y, x + 9, y + 9, 18);
    Line(x + 9, y + 9, x + 18, y + 18, 22);
    HLine(x, y, x + 18, 20);
    HLine(x, y + 19, x + 19, 20);
END I;

PROCEDURE J(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x + 19;
    FYs[0] := y; FYs[1] := y; FYs[2] := y + 9;
    Polygon(3, FXs, FYs, 21);
    FXs[0] := x - 1; FXs[1] := x + 19; FXs[2] := x + 9;
    FYs[0] := y + 9; FYs[1] := y + 9; FYs[2] := y + 19;
    Polygon(3, FXs, FYs, 19);
    Line(x - 1, y + 9, x + 9, y + 19, 18);
    Line(x + 9, y + 19, x + 19, y + 9, 18);
    Line(x, y, x + 17, y + 8, 20);
    Line(x + 19, y, x + 19, y + 9, 22);
    HLine(x, y + 9, x + 19, 20);
    Line(x, y, x + 19, y, 22);
END J;

PROCEDURE K(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 5; FXs[2] := x + 18; FXs[3] := x + 9; FXs[4] := x;
    FYs[0] := y; FYs[1] := y + 7; FYs[2] := y; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 21);
    FYs[0] := y + 18; FYs[1] := y + 11; FYs[2] := y + 18; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 19);
    Line(x, y, x, y + 9, 20);
    Line(x, y + 10, x, y + 19, 18);
    Line(x, y + 19, x + 5, y + 11, 18);
    Line(x + 5, y + 11, x + 19, y + 19, 18);
    Line(x + 9, y + 9, x + 19, y + 19, 20);
    Line(x + 9, y + 9, x + 19, y, 20);
    Line(x + 5, y + 7, x + 19, y, 20);
    Line(x, y, x + 5, y + 7, 22);
    HLine(x + 1, y + 9, x + 8, 20);
END K;

PROCEDURE L(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x; FXs[2] := x + 4;
    FYs[0] := y; FYs[1] := y + 19; FYs[2] := y + 14;
    Polygon(3, FXs, FYs, 19);
    FXs[1] := x + 19;
    FYs[0] := y + 19; FYs[1] := y + 19;
    Polygon(3, FXs, FYs, 21);
    Line(x, y, x, y + 19, 18);
    Line(x, y + 19, x + 19, y + 19, 20);
    Line(x, y, x + 4, y + 14, 20);
    Line(x + 4, y + 14, x + 19, y + 19, 22);
    Line(x + 1, y + 18, x + 3, y + 15, 20);
END L;

PROCEDURE M(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x; FXs[2] := x + 4;
    FYs[0] := y; FYs[1] := y + 19; FYs[2] := y + 9;
    Polygon(3, FXs, FYs, 21);
    FXs[0] := x + 19; FXs[1] := x + 19; FXs[2] := x + 14;
    Polygon(3, FXs, FYs, 21);
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 19; FXs[3] := x + 14; FXs[4] := x + 9; FXs[5] := x + 4;
    FYs[0] := y; FYs[1] := y + 9; FYs[2] := y; FYs[3] := y + 9; FYs[4] := y + 14; FYs[5] := y + 9;
    Polygon(6, FXs, FYs, 19);
    Line(x, y, x, y + 19, 20);
    Line(x, y + 19, x + 4, y + 9, 20);
    Line(x + 4, y + 9, x + 9, y + 14, 18);
    Line(x, y, x + 4, y + 9, 20);
    Line(x + 9, y + 14, x + 14, y + 9, 18);
    Line(x + 14, y + 9, x + 19, y, 20);
    Line(x, y, x + 9, y + 9, 20);
    Line(x + 9, y + 9, x + 19, y, 18);
    Line(x + 14, y + 9, x + 19, y + 19, 20);
    Line(x + 19, y, x + 19, y + 19, 22);
END M;

PROCEDURE N(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x; FXs[2] := x + 4;
    FYs[0] := y; FYs[1] := y + 19; FYs[2] := y + 9;
    Polygon(3, FXs, FYs, 19);
    FXs[0] := x + 19; FXs[1] := x + 19; FXs[2] := x + 14;
    Polygon(3, FXs, FYs, 19);
    FXs[0] := x; FXs[1] := x + 13; FXs[2] := x + 19; FXs[3] := x + 4;
    FYs[0] := y; FYs[1] := y + 9; FYs[2] := y + 19; FYs[3] := y + 9;
    Polygon(4, FXs, FYs, 21);
    Line(x, y, x, y + 19, 18);
    Line(x, y, x + 4, y + 9, 20);
    Line(x, y + 19, x + 4, y + 9, 18);
    Line(x + 4, y + 9, x + 19, y + 19, 20);
    Line(x + 13, y + 9, x + 19, y + 19, 20);
    Line(x, y, x + 13, y + 9, 22);
    Line(x + 13, y + 9, x + 19, y, 18);
    Line(x + 19, y, x + 19, y + 19, 20);
END N;

PROCEDURE O (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 18;
    FYs[0] := y + 9; FYs[1] := y; FYs[2] := y + 9;
    Polygon(3, FXs, FYs, 21);
    FYs[1] := y + 18;
    Polygon(3, FXs, FYs, 19);
    Line(x + 9, y, x, y + 9, 20);
    Line(x, y + 10, x + 9, y + 19, 18);
    Line(x + 9, y + 19, x + 18, y + 10, 18);
    Line(x + 9, y, x + 18, y + 9, 22);
    HLine(x + 1, y + 9, x + 18, 20);
END O;

PROCEDURE P(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x + 4; FXs[3] := x;
    FYs[0] := y; FYs[1] := y + 4; FYs[2] := y + 9; FYs[3] := y + 19;
    Polygon(4, FXs, FYs, 21);
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x + 4; FXs[3] := x;
    FYs[0] := y + 4; FYs[1] := y + 4; FYs[2] := y + 9; FYs[3] := y + 9;
    Polygon(4, FXs, FYs, 19);
    Line(x, y, x, y + 19, 20);
    Line(x, y + 4, x, y + 9, 18);
    Line(x + 4, y + 9, x + 19, y + 4, 18);
    Line(x, y + 19, x + 4, y + 9, 20);
    Line(x, y, x + 19, y + 4, 22);
    HLine(x + 1, y + 4, x + 18, 20);
    HLine(x + 1, y + 9, x + 3, 20);
END P;

PROCEDURE Q(x, y : CARDINAL);
BEGIN
    O(x, y);
    FXs[0] := x + 9; FXs[1] := x + 19; FXs[2] := x + 14;
    FYs[0] := y + 9; FYs[1] := y + 14; FYs[2] := y + 19;
    Polygon(3, FXs, FYs, 21);
    Line(x + 9, y + 9, x + 14, y + 19, 20);
    Line(x + 14, y + 19, x + 19, y + 14, 20);
    Line(x + 9, y + 9, x + 19, y + 14, 22);
END Q;

PROCEDURE R(x, y : CARDINAL);
BEGIN
    P (x,y);
    FXs[0] := x + 4; FXs[1] := x + 19; FXs[2] := x + 19;
    FYs[0] := y + 9; FYs[1] := y + 14; FYs[2] := y + 19;
    Polygon(3, FXs, FYs, 21);
    Line(x + 4, y + 9, x + 19, y + 19, 20);
    Line(x + 4, y + 9, x + 19, y + 14, 22);
    Line(x + 19, y + 14, x + 19, y + 19, 22);
END R;

PROCEDURE S(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x + 19;
    FYs[0] := y + 4; FYs[1] := y; FYs[2] := y + 4;
    Polygon(3, FXs, FYs, 21);
    FXs[0] := x; FXs[1] := x + 4; FXs[2] := x + 19; FXs[3] := x + 15;
    FYs[0] := y + 5; FYs[1] := y + 5; FYs[2] := y + 13; FYs[3] := y + 13;
    Polygon(4, FXs, FYs, 19);
    FXs[0] := x; FXs[1] := x; FXs[2] := x + 19;
    FYs[0] := y + 14; FYs[1] := y + 19; FYs[2] := y + 14;
    Polygon(3, FXs, FYs, 21);
    Line(x, y + 5, x + 15, y + 13, 18);
    Line(x + 4, y + 5, x + 19, y + 13, 20);
    Line(x, y + 14, x, y + 19, 20);
    Line(x, y + 19, x + 19, y + 14, 20);
    HLine(x, y + 14, x + 14, 22);    
    Line(x, y + 4, x + 19, y, 20);
    HLine(x, y + 4, x + 19, 20);
    Line(x + 19, y, x + 19, y + 4, 22);
END S;

PROCEDURE T(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 9; FXs[3] := x + 7;
    FYs[0] := y; FYs[1] := y; FYs[2] := y + 19; FYs[3] := y + 4;
    Polygon(4, FXs, FYs, 18);
    FXs[0] := x + 18; FXs[3] := x + 11;
    Polygon(4, FXs, FYs, 21);
    Line(x, y, x + 7, y + 4, 18);
    Line(x + 11, y + 4, x + 19, y, 20);
    HLine(x, y, x + 8, 20);
    HLine(x + 10, y, x + 19, 22);
    Line(x + 9, y, x + 9, y + 19, 20);
END T;

PROCEDURE U(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x; FXs[2] := x + 9;
    FYs[0] := y; FYs[1] := y + 19; FYs[2] := y + 19;
    Polygon(3, FXs, FYs, 19);
    FXs[0] := x + 19; FXs[1] := x + 19;
    Polygon(3, FXs, FYs, 21);
    HLine(x, y + 19, x + 8, 18);
    HLine(x + 10, y + 19, x + 19, 20);
    Line(x, y, x, y + 19, 18);
    Line(x, y, x + 9, y + 19, 20);
    Line(x + 9, y + 19, x + 19, y, 20);
    Line(x + 19, y, x + 19, y + 19, 22);
END U;

PROCEDURE V(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 9;
    FYs[0] := y; FYs[1] := y + 19; FYs[2] := y + 9;
    Polygon(3, FXs, FYs, 19);
    FXs[0] := x + 18;
    Polygon(3, FXs, FYs, 21);
    Line(x, y, x + 9, y + 19, 18);
    Line(x + 9, y + 19, x + 18, y, 20);
    Line(x, y, x + 9, y + 9, 20);
    Line(x + 9, y + 9, x + 18, y, 20);
    Line(x + 9, y + 10, x + 9, y + 18, 20);
END V;

PROCEDURE W(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 18; FXs[3] := x + 17; FXs[4] := x + 1;
    FYs[0] := y; FYs[1] := y + 9; FYs[2] := y; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 21);
    FXs[0] := x + 4; FXs[1] := x + 9; FXs[2] := x + 14; FXs[3] := x + 17; FXs[4] := x + 1;
    FYs[0] := y + 19; FYs[2] := y + 19;
    Polygon(5, FXs, FYs, 19);
    Line(x, y, x + 1, y + 9, 20);
    Line(x + 1, y + 9, x + 4, y + 19, 18);
    Line(x + 4, y + 19, x + 9, y + 9, 18);
    Line(x + 9, y + 9, x + 14, y + 19, 18);
    Line(x + 17, y + 9, x + 18, y, 20);
    Line(x + 14, y + 19, x + 17, y + 9, 18);
    Line(x + 9, y + 9, x + 18, y, 20);
    Line(x, y, x + 8, y + 8, 22);
    HLine(x + 2, y + 9, x + 16, 20);
END W;

PROCEDURE X(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 18; FXs[3] := x + 14; FXs[4] := x + 4;
    FYs[0] := y; FYs[1] := y + 9; FYs[2] := y; FYs[3] := y + 9; FYs[4] := y + 9;
    Polygon(5, FXs, FYs, 21);
    FYs[0] := y + 18; FYs[2] := y + 18;
    Polygon(5, FXs, FYs, 19);
    Line(x, y, x + 4, y + 9, 20);
    Line(x + 4, y + 9, x, y + 18, 18);
    Line(x, y + 18, x + 9, y + 9, 18);
    Line(x + 9, y + 9, x + 18, y + 18, 18);
    Line(x + 18, y + 18, x + 14, y + 9, 20);
    Line(x + 18, y + 18, x + 14, y + 9, 18);
    Line(x, y, x + 9, y + 9, 22);
    Line(x + 9, y + 9, x + 18, y, 20);
    HLine(x + 5, y + 9, x + 13, 20);
END X;

PROCEDURE Y(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 9; FXs[2] := x + 9; FXs[3] := x + 6;
    FYs[0] := y; FYs[1] := y + 4; FYs[2] := y + 19; FYs[3] := y + 4;
    Polygon(4, FXs, FYs, 19);
    FXs[0] := x + 18; FXs[3] := x + 12;
    Polygon(4, FXs, FYs, 21);

    Line(x, y, x + 6, y + 4, 18);
    Line(x, y, x + 9, y + 4, 20);
    Line(x + 6, y + 4, x + 9, y + 19, 18);

    Line(x + 18, y, x + 12, y + 4, 20);
    Line(x + 18, y, x + 9, y + 4, 20);
    Line(x + 12, y + 4, x + 9, y + 19, 20);

    Line(x + 9, y + 5, x + 9, y + 19, 20);
END Y;

PROCEDURE Z(x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x + 19; FXs[2] := x + 9;
    FYs[0] := y; FYs[1] := y; FYs[2] := y + 4;
    Polygon(3, FXs, FYs, 19);
    FYs[0] := y + 19; FYs[1] := y + 19; FYs[2] := y + 14;
    Polygon(3, FXs, FYs, 19);
    FXs[0] := x + 19; FXs[1] := x + 9; FXs[2] := x; FXs[3] := x + 9;
    FYs[0] := y; FYs[1] := y + 4; FYs[2] := y + 19; FYs[3] := y + 14;
    Polygon(4, FXs, FYs, 21);
    Line(x, y, x + 9, y + 4, 18);
    Line(x + 9, y + 4, x, y + 19, 20);
    HLine(x, y + 19, x + 19, 18);
    Line(x + 19, y + 19, x + 9, y + 14, 20);
    Line(x + 1, y + 18, x + 8, y + 15, 20);
    Line(x + 9, y + 14, x + 19, y, 20);
    HLine(x, y, x + 19, 20);
    Line(x + 10, y + 3, x + 18, y + 1, 20);
END Z;

PROCEDURE Num_0(x, y: CARDINAL);
BEGIN
    Rectangle(x + 1, y + 1, x + 6, y + 6, Yellow, FALSE);
    PutPixel(x + 2, y + 5, Yellow);
    PutPixel(x + 3, y + 4, Yellow);
    PutPixel(x + 4, y + 3, Yellow);
    PutPixel(x + 5, y + 2, Yellow);
END Num_0;

PROCEDURE Num_1(x, y: CARDINAL);
BEGIN
    Line(x + 4, y + 1, x + 4, y + 5, Yellow);
    Line(x + 5, y + 1, x + 5, y + 5, Yellow);
    HLine(x + 1, y + 6, x + 6, Yellow);
    PutPixel(x + 3, y + 3, Yellow);
END Num_1;

PROCEDURE Num_2(x, y: CARDINAL);
BEGIN
    HLine(x + 2, y + 1, x + 5, Yellow);
    HLine(x + 1, y + 6, x + 6, Yellow);
    PutPixel(x + 1, y + 2, Yellow);
    PutPixel(x + 6, y + 2, Yellow);
    PutPixel(x + 5, y + 3, Yellow);
    PutPixel(x + 4, y + 3, Yellow);
    PutPixel(x + 3, y + 4, Yellow);
    PutPixel(x + 2, y + 5, Yellow);
END Num_2;

PROCEDURE Num_3(x, y: CARDINAL);
BEGIN
    HLine(x + 2, y + 1, x + 5, Yellow);
    HLine(x + 3, y + 3, x + 5, Yellow);
    HLine(x + 2, y + 6, x + 5, Yellow);
    PutPixel(x + 1, y + 2, Yellow);
    PutPixel(x + 6, y + 2, Yellow);
    PutPixel(x + 6, y + 4, Yellow);
    PutPixel(x + 1, y + 5, Yellow);
    PutPixel(x + 6, y + 5, Yellow);
END Num_3;

PROCEDURE Num_4(x, y: CARDINAL);
BEGIN
    Line(x + 5, y + 1, x + 5, y + 6, Yellow);
    HLine(x + 1, y + 5, x + 6, Yellow);
    PutPixel(x + 4, y + 2, Yellow);
    PutPixel(x + 3, y + 3, Yellow);
    PutPixel(x + 2, y + 4, Yellow);
END Num_4;

PROCEDURE Num_5(x, y: CARDINAL);
BEGIN
    HLine(x + 1, y + 1, x + 6, Yellow);
    HLine(x + 1, y + 3, x + 5, Yellow);
    HLine(x + 2, y + 6, x + 5, Yellow);
    PutPixel(x + 1, y + 2, Yellow);
    PutPixel(x + 6, y + 4, Yellow);
    PutPixel(x + 6, y + 5, Yellow);
    PutPixel(x + 1, y + 5, Yellow);
END Num_5;

PROCEDURE Num_6(x, y: CARDINAL);
BEGIN
    HLine(x + 2, y + 1, x + 6, Yellow);
    HLine(x + 2, y + 3, x + 5, Yellow);
    HLine(x + 2, y + 6, x + 5, Yellow);
    Line(x + 1, y + 2, x + 1, y + 5, Yellow);
    PutPixel(x + 6, y + 4, Yellow);
    PutPixel(x + 6, y + 5, Yellow);
END Num_6;

PROCEDURE Num_7(x, y: CARDINAL);
BEGIN
    HLine(x + 1, y + 1, x + 6, Yellow);
    Line(x + 5, y + 2, x + 1, y + 6, Yellow);
    Line(x + 6, y + 2, x + 2, y + 6, Yellow);
END Num_7;

PROCEDURE Num_8(x, y: CARDINAL);
BEGIN
    HLine(x + 2, y + 1, x + 5, Yellow);
    HLine(x + 2, y + 3, x + 5, Yellow);
    HLine(x + 2, y + 6, x + 5, Yellow);
    PutPixel(x + 1, y + 2, Yellow);
    PutPixel(x + 6, y + 2, Yellow);
    PutPixel(x + 1, y + 4, Yellow);
    PutPixel(x + 6, y + 4, Yellow);
    PutPixel(x + 1, y + 5, Yellow);
    PutPixel(x + 6, y + 5, Yellow);
END Num_8;

PROCEDURE Num_9(x, y: CARDINAL);
BEGIN
    HLine(x + 2, y + 1, x + 5, Yellow);
    HLine(x + 2, y + 3, x + 5, Yellow);
    HLine(x + 1, y + 6, x + 5, Yellow);
    PutPixel(x + 1, y + 2, Yellow);
    PutPixel(x + 6, y + 2, Yellow);
    Line(x + 6, y + 2, x + 6, y + 5, Yellow);
END Num_9;

END Font.
