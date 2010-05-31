       .data 
vec:	 .word 8, 12, 16, 19, 2002, 0, 0, 0, 0, 0
space: .asciiz " "

       .text 
       .globl main

{ARG0=$a0}
{PRINT_INT=
  li $v0, 1
  syscall
}
{PRINT_STRING=
  li $v0, 4
  syscall
}
{EXIT_PROGRAM=
  li $v0, 10
  syscall
  jr $ra
}

main: 
  {ITERATOR=$s0}
  {MAX=$s1}
  li {ITERATOR}, 0
  li {MAX}, 5
loop: 
  {ADDRESS=$t0}
  mul {ADDRESS}, {ITERATOR}, 4
  lw {ARG0}, vec({ADDRESS})
  {PRINT_INT}

  la {ARG0}, space
  {PRINT_STRING}

  add {ITERATOR}, {ITERATOR}, 1
  bgt {MAX}, {ITERATOR}, loop

  {EXIT_PROGRAM}

