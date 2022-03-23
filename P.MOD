MODULE p;           
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)
IMPORT
      IO, Graph, Lib, Window, Str;
FROM Graph IMPORT 
      Line, HLine, Circle, Ellipse, Disc, Plot;

CONST Letters = 26;
      White = 1;
      Black = 0;
      FillColour = 3;
      BlackFillColour = 0;
      RadiusOne = 12;
      RadiusTwo = 37;
      StartUbidX = 2;
      StartUbidY = 50;
      BoxSides = 4;
      MaxStages = 5;
TYPE Coordinate = ARRAY [0..11] OF CARDINAL;

VAR
   RndNote, UbidX, UbidY, x, y, Stage, UbidSpeed : CARDINAL;
   Number, Count, a, b : INTEGER;
   Key, TypedLetter : CHAR;
   TypeCheck, LetterCheck, CheckLetter : ARRAY [0..30] OF CHAR;
   Xs, Ys : Coordinate;
   GameComplete, ScreenComplete, DontSlice : BOOLEAN;

PROCEDURE Title;
CONST BlankLines = 11;
      RandomNotes = 20;
BEGIN

   Window.Clear;

   FOR Count:=1 TO BlankLines DO
      IO.WrLn;
   END;

   IO.WrStr("                                ****************");
   IO.WrLn();
   IO.WrStr("                                * Letter Chase *");
   IO.WrLn();
   IO.WrStr("                                ****************");

   FOR Count:=1 TO RandomNotes DO
      RndNote := Lib.RANDOM ( 5000);
      Lib.Sound( RndNote);
      Lib.Delay( 100*(RandomNotes MOD 2 +1));
      Lib.NoSound;
   END;

   Lib.Sound( 50);
   Lib.Delay( 100);
   Lib.NoSound;
   Lib.Sound( 150);
   Lib.Delay( 100);
   Lib.NoSound;
   Lib.Sound( 300);
   Lib.Delay( 100);
   Lib.NoSound;

END Title;

PROCEDURE EraseBox(x,y,a,b : INTEGER);

BEGIN

   Xs [0] := x; Xs [1] := a; Xs [2] := a; Xs [3] := x;
   Ys [0] := y-1; Ys [1] := y-1; Ys [2] := b; Ys [3] := b;
   Graph.Polygon (BoxSides, Xs, Ys, BlackFillColour);
   
END EraseBox;

PROCEDURE A (x,y : CARDINAL);
BEGIN
   Line ( x+25, y, x, y+50, White);
   Line ( x+25, y, x+50, y+50, White);
   Line ( x+12, y+25, x+37, y+25, White);
END A;

(* For PROCEDURE "B", see after PROCEDURE "P" *)

PROCEDURE C (x,y : CARDINAL);
CONST Radius = 25;
BEGIN
   Circle( x+25, y+Radius, Radius, White);
   EraseBox(x+38, y+12, x+75, y+37);
END C;

PROCEDURE D (x,y : CARDINAL);
BEGIN
   Ellipse (x, y+25, 48, 25, White, FALSE);
   EraseBox (x-49, y, x-1, y+50);
   Line ( x, y, x, y+50, White );
END D;

PROCEDURE E (x,y : CARDINAL);
BEGIN
   Line(x, y, x, y+50, White);
   Line(x, y, x+50, y, White);
   Line(x, y+25, x+50, y+25, White);
   Line(x, y+50, x+50, y+50, White);
END E;

PROCEDURE F (x,y : CARDINAL);
BEGIN
   E (x,y);
   EraseBox (x+1, y+50,x+50,y+50);
END F;

PROCEDURE G (x,y : CARDINAL);
BEGIN
   Circle (x+25, y+25, 25, White);
   EraseBox (x+26, y+12, x+50, y+24);
   Line (x+25, y+25, x+50, y+25, White);
   Line (x+50, y+25, x+50, y+50, White);
END G;

PROCEDURE H (x,y : CARDINAL);
BEGIN
   Line (x, y, x, y+50, White);
   Line (x+50, y, x+50, y+50, White);
   Line (x, y+25, x+50, y+25, White);
END H;

PROCEDURE I (x,y : CARDINAL);
BEGIN
   Line (x, y, x+50, y, White);
   Line (x+25, y, x+25, y+50, White);
   Line (x, y+50, x+50, y+50, White);
END I;

PROCEDURE J (x,y : CARDINAL);
BEGIN
   Line (x+25, y, x+25, y+37, White);
   Circle (x+12, y+37, RadiusOne, White);
   EraseBox (x+1, y+24, x+24, y+36);
END J;

PROCEDURE K (x,y : CARDINAL);
BEGIN
   Line (x, y, x, y+50, White);
   Line (x, y+25, x+50, y+50, White);
   Line (x, y+25, x+50, y, White);
END K;

PROCEDURE L (x,y : CARDINAL);
BEGIN
   Line (x, y, x, y+50, White);
   Line (x, y+50, x+50, y+50, White);
END L;

PROCEDURE M (x,y : CARDINAL);
BEGIN
   Line (x, y, x, y+50, White);
   Line (x, y, x+25, y+25, White);
   Line (x+25, y+25, x+50, y, White);
   Line (x+50, y, x+50, y+50, White);
END M;

PROCEDURE N (x,y : CARDINAL);
BEGIN
   Line (x, y+50, x, y, White);
   Line (x, y, x+50, y+50, White);
   Line (x+50, y+50, x+50, y, White)
END N;

PROCEDURE O (x,y : CARDINAL);
BEGIN
   Circle(x+25, y+25, 25, White);
END O;

PROCEDURE P (x,y : CARDINAL);
BEGIN
   Ellipse (x+25, y+12, 25, 12, White, FALSE);
   EraseBox (x, y, x+24, y+25);
   Line (x+25, y, x+25, y+50, White);
END P;

PROCEDURE B (x,y : CARDINAL);
BEGIN
   P (x,y);
   Ellipse (x+25, y+37, 25, 12, White, FALSE);
   EraseBox (x, y+25, x+24, y+50);
END B;

PROCEDURE Q (x,y : CARDINAL);
BEGIN
   O (x,y);
   Line (x+25, y+25, x+50, y+50, White);
END Q;

PROCEDURE R (x,y : CARDINAL);
BEGIN
   P (x,y);
   Line (x+25, y+25, x+50, y+50, White);
END R;

PROCEDURE S (x,y : CARDINAL);
BEGIN
   Ellipse (x+25, y+12, 25, 12, White, FALSE);
   Ellipse (x+25, y+37, 25, 12, White, FALSE);
   EraseBox (x+26, y+12, x+50, y+24);
   EraseBox (x, y+26, x+24, y+37);
END S;

PROCEDURE T (x,y : CARDINAL);
BEGIN
   Line (x, y, x+50, y, White);
   Line (x+25, y, x+25, y+50, White);
END T;

PROCEDURE U (x,y : CARDINAL);
BEGIN
   O (x,y);
   EraseBox (x, y, x+50, y+24);
   Line (x, y, x, y+25, White);
   Line (x+50, y, x+50, y+25, White);
END U;

PROCEDURE V (x,y : CARDINAL);
BEGIN
   Line (x, y, x+25, y+50, White);
   Line (x+25, y+50, x+50, y, White);
END V;

PROCEDURE W (x,y :CARDINAL);
BEGIN
   Line (x, y, x+12, y+50, White);
   Line (x+12, y+50, x+25, y, White);
   Line (x+25, y, x+37, y+50, White);
   Line (x+37, y+50, x+50, y, White);
END W;

PROCEDURE X (x,y : CARDINAL);
BEGIN
   Line (x, y, x+50, y+50, White);
   Line (x+50, y, x, y+50, White);
END X;

PROCEDURE Y (x,y : CARDINAL);
BEGIN
   Line (x, y, x+25, y+25, White);
   Line (x+25, y+25, x+50, y, White);
   Line (x+25, y+25, x+25, y+50, White);
END Y;

PROCEDURE Z (x,y : CARDINAL);
BEGIN
   Line (x, y, x+50, y, White);
   Line (x+50, y, x, y+50, White);
   Line (x, y+50, x+50, y+50, White);
END Z;

PROCEDURE DrawLetter( x, y, Number : CARDINAL);

BEGIN

      CASE Number OF
         |  1 : A (x,y);
                Str.Append (TypeCheck, 'A');
         |  2 : B (x,y);
                Str.Append (TypeCheck, 'B');
         |  3 : C (x,y);
                Str.Append (TypeCheck, 'C');
         |  4 : D (x,y);
                Str.Append (TypeCheck, 'D');
         |  5 : E (x,y);
                Str.Append (TypeCheck, 'E');
         |  6 : F (x,y);
                Str.Append (TypeCheck, 'F');
         |  7 : G (x,y);
                Str.Append (TypeCheck, 'G');
         |  8 : H (x,y);
                Str.Append (TypeCheck, 'H');
         |  9 : I (x,y);
                Str.Append (TypeCheck, 'I');
         | 10 : J (x,y);
                Str.Append (TypeCheck, 'J');
         | 11 : K (x,y);
                Str.Append (TypeCheck, 'K');
         | 12 : L (x,y);
                Str.Append (TypeCheck, 'L');
         | 13 : M (x,y);
                Str.Append (TypeCheck, 'M');
         | 14 : N (x,y);
                Str.Append (TypeCheck, 'N');
         | 15 : O (x,y);
                Str.Append (TypeCheck, 'O');
         | 16 : P (x,y);
                Str.Append (TypeCheck, 'P');
         | 17 : Q (x,y);
                Str.Append (TypeCheck, 'Q');
         | 18 : R (x,y);
                Str.Append (TypeCheck, 'R');
         | 19 : S (x,y);
                Str.Append (TypeCheck, 'S');
         | 20 : T (x,y);
                Str.Append (TypeCheck, 'T');
         | 21 : U (x,y);
                Str.Append (TypeCheck, 'U');
         | 22 : V (x,y);
                Str.Append (TypeCheck, 'V');
         | 23 : W (x,y);
                Str.Append (TypeCheck, 'W');
         | 24 : X (x,y);
                Str.Append (TypeCheck, 'X');
         | 25 : Y (x,y);
                Str.Append (TypeCheck, 'Y');
         | 26 : Z (x,y);
                Str.Append (TypeCheck, 'Z');
      END;

END DrawLetter;

PROCEDURE SetupScreen;
BEGIN

   FOR y:= 50 TO 250 BY 100 DO
      FOR x:=50 TO 650 BY 100 DO
         DrawLetter (x, y, Lib.RANDOM(Letters)+1);
      END;
   END;

   EraseBox (50, 50, 349, 100);      (* Erases First Three Letters From Screen *)
   Str.Delete (TypeCheck, 0, 3);     (* Erases First Three Letters From Array *)

END SetupScreen;

PROCEDURE DrawUbid( x,y : CARDINAL);
CONST DiscRadius = 4;
BEGIN

   Circle (x+45, y+25, 5, White);
   Plot (x+47, y+23, White);
   Ellipse (x+48, y+28, 2, 1, FillColour, TRUE);
   Line (x+40, y+25, x+15, y+35, White);
   Line (x+20, y+40, x+35, y+35, White);
   Line (x+20, y+40, x+15, y+35, White);
   Line (x+35, y+35, x+38, y+42, White);
   Line (x+38, y+45, x+40, y+34, White);
   Line (x+40, y+34, x+45, y+42, White);
   Line (x+45, y+45, x+40, y+30, White);
   Line (x+40, y+30, x+42, y+28, White);
   Line (x+15, y+35, x+13, y+45, White);
   Line (x+20, y+40, x+15, y+45, White);
   Line (x+ 5, y+45, x+15, y+45, White);
   Disc (x+5, y+43, DiscRadius, FillColour);
   Disc (x+4, y+47, DiscRadius, FillColour);
   Disc (x+38, y+42, DiscRadius, FillColour);
   Disc (x+45, y+45, DiscRadius, FillColour);

END DrawUbid;

PROCEDURE DrawWoman (x, y : CARDINAL);
BEGIN
   Ellipse (x+32, y+22, 15, 8, White, FALSE);
   Line (x+30, y+15, x+18, y+10, White);
   Line (x+18, y+10, x+18, y+18, White);
   Line (x+35, y+15, x+50, y+20, White);
   Line (x+50, y+20, x+45, y+20, White);
   Line (x+25, y+29, x+15, y+45, White);
   Line (x+15, y+45, x+30, y+30, White);
   Line (x+15, y+45, x+20, y+45, White);
   Line (x+35, y+30, x+45, y+45, White);
   Line (x+45, y+45, x+40, y+30, White);
   Line (x+45, y+45, x+50, y+40, White);
   Circle (x+35, y+10, 5, White);

   Xs[0] := x+35; Xs[1] := x+25; Xs[2] := x+35;
   Ys[0] := y+5;  Ys[1] := y+13;  Ys[2] :=y+15;
   Graph.Polygon (3, Xs, Ys, FillColour);

   Disc (x+35, y+2, 3, FillColour);
   Disc (x+38, y+9, 0, FillColour);
   Line (x+40, y+10, x+37, y+7, White);
   Ellipse (x+38, y+13, 2, 1, White, TRUE);
   Line (x+20, y+5, x+15, y+15, White);
   Line (x+17, y+5, x+12, y+15, White);
   HLine (x+17, y+5, x+20, White);
   HLine (x+12, y+5, x+15, White);
   Circle (x+18, y+3, 2, White);
   Circle (x+13, y+17, 2, White);

END DrawWoman;

PROCEDURE DrawRex (x, y : CARDINAL);
BEGIN

Disc (x+20, y+15, 10, FillColour);

Xs[0] := x; Xs[1] := x; Xs[2] := x+15; Xs[3] := x+15; Xs[4] := x+25; Xs[5] := x+50; 
Xs[6] := x+30; Xs[7] := x+50; Xs[8] := x+25; Xs[9] := x+25; Xs[10] := x+50; Xs[11] := x+50;  
Ys[0] := y+50; Ys[1] := y+40; Ys[2] := y+40; Ys[3] := y+20; Ys[4] := y+5; Ys[5] := y+10; 
Ys[6] := y+15; Ys[7] := y+20; Ys[8] := y+25; Ys[9] := y+40; Ys[10] := y+40; Ys[11] := y+50;  
Graph.Polygon(12, Xs, Ys, FillColour);

Disc (x+25, y+12, 3, BlackFillColour);
Line (x+50, y+10, x+50, y+12, White);
Line (x+45, y+10, x+45, y+12, White);
Line (x+40, y+10, x+40, y+20, White);
Line (x+45, y+17, x+45, y+20, White);
Line (x+50, y+17, x+50, y+20, White);

END DrawRex;

PROCEDURE DrawEllie (x, y : CARDINAL);
BEGIN

   Xs[0] :=  x+5; Xs[1] :=  x+5; Xs[2] := x+20; Xs[3] := x+20; Xs[4] := x+50;
   Xs[5] := x+50; Xs[6] := x+25; Xs[7] := x+25; Xs[8] := x+45; Xs[9] := x+45;
   Ys[0] := y+45; Ys[1] := y+30; Ys[2] := y+30; Ys[3] := y+15; Ys[4] := y+15;
   Ys[5] := y+17; Ys[6] := y+20; Ys[7] := y+30; Ys[8] := y+30; Ys[9] := y+45;
   Graph.Polygon(10, Xs, Ys, FillColour);
   Disc (x+5, y+45, 5, FillColour);
   Disc (x+45, y+45, 5, FillColour);
   Disc (x+25, y+35, 10, FillColour);
   Disc (x+23, y+17, 7, FillColour);
   Disc (x+17, y+12, 3, FillColour);
   Disc (x+17, y+23, 3, FillColour);
   Disc (x+25, y+16, 1, BlackFillColour);

END DrawEllie;

PROCEDURE DrawChar (x, y : CARDINAL);
BEGIN
   CASE Stage OF
      | 1 : DrawUbid  (x,y);
      | 2 : DrawWoman (x,y);
      | 3 : DrawRex   (x,y);
      | 4 : DrawEllie (x,y);
   END;
END DrawChar;

PROCEDURE MoveUbid;
CONST HercColMax = 720;
BEGIN
   EraseBox (UbidX-1, UbidY, UbidX+49, UbidY+50);
   IF UbidX >= HercColMax THEN
      UbidX := StartUbidX;
      UbidY := UbidY + 100;
   END;
   UbidX := UbidX + UbidSpeed;
   DrawChar (UbidX, UbidY);
END MoveUbid;

PROCEDURE GameOver;
BEGIN
   FOR Count := 4000 TO 0 BY -5 DO
      Lib.Sound (Count);
      Lib.Delay (1);
      Lib.NoSound;
   END;
   Graph.TextMode;
   IO.WrStr("                                   GAME OVER");
   IO.WrStr("                                < Press any key >");
   ScreenComplete := TRUE;
   GameComplete := TRUE;
END GameOver;

PROCEDURE FinishGame;
BEGIN
   FOR Count := 1 TO 10 DO      
      RndNote := Lib.RANDOM (5000);      
      Lib.Sound(RndNote);      
      Lib.Delay(50);      
      Lib.NoSound;      
   END;      
   EraseBox(1, 1, 720, 348);      
   ScreenComplete := TRUE;
   x := 200;
   y := 50;
END FinishGame;

PROCEDURE TakeOffLetter;
BEGIN
   Lib.Sound(100);         
   Lib.Delay(50);         
   Lib.NoSound;         
   Lib.Sound(500);         
   Lib.Delay(50);         
   Lib.NoSound;         
   Lib.Sound(1000);         
   Lib.Delay(50);         
   Lib.NoSound;         
   EraseBox(x-5, y-5, x+55, y+55);         
   x := x+100;         
      Str.Delete (TypeCheck, 0, 1);         
      Str.Delete (CheckLetter, 0, 5);         
   IF (x>650) AND (y>=200) THEN         
      FinishGame;         
   END;         
   IF x > 650 THEN         
      x := 50;         
      y := y+100;         
   END;         
END TakeOffLetter;

PROCEDURE PlayGame;
BEGIN
   WHILE NOT IO.KeyPressed() DO
      MoveUbid;
      IF (UbidY >= y) AND (UbidX > (x-49)) THEN     (*   Check if   *)      
         UbidX := UbidX - 50;                       (* Ubid catches *)      
         GameOver;                                (*    Letter    *)
      END;
   END;
   IF NOT ScreenComplete THEN
      TypedLetter := IO.RdKey();
      Str.Caps (TypedLetter);
      Str.Caps (CheckLetter);
      Str.Caps (LetterCheck);
      Str.Caps (TypeCheck);
      IF TypedLetter = LetterCheck[0] THEN
         TakeOffLetter;
      ELSE
         DontSlice := TRUE;         
      END;
   END;
END PlayGame;

PROCEDURE LetterChase;
BEGIN
   Graph.GraphMode;
   SetupScreen;
   x := 350;
   y := 50;

   WHILE NOT ScreenComplete DO
      Line (x-5, y-5, x+55, y-5, White);                 (*         *)
       Line (x+55, y-5, x+55, y+55, White);               (* Enboxes *)
      Line (x+55, y+55, x-5, y+55, White);               (* Letter  *)
      Line (x-5, y+55, x-5, y-5, White);                 (*         *)
      Str.Slice(LetterCheck, TypeCheck, 0, 1);
      PlayGame;
   END;

END LetterChase;

PROCEDURE DisplayTitle;
BEGIN
   Graph.InitHerc;
   Graph.GraphMode;
   S(100, 50);
   T(200, 50);
   A(300, 50);
   G(400, 50);
   E(500, 50);

   FOR Count := 555 TO ((Stage * 25 ) + 530) BY 25 DO
      Line (Count, 50, Count, 100, White);
   END;

   CASE Stage OF
      |1:
         T(50,  150);
         H(101, 150);
         E(152, 150);
         B(303, 150);
         U(254, 150);
         D(405, 150);
         I(356, 150);
         O(507, 150);
         N(558, 150);
         W(209, 200);
         H(260, 200);
         E(311, 200);
         E(362, 200);
         S(463, 200);
         L(414, 200);

      |2:
         O(100, 150);
         U(151, 150);
         M(202, 150);
         A(253, 150);
         W(354, 150);
         I(405, 150);
         T(456, 150);
         H(507, 150);
         A(558, 150);
         R( 59,  200);
         O(110, 200);
         L(161, 200);
         L(212, 200);
         I(263, 200);
         N(314, 200);
         G(365, 200);
         P(466, 200);
         I(517, 200);
         N(568, 200);
      END;
   DrawChar(335, 300);
   Lib.Delay(5000);
   Graph.TextMode;
END DisplayTitle;

(* @@@@@@@@@ MAIN PROGRAM @@@@@@@@@@ *)

BEGIN

(* Initialisation of Variables *)

   Stage := 1;
   x := 350;
   y := 50;
   GameComplete := FALSE;
   UbidX := StartUbidX;
   UbidY := StartUbidY;
   TypeCheck := '';
   UbidSpeed := 1;
   Lib.RANDOMIZE;
   Title;

(* Actual Game *)

   WHILE NOT GameComplete AND (Stage < MaxStages) DO
      ScreenComplete := FALSE;
      DisplayTitle;
      LetterChase;
      INC (Stage, 1);
      UbidX := StartUbidX;
      UbidY := StartUbidY;      
      TypeCheck := '';
      INC (UbidSpeed, 1);
      IF Stage > 2 THEN INC (UbidSpeed, 1); END;
   END;
   Graph.TextMode;
END p.
