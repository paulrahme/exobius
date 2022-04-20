IMPLEMENTATION MODULE Sprites;

PROCEDURE DrawBoomGuards (x, y, Width : CARDINAL);
BEGIN
  Disc (x + (Width   DIV 10), y + (Width DIV 2), Width*3 DIV 50, Black);
  Disc (x + (Width*3 DIV 5), y + (Width DIV 2), Width*3 DIV 50, Black);
  Line (x + (Width   DIV 10), y + (Width DIV 2), x + (Width   DIV 10), y + (Width*4 DIV 5), Black);
  Line (x + (Width*3 DIV 5), y + (Width DIV 2), x + (Width*3 DIV 5), y + (Width*4 DIV 5), Black);
  Line (x + (Width   DIV 10), y + (Width*4 DIV 5), x, y + Width, Black);
  Line (x + (Width*3 DIV 5), y + (Width*4 DIV 5), x + (Width DIV 2), y + Width, Black);
  Line (x + (Width   DIV 10), y + (Width*4 DIV 5), x + (Width   DIV 5), y + Width, Black);
  Line (x + (Width*3 DIV 5), y + (Width*4 DIV 5), x + (Width*35 DIV 50), y + Width, Black);
  Rectangle (x + (Width*12 DIV 50), y + (Width*35 DIV 50), x + (Width*15 DIV 50), y + Width, Black, TRUE);
  Rectangle (x + (Width*37 DIV 50), y + (Width*35 DIV 50), x + (Width*4 DIV 5), y + Width, Black, TRUE);
  Line (x + (Width*16 DIV 50), y + (Width*35 DIV 50), x + (Width*25 DIV 50), y + (Width*35 DIV 50), Yellow);
  Line (x + (Width*41 DIV 50), y + (Width*35 DIV 50), x + Width, y + (Width*35 DIV 50), Yellow);
  Graph.SetLinestyle (0AAAAH);
  Line (x + (Width*16 DIV 50), y + (Width*35 DIV 50), x + (Width*25 DIV 50), y + (Width*35 DIV 50), Black);
  Line (x + (Width*41 DIV 50), y + (Width*35 DIV 50), x + (Width*3 DIV 2), y + (Width*35 DIV 50), Black);
  Graph.SetLinestyle (0FFFFH);
  CASE (y MOD 4) OF
     | 0 : Line (x + (Width*2 DIV 50), y + (Width*33 DIV 50), x + (Width*7 DIV 50), y + (Width*37 DIV 50), Black);
           Line (x + (Width*27 DIV 50), y + (Width*33 DIV 50), x + (Width*32 DIV 50), y + (Width*37 DIV 50), Black);
     | 1 : Line (x + (Width*2 DIV 50), y + (Width*35 DIV 50), x + (Width*7 DIV 50), y + (Width*35 DIV 50), Black);
           Line (x + (Width*27 DIV 50), y + (Width*35 DIV 50), x + (Width*32 DIV 50), y + (Width*35 DIV 50), Black);
     | 2 : Line (x + (Width*2 DIV 50), y + (Width*37 DIV 50), x + (Width*7 DIV 50), y + (Width*33 DIV 50), Black);
           Line (x + (Width*27 DIV 50), y + (Width*37 DIV 50), x + (Width*32 DIV 50), y + (Width*33 DIV 50), Black);
     | 3 : Line (x + (Width*2 DIV 50), y + (Width*35 DIV 50), x + (Width*7 DIV 50), y + (Width*35 DIV 50), Black);
           Line (x + (Width*27 DIV 50), y + (Width*35 DIV 50), x + (Width*32 DIV 50), y + (Width*35 DIV 50), Black);
  END;
END DrawBoomGuards;

PROCEDURE DrawSpinners (x, y, Width : CARDINAL);
VAR
  DiskX, DiskY : CARDINAL;
BEGIN
  Disc (x + (Width*25 DIV 50), y + (Width * 25 DIV 50), Width*9 DIV 50, DarkestGreen);
  Disc (x + (Width*26 DIV 50), y + (Width * 24 DIV 50), Width*7 DIV 50, DarkGreen);
  Disc (x + (Width*27 DIV 50), y + (Width * 23 DIV 50), Width*5 DIV 50, Green);
  Disc (x + (Width*28 DIV 50), y + (Width * 22 DIV 50), Width*3 DIV 50, LightGreen);
  Disc (x + (Width*29 DIV 50), y + (Width * 21 DIV 50), Width   DIV 50, LightestGreen);
  CASE (y MOD 3) OF
     | 0 : DiskX := 9;
           DiskY := 25;
     | 1 : DiskX := 12;
           DiskY := 17;
     | 2 : DiskX := 17;
           DiskY := 12;
  END;
  Disc (x + (Width*DiskX DIV 50), y + (Width*DiskY DIV 50), Width*9 DIV 50, DarkestBrown);
  Disc (x + (Width*(DiskX+1) DIV 50), y + (Width*(DiskY-1) DIV 50), Width*7 DIV 50, DarkBrown);
  Disc (x + (Width*(DiskX+2) DIV 50), y + (Width*(DiskY-2) DIV 50), Width*5 DIV 50, Brown);
  Disc (x + (Width*(DiskX+3) DIV 50), y + (Width*(DiskY-3) DIV 50), Width*3 DIV 50, LightBrown);
  Disc (x + (Width*(DiskX+4) DIV 50), y + (Width*(DiskY-4) DIV 50), Width   DIV 50, LightestBrown);
  CASE (y MOD 3) OF
     | 0 : DiskX := 25;
           DiskY := 9;
     | 1 : DiskX := 33;
           DiskY := 12;
     | 2 : DiskX := 38;
           DiskY := 17;
  END;
  Disc (x + (Width*DiskX DIV 50), y + (Width*DiskY DIV 50), Width*9 DIV 50, DarkestBrown);
  Disc (x + (Width*(DiskX+1) DIV 50), y + (Width*(DiskY-1) DIV 50), Width*7 DIV 50, DarkBrown);
  Disc (x + (Width*(DiskX+2) DIV 50), y + (Width*(DiskY-2) DIV 50), Width*5 DIV 50, Brown);
  Disc (x + (Width*(DiskX+3) DIV 50), y + (Width*(DiskY-3) DIV 50), Width*3 DIV 50, LightBrown);
  Disc (x + (Width*(DiskX+4) DIV 50), y + (Width*(DiskY-4) DIV 50), Width   DIV 50, LightestBrown);
  CASE (y MOD 3) OF
     | 0 : DiskX := 41;
           DiskY := 25;
     | 1 : DiskX := 38;
           DiskY := 33;
     | 2 : DiskX := 33;
           DiskY := 38;
  END;
  Disc (x + (Width*DiskX DIV 50), y + (Width*DiskY DIV 50), Width*9 DIV 50, DarkestBrown);
  Disc (x + (Width*(DiskX+1) DIV 50), y + (Width*(DiskY-1) DIV 50), Width*7 DIV 50, DarkBrown);
  Disc (x + (Width*(DiskX+2) DIV 50), y + (Width*(DiskY-2) DIV 50), Width*5 DIV 50, Brown);
  Disc (x + (Width*(DiskX+3) DIV 50), y + (Width*(DiskY-3) DIV 50), Width*3 DIV 50, LightBrown);
  Disc (x + (Width*(DiskX+4) DIV 50), y + (Width*(DiskY-4) DIV 50), Width   DIV 50, LightestBrown);
  CASE (y MOD 3) OF
     | 0 : DiskX := 25;
           DiskY := 41;
     | 1 : DiskX := 17;
           DiskY := 38;
     | 2 : DiskX := 12;
           DiskY := 33;
  END;
  Disc (x + (Width*DiskX DIV 50), y + (Width*DiskY DIV 50), Width*9 DIV 50, DarkestBrown);
  Disc (x + (Width*(DiskX+1) DIV 50), y + (Width*(DiskY-1) DIV 50), Width*7 DIV 50, DarkBrown);
  Disc (x + (Width*(DiskX+2) DIV 50), y + (Width*(DiskY-2) DIV 50), Width*5 DIV 50, Brown);
  Disc (x + (Width*(DiskX+3) DIV 50), y + (Width*(DiskY-3) DIV 50), Width*3 DIV 50, LightBrown);
  Disc (x + (Width*(DiskX+4) DIV 50), y + (Width*(DiskY-4) DIV 50), Width   DIV 50, LightestBrown);
END DrawSpinners;

PROCEDURE DrawPlants (x, y, Width : CARDINAL);
BEGIN
  Line (x + (Width*10 DIV 50), y + (Width*25 DIV 50), x + (Width*40 DIV 50), y + (Width*25 DIV 50), DarkestRed);
  Line (x + (Width*25 DIV 50), y + (Width*25 DIV 50), x + (Width*25 DIV 50), y + Width, DarkestRed);
  Disc (x + (Width*25 DIV 50), y + (Width*25 DIV 50), Width*10 DIV 50, DarkestRed);
  Disc (x + (Width*27 DIV 50), y + (Width*23 DIV 50), Width*8 DIV 50, DarkRed);
  Disc (x + (Width*29 DIV 50), y + (Width*21 DIV 50), Width*6 DIV 50, Red);
  Disc (x + (Width*31 DIV 50), y + (Width*19 DIV 50), Width*4 DIV 50, LightRed);
  Disc (x + (Width*33 DIV 50), y + (Width*17 DIV 50), Width*2 DIV 50, LightestRed);
  CASE (y MOD 4) OF
     | 0 : Line (x + (Width*25 DIV 50), y + (Width*14 DIV 50), x + (Width*10 DIV 50), y + (Width*10 DIV 50), LightBlue);
           Disc (x + (Width*10 DIV 50), y + (Width*10 DIV 50), Width*3 DIV 50, DarkestYellow);
           Plot (x + (Width*11 DIV 50), y + (Width*9 DIV 50), LightYellow);
     | 1 : Line (x + (Width*25 DIV 50), y + (Width*14 DIV 50), x + (Width*25 DIV 50), y + (Width*5 DIV 50), LightBlue);
           Disc (x + (Width*25 DIV 50), y + (Width*5 DIV 50), Width*3 DIV 50, DarkestYellow);
           Plot (x + (Width*26 DIV 50), y + (Width*4 DIV 50), LightYellow);
     | 2 : Line (x + (Width*25 DIV 50), y + (Width*14 DIV 50), x + (Width*40 DIV 50), y + (Width*10 DIV 50), LightBlue);
           Disc (x + (Width*40 DIV 50), y + (Width*10 DIV 50), Width*3 DIV 50, DarkestYellow);
           Plot (x + (Width*41 DIV 50), y + (Width*9 DIV 50), LightYellow);
     | 3 : Line (x + (Width*25 DIV 50), y + (Width*14 DIV 50), x + (Width*25 DIV 50), y + (Width*5 DIV 50), LightBlue);
           Disc (x + (Width*25 DIV 50), y + (Width*5 DIV 50), Width*3 DIV 50, DarkestYellow);
           Plot (x + (Width*26 DIV 50), y + (Width*4 DIV 50), LightYellow);
  END;
END DrawPlants;

PROCEDURE DrawFlyTraps (x, y, Width : CARDINAL);
BEGIN
  HLine (x, y + Width, x + Width, Black);
  Line (x + (Width*25 DIV 50), y, x + Width, y + Width, Black);
  Disc (x + (Width*25 DIV 50), y + (Width*20 DIV 50), Width*15 DIV 50, DarkestBlue);
  Disc (x + (Width*27 DIV 50), y + (Width*18 DIV 50), Width*13 DIV 50, DarkBlue);
  Disc (x + (Width*29 DIV 50), y + (Width*16 DIV 50), Width*11 DIV 50, Blue);
  Disc (x + (Width*31 DIV 50), y + (Width*14 DIV 50), Width*9 DIV 50, LightBlue);
  Disc (x + (Width*33 DIV 50), y + (Width*12 DIV 50), Width*7 DIV 50, LightestBlue);
  Disc (x + (Width*35 DIV 50), y + (Width*10 DIV 50), Width*3 DIV 50, LightestWhite);
  CASE (y MOD 4) OF
     | 0 : HLine (x + (Width*10 DIV 50), y + (Width*25 DIV 50), x + (Width*40 DIV 50), DarkestRed);
     | 1 : Ellipse (x + (Width*25 DIV 50), y + (Width*20 DIV 50), Width*15 DIV 50, Width*5 DIV 50, DarkestRed, TRUE);
           Line (x + (Width*20 DIV 50), y + (Width*15 DIV 50), x + (Width*20 DIV 50), y + (Width*20 DIV 50), White);
           Line (x + (Width*30 DIV 50), y + (Width*15 DIV 50), x + (Width*30 DIV 50), y + (Width*20 DIV 50), White);
     | 2 : Ellipse (x + (Width*25 DIV 50), y + (Width*20 DIV 50), Width*15 DIV 50, Width*5 DIV 50, DarkestRed, TRUE);
           Line (x + (Width*20 DIV 50), y + (Width*15 DIV 50), x + (Width*20 DIV 50), y + (Width*20 DIV 50), White);
           Line (x + (Width*30 DIV 50), y + (Width*15 DIV 50), x + (Width*30 DIV 50), y + (Width*20 DIV 50), White);
           Rectangle (x + (Width*24 DIV 50), y + (Width*20 DIV 50), x + (Width*26 DIV 50), y + (Width*40 DIV 50), LightRed, TRUE);
     | 3 : Ellipse (x + (Width*25 DIV 50), y + (Width*20 DIV 50), Width*15 DIV 50, Width*5 DIV 50, DarkestRed, TRUE);
           Line (x + (Width*20 DIV 50), y + (Width*15 DIV 50), x + (Width*20 DIV 50), y + (Width*20 DIV 50), White);
           Line (x + (Width*30 DIV 50), y + (Width*15 DIV 50), x + (Width*30 DIV 50), y + (Width*20 DIV 50), White);
  END;
END DrawFlyTraps;

PROCEDURE DrawMaces (x, y, Width : CARDINAL);
BEGIN
  Ellipse (x + (Width*25 DIV 50), y + (Width*25 DIV 50), Width*20 DIV 50, Width*10 DIV 50, DarkestGrey, TRUE);
  Ellipse (x + (Width*26 DIV 50), y + (Width*24 DIV 50), Width*18 DIV 50, Width*9 DIV 50, DarkGrey, TRUE);
  Ellipse (x + (Width*27 DIV 50), y + (Width*23 DIV 50), Width*16 DIV 50, Width*8 DIV 50, Grey, TRUE);
  Ellipse (x + (Width*28 DIV 50), y + (Width*22 DIV 50), Width*14 DIV 50, Width*7 DIV 50, LightGrey, TRUE);
  Ellipse (x + (Width*29 DIV 50), y + (Width*21 DIV 50), Width*12 DIV 50, Width*6 DIV 50, LightestGrey, TRUE);
  Ellipse (x + (Width*30 DIV 50), y + (Width*20 DIV 50), Width*10 DIV 50, Width*5 DIV 50, DarkestWhite, TRUE);
  Ellipse (x + (Width*31 DIV 50), y + (Width*19 DIV 50), Width*8 DIV 50, Width*4 DIV 50, DarkWhite, TRUE);
  Ellipse (x + (Width*32 DIV 50), y + (Width*18 DIV 50), Width*6 DIV 50, Width*3 DIV 50, White, TRUE);
  Ellipse (x + (Width*33 DIV 50), y + (Width*17 DIV 50), Width*4 DIV 50, Width*2 DIV 50, LightWhite, TRUE);
  Ellipse (x + (Width*34 DIV 50), y + (Width*16 DIV 50), Width*2 DIV 50, Width   DIV 50, LightestWhite, TRUE);
  CASE (y MOD 2) OF
     | 0 : Line (x + (Width*25 DIV 50), y + (Width*34 DIV 50), x + (Width*25 DIV 50), y + Width, Black);
           Line (x + (Width*5 DIV 50), y + (Width*25 DIV 50), x, y + (Width*25 DIV 50), Black);
           Line (x + (Width*45 DIV 50), y + (Width*25 DIV 50), x + Width, y + (Width*25 DIV 50), Black);
           Line (x + (Width*25 DIV 50), y + (Width*12 DIV 50), x + (Width*25 DIV 50), y + (Width*14 DIV 50), Black);
     | 1 : Line (x + (Width*15 DIV 50), y + (Width*30 DIV 50), x + (Width*5 DIV 50), y + (Width*45 DIV 50), Black);
           Line (x + (Width*35 DIV 50), y + (Width*30 DIV 50), x + (Width*45 DIV 50), y + (Width*45 DIV 50), Black);
           Line (x + (Width*15 DIV 50), y + (Width*20 DIV 50), x + (Width*10 DIV 50), y + (Width*10 DIV 50), Black);
           Line (x + (Width*35 DIV 50), y + (Width*20 DIV 50), x + (Width*40 DIV 50), y + (Width*40 DIV 50), Black);
  END;
END DrawMaces;

PROCEDURE DrawGlowWorms (x, y : CARDINAL);
BEGIN
   Xs[0] := x+1; Ys[0] := y+1; Xs[1] := x+10; Ys[1] := y+5; Xs[2] := x+19; Ys[2] := y+1; Xs[3] := x+10; Ys[3] := y+10; Xs[4] := x+19; Ys[4] := y+19; Xs[5] := x+10; Ys[5] := y+15; Xs[6] := x+1; Ys[6] := y+19; Xs[7] := x+10; Ys[7] := y+10;
   Polygon (8, Xs, Ys, 176);
   Ellipse (x+10,y+10,2,3,104, TRUE);
   Disc (x+10,y+4,2,1);
   Line (x+9,y+2,x+8,y,112);
   Line (x+11,y+2,x+13,y,112);
   Line (x + 7, y + 5, x + 2, y + 2, 187);
   Line (x + 13, y + 5, x + 19, y + 1, 187);
END DrawGlowWorms;

PROCEDURE DrawIceRocks (x, y, Width : CARDINAL);
VAR
	RockDots : CARDINAL;
BEGIN
	Line (x, y + Width, x + (Width*15 DIV 50), y + (Width*25 DIV 50), DarkGrey);
	Line (x + (Width*15 DIV 50), y + Width, x + (Width*22 DIV 50), y + (Width*25 DIV 50), Grey);
	Line (x + (Width*35 DIV 50), y + Width, x + (Width*27 DIV 50), y + (Width*25 DIV 50), LightGrey);
	Line (x + Width, y + Width, x + (Width*35 DIV 50), y + (Width*25 DIV 50), LightestBlue);
	Xs[0] := x + (Width*25 DIV 50); Xs[1] := x + (Width*15 DIV 50); Xs[2] := x + (Lib.RANDOM(Width*20 DIV 50) + Width - (Width*5 DIV 50));
	Xs[3] := x + (Width*35 DIV 50);
	Ys[0] := y; Ys[1] := y + (Width*25 DIV 50); Ys[2] := y + (Width*20 DIV 50); Ys[3] := y + (Width*25 DIV 50);
	Polygon (4, Xs, Ys, LightGrey);
	Line (x + (Width*25 DIV 50), y, x + (Width*15 DIV 50), y + (Width*25 DIV 50), Black);
	Line (x + (Width*25 DIV 50), y, x + (Width*35 DIV 50), y + (Width*25 DIV 50), DarkWhite);
	FOR RockDots := 1 TO 5 DO
		Plot (x + (Lib.RANDOM(Width*20 DIV 50) + (Width*15 DIV 50)), y + (Lib.RANDOM(Width*25 DIV 50) + (Width*25 DIV 50)), Grey);
	END;
END DrawIceRocks;

PROCEDURE DrawSnowMen(x, y, Width : CARDINAL);
BEGIN
	Disc (x + (Width*25 DIV 50), y + (Width*17 DIV 50), Width*7 DIV 50, DarkestWhite);
	Disc (x + (Width*27 DIV 50), y + (Width*15 DIV 50), Width*5 DIV 50, White);
	Disc (x + (Width*25 DIV 50), y + (Width*38 DIV 50), Width*12 DIV 50, DarkestWhite);
	Disc (x + (Width*27 DIV 50), y + (Width*36 DIV 50), Width*10 DIV 50, White);
	Disc (x + (Width*35 DIV 50), y + (Width*28 DIV 50), Width   DIV 50, LightestWhite);
	Line (x + (Width*15 DIV 50), y + (Width*28 DIV 50), x + (Width*5 DIV 50), y + (Width*25 DIV 50), Black);
	Line (x + (Width*35 DIV 50), y + (Width*30 DIV 50), x + (Width*45 DIV 50), y + (Width*25 DIV 50), Black);
	Graph.SetLinestyle (0AAAAH);
	HLine (x + (Width*25 DIV 50), y + (Width*20 DIV 50), x + (Width*27 DIV 50), Black);
	Graph.SetLinestyle (0FFFFH);
	Rectangle (x + (Width*20 DIV 50), y + (Width*5 DIV 50), x + (Width*30 DIV 50), y + (Width*10 DIV 50), Black, TRUE);
	CASE y MOD 8 OF
		| 0,1 : Plot (x + (Width*20 DIV 50), y + (Width*15 DIV 50), Black);
		   	  Plot (x + (Width*25 DIV 50), y + (Width*15 DIV 50), Black);
		| 2,3,6,7 : Plot (x + (Width*23 DIV 50), y + (Width*15 DIV 50), Black);
				  Plot (x + (Width*28 DIV 50), y + (Width*15 DIV 50), Black);
		| 4,5 : Plot (x + (Width*25 DIV 50), y + (Width*15 DIV 50), Black);
				  Plot (x + (Width*30 DIV 50), y + (Width*15 DIV 50), Black);
	END;
END DrawSnowMen;

PROCEDURE SnowBall(x, y, Width : CARDINAL);
BEGIN
	Disc (x, y, Width*7 DIV 50, DarkestWhite);
	Disc (x + 1, y - 1, Width*4 DIV 50, White);
	Disc (x + 1, y - 1, Width*2 DIV 50, LightestWhite);
END SnowBall;

PROCEDURE DrawSnowBalls(x, y, Width : CARDINAL);
BEGIN
	SnowBall (x + (Width*25 DIV 50), y + (Width*8 DIV 50), Width);
	SnowBall (x + (Width*17 DIV 50), y + (Width*25 DIV 50), Width);
	SnowBall (x + (Width*33 DIV 50), y + (Width*25 DIV 50), Width);
	SnowBall (x + (Width*8 DIV 50), y + (Width*43 DIV 50), Width);
	SnowBall (x + (Width*25 DIV 50), y + (Width*43 DIV 50), Width);
	SnowBall (x + (Width*43 DIV 50), y + (Width*43 DIV 50), Width);
END DrawSnowBalls;

PROCEDURE DrawSkiiers(x, y, Width : CARDINAL);
BEGIN
   Disc (x + (Width*13 DIV 50), y + (Width*5 DIV 50), Width*3 DIV 50, Black);
   Disc (x + (Width*38 DIV 50), y + (Width*5 DIV 50), Width*3 DIV 50, Black);
   Line (x + (Width*13 DIV 50), y + (Width*5 DIV 50), x + (Width*13 DIV 50), y + (Width*25 DIV 50), Black);
   Line (x + (Width*38 DIV 50), y + (Width*5 DIV 50), x + (Width*38 DIV 50), y + (Width*25 DIV 50), Black);
   Line (x + (Width*38 DIV 50), y + (Width*25 DIV 50), x + (Width*10 DIV 50), y + (Width*38 DIV 50), Black);
   Line (x + (Width*38 DIV 50), y + (Width*25 DIV 50), x + (Width*35 DIV 50), y + (Width*38 DIV 50), Black);
   Line (x + (Width*38 DIV 50), y + (Width*25 DIV 50), x + (Width*16 DIV 50), y + (Width*25 DIV 50), Black);
   Line (x + (Width*38 DIV 50), y + (Width*25 DIV 50), x + (Width*41 DIV 50), y + (Width*25 DIV 50), Black);
   Rectangle (x + (Width*9 DIV 50), y + (Width*20 DIV 50), x + (Width*11 DIV 50), y + (Width*40 DIV 50), Black, TRUE);
   Rectangle (x + (Width*15 DIV 50), y + (Width*20 DIV 50), x + (Width*17 DIV 50), y + (Width*40 DIV 50), Black, TRUE);
   Rectangle (x + (Width*34 DIV 50), y + (Width*20 DIV 50), x + (Width*40 DIV 50), y + (Width*40 DIV 50), Black, TRUE);
   Rectangle (x + (Width*37 DIV 50), y + (Width*20 DIV 50), x + (Width*40 DIV 50), y + (Width*40 DIV 50), Black, TRUE);
END DrawSkiiers;

END Sprites.
