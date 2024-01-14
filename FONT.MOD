IMPLEMENTATION MODULE Font;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Exobius;
FROM Graph IMPORT Polygon, Line;
FROM Exobius IMPORT Grey, LightGrey;

VAR
    FXs, FYs : ARRAY[0..5] OF CARDINAL;

PROCEDURE A (x, y : CARDINAL);
BEGIN
    FXs[0] := x+9; FXs[1] := x; FXs[2] := x+9; FXs[3] := x+19;
    FYs[0] := y; FYs[1] := y+19; FYs[2] := y+8; FYs[3] := y+19;
    Polygon(4, FXs, FYs, LightGrey);
    FYs[0] := y+9; FYs[1] := y+19; FYs[2] := y+12; FYs[3] := y+19;
    Polygon(4,FXs, FYs, Grey);
END A;

PROCEDURE B (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+19; FXs[2] := x+9; FXs[3] := x;
    FYs[0] := y; FYs[1] := y+4; FYs[2] := y+9; FYs[3] := y+9;
    Polygon(4,FXs, FYs, LightGrey);
    FYs[0] := y+19; FYs[1] := y+14; FYs[2] := y+9; FYs[3] := y+9;
    Polygon(4,FXs, FYs, Grey);
END B;

PROCEDURE C (x, y : CARDINAL);
BEGIN
    FXs[0] := x+19; FXs[1] := x+9; FXs[2] := x;
    FYs[0] := y; FYs[1] := y+9; FYs [2] := y+9;
    Polygon(3,FXs, FYs, LightGrey);
    FYs[0] := y+19;
    Polygon(3, FXs, FYs, Grey);
END C;

PROCEDURE D (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+19; FXs[2] := x;
    FYs[0] := y; FYs[1] := y+9; FYs[2] := y+9;
    Polygon(3, FXs, FYs, LightGrey);
    FYs[0] := y+19;
    Polygon(3, FXs, FYs, Grey);
END D;

PROCEDURE E (x, y : CARDINAL);
BEGIN
    FXs [0] := x; FXs[1] := x+19; FXs[2] := x+9; FXs[3] := x+19; FXs[4] := x;
    FYs [0] := y; FYs[1] := y+3; FYs[2] := y+6; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, LightGrey);
    FYs [0] := y+19; FYs[1] := y+17; FYs[2] := y+13; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, Grey);
END E;

PROCEDURE F (x, y : CARDINAL);
BEGIN
    FXs [0] := x; FXs[1] := x+19; FXs[2] := x+9; FXs[3] := x+19; FXs[4] := x;
    FYs [0] := y; FYs[1] := y+3; FYs[2] := y+6; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, LightGrey);
    FXs [0] := x; FXs[1] := x+19; FXs[2] := x+9; FXs[3] := x;
    FYs [0] := y+9; FYs[1] := y+9; FYs[2] := y+13; FYs[3] := y+19;
    Polygon(4, FXs, FYs, Grey);
END F;

PROCEDURE G (x, y : CARDINAL);
BEGIN
    C (x,y);
    FXs[0] := x+9; FXs[1] := x+19; FXs[2] := x+19;
    FYs[0] := y+9; FYs[1] := y+9; FYs[2] := y+19;
    Polygon(3, FXs, FYs, LightGrey);
END G;

PROCEDURE H (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+19; FXs[3] := x+19; FXs[4] := x;
    FYs[0] := y; FYs[1] := y+9; FYs[2] := y; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, LightGrey);
    FYs[0] := y+19; FYs[1] := y+9; FYs[2] := y+19; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, Grey);
END H;

PROCEDURE I (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+19;
    FYs[0] := y; FYs[1] := y+9; FYs[2] := y;
    Polygon(3, FXs, FYs, Grey);
    FYs[0] := y+19; FYs[1] := y+9; FYs[2] := y+19;
    Polygon(3, FXs, FYs, LightGrey);
END I;

PROCEDURE J (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+19; FXs[2] := x+19;
    FYs[0] := y; FYs[1] := y; FYs[2] := y+9;
    Polygon(3, FXs, FYs, LightGrey);
    FXs[0] := x; FXs[1] := x+19; FXs[2] := x+9;
    FYs[0] := y+9; FYs[1] := y+9; FYs[2] := y+19;
    Polygon(3, FXs, FYs, Grey);
END J;

PROCEDURE K (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+19; FXs[3] := x+14; FXs[4] := x;
    FYs[0] := y; FYs[1] := y+9; FYs[2] := y; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, LightGrey);
    FYs[0] := y+19; FYs[1] := y+9; FYs[2] := y+19; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, Grey);
    Line (x+13, y+9, x+18, y+18, Grey);
END K;

PROCEDURE L (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x; FXs[2] := x+4;
    FYs[0] := y; FYs[1] := y+19; FYs[2] := y+14;
    Polygon(3, FXs, FYs, Grey);
    FXs[1] := x+19;
    FYs[0] := y+19; FYs[1] := y+19;
    Polygon(3, FXs, FYs, LightGrey);
END L;

PROCEDURE M (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x; FXs[2] := x+4;
    FYs[0] := y; FYs[1] := y+19; FYs[2] := y+9;
    Polygon(3, FXs, FYs, LightGrey);
    FXs[0] := x+19; FXs[1] := x+19; FXs[2] := x+14;
    Polygon(3, FXs, FYs, LightGrey);
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+19; FXs[3] := x+14; FXs[4] := x+9; FXs[5] := x+4;
    FYs[0] := y; FYs[1] := y+9; FYs[2] := y; FYs[3] := y+9; FYs[4] := y+14; FYs[5] := y+9;
    Polygon(6, FXs, FYs, Grey);
END M;

PROCEDURE N (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x; FXs[2] := x+4;
    FYs[0] := y; FYs[1] := y+19; FYs[2] := y+9;
    Polygon(3, FXs, FYs, Grey);
    FXs[0] := x+19; FXs[1] := x+19; FXs[2] := x+14;
    Polygon(3, FXs, FYs, Grey);
    FXs[0] := x; FXs[1] := x+13; FXs[2] := x+19; FXs[3] := x+4;
    FYs[0] := y; FYs[1] := y+9; FYs[2] := y+19; FYs[3] := y+9;
    Polygon(4, FXs, FYs, LightGrey);
END N;

PROCEDURE O (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+19;
    FYs[0] := y+9; FYs[1] := y; FYs[2] := y+9;
    Polygon(3, FXs, FYs, LightGrey);
    FYs[1] := y+19;
    Polygon(3, FXs, FYs, Grey);
END O;

PROCEDURE P (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+19; FXs[2] := x+4; FXs[3] := x;
    FYs[0] := y; FYs[1] := y+4; FYs[2] := y+9; FYs[3] := y+19;
    Polygon(4, FXs, FYs, LightGrey);
    FXs[0] := x; FXs[1] := x+19; FXs[2] := x+4; FXs[3] := x;
    FYs[0] := y+4;FYs[1] := y+4; FYs[2] := y+9; FYs[3] := y+9;
    Polygon(4, FXs, FYs, Grey);
END P;

PROCEDURE Q (x, y : CARDINAL);
BEGIN
    O (x,y);
    FXs[0] := x+9; FXs[1] := x+19; FXs[2] := x+14;
    FYs[0] := y+9; FYs[1] := y+14; FYs[2] := y+19;
    Polygon(3, FXs, FYs, LightGrey);
END Q;

PROCEDURE R (x, y : CARDINAL);
BEGIN
    P (x,y);
    FXs[0] := x+4; FXs[1] := x+19; FXs[2] := x+19;
    FYs[0] := y+9; FYs[1] := y+14; FYs[2] := y+19;
    Polygon(3, FXs, FYs, LightGrey);
END R;

PROCEDURE S (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+19; FXs[2] := x+19;
    FYs[0] := y+4; FYs[1] := y; FYs[2] := y+4;
    Polygon(3, FXs, FYs, LightGrey);
    Line (x, y+4, x+19, y+14, Grey);
    FXs[0] := x; FXs[1] := x; FXs[2] := x+19;
    FYs[0] := y+14; FYs[1] := y+19; FYs[2] := y+14;
    Polygon(3, FXs, FYs, LightGrey);
END S;

PROCEDURE T (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+9;FXs[3] := x+7;
    FYs[0] := y; FYs[1] := y; FYs[2] := y+19; FYs[3] := y+4;
    Polygon(4, FXs, FYs, Grey);
    FXs[0] := x+19; FXs[3] := x+13;
    Polygon(4, FXs, FYs, LightGrey);
END T;

PROCEDURE U (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x; FXs[2] := x+9;
    FYs[0] := y; FYs[1] := y+19; FYs[2] := y+19;
    Polygon(3, FXs, FYs, Grey);
    FXs[0] := x+19; FXs[1] := x+19;
    Polygon(3, FXs, FYs, LightGrey);
END U;

PROCEDURE V (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+9;
    FYs[0] := y; FYs[1] := y+19; FYs[2] := y+9;
    Polygon(3, FXs, FYs, Grey);
    FXs[0] := x+19;
    Polygon(3, FXs, FYs, LightGrey);
END V;

PROCEDURE W (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+19; FXs[3] := x+18; FXs[4] := x+1;
    FYs[0] := y; FYs[1] := y+9; FYs[2] := y; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, LightGrey);
    FXs[0] := x+4; FXs[1] := x+9; FXs[2] := x+14; FXs[3] := x+18; FXs[4] := x+1;
    FYs[0] := y+19; FYs[2] := y+19;
    Polygon(5, FXs, FYs, Grey);
END W;

PROCEDURE X (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+19; FXs[3] := x+14; FXs[4] := x+4;
    FYs[0] := y; FYs[1] := y+9; FYs[2] := y; FYs[3] := y+9; FYs[4] := y+9;
    Polygon(5, FXs, FYs, LightGrey);
    FYs[0] := y+19; FYs[2] := y+19;
    Polygon(5, FXs, FYs, Grey);
    Line(x+13, y+9, x+19, y+19, Grey);
END X;

PROCEDURE Y (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+9; FXs[2] := x+9;FXs[3] := x+7;
    FYs[0] := y; FYs[1] := y+4; FYs[2] := y+19; FYs[3] := y+4;
    Polygon(4, FXs, FYs, Grey);
    FXs[0] := x+19; FXs[3] := x+13;
    Polygon(4, FXs, FYs, LightGrey);
END Y;

PROCEDURE Z (x, y : CARDINAL);
BEGIN
    FXs[0] := x; FXs[1] := x+19; FXs[2] := x+9;
    FYs[0] := y; FYs[1] := y; FYs[2] := y+4;
    Polygon(3, FXs, FYs, Grey);
    FYs[0] := y+19; FYs[1] := y+19; FYs[2] := y+14;
    Polygon(3, FXs, FYs, Grey);
    FXs[0] := x+19; FXs[1] := x+9; FXs[2] := x; FXs[3] := x+9;
    FYs[0] := y; FYs[1] := y+4; FYs[2] := y+19; FYs[3] := y+14;
    Polygon(4, FXs, FYs, LightGrey);
END Z;

END Font.