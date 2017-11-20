// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

@i
M=0

@sum
M=0

@i
D=M

(CHECK_END)
  @R1
  D=M-D

  @INCREMENT_I
  D;JGT


@OUTPUT
0;JMP


(INCREMENT_I)
  @R0
  D=M

  @sum
  M=M+D

  @i
  M=M+1

  @i
  D=M

  @CHECK_END
  0;JMP

(OUTPUT)
  @sum
  D=M

  @R2
  M=D

(INFINITE_LOOP)
  @INFINITE_LOOP
  0;JMP

