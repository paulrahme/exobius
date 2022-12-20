IMPLEMENTATION MODULE Sprites;

IMPORT Graph, Lib;

FROM Graph IMPORT
  Rectangle, Polygon, Line, HLine, Ellipse, Disc, Plot;

FROM Exobius IMPORT
  Black,
  DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
  DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
  DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
  DarkestRed, DarkRed, Red, LightRed, LightestRed,
  DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
  DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
  DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
  Xs, Ys;

PROCEDURE DrawBoomGuards(x, y, Width : CARDINAL);
VAR
      Width3, Width5, Width10, Width15, Width25, Width30,  Width35, Width40 : CARDINAL;
BEGIN
      Width3 := Width * 3 DIV 50;
      Width5 := Width DIV 10;
      Width10 := Width DIV 5;
      Width15 := Width * 15 DIV 50;
      Width25 := Width DIV 2;
      Width30 := Width * 3 DIV 5;
      Width35 := Width * 35 DIV 50;
      Width40 := Width * 4 DIV 5;

      (* Guards' heads + bodies *)
      Disc(x + Width5, y + Width25, Width3, Black);
      Disc(x + Width30, y + Width25, Width3, Black);
      Line(x + Width5, y + Width25, x + Width5, y + Width40, Black);
      Line(x + Width30, y + Width25, x + Width30, y + Width40, Black);
      Line(x + Width5, y + Width40, x, y + Width, Black);
      Line(x + Width30, y + Width40, x + Width25, y + Width, Black);
      Line(x + Width5, y + Width40, x + Width10, y + Width, Black);
      Line(x + Width30, y + Width40, x + Width35, y + Width, Black);
      (* Guards' waving arms *)
      CASE (y MOD 4) OF
          |0: Line(x, y + Width30, x + Width15, y + Width40, Black);
            Line(x + Width25, y + Width30, x + Width40, y + Width40, Black);
          |1,3: HLine(x, y + Width35, x + Width15, Black);
            HLine(x + Width25, y + Width35, x + Width40, Black);
          |2: Line(x, y + Width40, x + Width15, y + Width30, Black);
            Line(x + Width25, y + Width40, x + Width40, y + Width30, Black);
      END;
      (* Boom stands *)
      Rectangle(x + (Width*12 DIV 50), y + Width35, x + (Width*14 DIV 50), y + Width, Black, FALSE);
      Rectangle(x + (Width*38 DIV 50), y + Width35, x + Width40, y + Width, Black, FALSE);
      (* Boom beams *)
      HLine(x + (Width*16 DIV 50), y + Width35, x + Width25, Yellow);
      HLine(x + (Width*41 DIV 50), y + Width35, x + Width, Yellow);
      Graph.SetLinestyle(0AAAAH);
      Line(x + (Width*16 DIV 50), y + Width35, x + Width25, y + Width35, Black);
      Line(x + (Width*41 DIV 50), y + Width35, x + Width, y + Width35, Black);
      Graph.SetLinestyle(0FFFFH);
END DrawBoomGuards;

PROCEDURE DrawSpinners(x, y, Width : CARDINAL);
VAR
    DiskX, DiskY, Width1, Width3, Width5, Width7, Width9, YMod3 : CARDINAL;
BEGIN
    Width1 := Width DIV 50;
    Width3 := Width * 3 DIV 50;
    Width5 := Width DIV 10;
    Width7 := Width * 7 DIV 50;
    Width9 := Width * 9 DIV 50;
    YMod3 := y MOD 3;

    Disc(x + (Width*25 DIV 50), y + (Width * 25 DIV 50), Width9, DarkestGreen);
    Disc(x + (Width*26 DIV 50), y + (Width * 24 DIV 50), Width7, DarkGreen);
    Disc(x + (Width*27 DIV 50), y + (Width * 23 DIV 50), Width5, Green);
    Disc(x + (Width*28 DIV 50), y + (Width * 22 DIV 50), Width3, LightGreen);
    Disc(x + (Width*29 DIV 50), y + (Width * 21 DIV 50), Width1, LightestGreen);

    CASE (YMod3) OF
        |0: DiskX := 9;
            DiskY := 25;
        |1: DiskX := 12;
            DiskY := 17;
        |2: DiskX := 17;
            DiskY := 12;
    END;
    Disc (x + (Width*DiskX DIV 50), y + (Width*DiskY DIV 50), Width*9 DIV 50, DarkestBrown);
    Disc (x + (Width*(DiskX+1) DIV 50), y + (Width*(DiskY-1) DIV 50), Width*7 DIV 50, DarkBrown);
    Disc (x + (Width*(DiskX+2) DIV 50), y + (Width*(DiskY-2) DIV 50), Width*5 DIV 50, Brown);
    Disc (x + (Width*(DiskX+3) DIV 50), y + (Width*(DiskY-3) DIV 50), Width*3 DIV 50, LightBrown);
    Disc (x + (Width*(DiskX+4) DIV 50), y + (Width*(DiskY-4) DIV 50), Width   DIV 50, LightestBrown);
    CASE (YMod3) OF
        |0: DiskX := 25;
            DiskY := 9;
        |1: DiskX := 33;
            DiskY := 12;
        |2: DiskX := 38;
            DiskY := 17;
    END;
    Disc (x + (Width*DiskX DIV 50), y + (Width*DiskY DIV 50), Width*9 DIV 50, DarkestBrown);
    Disc (x + (Width*(DiskX+1) DIV 50), y + (Width*(DiskY-1) DIV 50), Width*7 DIV 50, DarkBrown);
    Disc (x + (Width*(DiskX+2) DIV 50), y + (Width*(DiskY-2) DIV 50), Width*5 DIV 50, Brown);
    Disc (x + (Width*(DiskX+3) DIV 50), y + (Width*(DiskY-3) DIV 50), Width*3 DIV 50, LightBrown);
    Disc (x + (Width*(DiskX+4) DIV 50), y + (Width*(DiskY-4) DIV 50), Width   DIV 50, LightestBrown);
    CASE (YMod3) OF
        |0: DiskX := 41;
            DiskY := 25;
        |1: DiskX := 38;
            DiskY := 33;
        |2: DiskX := 33;
            DiskY := 38;
    END;
    Disc (x + (Width*DiskX DIV 50), y + (Width*DiskY DIV 50), Width*9 DIV 50, DarkestBrown);
    Disc (x + (Width*(DiskX+1) DIV 50), y + (Width*(DiskY-1) DIV 50), Width*7 DIV 50, DarkBrown);
    Disc (x + (Width*(DiskX+2) DIV 50), y + (Width*(DiskY-2) DIV 50), Width*5 DIV 50, Brown);
    Disc (x + (Width*(DiskX+3) DIV 50), y + (Width*(DiskY-3) DIV 50), Width*3 DIV 50, LightBrown);
    Disc (x + (Width*(DiskX+4) DIV 50), y + (Width*(DiskY-4) DIV 50), Width   DIV 50, LightestBrown);
    CASE (YMod3) OF
        |0: DiskX := 25;
            DiskY := 41;
        |1: DiskX := 17;
            DiskY := 38;
        |2: DiskX := 12;
            DiskY := 33;
    END;
    Disc (x + (Width*DiskX DIV 50), y + (Width*DiskY DIV 50), Width*9 DIV 50, DarkestBrown);
    Disc (x + (Width*(DiskX+1) DIV 50), y + (Width*(DiskY-1) DIV 50), Width*7 DIV 50, DarkBrown);
    Disc (x + (Width*(DiskX+2) DIV 50), y + (Width*(DiskY-2) DIV 50), Width*5 DIV 50, Brown);
    Disc (x + (Width*(DiskX+3) DIV 50), y + (Width*(DiskY-3) DIV 50), Width*3 DIV 50, LightBrown);
    Disc (x + (Width*(DiskX+4) DIV 50), y + (Width*(DiskY-4) DIV 50), Width   DIV 50, LightestBrown);
END DrawSpinners;

PROCEDURE DrawPlants(x, y, Width : CARDINAL);
VAR
      Width10, Width14, Width25 : CARDINAL;
BEGIN
    Width10 := Width DIV 5;
    Width25 := Width DIV 2;

    (* Plant base *)
    Line(x + Width10, y + (Width25), x + (Width*40 DIV 50), y + (Width25), DarkestRed);
    Line(x + (Width25), y + (Width25), x + (Width25), y + Width, DarkestRed);
    Disc(x + (Width25), y + (Width25), Width10, DarkestRed);
    Disc(x + (Width*26 DIV 50), y + (Width*24 DIV 50), Width*8 DIV 50, DarkRed);
    Disc(x + (Width*27 DIV 50), y + (Width*23 DIV 50), Width*6 DIV 50, Red);
    Disc(x + (Width*28 DIV 50), y + (Width*22 DIV 50), Width*4 DIV 50, LightRed);
    Plot(x + (Width*29 DIV 50), y + (Width*21 DIV 50), LightestRed);
    (* Bobble on top *)
    CASE (y MOD 4) OF
        |0: Line(x + (Width25), y + (Width*14 DIV 50), x + Width10, y + Width10, LightBlue);
            Disc(x + Width10, y + Width10, Width*4 DIV 50, DarkestYellow);
            Plot(x + (Width*11 DIV 50), y + (Width*9 DIV 50), LightYellow);
        |1: Line(x + (Width25), y + (Width*14 DIV 50), x + (Width25), y + (Width*5 DIV 50), LightBlue);
            Disc(x + (Width25), y + (Width*5 DIV 50), Width*4 DIV 50, DarkestYellow);
            Plot(x + (Width*26 DIV 50), y + (Width*4 DIV 50), LightYellow);
        |2: Line(x + (Width25), y + (Width*14 DIV 50), x + (Width*40 DIV 50), y + Width10, LightBlue);
            Disc(x + (Width*40 DIV 50), y + Width10, Width*4 DIV 50, DarkestYellow);
            Plot(x + (Width*41 DIV 50), y + (Width*9 DIV 50), LightYellow);
        |3: Line(x + (Width25), y + (Width*14 DIV 50), x + (Width25), y + (Width*5 DIV 50), LightBlue);
            Disc(x + (Width25), y + (Width*5 DIV 50), Width*4 DIV 50, DarkestYellow);
            Plot(x + (Width*26 DIV 50), y + (Width*4 DIV 50), LightYellow);
    END;
END DrawPlants;

PROCEDURE DrawFlyTraps(x, y, Width : CARDINAL);
VAR
    Width15, Width20, Width25, Width30 : CARDINAL;
BEGIN
    Width15 := Width * 15 DIV 50;
    Width20 := Width * 20 DIV 50;
    Width25 := Width * 25 DIV 50;
    Width30 := Width * 30 DIV 50;

    (* Stalk + head *)
    HLine(x, y + Width, x + Width, Black);
    Line(x + Width25, y, x + Width, y + Width, Black);
    Disc(x + Width25, y + Width20, Width15, DarkestBlue);
    Disc(x + (Width*26 DIV 50), y + (Width*19 DIV 50), Width*13 DIV 50, DarkBlue);
    Disc(x + (Width*27 DIV 50), y + (Width*18 DIV 50), Width*11 DIV 50, Blue);
    Disc(x + (Width*28 DIV 50), y + (Width*17 DIV 50), Width*9 DIV 50, LightBlue);
    Disc(x + (Width*29 DIV 50), y + (Width*16 DIV 50), Width*7 DIV 50, LightestBlue);
    Disc(x + Width30, y + Width15, Width*3 DIV 50, LightestWhite);
    (* Tongue *)
    CASE (y MOD 4) OF
        |0: HLine(x + (Width*10 DIV 50), y + Width25, x + (Width*40 DIV 50), DarkestRed);
        |1: Ellipse(x + Width25, y + Width20, Width15, Width*5 DIV 50, DarkestRed, TRUE);
            Line(x + Width20, y + Width15, x + Width20, y + Width20, White);
            Line(x + Width30, y + Width15, x + Width30, y + Width20, White);
        |2: Ellipse(x + Width25, y + Width20, Width15, Width*5 DIV 50, DarkestRed, TRUE);
            Line(x + Width20, y + Width15, x + Width20, y + Width20, White);
            Line(x + Width30, y + Width15, x + Width30, y + Width20, White);
            Rectangle(x + (Width*23 DIV 50), y + Width20, x + (Width*27 DIV 50), y + (Width*40 DIV 50), LightRed, TRUE);
        |3: Ellipse(x + Width25, y + Width20, Width15, Width*5 DIV 50, DarkestRed, TRUE);
            Line(x + Width20, y + Width15, x + Width20, y + Width20, White);
            Line(x + Width30, y + Width15, x + Width30, y + Width20, White);
    END;
END DrawFlyTraps;

PROCEDURE DrawMaces(x, y, Width : CARDINAL);
VAR
    Width5, Width10, Width15, Width20, Width25, Width45 : CARDINAL;
BEGIN
    Width5 := Width DIV 10;
    Width10 := Width * 10 DIV 50;
    Width15 := Width * 15 DIV 50;
    Width20 := Width * 20 DIV 50;
    Width25 := Width * 25 DIV 50;
    Width45 := Width * 45 DIV 50;

    (* Base disc *)
    Ellipse(x + Width25, y + Width25, Width*20 DIV 50, Width10, DarkestGrey, TRUE);
    Ellipse(x + (Width*26 DIV 50), y + (Width*24 DIV 50), Width*18 DIV 50, Width*9 DIV 50, DarkGrey, TRUE);
    Ellipse(x + (Width*27 DIV 50), y + (Width*23 DIV 50), Width*16 DIV 50, Width*8 DIV 50, Grey, TRUE);
    Ellipse(x + (Width*28 DIV 50), y + (Width*22 DIV 50), Width*14 DIV 50, Width*7 DIV 50, LightGrey, TRUE);
    Ellipse(x + (Width*29 DIV 50), y + (Width*21 DIV 50), Width*12 DIV 50, Width*6 DIV 50, LightestGrey, TRUE);
    Ellipse(x + (Width*30 DIV 50), y + Width20, Width10, Width5, DarkestWhite, TRUE);
    Ellipse(x + (Width*31 DIV 50), y + (Width*19 DIV 50), Width*8 DIV 50, Width*4 DIV 50, DarkWhite, TRUE);
    Ellipse(x + (Width*32 DIV 50), y + (Width*18 DIV 50), Width*6 DIV 50, Width*3 DIV 50, White, TRUE);
    Ellipse(x + (Width*33 DIV 50), y + (Width*17 DIV 50), Width*4 DIV 50, Width*2 DIV 50, LightWhite, TRUE);
    Ellipse(x + (Width*34 DIV 50), y + (Width*16 DIV 50), Width*2 DIV 50, Width   DIV 50, LightestWhite, TRUE);
    (* Spikes *)
    CASE (y MOD 2) OF
        |0: Line(x + Width25, y + (Width*34 DIV 50), x + Width25, y + Width, Black);
            Line(x + Width25, y + (Width*12 DIV 50), x + Width25, y + (Width*14 DIV 50), Black);
            HLine(x, y + Width25, x + Width5, Black);
            HLine(x + Width45, y + Width25, x + Width, Black);
        |1: Line(x + Width10, y + Width10,x + Width15, y + Width15, Black);
            Line(x + (Width*40 DIV 50), y + Width10, x + (Width*35 DIV 50), y + Width15, Black);
            Line(x, y + Width45, x + Width15, y + (Width*30 DIV 50), Black);
            Line(x + Width, y + Width45, x + (Width*35 DIV 50), y + (Width*30 DIV 50), Black);
    END;
END DrawMaces;

PROCEDURE DrawGlowWorms(x, y : CARDINAL);
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

PROCEDURE DrawIceRocks(x, y, Width : CARDINAL);
VAR
    Width15, Width20, Width25, Width35, RockDots : CARDINAL;
BEGIN
    Width15 := Width * 15 DIV 50;
    Width20 := Width * 20 DIV 50;
    Width25 := Width DIV 2;
    Width35 := Width * 35 DIV 50;

    Line(x, y + Width, x + Width15, y + Width25, DarkGrey);
    Line(x + Width15, y + Width, x + (Width*22 DIV 50), y + Width25, Grey);
    Line(x + Width35, y + Width, x + (Width*27 DIV 50), y + Width25, LightGrey);
    Line(x + Width, y + Width, x + Width35, y + Width25, LightestBlue);
    Xs[0] := x + Width25; Xs[1] := x + Width15; Xs[2] := x + Width20 + Lib.RANDOM(Width DIV 5); Xs[3] := x + Width35;
    Ys[0] := y; Ys[1] := y + Width25; Ys[2] := y + Width20; Ys[3] := y + Width25;
    Polygon(4, Xs, Ys, LightGrey);
    Line(x + Width25, y, x + Width15, y + Width25, Black);
    Line(x + Width25, y, x + Width35, y + Width25, DarkWhite);
    FOR RockDots := 1 TO 5 DO
        Plot(x + Lib.RANDOM(Width20 + Width15), y + (Lib.RANDOM(Width25) + Width25), Grey);
    END;
END DrawIceRocks;

PROCEDURE DrawSnowMen(x, y, Width : CARDINAL);
VAR
    Width5, Width15, Width20, Width25, Width27, Width30, Width35 : CARDINAL;
BEGIN
    Width5 := Width DIV 10;
    Width15 := Width * 15 DIV 50;
    Width20 := Width * 20 DIV 50;
    Width25 := Width DIV 2;
    Width27 := Width * 27 DIV 50;
    Width30 := Width * 3 DIV 5;
    Width35 := Width * 35 DIV 50;

    Disc(x + Width25, y + (Width*17 DIV 50), Width*7 DIV 50, DarkestWhite);
    Disc(x + Width27, y + Width15, Width*5 DIV 50, White);
    Disc(x + Width25, y + (Width*38 DIV 50), Width*12 DIV 50, DarkestWhite);
    Disc(x + Width27, y + (Width*36 DIV 50), Width*10 DIV 50, White);
    Disc(x + Width35, y + (Width*28 DIV 50), Width DIV 50, LightestWhite);
    Line(x + Width15, y + (Width*28 DIV 50), x + Width5, y + Width25, Black);
    Line(x + Width35, y + Width30, x + (Width*45 DIV 50), y + Width25, Black);
    Graph.SetLinestyle(0AAAAH);
    Line(x + Width25, y + Width20, x + Width27, y + Width20, Black);
    Graph.SetLinestyle(0FFFFH);
    Rectangle(x + Width20, y + Width5, x + Width30, y + (Width*10 DIV 50), Black, TRUE);
    CASE y MOD 8 OF
        |0,1: Plot(x + Width20, y + Width15, Black);
            Plot(x + Width25, y + Width15, Black);
        |2,3,6,7: Plot(x + (Width*23 DIV 50), y + Width15, Black);
            Plot(x + (Width*28 DIV 50), y + Width15, Black);
        |4,5: Plot (x + Width25, y + Width15, Black);
            Plot(x + Width30, y + Width15, Black);
    END;
END DrawSnowMen;

PROCEDURE SnowBall(x, y, Width : CARDINAL);
BEGIN
    Disc(x, y, Width*7 DIV 50, DarkestWhite);
    Disc(x + 1, y - 1, Width*4 DIV 50, White);
    Disc(x + 1, y - 1, Width*2 DIV 50, LightestWhite);
END SnowBall;

PROCEDURE DrawSnowBalls(x, y, Width : CARDINAL);
VAR
    Width8, Width25, Width43 : CARDINAL;
BEGIN
    Width8 := Width * 8 DIV 50;
    Width25 := Width DIV 2;
    Width43 := Width * 43 DIV 50;

    SnowBall(x + Width25, y + Width8, Width);
    SnowBall(x + (Width*17 DIV 50), y + Width25, Width);
    SnowBall(x + (Width*33 DIV 50), y + Width25, Width);
    SnowBall(x + Width8, y + Width43, Width);
    SnowBall(x + Width25, y + Width43, Width);
    SnowBall(x + Width43, y + Width43, Width);
END DrawSnowBalls;

PROCEDURE DrawSkiiers(x, y, Width : CARDINAL);
VAR
    Width4, Width5, Width8, Width13, Width20, Width25, Width38, Width40 : CARDINAL;
BEGIN
    Width4 := Width * 4 DIV 50;
    Width5 := Width DIV 10;
    Width8 := Width * 8 DIV 50;
    Width13 := Width * 13 DIV 50;
    Width20 := Width * 2 DIV 5;
    Width25 := Width DIV 2;
    Width38 := Width * 38 DIV 50;
    Width40 := Width * 4 DIV 5;

    (* Skis *)
    Rectangle(x + (Width*9 DIV 50), y + Width20, x + (Width*11 DIV 50), y + Width, DarkBlue, FALSE);
    Rectangle(x + (Width*15 DIV 50), y + Width20, x + (Width*17 DIV 50), y + Width, DarkBlue, FALSE);
    Rectangle(x + (Width*34 DIV 50), y + Width20, x + (Width*36 DIV 50), y + Width, DarkBlue, FALSE);
    Rectangle(x + Width40, y + Width20, x + (Width*42 DIV 50), y + Width, DarkBlue, FALSE);

    (* Heads + bodies *)
    Line(x + Width13, y + Width5, x + Width13, y + Width25, Red);
    Disc(x + Width13, y + Width5, Width4, DarkestRed);
    Line(x + Width38, y + Width5, x + Width38, y + Width25, Yellow);
    Disc(x + Width38, y + Width5, Width4, DarkestYellow);

    (* Arms + legs *)
    Line(x + Width13, y + Width8, x + (Width*10 DIV 50), y + Width25, DarkRed);
    Line(x + Width13, y + Width8, x + (Width*16 DIV 50), y + Width25, DarkRed);
    Line(x + Width13, y + Width25, x + (Width*10 DIV 50), y + Width38, DarkRed);
    Line(x + Width13, y + Width25, x + (Width*16 DIV 50), y + Width38, DarkRed);
    Line(x + Width38, y + Width8, x + (Width*35 DIV 50), y + Width25, DarkYellow);
    Line(x + Width38, y + Width8, x + (Width*41 DIV 50), y + Width25, DarkYellow);
    Line(x + Width38, y + Width25, x + (Width*35 DIV 50), y + Width38, DarkYellow);
    Line(x + Width38, y + Width25, x + (Width*41 DIV 50), y + Width38, DarkYellow);
END DrawSkiiers;

PROCEDURE RandomBrown() : CARDINAL;
BEGIN
    CASE Lib.RANDOM(5) OF
        |1: RETURN LightestBrown;
        |2: RETURN LightBrown;
        |3: RETURN Brown;
        |4: RETURN DarkBrown;
        |0,5: RETURN DarkestBrown;
   END;
END RandomBrown;

END Sprites.
