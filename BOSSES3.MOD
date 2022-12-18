IMPLEMENTATION MODULE Bosses3;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius, Font;
FROM Graph IMPORT Point, Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;
FROM Lib IMPORT Sound, NoSound, Delay, RANDOM;
FROM Sprites IMPORT DrawSpinners;
FROM Screens8 IMPORT DrawStars8, DrawPlanet, PlanetRadius;
FROM Font IMPORT A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
FROM Exobius IMPORT
    SolidFill, PlaneWidth, PlaneHeight,
    EnemyYStart, PlaneXMin, CollisionY,
    Black, DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue, DarkestRed,
    DarkRed, Red, LightRed, LightestRed, DarkestBrown, DarkBrown,
    Brown, LightBrown, LightestBrown, DarkestGreen, DarkGreen, Green, LightGreen,
    LightestGreen, DarkestYellow, DarkYellow, Yellow, LightYellow,
    LightestYellow, PlaneX,  Enemy1X, Enemy2X, Enemy3X, Enemy4X, Enemy5X,
    Enemy6X, Enemies, BulletX, BulletY, PlaneY, CoverRectangleX,
    Count, Lives, EnemyY, BkColour,
    OldBkColor,  Xs, Ys, OneAlive, TwoAlive, ThreeAlive, FourAlive, FiveAlive,
    SixAlive, ScreenComplete, GameOver,  MouseButtons,  MouseMove, GameSpeed,
    Update3DBullet, DrawPlane, CheckMouse, Die,
    FinishScreen, Key, PlaneXMove, Score,
    BkAddress, DrawGameOver, TextPos;

VAR
    Boss3Y3, Boss3X3 : CARDINAL;
    Boss3Lives : INTEGER;
    BossDiving : BOOLEAN;

PROCEDURE DrawBoss3(x, y : CARDINAL);
VAR
  WingColour, WingColour2, WingTip : CARDINAL;
BEGIN
    Xs[0] := x+40; Ys[0] := y+15; Xs[1] := x+50; Ys[1] := y+30; Xs[2] := x+60; Ys[2] := y+15;
    Polygon (3, Xs, Ys, Red);
    Xs[0] := x+45; Ys[0] := y+15; Xs[1] := x+50; Ys[1] := y+24; Xs[2] := x+55; Ys[2] := y+15;
    Polygon (3, Xs, Ys, Red);
    Disc (x+43,y+10,2,Blue);
    Disc (x+57,y+10,2,Blue);
    IF NOT BossDiving THEN
       Xs[0] := x+40; Ys[0] := y+14; Xs[1] := x+50; Ys[1] := y+4; Xs[2] := x+60; Ys[2] := y+14;
       Polygon (3, Xs, Ys, LightestRed);
    END;
    Line (x+50,y+7,x+50,y+14,Red);
    Line (x+48,y+9,x+47,y+14,Red);
    Line (x+52,y+9,x+53,y+14,Red);
    CASE (x MOD 10) OF
         |  0,9,10,11  : WingTip := y; WingColour := DarkestGrey; WingColour2 := LightWhite;
         |  1,2,18,19  : WingTip := y+2; WingColour := Grey; WingColour2 := DarkWhite;
         |  3,4,16,17  : WingTip := y+4; WingColour := LightGrey; WingColour2 := LightestGrey;
         |  5,6,14,15  : WingTip := y+6; WingColour := DarkWhite; WingColour2 := Grey;
         |  7,8,12,13  : WingTip := y+8; WingColour := LightWhite; WingColour2 := DarkGrey;
    END;
    Xs[0] := x; Xs[1] := x+25; Xs[2] := x + 25;
    Ys[0] := y+30; Ys[1] := WingTip; Ys[2] := WingTip + 20;
    Polygon (3, Xs, Ys, WingColour);
    Xs[0] := x + 100; Xs[1] := x + 75; Xs[2] := x+75;
    Polygon (3, Xs, Ys, WingColour);
    Xs[0] := x + 25; Xs[1] := x + 25; Xs[2] := x + 50; Xs[3] := x + 40;
    Ys[0] := WingTip; Ys[1] := WingTip + 20; Ys[2] := y + 30; Ys[3] := y + 15;
    Polygon (4, Xs, Ys, WingColour2);
    Xs[0] := x + 75; Xs[1] := x + 75; Xs[2] := x + 50; Xs[3] := x + 60;
    Polygon (4, Xs, Ys, WingColour2);
END DrawBoss3;

PROCEDURE HurtBoss3;
BEGIN
    Sound (100);
    Xs[0] := Boss3X3; Xs[1] := Boss3X3 + 25; Xs[2] := Boss3X3 + 50;
          Xs[3] := Boss3X3 + 75; Xs[4] := Boss3X3 + 100; Xs[5] := Boss3X3 + 75;
          Xs[6] := Boss3X3 + 50; Xs[7] := Boss3X3 + 25;
    Ys[0] := Boss3Y3 + 30; Ys[1] := Boss3Y3; Ys[2] := Boss3Y3 + 15;
          Ys[3] := Boss3Y3; Ys[4] := Boss3Y3 + 30; Ys[5] := Boss3Y3 + 20;
          Ys[6] := Boss3Y3 + 30; Ys[7] := Boss3Y3 + 20;
    Polygon (8, Xs, Ys, LightestWhite);
    Boss3Lives := Boss3Lives - 1;
    IF (Boss3Lives=0) THEN
       ScreenComplete := TRUE;
    END;
    Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
    Rectangle (1, 1, 318, 9, Black, TRUE);
    Rectangle (1, 1, Boss3Lives*4, 9, Red, TRUE);
    Rectangle (0, 0, 319, 10, White, FALSE);
    Graph.GetImage (0, 0, 320, 200, BkAddress);
    NoSound;
END HurtBoss3;

PROCEDURE FinishScreenBoss3;
BEGIN
  FOR PlaneY := 175 TO 100 BY -2 DO
     IF (PlaneX<155) THEN
        PlaneX := PlaneX + 5;
     END;
     IF (PlaneX>155) THEN
        PlaneX := PlaneX - 5;
     END;
     Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
     DrawPlane (PlaneX, PlaneY, ((PlaneY - 100) DIV 2));
     DrawStars8;
     Delay (40);
  END;
  Graph.ClearScreen(Graph._GCLEARSCREEN);
END FinishScreenBoss3;

PROCEDURE KillBoss3;
VAR
  Explosions, Colour : CARDINAL;
BEGIN
  TextPos := Graph.SetTextPosition (1, 15);
  Graph.OutText ("Extra Life!");
  ScreenComplete := TRUE;
  FOR Explosions := 200 TO 0 BY -1 DO
     Sound (Explosions);
     CASE (Lib.RANDOM(10)) OF
        | 1 : Colour := DarkestRed;
        | 2 : Colour := DarkRed;
        | 3 : Colour := Red;
        | 4 : Colour := LightRed;
        | 5 : Colour := LightestRed;
        | 6 : Colour := DarkestYellow;
        | 7 : Colour := DarkYellow;
        | 8 : Colour := Yellow;
        | 9 : Colour := LightYellow;
        |10 : Colour := LightestYellow;
     END;
     Ellipse (Lib.RANDOM(100) + CARDINAL(Boss3X3), Lib.RANDOM(30) + Boss3Y3, Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
     Plot (Lib.RANDOM(100) + CARDINAL(Boss3X3), Lib.RANDOM(30) + Boss3Y3, Colour);
     Delay(10);
     NoSound;
  END;
END KillBoss3;

PROCEDURE DrawBullet8Boss;
VAR
    BossLeft, BossRight : CARDINAL;
BEGIN
    Line (PlaneX + (PlaneWidth DIV 2), PlaneY-1, PlaneX + (PlaneWidth DIV 2), 0, White);
    Line (PlaneX + (PlaneWidth DIV 2)-1, PlaneY-1, PlaneX + (PlaneWidth DIV 2), 0, LightBlue);
    Line (PlaneX + (PlaneWidth DIV 2)+1, PlaneY-1, PlaneX + (PlaneWidth DIV 2), 0, LightBlue);
    IF (Boss3X3 < 30) THEN BossLeft := 0; ELSE BossLeft := Boss3X3 - 30; END;
    IF (Boss3X3 > 239) THEN BossRight := 319; ELSE BossRight := Boss3X3 + 80; END;
    IF (PlaneX > BossLeft) AND (PlaneX < BossRight) THEN
       HurtBoss3;
    END;
END DrawBullet8Boss;

PROCEDURE Boss3;
VAR
    Boss3Move : CARDINAL;
CONST
    BossDive = 20;
    Boss3YTop = 20;
BEGIN
    Boss3Lives := 80; GameOver := FALSE; ScreenComplete := FALSE;
    Graph.ClearScreen (Graph._GCLEARSCREEN);
    DrawPlanet (160, 100, PlanetRadius);
    Rectangle (1, 1, 318, 9, Black, TRUE);
    Rectangle (1, 1, Boss3Lives*4, 9, Red, TRUE);
    Rectangle (0, 0, 319, 10, White, FALSE);
    Graph.GetImage (0, 0, 320, 200, BkAddress);
    Boss3X3 := 160;
    BossDiving := FALSE;
    FOR Boss3Y3 := 200 TO Boss3YTop BY -(BossDive) DO
        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
        DrawPlane (PlaneX, PlaneY, PlaneWidth);
        DrawBoss3 (Boss3X3, Boss3Y3);
    END;
    WHILE NOT (GameOver) AND NOT (ScreenComplete) DO
          IF NOT (GameOver) AND NOT (ScreenComplete) THEN
             Delay (GameSpeed);
             Boss3Move := Lib.RANDOM(5)+1;
             Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
             DrawPlane (PlaneX, PlaneY, PlaneWidth);
             IF (PlaneX<Boss3X3) THEN
                Boss3X3 := Boss3X3 - Boss3Move;
             ELSIF (PlaneX>Boss3X3) THEN
                Boss3X3 := Boss3X3 + Boss3Move;
             END;
             DrawBoss3 (Boss3X3, Boss3Y3);
             CheckMouse;
             IF (BulletY=5) THEN
                BulletY := 0;
                DrawBullet8Boss;
             END;
             DrawStars8;
             IF (PlaneX>Boss3X3-10) AND (PlaneX<=Boss3X3+50) THEN
                Boss3Y3 := Boss3YTop; BossDiving := TRUE;
                WHILE (Boss3Y3<170) AND NOT (GameOver) AND NOT (ScreenComplete) DO
                  IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                    Boss3Y3 := Boss3Y3 + BossDive;
                    Delay (GameSpeed);
                    Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                    DrawBoss3 (Boss3X3, Boss3Y3);
                    DrawPlane (PlaneX, PlaneY, PlaneWidth);
                    CheckMouse;
                    IF (BulletY=5) THEN
                       BulletY := 0;
                       DrawBullet8Boss;
                    END;
                    DrawStars8;
                    IF (Boss3Y3>140) AND (PlaneX>Boss3X3-35) AND (PlaneX<(Boss3X3+85)) THEN
                       Die;
                    END;
                  END;
                END;
                Boss3Y3 := 180;
                WHILE (Boss3Y3>Boss3YTop) AND NOT (GameOver) AND NOT (ScreenComplete) DO
                  IF NOT (GameOver) AND NOT (ScreenComplete) THEN
                    Boss3Y3 := Boss3Y3 - BossDive;
                    Delay (GameSpeed);
                    Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                    DrawBoss3 (Boss3X3, Boss3Y3);
                    DrawPlane (PlaneX, PlaneY, PlaneWidth);
                    CheckMouse;
                    IF (BulletY=5) THEN
                       BulletY := 0;
                       DrawBullet8Boss;
                    END;
                    DrawStars8;
                    IF (Boss3Y3>140) AND ((PlaneX>(Boss3X3-35)) AND (PlaneX<(Boss3X3+85))) THEN
                       Die;
                    END;
                  END;
                END;
             END;
             BossDiving := FALSE;
          END;
    END;
    IF (ScreenComplete) THEN
       KillBoss3;
       FinishScreenBoss3;
    END;
    IF (GameOver) THEN
       DrawGameOver;
    END;
    IF (ScreenComplete) AND (Lives>0) THEN
       Lives := Lives - 1;
    END;
END Boss3;

END Bosses3.
