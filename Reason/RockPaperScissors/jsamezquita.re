/*
  ocamlc -o jsamezquita -pp "bsrefmt -p ml" -impl jsamezquita.re
*/

let wins = (game) => {
  if(game == "SS" || game == "PP" || game == "RR") {
    0;
  } else if(game == "PR" || game == "SP" || game == "RS") {
    1;
  } else {
    -1;
  }
};

let rec rpsLine = (line, points) => {
  let sLength = String.length(line);
  if(sLength > 0) {
    let index =
      switch(String.index(line, ' ')) {
      | exception Not_found => 0;
      | k => k;
      };
    let game = String.sub(line, 0, 2);
    let newLine =
      switch(index == 0) {
      | true => "";
      | false => String.sub(line, 3, sLength - 3);
      };
    let addedPoints = wins(game);
    rpsLine(newLine, points + addedPoints);
  } else {
    if(points > 0) {
      "1 ";
    } else {
      "2 ";
    }
  }
}

let rec rpsCases = (numCases, index, result) => {
  if(index < numCases) {
    let actualCase = read_line();
    let newResult = result ++ rpsLine(actualCase, 0);
    rpsCases(numCases, index + 1, newResult);
  } else {
    result;
  }
}

let main = () => {
  let numCases = int_of_string(read_line());
  let result = rpsCases(numCases, 0, "");
  print_string(result ++ "\n");
}

main();

/*
  cat DATA.lst | ./jsamezquita
1 1 1 1 2 2 2 1 1 2 2 2 2 1 2 1 1 2 2 1 1 1 2 1
*/
