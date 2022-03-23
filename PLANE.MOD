MODULE Plane;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)
IMPORT
  Graph;
FROM Graph IMPORT
  Polygon, Line, HLine, Circle, Ellipse, Disc;
PROCEDURE DrawPlane (x, y, Width, Height : CARDINAL);
VAR
  Xs, Ys : ARRAY [0..6] OF CARDINAL;
  PlaneCount : CARDINAL;
BEGIN
  Xs[0] := x; Xs[1] := x+(Width DIV 4); Xs[2] := x+(Width DIV 3); Xs[3] := x+(Width*2 DIV 5);
  Xs[4] := x+(Width DIV 2); Xs[5] := x+(Width DIV 2); Xs[6] := x+(Width DIV 4);
  Ys[0] := y+Height; Ys[1] := y+(Height DIV 3); Ys[2] := y+(Height DIV 2); Ys[3] := y+(Height DIV 5);
  Ys[4] := y; Ys[5] := y+(Height*4 DIV 5); Ys[6] := y+(Height*13 DIV 15);
  Polygon (7, Xs, Ys, Blue);
  FOR PlaneCount := 0 TO 6 DO
     Xs[PlaneCount] := (x + Width) - (Xs[PlaneCount] - x);
  END;
  Polygon (7, Xs, Ys, LightestBlue);
  Line (x + (Width*5 DIV 15), y + (Height*2 DIV 5), x + (Width DIV 4), y + (Height*4 DIV 5), DarkBlue);
  Line (x + (Width DIV 4), y + (Height DIV 3), x + (Width*3 DIV 16), y + (Height*4 DIV 5), Blue);
  Line (x + (Width*9 DIV 32), y + (Height DIV 3), x + (Width DIV 4), y + (Height*4 DIV 5), LightBlue);
  Line (x + (Width*5 DIV 16), y + (Height*2 DIV 5), x + (Width*5 DIV 16), y + (Height*4 DIV 5), LightestBlue);
  Ellipse (x + (Width*1 DIV 4), y + (Height*4 DIV 5), (Height DIV 5), (Width DIV 16), LightestWhite, TRUE);
  Line (x + (Width*21 DIV 32), y + (Height*2 DIV 5), x + (Width*21 DIV 32), y + (Height*4 DIV 5), DarkBlue);
  Line (x + (Width*11 DIV 16), y + (Height DIV 3), x + (Width*23 DIV 32), y + (Height*4 DIV 5), Blue);
  Line (x + (Width*23 DIV 32), y + (Height DIV 3), x + (Width*25 DIV 32), y + (Height*4 DIV 5), LightBlue);
  Line (x + (Width*3 DIV 4), y + (Height*2 DIV 5), x + (Width*27 DIV 32), y + (Height*4 DIV 5), LightestBlue);
  Ellipse (x + (Width*23 DIV 32), y + (Height*4 DIV 5), (Height DIV 5), (Width DIV 16), LightestWhite, TRUE);
End DrawPlane;

BEGIN
VAR
  Count : CARDINAL;
BEGIN
    Graph.InitVGA;
    Graph.GraphMode;
    DrawPlane (0, 0, 50, 25);
END Plane.
