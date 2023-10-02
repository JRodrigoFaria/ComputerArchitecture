	.data
one:	.float 	1.0
base:	.float 	2.0
	.eqv	y, 8
str:	.asciiz "Result: "
	.text
	.globl 	main
main:	
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str
	li	$v0, 4
	syscall
	li	$a0, y
	l.s	$f12, base
	jal	xtoy		# base^y
	mov.s	$f12, $f0
	li	$v0, 2
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
# ---------------------------------------------
xtoy:	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	li	$s0, 0
	jal	abso
	l.s	$f0, one
forxy:	bge	$s0, $v0, endfx
	blez	$a0, else
	mul.s 	$f0, $f0, $f12
	j	endif
else:	div.s	$f0, $f0, $f12
endif:	addi	$s0, $s0, 1
	j	forxy
endfx:	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	addiu	$sp, $sp, 8
	jr	$ra
# ---------------------------------------------	
abso:	bgez	$a0, endifa
	sub	$a0, $0, $a0
endifa:	move	$v0, $a0
	jr	$ra