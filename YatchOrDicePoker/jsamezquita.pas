procedure minMaxProc(dices: array of integer; var count: array of integer;
var min, max: Shortint; index: integer);
begin
  if index >= 5 then
    exit;
  count[dices[index]-1] += 1;
  if dices[index] > max then
    max := dices[index];
  if dices[index] < min then
    min := dices[index];
  index += 1;
  minMaxProc(dices, count, min, max, index);
end;

procedure readArray(count: array of integer; min, max: Shortint;
index: integer; var result: String);
var
  actual: integer;
begin
  actual := count[index];
  if actual = 2 then
    begin
      if result = 'pair' then
        result := 'two-pairs'
      else if result = 'three' then
        result := 'full-house'
      else
        result := 'pair';
    end
  else if actual = 3 then
    begin
      if result = 'pair' then
        result := 'full-house'
      else
        result := 'three';
    end
  else if actual = 4 then
    begin
      result := 'four';
      exit;
    end
  else if actual = 5 then
    begin
      result := 'yacht';
      exit;
    end;
  if index = 5 then
    begin
      if result = '' then
        begin
          if (max - min) = 4 then
            begin
              if max = 6 then
                result := 'big-straight'
              else
                result := 'small-straight';
            end
          else
            result := 'none';
        end;
      exit;
    end;
  index += 1;
  readArray(count, min, max, index, result);
end;

procedure yatchLoop(length: integer; index: integer; var output: AnsiString);
type
  numberArray = array of integer;
var
  d1, d2, d3, d4, d5: integer;
  min, max: 1..6;
  result: String;
  dices, count: numberArray;
  diceIndex, combIndex: integer;
begin
  min := 6;
  max := 1;
  diceIndex := 0;
  combIndex := 0;
  result := '';
  if index >= length then
    exit;
  read(d1, d2, d3, d4, d5);
  dices := numberArray.Create(d1, d2, d3, d4, d5);
  count := numberArray.Create(0, 0, 0, 0, 0, 0);
  minMaxProc(dices, count, min, max, diceIndex);
  readArray(count, min, max, combIndex, result);
  output := concat(output, result,' ');
  index += 1;
  yatchLoop(length, index, output);
end;

procedure dicePoker; {Main}
var
  output: AnsiString;
  length: integer;
  index: integer;
begin
  index := 0;
  output := '';
  readln(length);
  yatchLoop(length, index, output);
  writeln(output);
end;

begin
  dicePoker;
end.
