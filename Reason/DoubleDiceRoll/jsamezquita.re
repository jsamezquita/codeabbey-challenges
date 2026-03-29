/*
  ocamlc -o jsamezquita -pp "bsrefmt -p ml" -impl jsamezquita.re
*/

let rec doubleDiceRoll = (size, index, output) => {
  if (index < size) {
    let line = read_line();
    let indexSep = String.index(line, ' ');
    let num1 = int_of_string(String.sub(line, 0, indexSep));
    let num2 = int_of_string(String.sub(line, indexSep + 1,
      String.length(line) - indexSep - 1));
    let dicePoints = (num1 mod 6) + (num2 mod 6) + 2;
    let newOutput = output ++ string_of_int(dicePoints) ++ " ";
    doubleDiceRoll(size, index + 1, newOutput);
  } else {
    print_string(output ++ "\n");
  }
}

let main = () => {
  let numCases = int_of_string(read_line());
  doubleDiceRoll(numCases, 0, "");
}

main();

/*
  cat DATA.lst | ./jsamezquita
5 4 7 6 9 8 3 9 7 4 3 9 4 6 2 7 8 4 6 3 4 6 12 5 9 7
*/
