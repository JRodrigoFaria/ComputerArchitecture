# Mapa de registos:
# res : $f0
# val : $t0
	
	.data
zero: 	.float 0.0
value:	.float 2.59375
.eqv	print_float, 2
.eqv	read_int, 5

	.text
	.globl 	main
main:
do:
	li	$v0, read_int	#
	syscall			#
	move	$t0, $v0	# val = read_int();
	
	mtc1	$t0, $f0	# 
	cvt.s.w	$f0, $f0	# res = (float)val;
	
	l.s	$f2, value	# $f2 = 2.59375
	mul.s	$f0, $f0, $f2	# res = (float)val * 2.59375;
	
	mov.s	$f12, $f0	#
	li	$v0, print_float#
	syscall			# print_float(res);
	
	l.s	$f2, zero	# 
	c.eq.s	$f2, $f0	# 
	bc1f	do		# while(res != 0.0);
	
	li	$v0, 0		# return 0
	jr	$ra		# 