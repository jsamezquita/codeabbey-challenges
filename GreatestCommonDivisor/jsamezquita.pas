{
fpc jsamezquita.pas
Free Pascal Compiler version 3.2.2 [2021/05/15] for i386
Copyright (c) 1993-2021 by Florian Klaempfl and others
Target OS: Win32 for i386
Compiling jsamezquita.pas
Linking jsamezquita.exe
46 lines compiled, 0.0 sec, 31568 bytes code, 1332 bytes data
}
procedure gcdProc(n1, n2: cardinal; var gcd: cardinal);{GCD Procedure}
begin
  if n1 > n2 then
    n1 -= n2
  else if n2 > n1 then
    n2 -= n1
  else if n1 = n2 then
    begin
      gcd := n1;
      exit;
    end;
  gcdFunc(n1, n2, gcd);
end;
{Reader}
procedure pairsLoop(length: integer; index: integer; var output: String);
var
  n1, n2, gcd: cardinal;
  lcm, stGcd: String;
begin
  if index >= length then
    exit;
  read(n1, n2);
  gcdProc(n1, n2, gcd);
  str(gcd, stGcd);
  str((n1 * n2) div gcd, lcm);
  output := concat(output, '(', stGcd, ' ', lcm, ') ');
  index += 1;
  pairsLoop(length, index, output);
end;

procedure greatestCommonDivisor; {Main}
var
  output: String;
  length: integer;
  index: integer;
begin
  index := 0;
  output := '';
  readln(length);
  pairsLoop(length, index, output);
  writeln(output);
end;

begin
  greatestCommonDivisor;
end.
{
}
