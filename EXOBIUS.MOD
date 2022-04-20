IMPLEMENTATION MODULE Exobius;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

PROCEDURE VgaInitialisation;
BEGIN
  Graph.SetFillMask (SolidFill);
END VgaInitialisation;

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
  E (x,y);
  Rectangle (x, y+13, x+19, y+19, Black, TRUE);
  Xs[0] := x; Xs[1] := x; Xs[2] := x+9;
  Ys[0] := y+13; Ys[1] := y+19; Ys[2] := y+13;
  Polygon (3, Xs, Ys, LightGrey);
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

(* Scrap From "Congrats.mod" *)

PROCEDURE DrawPlane (x, y, PlaneWidth, PlaneHeight : CARDINAL);
VAR
  Xs, Ys : ARRAY [0..6] OF CARDINAL;
  PlaneCount : CARDINAL;
BEGIN
     Xs[0] := x; Xs[1] := x+(PlaneWidth DIV 4); Xs[2] := x+(PlaneWidth DIV 3); Xs[3] := x+(PlaneWidth*2 DIV 5);
     Xs[4] := x+(PlaneWidth DIV 2); Xs[5] := x+(PlaneWidth DIV 2); Xs[6] := x+(PlaneWidth DIV 4);
     Ys[0] := y+PlaneHeight; Ys[1] := y+(PlaneHeight DIV 3); Ys[2] := y+(PlaneHeight DIV 2); Ys[3] := y+(PlaneHeight DIV 5);
     Ys[4] := y; Ys[5] := y+(PlaneHeight*4 DIV 5); Ys[6] := y+(PlaneHeight*13 DIV 15);
     Polygon (7, Xs, Ys, Blue);
     FOR PlaneCount := 0 TO 6 DO
        Xs[PlaneCount] := (x + PlaneWidth) - (Xs[PlaneCount] - x);
     END;
     Polygon (7, Xs, Ys, LightestBlue);
     Line (x + (PlaneWidth DIV 3), y + (PlaneHeight*2 DIV 5), x + (PlaneWidth DIV 4), y + (PlaneHeight*4 DIV 5), LightGrey);
     Line (x + (PlaneWidth* 6 DIV 20), y + (PlaneHeight*2 DIV 5), x + (PlaneWidth*3 DIV 8), y + (PlaneHeight*4 DIV 5), DarkestWhite);
     Line (x + (PlaneWidth*5 DIV 20), y + (PlaneHeight DIV 3), x + (PlaneWidth*1 DIV 8), y + (PlaneHeight*4 DIV 5), DarkestGrey);
     Line (x + (PlaneWidth DIV 4), y + (PlaneHeight DIV 3), x + (PlaneWidth*3 DIV 16), y + (PlaneHeight*4 DIV 5), DarkGrey);
     Line (x + (PlaneWidth*9 DIV 32), y + (PlaneHeight DIV 3), x + (PlaneWidth DIV 4), y + (PlaneHeight*4 DIV 5), Grey);
     Line (x + (PlaneWidth*5 DIV 16), y + (PlaneHeight*2 DIV 5), x + (PlaneWidth*5 DIV 16), y + (PlaneHeight*4 DIV 5), LightestGrey);
     Ellipse (x + (PlaneWidth*1 DIV 4), y + (PlaneHeight*4 DIV 5), (PlaneHeight DIV 5), (PlaneWidth DIV 16), LightestWhite, TRUE);
     Line (x + (PlaneWidth*21 DIV 32), y + (PlaneHeight*2 DIV 5), x + (PlaneWidth*21 DIV 32), y + (PlaneHeight*4 DIV 5), DarkestGrey);
     Line (x + (PlaneWidth*23 DIV 32), y + (PlaneHeight*2 DIV 5), x + (PlaneWidth*23 DIV 32), y + (PlaneHeight*4 DIV 5), DarkestGrey);
     Line (x + (PlaneWidth*23 DIV 32), y + (PlaneHeight DIV 3), x + (PlaneWidth*25 DIV 32), y + (PlaneHeight*4 DIV 5), LightGrey);
     Line (x + (PlaneWidth*3 DIV 4), y + (PlaneHeight*2 DIV 5), x + (PlaneWidth*27 DIV 32), y + (PlaneHeight*4 DIV 5), LightestGrey);
     Ellipse (x + (PlaneWidth*23 DIV 32), y + (PlaneHeight*4 DIV 5), (PlaneHeight DIV 5), (PlaneWidth DIV 16), LightestWhite, TRUE);
     Line (x + (PlaneWidth DIV 2), y, x + (PlaneWidth DIV 2), y + (PlaneHeight * 4 DIV 5), LightestWhite);
END DrawPlane;

(* PlaneToPlanet *)

PROCEDURE CheckSpecialKeys;
VAR
  TextPos : Graph.TextCoords;
BEGIN
  Key := IO.RdKey();
  IF (Key="q") OR (Key="Q") THEN
     GameOver := TRUE;
  END;
  IF (Key="p") OR (Key="P") THEN
     TextPos := Graph.SetTextPosition(25, 33);
     Graph.OutText('PAUSED');
     Key := IO.RdKey();
     Rectangle (250, 190, 320, 200, Black, TRUE);
  END;
  IF (Key="d") OR (Key="D") THEN
     HighDetail := NOT (HighDetail);
  END;
END CheckSpecialKeys;

PROCEDURE CheckMouseAndSpecialKeys;
BEGIN
   IF MouseUsed THEN
      MsMouse.GetStatus(MouseButtons);
      MsMouse.GetMotion(MouseMove);
   END;
   IF (IO.KeyPressed()) THEN
      CheckSpecialKeys();
   END;
END CheckMouseAndSpecialKeys;

PROCEDURE CheckMouse;
BEGIN
   IF MouseUsed THEN
      CheckMouseAndSpecialKeys();
      IF (MouseButtons.left_pressed) OR (MouseButtons.right_pressed) OR (MouseButtons.middle_pressed) THEN
         BulletX := PlaneX + 25;
         BulletY := 5;
      END;
      IF (MouseMove.horiz <> 0) AND (PlaneX + MouseMove.horiz >= 0) THEN
         INC (PlaneX, MouseMove.horiz DIV PlaneMovement);
      END;
      IF (PlaneX + MouseMove.horiz < 0) THEN
         PlaneX := 0;
      END;
      IF (PlaneX < PlaneXMin) THEN
         PlaneX := PlaneXMin;
      END;
      IF (PlaneX > PlaneXMax) THEN
         PlaneX := PlaneXMax;
      END;
   END;
END CheckMouse;

PROCEDURE CheckKeyboard;
VAR
  TextPos : Graph.TextCoords;
BEGIN
  IF ( IO.KeyPressed() ) THEN
     Key := IO.RdKey();
     IF (Key=" ") AND ((BulletY=0) OR (BulletY>5)) THEN
        BulletY := 5;
        BulletX := PlaneX + 25;
     END;
     IF (Key="4") THEN
        PlaneX := PlaneX -  PlaneXMove;
     END;
     IF (Key="6") THEN
        PlaneX := PlaneX + PlaneXMove;
     END;
     IF (Key="7") THEN
        PlaneX := PlaneXMin;
     END;
     IF (Key="9") THEN
        PlaneX := PlaneXMax;
     END;
     IF (PlaneX < PlaneXMin) THEN
        PlaneX := PlaneXMin;
     END;
     IF (PlaneX > PlaneXMax) THEN
        PlaneX := PlaneXMax;
     END;
     CheckSpecialKeys();
  END;
END CheckKeyboard;

PROCEDURE BlowUpEnemy;
CONST
  SoundDelay = 30;
BEGIN;
  IF (BulletX<=50) AND (OneAlive) THEN
     Sound (30);
     Disc (Enemy1X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 6, LightRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (25);
     Disc (Enemy1X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 8, LightestRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (21);
     Disc (Enemy1X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 10, DarkestYellow);
     Lib.Delay (SoundDelay);
     NoSound;
     OneAlive := FALSE;
  END;
  IF (BulletX>=55) AND (BulletX<=100) AND (TwoAlive) THEN
     Sound (30);
     Disc (Enemy2X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 6, LightRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (25);
     Disc (Enemy2X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 8, LightestRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (21);
     Disc (Enemy2X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 10, DarkestYellow);
     Lib.Delay (SoundDelay);
     NoSound;
     TwoAlive := FALSE;
  END;
  IF (BulletX>=100) AND (BulletX<=160) AND (ThreeAlive) THEN
     Sound (30);
     Disc (Enemy3X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 6, LightRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (25);
     Disc (Enemy3X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 8, LightestRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (21);
     Disc (Enemy3X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 10, DarkestYellow);
     Lib.Delay (SoundDelay);
     NoSound;
     ThreeAlive := FALSE;
  END;
  IF (BulletX>=160) AND (BulletX<=210) AND (FourAlive) THEN
     Sound (30);
     Disc (Enemy4X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 6, LightRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (25);
     Disc (Enemy4X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 8, LightestRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (21);
     Disc (Enemy4X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 10, DarkestYellow);
     Lib.Delay (SoundDelay);
     NoSound;
     FourAlive := FALSE;
  END;
  IF (BulletX>=210) AND (BulletX<=260) AND (FiveAlive) THEN
     Sound (30);
     Disc (Enemy5X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 6, LightRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (25);
     Disc (Enemy5X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 8, LightestRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (21);
     Disc (Enemy5X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 10, DarkestYellow);
     Lib.Delay (SoundDelay);
     NoSound;
     FiveAlive := FALSE;
  END;
  IF (BulletX>=260) AND (SixAlive) THEN
     Sound (30);
     Disc (Enemy6X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 6, LightRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (25);
     Disc (Enemy6X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 8, LightestRed);
     Lib.Delay (SoundDelay);
     NoSound;
     Sound (21);
     Disc (Enemy6X + (EnemyY-100) DIV 3, EnemyY + (EnemyY -100) DIV 3, (EnemyY -100) DIV 10, DarkestYellow);
     Lib.Delay (SoundDelay);
     NoSound;
     SixAlive := FALSE;
  END;
  Score := Score + 10;
END BlowUpEnemy;

PROCEDURE DrawBullet;
VAR
  NewBulletX : CARDINAL;
  Dist : INTEGER;
BEGIN
  CASE BulletY OF
     |5 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*70) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*70) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 170, 4, LightestYellow);
          IF (EnemyY >= 158) THEN
             BlowUpEnemy;
          END;
     |4 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*45) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*45) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 145, 3, LightYellow);
          IF (EnemyY >= 132) THEN
             BlowUpEnemy;
          END;
     |3 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*20) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*20) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 120, 2, Yellow);
          IF (EnemyY >= 113) THEN
             BlowUpEnemy;
          END;
     |2 : IF (BulletX >= 160) THEN
             Dist := (10 + ((3*5) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*5) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 105, 1, DarkYellow);
          IF (EnemyY >= 103) THEN
             BlowUpEnemy;
          END;
     |1 :
          IF (BulletX >= 160) THEN
             Dist := (10 + ((3*1) DIV 2))*(BulletX-160) DIV 160;
             NewBulletX := 160 + Dist;
          ELSIF (BulletX < 160) THEN
             Dist := (10 + ((3*1) DIV 2))*(160-BulletX) DIV 160;
             NewBulletX := 160 - Dist;
          END;
          Disc (NewBulletX, 101, 1, DarkestYellow);
          IF (EnemyY >= 100) THEN
             BlowUpEnemy;
          END;
   END;
END DrawBullet;

PROCEDURE Die;
CONST
  SoundDelay = 50;
BEGIN
  Sound (200);
  Ellipse (PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, Red, TRUE);
  Lib.Delay(SoundDelay);
  NoSound;
  Sound (150);
  Ellipse (PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, LightestRed, TRUE);
  Lib.Delay(SoundDelay);
  NoSound;
  Sound (120);
  Ellipse (PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, Yellow, TRUE);
  Lib.Delay(SoundDelay);
  Sound (100);
  Ellipse (PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, LightYellow, TRUE);
  Lib.Delay(SoundDelay);
  Sound (60);
  Ellipse (PlaneX + (PlaneWidth DIV 2), PlaneY + (PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, LightestYellow, TRUE);
  Lib.Delay(SoundDelay);
  Sound (80);
  Ellipse (PlaneX + (PlaneWidth DIV 2), PlaneY*(PlaneHeight DIV 2), PlaneWidth DIV 2, PlaneHeight DIV 2, White, TRUE);
  Lib.Delay(SoundDelay);
  NoSound;
  Lives := Lives + 1;
  IF (Lives=5) THEN
  Lives := 0;
     IF (Cheat=FALSE) THEN
        GameOver := TRUE;
     END;
  END;
  OneAlive := FALSE;
  PlaneX := PlaneXMin;
END Die;

PROCEDURE CheckDeath1;
BEGIN
  IF ((OneAlive) AND (PlaneX<50)) THEN
     Die;
  END;
  IF (TwoAlive) AND (PlaneX>55) AND (PlaneX<100) THEN
     Die;
  END;
  IF (ThreeAlive) AND (PlaneX>110) AND (PlaneX<155) THEN
     Die;
  END;
  IF (FourAlive) AND (PlaneX>165) AND (PlaneX<210)THEN
     Die;
  END;
  IF (FiveAlive) AND (PlaneX>216) AND (PlaneX<260) THEN
     Die;
  END;
  IF (SixAlive) AND (PlaneX>260) THEN
     Die;
  END;
END CheckDeath1;

PROCEDURE FinishScreen1;
BEGIN
  Rectangle (0, 0, 320, 10, White, FALSE);
  FOR PlaneY := 175 TO 100 BY -2 DO
     IF (PlaneX<155) THEN
        PlaneX := PlaneX + 5;
     END;
     IF (PlaneX>155) THEN
        PlaneX := PlaneX - 5;
     END;
     BlankGround1;
     DrawPlane (PlaneX, PlaneY, ((PlaneY - 100) DIV 2), ((PlaneY - 100) DIV 4));
     Delay (40);
  END;
  Graph.ClearScreen(Graph._GCLEARSCREEN);
END FinishScreen1;

END Exobius.
