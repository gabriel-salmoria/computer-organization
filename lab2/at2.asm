.data

.text
# Register Usage:
# $s0 - command row number of hexadecimal keyboard
# $s1 - receive row and column of the key pressed
# $s2 - command right seven segment display 

	# Load important adresses to registers
	li $s0, 0xFFFF0012
	li $s1, 0xFFFF0014
	li $s2, 0xFFFF0010
	
   Loop:
   	# Set a value to comand row
   	li $s4, 1
	sb $s4, 0($s0)
	
	# Get the value from receive row
	lw $s5, 0($s1)
	
	j Loop