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

(READ_KEYBOARD)

@KBD
D=M

@PAINT_BLACK_SCREEN
D;JGT

@PAINT_WHITE_SCREEN
0;JMP

(PAINT_BLACK_SCREEN)

  @24575
  D=A

  @R0 //Max register value for paint full screen
  M=D

  @SCREEN
  D=A

  @R1 // Initial SCREEN address
  M=D


  (PAINT_BLACK)
    @R1
    D=M

    A=D
    M=-1

    D=D+1

    @R1
    M=D

    @END_PAINT_BLACK
    0;JMP


    (END_PAINT_BLACK)
    @R0
    D=M

    @R1
    D=D-M;

    @PAINT_BLACK
    D;JGE

    @READ_KEYBOARD
    D;JLT


(PAINT_WHITE_SCREEN)

  @24575
  D=A

  @R0 //Max register value for paint full screen
  M=D

  @SCREEN
  D=A

  @R1 // Initial Screen Address
  M=D

  (PAINT_WHITE)
  @R1
    D=M

    A=D
    M=0

    D=D+1

    @R1
    M=D

    @END_PAINT_WHITE
    0;JMP


(END_PAINT_WHITE)
    @R0
    D=M

    @R1
    D=D-M;

    @PAINT_WHITE
    D;JGE

    @READ_KEYBOARD
    D;JLT




