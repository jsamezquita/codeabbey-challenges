procedure countingSort(var weight, countArray, digitArray: array of integer;
index, digitIndex, digits: integer);
var
  actualNumber: String;
  actualDigit: integer;
begin
  if index < 0 then
    exit;
  str(weight[index], actualNumber);
  writeln();
  actualNumber := AddChar('0', actualNumber, digits);
  val(actualNumber[digitIndex], actualDigit);
  digitArray[index] := actualDigit;
  countArray[actualDigit] += 1;
  index -= 1;
  countingSort(weight, countArray, digitArray, index, digitIndex, digits);
end;

procedure countingSortAux1(var countArray: array of integer; index: integer);
begin
  if index > 9 then
    exit;
  countArray[index] += countArray[index-1];
  index += 1;
  countingSortAux1(countArray, index);
end;

procedure countingSortAux2(var weight, value, digitArray, countArray,
auxWeight, auxValue: array of integer; index: integer);
var
  auxIndex, newIndex: integer;
begin
  if index < 0 then
    exit;
  auxIndex := digitArray[index];
  newIndex := countArray[auxIndex]-1;
  auxWeight[newIndex] := weight[index];
  auxValue[newIndex] := value[index];
  countArray[auxIndex] -= 1;
  index -= 1;
  countingSortAux2(weight, value, digitArray, countArray,
  auxWeight, auxValue, index);
end;

procedure radixSort(var weight, value: array of integer; Sorts items by their weight
amountItems, digits, index: integer);
type
numberArray = array of integer;
var
auxWeight, auxValue, countArray, digitArray: numberArray;
begin
  if index >= digits then
    exit;
  setLength(auxWeight, amountItems);
  setLength(auxValue, amountItems);
  setLength(digitArray, amountItems);
  setLength(countArray, 10);
  countingSort(weight, countArray, digitArray, amountItems-1, (digits-index), digits);
  countingSortAux1(countArray, 1);
  countingSortAux2(weight, value, digitArray, countArray,
  auxWeight, auxValue, amountItems-1);
  Move(auxWeight[0], weight[0], SizeOf(Integer) * Length(auxWeight));
  Move(auxValue[0], value[0], SizeOf(Integer) * Length(auxValue));
  index += 1;
  radixSort(weight, value, amountItems, digits, index);
end;

begin

end.
