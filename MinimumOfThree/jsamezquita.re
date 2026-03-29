/*
  ocamlc -o jsamezquita -pp "bsrefmt -p ml" -impl jsamezquita.re
*/

let rec minimumOfThree = (size, index, output) => {
  if (index < size) {
    let line = read_line();
    let indexSep = String.index(line, ' ');
    let indexSep2 = String.rindex(line, ' ');
    let num1 = int_of_string(String.sub(line, 0, indexSep));
    let num2 = int_of_string(String.sub(line, indexSep + 1,
      indexSep2 - indexSep - 1));
    let num3 = int_of_string(String.sub(line, indexSep2 + 1,
      String.length(line) - indexSep2 - 1));
    if (num1 <= num2) {
      if (num1 <= num3) {
        minimumOfThree(size, index + 1, output ++ string_of_int(num1) ++ " ");
      } else {
        minimumOfThree(size, index + 1, output ++ string_of_int(num3) ++ " ");
      }
    }
    if (num2 <= num1) {
      if (num2 <= num3) {
        minimumOfThree(size, index + 1, output ++ string_of_int(num2) ++ " ");
      } else {
        minimumOfThree(size, index + 1, output ++ string_of_int(num3) ++ " ");
      }
    }
  } else {
    print_string(output ++ "\n");
  }
}

let main = () => {
  let cases = read_int();
  minimumOfThree(cases, 0, "");
}

main();

/*
  cat DATA.lst | ./jsamezquita
-5796038 628841 -8378213 85609 -6962060 -4183919 -9372788 -8631360 1639881
4643986 516737 1446114 -4846926 -9450405 -5026510 -8806095 -5359561 403619
-7475663 -6771588 -8415433 -9003787 -217985
*/
