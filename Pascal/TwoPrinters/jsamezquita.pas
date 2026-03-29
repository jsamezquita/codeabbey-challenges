{
fpc jsamezquita.pas
Free Pascal Compiler version 3.2.2 [2021/05/15] for i386
Copyright (c) 1993-2021 by Florian Klaempfl and others
Target OS: Win32 for i386
Compiling jsamezquita.pas
Linking jsamezquita.exe
36 lines compiled, 0.2 sec, 70032 bytes code, 4292 bytes data
}
uses math;
procedure printersLoop(length: integer; index: integer; var output: String);
var
  p1, p2, pages, t1, t2: Longint;
  t: String;
begin
  if index >= length then
    exit;
  read(p1, p2, pages);
  t1 := Ceil((p2 / (p1 + p2)) * pages) * p1;
  t2 := Ceil((p1 / (p1 + p2)) * pages) * p2;
  if t1 < t2 then
    str(t1, t)
  else
    str(t2, t);
  output := concat(output, t, ' ');
  index += 1;
  printersLoop(length, index, output);
end;

procedure twoPrinters; {Main}
var
  output: String;
  length: integer;
  index: integer;
begin
  index := 0;
  output := '';
  readln(length);
  printersLoop(length, index, output);
  writeln(output);
end;

begin
  twoPrinters;
end.
{
cat DATA.lst | ./jsamezquita
340794288 299607282 243826992 119636082 76060959 313658508 20027907 273250960
320090870 415758649 439063864 44471840 303827916 460244889 333600828 57428712
430523140 297156086 266199332
}
