{Free Pascal Compiler version 3.2.2 [2021/05/15] for i386
Copyright (c) 1993-2021 by Florian Klaempfl and others
Target OS: Win32 for i386
Compiling jsamezquita.pas
Linking jsamezquita.exe
37 lines compiled, 0.0 sec, 37008 bytes code, 3300 bytes data
}
{Recursive procedure}
procedure equationsLoop(length: integer; index: integer; var output: String);
var
  x1: real;
  y1: real;
  x2: real;
  y2: real;
  mInt: integer;
  m: String;
  c: String;
begin
  if index >= length then
    exit;
  read(x1, y1, x2, y2);
  mInt := round((y2 - y1) / (x2 - x1));
  str(mInt, m);
  str(round(y1 - (x1 * mInt)), c);
  output := concat(output, '(', m, ' ', c, ') ');
  index += 1;
  equationsLoop(length, index, output);
end;

procedure linearFunction; {Main}
var
  output: String;
  length: integer;
  index: integer;
begin
  index := 0;
  output := '';
  readln(length);
  equationsLoop(length, index, output);
  writeln(output);
end;

begin
  linearFunction;
end.
{
cat DATA.lst | ./jsamezquita
(14 -522) (71 682) (62 172) (1 495) (85 -679) (42 422) (87 -34) (97 -701)
 (89 -128) (-90 -365) (-84 879) (-41 250)
}
