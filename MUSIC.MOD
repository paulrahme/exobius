MODULE Music;

IMPORT FIO, Str, IO;

FROM Lib IMPORT
    Sound, NoSound, Delay;

TYPE
    NoteCharType = CHAR['A'..'g'];
    FreqArrayType = ARRAY NoteCharType OF CARDINAL;

VAR
    NoteNo : CARDINAL;
    Frequencies : ARRAY[0..5] OF FreqArrayType;
    Chord : RECORD
        Note1, Note2, Note3 : CHAR;
        Octave1, Octave2, Octave3 : CARDINAL;
    END;
    f : FIO.File;

CONST
    NoteLength = 16;
    NoOfNotes = 3;

PROCEDURE Init;
VAR
    FreqIndex : CARDINAL;
BEGIN
    (* Create octave/frequency lookup table *)
    Frequencies[0]['c'] := 33; Frequencies[1]['c'] := 66; Frequencies[2]['c'] := 132; Frequencies[3]['c'] := 164; Frequencies[4]['c'] := 328; Frequencies[5]['c'] := 656;
    Frequencies[0]['C'] := 35; Frequencies[1]['C'] := 70; Frequencies[2]['C'] := 140; Frequencies[3]['C'] := 280; Frequencies[4]['C'] := 560; Frequencies[5]['C'] := 1120; 
    Frequencies[0]['d'] := 37; Frequencies[1]['d'] := 74; Frequencies[2]['d'] := 148; Frequencies[3]['d'] := 296; Frequencies[4]['d'] := 592; Frequencies[5]['d'] := 1184; 
    Frequencies[0]['D'] := 39; Frequencies[1]['D'] := 78; Frequencies[2]['D'] := 156; Frequencies[3]['D'] := 312; Frequencies[4]['D'] := 624; Frequencies[5]['D'] := 1248; 
    Frequencies[0]['e'] := 41; Frequencies[1]['e'] := 82; Frequencies[2]['e'] := 164; Frequencies[3]['e'] := 328; Frequencies[4]['e'] := 656; Frequencies[5]['e'] := 1312; 
    Frequencies[0]['f'] := 43; Frequencies[1]['f'] := 86; Frequencies[2]['f'] := 172; Frequencies[3]['f'] := 344; Frequencies[4]['f'] := 688; Frequencies[5]['f'] := 1376; 
    Frequencies[0]['F'] := 45; Frequencies[1]['F'] := 90; Frequencies[2]['F'] := 180; Frequencies[3]['F'] := 360; Frequencies[4]['F'] := 720; Frequencies[5]['F'] := 1440; 
    Frequencies[0]['g'] := 48; Frequencies[1]['g'] := 96; Frequencies[2]['g'] := 192; Frequencies[3]['g'] := 384; Frequencies[4]['g'] := 768; Frequencies[5]['g'] := 1536; 
    Frequencies[0]['G'] := 51; Frequencies[1]['G'] := 102; Frequencies[2]['G'] := 204; Frequencies[3]['G'] := 408; Frequencies[4]['G'] := 816; Frequencies[5]['G'] := 1632; 
    Frequencies[0]['a'] := 55; Frequencies[1]['a'] := 110; Frequencies[2]['a'] := 220; Frequencies[3]['a'] := 440; Frequencies[4]['a'] := 880; Frequencies[5]['a'] := 1760;
    Frequencies[0]['A'] := 57; Frequencies[1]['A'] := 114; Frequencies[2]['A'] := 228; Frequencies[3]['A'] := 456; Frequencies[4]['A'] := 912; Frequencies[5]['A'] := 1824;
    Frequencies[0]['b'] := 62; Frequencies[1]['b'] := 124; Frequencies[2]['b'] := 248; Frequencies[3]['b'] := 496; Frequencies[4]['b'] := 992; Frequencies[5]['b'] := 1984;
END Init;

PROCEDURE PlayNote(Pitch, Duration : CARDINAL);
BEGIN
    Sound(Pitch);
    Delay(Duration);
    NoSound;
END PlayNote;

PROCEDURE PlaySong(Song : ARRAY OF CHAR);
BEGIN
    f := FIO.Open(Song);
    WHILE NOT FIO.EOF AND NOT IO.KeyPressed() DO
        Chord.Octave1 := FIO.RdCard(f);
        Chord.Note1 := FIO.RdChar(f);
        Chord.Octave2 := FIO.RdCard(f);
        Chord.Note2 := FIO.RdChar(f);
        Chord.Octave3 := FIO.RdCard(f);
        Chord.Note3 := FIO.RdChar(f);
        FOR NoteNo := 1 TO NoOfNotes DO
            PlayNote(Frequencies[Chord.Octave1][Chord.Note1], NoteLength);
            PlayNote(Frequencies[Chord.Octave2][Chord.Note2], NoteLength);
            PlayNote(Frequencies[Chord.Octave3][Chord.Note3], NoteLength);
        END;
    END;
    FIO.Close (f);
END PlaySong;

BEGIN
    Init();
    PlaySong("music.dat");
END Music.
