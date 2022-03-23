MODULE MemWipe;
(*$I+,O+,R+,S+,Z+*)
(*$S FF00*)

VAR
  WipeArea [9D00H:0000H] : ARRAY [0..12000] OF BYTE;
  Count : CARDINAL;
BEGIN
    FOR Count := 0 TO 12000 DO
        WipeArea[Count] := 0;
    END;
END MemWipe.