const fs = require("fs");
const inputASM = fs.readFileSync("../pong/PongL.asm");
const inputList = inputASM.toString().split(/\r\n|\n/);
const fileName = process.argv[2].split(".asm")[0];
const symbolTable = require("./spec").symbolTable;
const spec = require("./spec");
const writeFileName = `${fileName}.hack`;
// var symbols = {};
const stripInput = inputList => {
  return inputList
    .map(str => str.replace(/\/\/.*/, "").trim())
    .filter(str => !str == "");
};

const firstPass = (instructions) => {
  let iCount = 0;
  var filtered = instructions.filter(asm => {
    if (asm.includes("(")) {
      const location = asm.replace(/\(|\)/g, "");
      console.log(location, "asm", asm);
      symbolTable[location] = iCount;
      return false;
    }
    iCount++;
    return true;
  });

  return filtered;
};

const secondPass = (instructions) => {
  let memory = 15;
  return instructions.map(i => {
    if (i.includes('@')) {
      const sym = i.split('@')[1]
      if (Number.isInteger(parseInt(sym))) {
        return `@${sym}`
      }
      if (symbolTable[sym] === undefined) {
        symbolTable[sym] = ++memory
      }

      return `@${symbolTable[sym]}`

    } return i
  })

}

// console.log(secondPass(firstPass(stripInput(inputList))))
// console.log(firstPass(stripInput(inputList)));
// console.log(symbolTable, "sym");

const instructions = secondPass(firstPass(stripInput(inputList)));

console.log(instructions, 'instructions');

const machineInstructions = instructions.map(asm => {
  const inst = {
      comp: "",
      dest: "",
      jmp: ""
    };
  if (asm.includes("@")) {
    return parseInt(asm.split("@")[1]).toString(2).padStart(16, "0");
  } else if (asm.includes("=") && asm.includes(";")) {
    const splitEqual = asm.split("=");
    inst.dest = splitEqual[0];
    const splitJmp = splitEqual[1].split(";");
    inst.comp = splitJmp[0];
    inst.jmp = splitJmp[1];
  } else if (asm.includes('=')) {
    const splitEqual = asm.split("=");
    inst.dest = splitEqual[0];
    inst.comp = splitEqual[1];
    inst.jmp = '';
  } else if (asm.includes(';')) {
    const splitJmp = asm.split(";");
    inst.dest = '';
    inst.comp = splitJmp[0];
    inst.jmp = splitJmp[1];
  }

  // console.log(inst, 'inst')
    return `111${spec.opCodes[inst.comp]}${spec.destCodes[inst.dest]}${spec
      .jmpCodes[inst.jmp]}`;
});

fs.writeFileSync(writeFileName, "");

machineInstructions.forEach(instruction => {
  fs.appendFileSync(writeFileName, `${instruction}\n`);
});
