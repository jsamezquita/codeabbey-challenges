{
fpc jsamezquita.pas
Free Pascal Compiler version 3.2.2 [2021/05/15] for i386
Copyright (c) 1993-2021 by Florian Klaempfl and others
Target OS: Win32 for i386
Compiling jsamezquita.pas
Linking jsamezquita.exe
77 lines compiled, 0.0 sec, 34464 bytes code, 1364 bytes data
}
function max(n1, n2: integer): integer; {Returns max between two numbers}
begin
  if n1 > n2 then
    max := n1
  else
    max := n2;
end;

procedure lineLoop(var actual, last: array of integer; index, capacity, value,
weight: integer; var first: boolean); {Calculates values with current items}
begin
  if index > capacity then
    begin
      move(actual[0], last[0], SizeOf(Integer) * (capacity + 1));
      first := false;
      exit;
    end;
  if first then
    begin
      actual[index] := value;
    end
  else
    begin
      actual[index] := max(value + last[index - weight], last[index]);
    end;
  index += 1;
  lineLoop(actual, last, index, capacity, value, weight, first);
end;

procedure knapsackLoop(var actual, last, weight, value: array of integer;
index, nItems, capacity: integer); {Goes through the items list}
var
  itemValue, itemWeight: integer;
  first: boolean;
begin
  if index >= nItems then
    exit;
  first := index = 0;
  itemValue := value[index];
  itemWeight := weight[index];
  lineLoop(actual, last, itemWeight, capacity, itemValue, itemWeight, first);
  index += 1;
  knapsackLoop(actual, last, weight, value, index, nItems, capacity);
end;

procedure readItems(var weight, value: array of integer; {Reads items input}
index, amount: integer);
begin
  if index >= amount then
    exit;
  readln(weight[index], value[index]);
  index += 1;
  readItems(weight, value, index, amount);
end;

procedure knapsackOfIntegers; {Main}
type
  numberArray = array of integer;
var
  weight, value, lastArray, actualArray: numberArray;
  amountItems, maxCapacity: integer;
begin
  readln(amountItems);
  readln(maxCapacity);
  weight := [];
  value := [];
  lastArray := [];
  actualArray := [];
  setLength(weight, amountItems);
  setLength(value, amountItems);
  setLength(lastArray, maxCapacity + 1);
  setLength(actualArray, maxCapacity + 1);
  readItems(weight, value, 0, amountItems);
  knapsackLoop(actualArray, lastArray, weight, value, 0,
  amountItems, maxCapacity);
  writeln(actualArray[maxCapacity]);
end;

begin
  knapsackOfIntegers;
end.
{
cat DATA.lst | ./jsamezquita
3315
}
