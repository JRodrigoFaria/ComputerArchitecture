# Mapa de registos:
# rv 	: $t0
# n 	: $t1
# sum	: $t2
# nit	: $t3
# *pt	: $t4
	
	.data
list:	.space 	32
	.eqv 	SIZE, 8
	.eqv	print_int10, 1
	.eqv 	read_int, 5
	.eqv 	print_string, 4	
str:	.asciiz "Media invalida!\n"
	.text
	.globl	main
main:
	li	$t2, 0			# sum = 0
	li	$t3, 0			# nit = 0
	la	$t4, list		# pt = list
	li	$t5, SIZE		# ($t5 = SIZE
	sll	$t5, $t5, 2		# $t5 = SIZE * 4)
	addu	$t5, $t5, $t4		# $t5 = list + SIZE
for:	bge	$t4, $t5, endf		# for(pt = list; pt < list + SIZE; )
	li	$v0, read_int
	syscall
	sw	$v0, 0($t4)		# *pt = read_int()
	addiu	$t4, $t4, 4		# pt++
	j	for
endf:	li	$t1, 0			# n = 0
for2:	bge	$t1, SIZE, endf2	# for(n = 0; n < SIZE; )
	la	$t5, list		# $t5 = list
	sll	$t6, $t1, 2		# 
	addu	$t6, $t6, $t5 		# 
	lw	$t6, 0($t6)		# $t6 = list[n]
if:	bltz	$t6, endif		# if(list[n] >= 0)
	add	$t2, $t2, $t6		# sum += list[n]
	addi	$t3, $t3, 1		# nit++
endif:	addi	$t1, $t1, 1		# n++
	j	for2
endf2:
if2:	blez	$t3, else		# if(nit > 0)
	div	$a0, $t2, $t3		# sum/nit
	li	$v0, print_int10	#
	syscall				# print_int10(sum / nit)
	li	$t0, 0			# rv = 0
	j	endif2
else:	la	$a0, str		#
	li	$v0, print_string	#
	syscall				# print_string("Media invalida!\n")
	li	$t0, -1			# rv = -1
endif2:	move	$v0, $t0		# 
	jr	$ra			# return rv