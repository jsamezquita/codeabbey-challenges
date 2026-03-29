/*
  ocamlc -o jsamezquita -pp "bsrefmt -p ml" -impl jsamezquita.re
*/
let max = (n1, n2) => {
  if(n1 > n2) {
    n1;
  } else {
    n2;
  }
}

let rec readItems = (weights, values, size, index) => {
  if(index < size) {
    let line = read_line();
    let indexSep = String.index(line, ' ');
    let st1 = String.sub(line, 0, indexSep);
    let st2 = String.sub(line, indexSep+1, String.length(line) - indexSep - 1);
    let weight = int_of_string(st1);
    let value = int_of_string(st2);
    weights[index] = weight;
    values[index] = value;
    let newindex = index + 1;
    readItems(weights, values, size, newindex);
  }
}

let rec lineLoop = (matrix, xindex, yindex, capacity, value, weight, first) => {
  let newindex = xindex + 1;
  if(xindex <= capacity) {
    if(first) {
      if(xindex >= weight) {
        matrix[xindex][yindex] = value;
      }
    } else {
      if(xindex < weight) {
        matrix[xindex][yindex] = matrix[xindex][yindex - 1];
      } else {
        matrix[xindex][yindex]= max(value +
        matrix[xindex - weight][yindex - 1], matrix[xindex][yindex - 1]);
      }
    }
    lineLoop(matrix, newindex, yindex, capacity, value, weight, first);
  }
}

let rec knapsackLoop = (matrix, weights, values, index, numItems, capacity) => {
  let newindex = index + 1;
  if(index < numItems) {
    let actualValue = values[index];
    let actualWeight = weights[index];
    let first = index == 0;
    lineLoop(matrix, 1, index, capacity, actualValue, actualWeight, first);
    knapsackLoop(matrix, weights, values, newindex, numItems, capacity);
  }
}

let rec knapsackBacktracking = (matrix, weights, xindex, yindex) => {
  if(xindex != 0 || yindex != 0) {
    let actualValue = matrix[xindex][yindex];
    if(yindex > 0) {
      if(actualValue == matrix[xindex][yindex - 1]) {
        knapsackBacktracking(matrix, weights, xindex, yindex - 1);
      } else {
        print_string(string_of_int(yindex) ++ " ");
        knapsackBacktracking(matrix, weights, xindex - weights[yindex],
        yindex - 1);
      }
    } else {
      if(actualValue != 0) {
        print_string(string_of_int(yindex));
      }
    }
  }
}

let main = () => {
  let numItems = int_of_string(read_line());
  let capacity = int_of_string(read_line());
  let weights = Array.make(numItems, 0);
  let values = Array.make(numItems, 0);
  readItems(weights, values, numItems, 0);
  let matrix = Array.make_matrix(capacity + 1, numItems, 0);
  knapsackLoop(matrix, weights, values, 0, numItems, capacity);
  knapsackBacktracking(matrix, weights, capacity, numItems - 1);
  print_string("\n");
}

main();

/*
  cat DATA.lst | ./jsamezquita
127 125 122 120 119 114 112 110 109 108 104 103 102 100 96 94 92 90 88 87 84
83 81 80 79 76 73 72 71 70 68 66 63 61 58 55 54 53 52 51 49 48 46 42 31 28 26
25 21 19 18 16 15 13 12 11 2 1 0
*/
