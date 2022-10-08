IMPLEMENTATION MODULE Intro2;

IMPORT Graph, IO, Lib, Exobius, Storage;

FROM Graph IMPORT
    ClearScreen, _GCLEARSCREEN,
    Rectangle, Polygon, Line, HLine, Circle, Ellipse, Disc, Plot, Arc;

FROM IO IMPORT KeyPressed;

FROM Lib IMPORT
    Delay;

FROM Exobius IMPORT
    PutPixel, GetPixel,
    Black,
    DarkestGrey, DarkGrey, Grey, LightGrey, LightestGrey,
    DarkestWhite, DarkWhite, White, LightWhite, LightestWhite,
    DarkestBlue, DarkBlue, Blue, LightBlue, LightestBlue,
    DarkestRed, DarkRed, Red, LightRed, LightestRed,
    DarkestBrown, DarkBrown, Brown, LightBrown, LightestBrown,
    DarkestGreen, DarkGreen, Green, LightGreen, LightestGreen,
    DarkestYellow, DarkYellow, Yellow, LightYellow, LightestYellow,
    DrawPlane, PlaneX, PlaneY,
    Count, GameSpeed,
    A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;

PROCEDURE DrawVGAPlanet;
VAR
    RndX, RndY : CARDINAL;
    PrevColor : SHORTCARD;
BEGIN
    (* Planet *)
    Ellipse(319, 220, 250, 95, DarkestRed, TRUE);
    Ellipse(319, 220, 225, 85, DarkRed, TRUE);
    Ellipse(319, 220, 200, 75, Red, TRUE);
    Ellipse(319, 220, 175, 65, LightRed, TRUE);
    Ellipse(319, 220, 150, 55, LightestRed, TRUE);

    (* Stars and planet dots *)
    FOR Count := 0 TO 800 DO
        RndX := Lib.RANDOM(320); RndY := Lib.RANDOM(200);
        PrevColor := GetPixel(RndX, RndY);
        CASE (PrevColor) OF
            |Black: PutPixel(RndX, RndY, DarkestGrey + SHORTCARD(Lib.RANDOM(13)));
            |DarkestRed: PutPixel(RndX, RndY, DarkRed);
            |DarkRed: PutPixel(RndX, RndY, Red);
            |Red: PutPixel(RndX, RndY, LightRed);
            |LightRed: PutPixel(RndX, RndY, LightestRed);
            |LightestRed: PutPixel(RndX, RndY, DarkestYellow);
        END;
    END;

    (* More random dots *)
    FOR Count := 1 TO 100 DO
        Plot (Lib.RANDOM(220) + 100, Lib.RANDOM(80) + 120, Lib.RANDOM(4) + 109);
    END;
    FOR Count := 1 TO 50 DO
        Plot (Lib.RANDOM(320), Lib.RANDOM(200), Lib.RANDOM(10) + 109);
    END;
END DrawVGAPlanet;

PROCEDURE PlaneToPlanet;
VAR
    NegPlaneAddress : ADDRESS;
    NegPlaneSize, RandomRed, Width : CARDINAL;
    Skipped : BOOLEAN;
BEGIN
    Graph.ClearScreen(Graph._GCLEARSCREEN);
    NegPlaneSize := CARDINAL(Graph.ImageSize(199, 29, 319, 201));
    Storage.ALLOCATE(NegPlaneAddress, NegPlaneSize);
    DrawVGAPlanet;
    Graph.GetImage(199, 29, 319, 201, NegPlaneAddress);
    PlaneX := 200; Width := 30;
    FOR PlaneY := 30 TO 200 DO
        Skipped := KeyPressed();
        IF (NOT Skipped) THEN
            IF (PlaneY MOD 2 = 0) THEN
                PlaneX := PlaneX + 1;
            ELSE
                Width := (Width * 99) DIV 100;
            END;
            Graph.PutImage(199, 29, NegPlaneAddress, Graph._GPSET);
            DrawPlane(PlaneX, PlaneY, Width);
            Lib.Delay(GameSpeed * 3);
        END;
    END;
    IF (NOT Skipped) THEN
        Graph.PutImage(249, 59, NegPlaneAddress, Graph._GPSET);
        Lib.Delay(100);
    END;
    Storage.DEALLOCATE(NegPlaneAddress, NegPlaneSize);
END PlaneToPlanet;

END Intro2.
