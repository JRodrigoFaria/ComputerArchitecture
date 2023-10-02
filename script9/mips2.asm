	.data
	
str1:	.asciiz "Result in Celsius: "

ft:	.double 100.0	
	
const1:	.double 5.0
const2: .double 9.0
const3: .double 32.0

	.text
	.globl 	main
main:
	addiu	$sp, $sp, -4	#
	sw	$ra, 0($sp)	#

	l.d	$f12, ft
	jal	f2c
	
	la	$a0, str1	#
	li	$v0, 4		#
	syscall			# print_string(str1);

	mov.d	$f12, $f0	#
	li	$v0, 3		#
	syscall			# print_double(ft);
			
	lw	$ra, 0($sp)	#
	addiu	$sp, $sp, 4	#
	
f2c:	
	l.d	$f2, const1	#
	l.d	$f4, const2	#
	l.d	$f6, const3	#
	
	sub.d	$f0, $f12, $f6	# (ft - 32.0)
	div.d	$f2, $f2, $f4	# 5.0 / 9.0
	mul.d	$f0, $f2, $f0	# return (5.0 / 9.0 * (ft - 32.0));

	jr	$ra	