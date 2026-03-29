/*
  ocamlc -o jsamezquita -pp "bsrefmt -p ml" -impl jsamezquita.re
*/
let rec readList = (list, maxNumber, minNumber) => {
  let sLength = String.length(list);
  if(sLength > 0) {
    let index =
      switch(String.index(list, ' ')) {
      | exception Not_found => sLength;
      | k => k;
      };
    let number = int_of_string(String.sub(list, 0, index));
    let newList =
      switch(sLength == index) {
      | true => "";
      | false => String.sub(list, index + 1, sLength - index - 1);
      }
    let newMax =
      switch(number > maxNumber) {
      | true => number;
      | false => maxNumber;
      }
    let newMin =
      switch(number < minNumber) {
      | true => number;
      | false => minNumber;
      }
    readList(newList, newMax, newMin);
  }
  else {
    print_string(string_of_int(maxNumber) ++ " "
    ++ string_of_int(minNumber) ++ "\n");
  }
}

let main = () => {
  let listNumbers = read_line();
  let index = String.index(listNumbers, ' ');
  let number = int_of_string(String.sub(listNumbers, 0, index));
  readList(listNumbers, number, number);
}

main();

/*
  cat DATA.lst | ./jsamezquita
79734 -79769
*/
