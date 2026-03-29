function max(n1, n2: integer): integer; {Returns max between two numbers}
begin
  if n1 > n2 then
    max := n1
  else
    max := n2;
end;
{Calculates values with current items}
procedure lineLoop(var matrix: array of integer; index, yindex, capacity, value,
weight: integer; var first: boolean); {Calculates values with current items}
var
  auxIndex: integer;
begin
  auxIndex := index-capacity-1;
  if yindex > capacity then
    begin
      if NOT first then
        move(matrix[auxIndex], matrix[auxIndex-capacity-1], SizeOf(Integer) * (capacity + 1));
      exit;
    end;
  if first then
    begin
      matrix[index] := value;
    end
  else
    begin
      matrix[index] := max(value + matrix[auxIndex - weight], matrix[auxIndex]);
    end;
  index += 1;
  yindex += 1;
  lineLoop(matrix, index, yindex, capacity, value, weight, first);
end;
{Goes through the items list}
procedure knapsackLoop(var matrix: array of integer;
weight, value: array of integer; index, nItems, capacity: integer);
var
  itemValue, itemWeight: integer;
  first: boolean;
begin
  writeln('inicio item: ',index);
  if index >= nItems then
    exit;
  first := index = 0;
  itemValue := value[index];
  itemWeight := weight[index];
  lineLoop(matrix, (index * (capacity + 1)) + itemWeight, itemWeight, capacity, itemValue, itemWeight, first);
  index += 1;
  writeln('fin item: ',index);
  knapsackLoop(matrix, weight, value, index, nItems, capacity);
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

procedure backtracking(); {Backtracks and prints the output}
begin
end;

procedure printMatrix(matrix: array of integer; index, size, x, y: integer);
begin
    if index >= size then
      exit;
    if x > y then
      begin
        writeln();
        x := 0;
      end;
    write(matrix[index],' ');
    x += 1;
    index += 1;

end;

procedure knapsackBacktracking; {Main}
type
  numberArray = array of integer;
var
  weight, value, matrix: numberArray;
  amountItems, maxCapacity: integer;
begin
  readln(amountItems);
  readln(maxCapacity);
  weight := [];
  value := [];
  matrix := [];
  setLength(weight, amountItems);
  setLength(value, amountItems);
  setLength(matrix, (maxCapacity + 1) * amountItems);
  readItems(weight, value, 0, amountItems);
  writeln('------');
  knapsackLoop(matrix, weight, value, 0,
  amountItems, maxCapacity);
  writeln();
  printMatrix(matrix, 0, (maxCapacity + 1) * amountItems, 0, maxCapacity);
  writeln(matrix[(maxCapacity + 1) * amountItems]);
end;

begin
  knapsackBacktracking;
end.
