{
fpc jsamezquita.pas
Free Pascal Compiler version 3.2.2 [2021/05/15] for i386
Copyright (c) 1993-2021 by Florian Klaempfl and others
Target OS: Win32 for i386
Compiling jsamezquita.pas
Linking jsamezquita.exe
26 lines compiled, 0.0 sec, 30704 bytes code, 1332 bytes data
}
procedure loop(amount: integer; var return: integer); {Recursive function for the sum}
var
  number: integer;
begin
  if amount <= 0 then
    exit;
  read(number);
  return += number;
  amount -= 1;
  loop(amount, return);
end;

procedure sumInLoop; {Main}
var
  sum: integer;
  amount: integer;
begin
  sum := 0;
  readln(amount);
  loop(amount, sum);
  writeln(sum);
end;

begin
sumInLoop
end.
{
cat DATA.lst | ./jsamezquita
27455
}
