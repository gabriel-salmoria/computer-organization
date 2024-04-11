.data

.text
# Register Usage:
# $s0 - command right seven segment display 	
# $s1 - number value

	li $s1, 0x3F
	j Loop
	
	li $s1, 0x6
	li $s1, 0x5B
	li $s1, 0x4F
	li $s1, 0x66
	li $s1, 0x6D
	li $s1, 0x7D
	li $s1, 0x07
	li $s1, 0x7F
	li $s1, 0x6F
   Abcd:
   Loop:li $s0, 0xFFFF0010
	sb $s1, 0($s0)