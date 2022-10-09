IMPLEMENTATION MODULE Bosses4;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

IMPORT Str, Graph, Lib, IO, Window, Storage, MsMouse, Exobius, Font;
FROM Graph IMPORT Point, SetClipRgn, SetVideoMode, Rectangle, GraphMode, TextMode, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;
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

PROCEDURE WritePlayExobius(x, y, Width : CARDINAL);
BEGIN
    Line (x+Width*59 DIV 150,y+Width*120 DIV 150,x+Width*79 DIV 150,y+Width*133 DIV 150,Red);
    Line (x+Width*41 DIV 150,y+Width*120 DIV 150,x+Width*21 DIV 150,y+Width*133 DIV 150,DarkRed);
    Line (x+Width*42 DIV 150,y+Width*122 DIV 150,x+Width*40 DIV 150,y+Width*127 DIV 150,Blue);
    Line (x+Width*42 DIV 150,y+Width*122 DIV 150,x+Width*44 DIV 150,y+Width*124 DIV 150,Blue);
    Line (x+Width*44 DIV 150,y+Width*124 DIV 150,x+Width*42 DIV 150,y+Width*125 DIV 150,Blue);
    Line (x+Width*46 DIV 150,y+Width*123 DIV 150,x+Width*45 DIV 150,y+Width*127 DIV 150,Blue);
    Line (x+Width*47 DIV 150,y+Width*127 DIV 150,x+Width*46 DIV 150,y+Width*127 DIV 150,Blue);
    Line (x+Width*50 DIV 150,y+Width*127 DIV 150,x+Width*51 DIV 150,y+Width*123 DIV 150,Blue);
    Line (x+Width*54 DIV 150,y+Width*127 DIV 150,x+Width*52 DIV 150,y+Width*123 DIV 150,Blue);
    Line (x+Width*51 DIV 150,y+Width*123 DIV 150,x+Width*53 DIV 150,y+Width*125 DIV 150,Blue);
    Line (x+Width*55 DIV 150,y+Width*123 DIV 150,x+Width*57 DIV 150,y+Width*125 DIV 150,Blue);
    Line (x+Width*57 DIV 150,y+Width*125 DIV 150,x+Width*58 DIV 150,y+Width*123 DIV 150,Blue);
    Line (x+Width*58 DIV 150,y+Width*123 DIV 150,x+Width*59 DIV 150,y+Width*127 DIV 150,Blue);
    Line (x+Width*35 DIV 150,y+Width*132 DIV 150,x+Width*31 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*35 DIV 150,y+Width*132 DIV 150,x+Width*37 DIV 150,y+Width*132 DIV 150,LightBlue);
    Line (x+Width*36 DIV 150,y+Width*135 DIV 150,x+Width*33 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*31 DIV 150,y+Width*138 DIV 150,x+Width*35 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*39 DIV 150,y+Width*132 DIV 150,x+Width*40 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*42 DIV 150,y+Width*132 DIV 150,x+Width*36 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*45 DIV 150,y+Width*132 DIV 150,x+Width*43 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*43 DIV 150,y+Width*136 DIV 150,x+Width*44 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*44 DIV 150,y+Width*137 DIV 150,x+Width*46 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*46 DIV 150,y+Width*135 DIV 150,x+Width*46 DIV 150,y+Width*132 DIV 150,LightBlue);
    Line (x+Width*48 DIV 150,y+Width*132 DIV 150,x+Width*48 DIV 150,y+Width*138 DIV 150,LightBlue);
    Line (x+Width*48 DIV 150,y+Width*138 DIV 150,x+Width*51 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*51 DIV 150,y+Width*137 DIV 150,x+Width*49 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*49 DIV 150,y+Width*135 DIV 150,x+Width*51 DIV 150,y+Width*133 DIV 150,LightBlue);
    Line (x+Width*51 DIV 150,y+Width*133 DIV 150,x+Width*48 DIV 150,y+Width*132 DIV 150,LightBlue);
    Line (x+Width*55 DIV 150,y+Width*132 DIV 150,x+Width*55 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*58 DIV 150,y+Width*132 DIV 150,x+Width*60 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*61 DIV 150,y+Width*137 DIV 150,x+Width*61 DIV 150,y+Width*132 DIV 150,LightBlue);
    Line (x+Width*66 DIV 150,y+Width*132 DIV 150,x+Width*64 DIV 150,y+Width*133 DIV 150,LightBlue);
    Line (x+Width*64 DIV 150,y+Width*133 DIV 150,x+Width*67 DIV 150,y+Width*135 DIV 150,LightBlue);
    Line (x+Width*67 DIV 150,y+Width*135 DIV 150,x+Width*64 DIV 150,y+Width*137 DIV 150,LightBlue);
    Line (x+Width*68 DIV 150,y+Width*132 DIV 150,x+Width*69 DIV 150,y+Width*135 DIV 150,LightBlue);
    Plot (x+Width*70 DIV 150,y+Width*137 DIV 150,LightBlue);
END WritePlayExobius;

PROCEDURE DrawBoss4 (x, y, Width : CARDINAL);
BEGIN
    Disc (x+Width*50 DIV 150,y+Width*50 DIV 150,Width*50 DIV 150,Red);
    Disc (x+Width*51 DIV 150,y+Width*49 DIV 150,Width*48 DIV 150,LightRed);
    Disc (x+Width*52 DIV 150,y+Width*48 DIV 150,Width*46 DIV 150,LightestRed);
    Xs[0] := x+Width*93 DIV 150; Ys[0] := y+Width*24 DIV 150; Xs[1] := x+Width*88 DIV 150; Ys[1] := y+Width*2 DIV 150; Xs[2] := x+Width*80 DIV 150; Ys[2] := y+Width*9 DIV 150;
    Polygon (3, Xs, Ys, LightRed);
    Xs[0] := x+Width*7 DIV 150; Ys[0] := y+Width*24 DIV 150; Xs[1] := x+Width*12 DIV 150; Ys[1] := y+Width*2 DIV 150; Xs[2] := x+Width*20 DIV 150; Ys[2] := y+Width*10 DIV 150;
    Polygon (3, Xs, Ys, LightRed);
    Xs[0] := x+Width*90 DIV 150; Ys[0] := y+Width*20 DIV 150; Xs[1] := x+Width*87 DIV 150; Ys[1] := y+Width*6 DIV 150; Xs[2] := x+Width*82 DIV 150; Ys[2] := y+Width*11 DIV 150;
    Polygon (3, Xs, Ys, Red);
    Xs[0] := x+Width*10 DIV 150; Ys[0] := y+Width*21 DIV 150; Xs[1] := x+Width*12 DIV 150; Ys[1] := y+Width*6 DIV 150; Xs[2] := x+Width*19 DIV 150; Ys[2] := y+Width*12 DIV 150;
    Polygon (3, Xs, Ys, Red);
    Ellipse (x+Width*51 DIV 150,y+Width*74 DIV 150,Width*27 DIV 150,Width*10 DIV 150,Black,TRUE);
    Disc (x+Width*32 DIV 150,y+Width*30 DIV 150,Width*7 DIV 150,Black);
    Disc (x+Width*68 DIV 150,y+Width*30 DIV 150,Width*7 DIV 150,Black);
    Disc (x+Width*48 DIV 150,y+Width*50 DIV 150,Width*6 DIV 150,Black);
    Disc (x+Width*52 DIV 150,y+Width*50 DIV 150,Width*6 DIV 150,Black);
    Plot (x+Width*47 DIV 150,y+Width*50 DIV 150,Black);
    Plot (x+Width*53 DIV 150,y+Width*50 DIV 150,Black);
    Line (x+Width*50 DIV 150,y+Width*23 DIV 150,x+Width*50 DIV 150,y+Width*5 DIV 150,DarkestYellow);
    Line (x+Width*44 DIV 150,y+Width*25 DIV 150,x+Width*38 DIV 150,y+Width*17 DIV 150,DarkestYellow);
    Line (x+Width*38 DIV 150,y+Width*17 DIV 150,x+Width*30 DIV 150,y+Width*12 DIV 150,DarkestYellow);
    Line (x+Width*55 DIV 150,y+Width*26 DIV 150,x+Width*62 DIV 150,y+Width*17 DIV 150,DarkestYellow);
    Line (x+Width*62 DIV 150,y+Width*17 DIV 150,x+Width*71 DIV 150,y+Width*12 DIV 150,DarkestYellow);
    Line (x+Width*12 DIV 150,y+Width*42 DIV 150,x+Width*33 DIV 150,y+Width*51 DIV 150,15);
    Line (x+Width*33 DIV 150,y+Width*51 DIV 150,x+Width*6 DIV 150,y+Width*51 DIV 150,15);
    Line (x+Width*33 DIV 150,y+Width*51 DIV 150,x+Width*13 DIV 150,y+Width*58 DIV 150,15);
    Line (x+Width*69 DIV 150,y+Width*51 DIV 150,x+Width*96 DIV 150,y+Width*51 DIV 150,15);
    Line (x+Width*69 DIV 150,y+Width*51 DIV 150,x+Width*91 DIV 150,y+Width*42 DIV 150,15);
    Line (x+Width*90 DIV 150,y+Width*58 DIV 150,x+Width*69 DIV 150,y+Width*51 DIV 150,15);
    Circle (x+Width*47 DIV 150,y+Width*50 DIV 150,Width*1 DIV 150,21);
    Circle (x+Width*53 DIV 150,y+Width*50 DIV 150,Width*1 DIV 150,21);
    Line (x+Width*43 DIV 150,y+Width*101 DIV 150,x+Width*43 DIV 150,y+Width*119 DIV 150,DarkRed);
    Line (x+Width*57 DIV 150,y+Width*101 DIV 150,x+Width*57 DIV 150,y+Width*119 DIV 150,DarkRed);
    Line (x+Width*44 DIV 150,y+Width*101 DIV 150,x+Width*44 DIV 150,y+Width*119 DIV 150,Red);
    Line (x+Width*56 DIV 150,y+Width*101 DIV 150,x+Width*56 DIV 150,y+Width*119 DIV 150,Red);
    Rectangle (x+Width*45 DIV 150,y+Width*101 DIV 150,x+Width*48 DIV 150,y+Width*119 DIV 150,LightRed,TRUE);
    Rectangle (x+Width*54 DIV 150,y+Width*101 DIV 150,x+Width*55 DIV 150,y+Width*119 DIV 150,LightRed,TRUE);
    Rectangle (x+Width*49 DIV 150,y+Width*101 DIV 150,x+Width*54 DIV 150,y+Width*119 DIV 150,LightestRed,TRUE);
    Line (x+Width*50 DIV 150,y+Width*101 DIV 150,x+Width*50 DIV 150,y+Width*119 DIV 150,LightRed);
    Line (x+Width*53 DIV 150,y+Width*101 DIV 150,x+Width*53 DIV 150,y+Width*119 DIV 150,LightRed);
    Xs[0] := x+Width*43 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*23 DIV 150; Ys[1] := y+Width*145 DIV 150; Xs[2] := x+Width*77 DIV 150; Ys[2] := y+Width*145 DIV 150; Xs[3] := x+Width*57 DIV 150; Ys[3] := y+Width*120 DIV 150;
    Polygon (4, Xs, Ys, 40);
    Xs[0] := x+Width*58 DIV 150; Ys[0] := y+Width*120 DIV 150;
    Polygon (1, Xs, Ys, 40);
    Xs[0] := x+Width*58 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*77 DIV 150; Ys[1] := y+Width*144 DIV 150; Xs[2] := x+Width*79 DIV 150; Ys[2] := y+Width*134 DIV 150;
    Polygon (3, Xs, Ys, 40);
    Xs[0] := x+Width*42 DIV 150; Ys[0] := y+Width*120 DIV 150; Xs[1] := x+Width*23 DIV 150; Ys[1] := y+Width*144 DIV 150; Xs[2] := x+Width*21 DIV 150; Ys[2] := y+Width*134 DIV 150;
    Polygon (3, Xs, Ys, 40);
    WritePlayExobius(x,y,Width);
END DrawBoss4;

PROCEDURE KillBoss4;
VAR
  Explosions, Colour : CARDINAL;
BEGIN
 PlaneY := 175;
 WHILE (PlaneY>10) DO
     PlaneY := PlaneY - 1;
     Sound (Lib.RANDOM(15) + 20);
    FOR Explosions := 1 TO 50 DO
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
        |10 : Colour := LightestYellow
     END;
     Ellipse (Lib.RANDOM(320), Lib.RANDOM(200), Lib.RANDOM(20), Lib.RANDOM(20), Colour, TRUE);
     Plot (Lib.RANDOM(320), Lib.RANDOM(200), Colour);
    END;
     IF (PlaneX<155) THEN
        PlaneX := PlaneX + 5;
     END;
     IF (PlaneX>155) THEN
        PlaneX := PlaneX - 5;
     END;
     DrawPlane (PlaneX, PlaneY, PlaneY DIV 3);
     Delay (40);
     NoSound;
 END; (* WHILE *)
 ScreenComplete := TRUE;
END KillBoss4;

PROCEDURE Boss4;
CONST
    SpitMovement = 2;
    SpitHitY = 180;
    MouthY = 100;
    MouthX = 160;
VAR
    SpitX, SpitY, Boss4X, Boss4Y, Boss4Width, BossLives : CARDINAL;
BEGIN
    ScreenComplete := FALSE;
    Rectangle (PlaneX, PlaneY, PlaneX + PlaneWidth, PlaneY + PlaneHeight, DarkRed, TRUE);
    Graph.GetImage (0, 0, 320, 200, BkAddress);
    FOR Boss4Width := 1 TO 150 BY 3 DO
        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
        DrawBoss4 ((160-Boss4Width DIV 2), (100-Boss4Width DIV 2), Boss4Width);
        DrawPlane (PlaneX, PlaneY, PlaneWidth);
        CheckMouse;
    END;
    Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
    DrawBoss4 ((160-Boss4Width DIV 2), (100-Boss4Width DIV 2), Boss4Width);
    Graph.GetImage (0, 0, 320, 200, BkAddress);

(****************************************************************)

        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
        CheckMouse;
        DrawPlane (PlaneX, PlaneY, PlaneWidth);
        Update3DBullet;
        IF (BulletY  > 99) THEN
                BulletY := BulletY - 1;
        END;
        BossLives := 10;
        Rectangle (0, 0, 319, 10, White, FALSE);
        Rectangle (1, 1, 318, 9, Black, TRUE);
        WHILE NOT GameOver AND NOT ScreenComplete DO
          IF NOT GameOver AND NOT ScreenComplete THEN
                 SpitY := MouthY;
                 SpitX := MouthX;
                 Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                 Rectangle (1, 1, 318, 9, Black, TRUE);
                 Rectangle (1, 1, BossLives*32, 9, Red, TRUE);
                 Rectangle (0, 0, 319, 10, White, FALSE);
                 Graph.GetImage (0, 0, 320, 200, BkAddress);
                 WHILE (SpitY < 200) AND NOT ScreenComplete DO
                        Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                        Graph.GetImage (0, 0, 320, 200, BkAddress);
                        IF ((PlaneX+PlaneWidth DIV 2) > SpitX) THEN
                           SpitX := SpitX + Lib.RANDOM(10) + 20
                        ELSE
                           IF (SpitX>10) THEN
                              SpitX := SpitX - Lib.RANDOM(25)
                           ELSE
                              SpitX := 2;
                           END;
                        END;
                        Ellipse (SpitX, SpitY, (SpitY - MouthY)*4 DIV 15, (SpitY - MouthY)*2 DIV 15, Blue, TRUE);
                        Ellipse (SpitX, SpitY, (SpitY + 1 - MouthY)*4 DIV 15, (SpitY + 2 - MouthY)*2 DIV 15, LightestBlue, FALSE);
                        IF (SpitY > SpitHitY) AND (PlaneX + (PlaneWidth DIV 2) > SpitX-30) AND (PlaneX + (PlaneWidth DIV 2) < SpitX + 30) THEN
                                Die;
                        END;
                        CheckMouse;
                        DrawPlane (PlaneX, PlaneY, PlaneWidth);
                        Update3DBullet;
                        IF (BulletY  < 6) AND (BulletY > 0) THEN
                                BulletY := BulletY - 1;
                        END;
                        IF (BulletX > 100) AND (BulletX < 180) AND (BulletY < 3) THEN
                                Rectangle (0, 0, 320, 200, LightestWhite, TRUE);
                                BossLives := BossLives - 1;
                                BulletY := 50;
                                Delay (5);
                                Score := Score + 150;
                        END;
                        IF (BossLives = 0) THEN
                                Graph.PutImage (0, 0, BkAddress, Graph._GPSET);
                                KillBoss4;
                                ScreenComplete := TRUE;
                        END;
                        Delay (GameSpeed);
                        SpitY := SpitY + 1 + (SpitY - MouthY) DIV 2;
                END;    (* This "END" From SpitY < 200 Check. *)
          END;          (* This "END" From ScreenComplete FOR Loop. *)
        END;            (* This "END" From ScreenComplete WHILE Loop. *)
        IF GameOver THEN
           G(110, 30); A(140, 30); M(170, 30); E(200, 30);
           O(110, 60); V(140, 60); E(170, 60); R(200, 60);
           Key := IO.RdKey();
        END;
END Boss4;

END Bosses4.
