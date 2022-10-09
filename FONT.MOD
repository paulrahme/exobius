IMPLEMENTATION MODULE Font;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Graph, Exobius;
FROM Graph IMPORT Polygon, Line;
FROM Exobius IMPORT Xs, Ys, Grey, LightGrey;

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
    Polygon(3, Xs, Ys, LightGrey);
    Ys[0] := y+19;
    Polygon(3, Xs, Ys, Grey);
END D;

PROCEDURE E (x, y : CARDINAL);
BEGIN
    Xs [0] := x; Xs[1] := x+19; Xs[2] := x+9; Xs[3] := x+19; Xs[4] := x;
    Ys [0] := y; Ys[1] := y+3; Ys[2] := y+6; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, LightGrey);
    Ys [0] := y+19; Ys[1] := y+17; Ys[2] := y+13; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, Grey);
END E;

PROCEDURE F (x, y : CARDINAL);
BEGIN
    Xs [0] := x; Xs[1] := x+19; Xs[2] := x+9; Xs[3] := x+19; Xs[4] := x;
    Ys [0] := y; Ys[1] := y+3; Ys[2] := y+6; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, LightGrey);
    Xs [0] := x; Xs[1] := x+19; Xs[2] := x+9; Xs[3] := x;
    Ys [0] := y+9; Ys[1] := y+9; Ys[2] := y+13; Ys[3] := y+19;
    Polygon(4, Xs, Ys, Grey);
END F;

PROCEDURE G (x, y : CARDINAL);
BEGIN
    C (x,y);
    Xs[0] := x+9; Xs[1] := x+19; Xs[2] := x+19;
    Ys[0] := y+9; Ys[1] := y+9; Ys[2] := y+19;
    Polygon(3, Xs, Ys, LightGrey);
END G;

PROCEDURE H (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+19; Xs[4] := x;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, LightGrey);
    Ys[0] := y+19; Ys[1] := y+9; Ys[2] := y+19; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, Grey);
END H;

PROCEDURE I (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y;
    Polygon(3, Xs, Ys, Grey);
    Ys[0] := y+19; Ys[1] := y+9; Ys[2] := y+19;
    Polygon(3, Xs, Ys, LightGrey);
END I;

PROCEDURE J (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+19;
    Ys[0] := y; Ys[1] := y; Ys[2] := y+9;
    Polygon(3, Xs, Ys, LightGrey);
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+9;
    Ys[0] := y+9; Ys[1] := y+9; Ys[2] := y+19;
    Polygon(3, Xs, Ys, Grey);
END J;

PROCEDURE K (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+14; Xs[4] := x;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, LightGrey);
    Ys[0] := y+19; Ys[1] := y+9; Ys[2] := y+19; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, Grey);
    Line (x+13, y+9, x+18, y+18, Grey);
END K;

PROCEDURE L (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x; Xs[2] := x+4;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+14;
    Polygon(3, Xs, Ys, Grey);
    Xs[1] := x+19;
    Ys[0] := y+19; Ys[1] := y+19;
    Polygon(3, Xs, Ys, LightGrey);
END L;

PROCEDURE M (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x; Xs[2] := x+4;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+9;
    Polygon(3, Xs, Ys, LightGrey);
    Xs[0] := x+19; Xs[1] := x+19; Xs[2] := x+14;
    Polygon(3, Xs, Ys, LightGrey);
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+14; Xs[4] := x+9; Xs[5] := x+4;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+14; Ys[5] := y+9;
    Polygon(6, Xs, Ys, Grey);
END M;

PROCEDURE N (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x; Xs[2] := x+4;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+9;
    Polygon(3, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[1] := x+19; Xs[2] := x+14;
    Polygon(3, Xs, Ys, Grey);
    Xs[0] := x; Xs[1] := x+13; Xs[2] := x+19; Xs[3] := x+4;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y+19; Ys[3] := y+9;
    Polygon(4, Xs, Ys, LightGrey);
END N;

PROCEDURE O (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19;
    Ys[0] := y+9; Ys[1] := y; Ys[2] := y+9;
    Polygon(3, Xs, Ys, LightGrey);
    Ys[1] := y+19;
    Polygon(3, Xs, Ys, Grey);
END O;

PROCEDURE P (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+4; Xs[3] := x;
    Ys[0] := y; Ys[1] := y+4; Ys[2] := y+9; Ys[3] := y+19;
    Polygon(4, Xs, Ys, LightGrey);
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+4; Xs[3] := x;
    Ys[0] := y+4;Ys[1] := y+4; Ys[2] := y+9; Ys[3] := y+9;
    Polygon(4, Xs, Ys, Grey);
END P;

PROCEDURE Q (x, y : CARDINAL);
BEGIN
    O (x,y);
    Xs[0] := x+9; Xs[1] := x+19; Xs[2] := x+14;
    Ys[0] := y+9; Ys[1] := y+14; Ys[2] := y+19;
    Polygon(3, Xs, Ys, LightGrey);
END Q;

PROCEDURE R (x, y : CARDINAL);
BEGIN
    P (x,y);
    Xs[0] := x+4; Xs[1] := x+19; Xs[2] := x+19;
    Ys[0] := y+9; Ys[1] := y+14; Ys[2] := y+19;
    Polygon(3, Xs, Ys, LightGrey);
END R;

PROCEDURE S (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+19;
    Ys[0] := y+4; Ys[1] := y; Ys[2] := y+4;
    Polygon(3, Xs, Ys, LightGrey);
    Line (x, y+4, x+19, y+14, Grey);
    Xs[0] := x; Xs[1] := x; Xs[2] := x+19;
    Ys[0] := y+14; Ys[1] := y+19; Ys[2] := y+14;
    Polygon(3, Xs, Ys, LightGrey);
END S;

PROCEDURE T (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+9;Xs[3] := x+7;
    Ys[0] := y; Ys[1] := y; Ys[2] := y+19; Ys[3] := y+4;
    Polygon(4, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[3] := x+13;
    Polygon(4, Xs, Ys, LightGrey);
END T;

PROCEDURE U (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x; Xs[2] := x+9;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+19;
    Polygon(3, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[1] := x+19;
    Polygon(3, Xs, Ys, LightGrey);
END U;

PROCEDURE V (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+9;
    Ys[0] := y; Ys[1] := y+19; Ys[2] := y+9;
    Polygon(3, Xs, Ys, Grey);
    Xs[0] := x+19;
    Polygon(3, Xs, Ys, LightGrey);
END V;

PROCEDURE W (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+18; Xs[4] := x+1;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, LightGrey);
    Xs[0] := x+4; Xs[1] := x+9; Xs[2] := x+14; Xs[3] := x+18; Xs[4] := x+1;
    Ys[0] := y+19; Ys[2] := y+19;
    Polygon(5, Xs, Ys, Grey);
END W;

PROCEDURE X (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+19; Xs[3] := x+14; Xs[4] := x+4;
    Ys[0] := y; Ys[1] := y+9; Ys[2] := y; Ys[3] := y+9; Ys[4] := y+9;
    Polygon(5, Xs, Ys, LightGrey);
    Ys[0] := y+19; Ys[2] := y+19;
    Polygon(5, Xs, Ys, Grey);
    Line(x+13, y+9, x+19, y+19, Grey);
END X;

PROCEDURE Y (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+9; Xs[2] := x+9;Xs[3] := x+7;
    Ys[0] := y; Ys[1] := y+4; Ys[2] := y+19; Ys[3] := y+4;
    Polygon(4, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[3] := x+13;
    Polygon(4, Xs, Ys, LightGrey);
END Y;

PROCEDURE Z (x, y : CARDINAL);
BEGIN
    Xs[0] := x; Xs[1] := x+19; Xs[2] := x+9;
    Ys[0] := y; Ys[1] := y; Ys[2] := y+4;
    Polygon(3, Xs, Ys, Grey);
    Ys[0] := y+19; Ys[1] := y+19; Ys[2] := y+14;
    Polygon(3, Xs, Ys, Grey);
    Xs[0] := x+19; Xs[1] := x+9; Xs[2] := x; Xs[3] := x+9;
    Ys[0] := y; Ys[1] := y+4; Ys[2] := y+19; Ys[3] := y+14;
    Polygon(4, Xs, Ys, LightGrey);
END Z;

END Font.