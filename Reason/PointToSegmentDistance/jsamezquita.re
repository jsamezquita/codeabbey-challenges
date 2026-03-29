/*
  ocamlc -o jsamezquita -pp "bsrefmt -p ml" -impl jsamezquita.re
*/

let rec readLine = (line, list, index) => {
  let sLength = String.length(line);
  if (sLength > 0) {
    let indexSep =
      switch (String.index(line, ' ')) {
      | exception Not_found => 0;
      | k => k;
      };
    if (indexSep == 0) {
      list[index] = float_of_string(line);
    } else {
      list[index] = float_of_string(String.sub(line, 0, indexSep));
      let newLine = String.sub(line, indexSep + 1,
        String.length(line) - indexSep - 1);
      readLine(newLine, list, index + 1);
    }
  }
}

let rec pointToSegment = (size, output) => {
  if (size > 0) {
    let input = [|0.0, 0.0, 0.0, 0.0, 0.0, 0.0|];
    let line = read_line();
    readLine(line, input, 0);
    let linex = input[2] -. input[0];
    let liney = input[3] -. input[1];
    let vec1x = input[4] -. input[0];
    let vec1y = input[5] -. input[1];
    let vec2x = input[4] -. input[2];
    let vec2y = input[5] -. input[3];
    let inRight = (linex *. vec1x) +. (liney *. vec1y) > 0.;
    let inLeft = ((0. -. linex) *. vec2x) +. ((0. -. liney) *. vec2y) > 0.;
    if (inRight && inLeft) {
      let slope = (liney) /. (linex);
      let cons = input[1] -. (input[0] *. slope);
      let pdis = input[5] -. (input[4] *. slope) -. cons;
      let abs =
        switch (pdis > 0.) {
        | true => pdis;
        | false => 0. -. pdis;
        };
      let distance = abs /. ((1. +. ( slope ** 2.)) ** 0.5);
      let newOutput = output ++ string_of_float(distance) ++ " ";
      pointToSegment(size - 1, newOutput);
    } else {
      let distance =
        switch (inRight) {
        | true => ((vec2x ** 2.) +. (vec2y ** 2.)) ** 0.5;
        | false => ((vec1x ** 2.) +. (vec1y ** 2.)) ** 0.5;
        };
      let newOutput = output ++ string_of_float(distance) ++ " ";
      pointToSegment(size - 1, newOutput);
    }
  } else {
    print_string(output ++ "\n");
  }
}

let main = () => {
  let numCases = int_of_string(read_line());
  pointToSegment(numCases, "");
}

main();

/*
  cat DATA.lst | ./jsamezquita
6.7082039325 9.7081811112 5.38516480713 5. 12.8062484749 3.16227766017
0.514495755428 11.4159935944 17. 5.52865605151 7.28010988928 1. 1.41421356237
10.6066017178 9.21954445729 4.472135955 6. 9.54084337507 17.0327099296
*/
