{
fpc jsamezquita.pas
Free Pascal Compiler version 3.2.2 [2021/05/15] for i386
Copyright (c) 1993-2021 by Florian Klaempfl and others
Target OS: Win32 for i386
Compiling jsamezquita.pas
Linking jsamezquita.exe
35 lines compiled, 0.0 sec, 31440 bytes code, 1332 bytes data
}
{Recursive procedure}
procedure tripletsLoop(length: integer; index: integer; var output: String);
var
  n1: cardinal;
  n2: cardinal;
  n3: cardinal;
  result: String;
begin
  if index >= length then
    exit;
  read(n1, n2, n3);
  if ((n1 + n2) > n3) AND ((n1 + n3) > n2) AND ((n2 + n3) > n1) then
    result := '1'
  else
    result := '0';
  output := concat(output, result, ' ');
  index += 1;
  tripletsLoop(length, index, output);
end;

procedure triangles; {Main}
var
  output: String;
  length: integer;
  index: integer;
begin
  index := 0;
  output := '';
  readln(length);
  tripletsLoop(length, index, output);
  writeln(output);
end;

begin
  triangles;
end.
{
cat DATA.lst | ./jsamezquita
1 0 1 0 0 0 0 1 0 1 1 1 1 0 0 1 1 1 0 1 0
}
