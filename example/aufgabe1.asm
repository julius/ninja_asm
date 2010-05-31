      .data 
vec:	.word 8, 12, 16, 19, 2002, 0, 0, 0, 0, 0
space: .asciiz " "

      .text 
      .globl main






main: 
  
  
  li $s0, 0
  li $s1, 5
loop: 
  
  mul $t0, $s0, 4
  lw $a0, vec($t0)
  li $v0, 1
  syscall


  la $a0, space
  li $v0, 4
  syscall


  add $s0, $s0, 1
  bgt $s1, $s0, loop

  li $v0, 10
  syscall
  jr $ra


