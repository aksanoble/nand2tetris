// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
@24575
D=A

@R0 //Max register value for paint full screen
M=D

@SCREEN
D=A

@R1 // Initial register
M=D

(END_PAINT)
  @R0
  D=M

  @R1
  D=D-M;

  @INFINITE_LOOP
  D;JLT

(PAINT)
  @R1
  D=M

  A=D
  M=-1

  D=D+1

  @R1
  M=D

  @END_PAINT
  0;JMP

(INFINITE_LOOP)
  @INFINITE_LOOP
  0;JMP
