MODULE VgaClr;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)
IMPORT
  Graph, IO, Lib;
FROM Graph IMPORT
  Rectangle;
VAR
  RectX, RectY, Colour : CARDINAL;
  OldVideoMode : BOOLEAN;
  Key : CHAR;


PROCEDURE Blocks;
BEGIN
  FOR RectX := 0 TO 290 BY 15 DO
     Rectangle (RectX, RectY, RectX+10, RectY+10, Colour, TRUE);
     Colour := Colour + 1;
  END;
END Blocks;

BEGIN
  Graph.InitVGA;
  OldVideoMode := Graph.SetVideoMode(Graph._MRES256COLOR);
  Colour := 0;
  FOR RectY := 0 TO 210 BY 15 DO
     Blocks;
  END;
  Key := IO.RdKey();
END VgaClr.
