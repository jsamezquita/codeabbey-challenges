/*
  ocamlc -o jsamezquita -pp "bsrefmt -p ml" -impl jsamezquita.re
*/

let initialize = (num) => {
  (Char.chr(num), 0);
}

let abs = (num) => {
  if (num < 0.0) {
    0.0 -. num;
  } else {
    num;
  }
}

let rec trimArray = (array, index) => {
  let (ascii, count) = array[index]
  if (count != 0) {
    trimArray(array, index + 1);
  } else {
    let newArray = Array.sub(array, 0, index);
    newArray;
  }
}

let compare = (obj1, obj2) => {
  let (ascii1, count1) = obj1;
  let (ascii2, count2) = obj2;
  let answ = count2 - count1;
  if (answ == 0) {
    Char.code(ascii1) - Char.code(ascii2);
  } else {
    answ;
  }
}

let rec processInput = (input, count, length, index) => {
  if (index < length) {
    let pindex = Char.code(String.get(input, index));
    let (ascii, tcount) = count[pindex];
    count[pindex] = (ascii, tcount + 1);
    processInput(input, count, length, index + 1);
  } else {
    Array.sort(compare, count);
    trimArray(count, 0);
  }
}

let rec sumArray = (array, sum, size, index) => {
  if (index < size) {
    let (ascii, count) = array[index];
    sumArray(array, sum + count, size, index + 1);
  } else {
    sum;
  }
}

let rec findMiddle = (array, total, minimum, half, size, index) => {
  if (index < size) {
    let (ascii, count) = array[index];
    let newTotal = total + count;
    let residue  = abs(float_of_int(newTotal) -. half);
    if (residue < minimum) {
      findMiddle(array, newTotal, residue, half, size, index + 1);
    } else {
      index;
    }
  } else {
    raise(Not_found);
  }
}

let rec shannonFano = (array, size, route, index) => {
  if (size > 1) {
    let half = float_of_int(sumArray(array, 0, size, 0)) /. 2.0;
    let middleIndex = findMiddle(array, 0, half, half, size, 0);
    let leftArray = Array.sub(array, 0, middleIndex);
    let rightSize = size - middleIndex;
    let rightArray = Array.sub(array, middleIndex, rightSize);
    shannonFano(leftArray, middleIndex, route ++ "O", 0);
    shannonFano(rightArray, rightSize, route ++ "I", 0);
  } else {
    let (ascii, count) = array[0];
    print_string(string_of_int(Char.code(ascii)) ++ " " ++ route ++ " ");
  }
}

let main = () => {
  let count = Array.init(128, initialize);
  let input = read_line();
  let length = String.length(input);
  let parray = processInput(input, count, length, 0);
  shannonFano(parray, Array.length(parray), "", 0);
  print_string("\n");
}

main();
/*
  cat DATA.lst | ./jsamezquita
32 OOO 101 OOI 97 OIOO 116 OIOI 104 OIIO 111 OIII 114 IOOO 110 IOOIO 115 IOOII
119 IOIO 100 IOIIO 105 IOIII 108 IIOOO 99 IIOOI 112 IIOIO 117 IIOIIO 102
IIOIII 109 IIIOOO 121 IIIOOI 73 IIIOIO 98 IIIOII 44 IIIIOO 45 IIIIOIO 103
IIIIOII 34 IIIIIOO 46 IIIIIOIO 66 IIIIIOII 87 IIIIIIOO 107 IIIIIIOI 113
IIIIIIIO 118 IIIIIIII
*/
