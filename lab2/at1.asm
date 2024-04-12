.data
	seven_seg_lookup_table: .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.text
# Register Usage:
# $s0 - command right seven segment display address
# $t0 - counter
# $t1 - number value [0x00,0xFF]
# $t2 - loop condition verification

	li $s0, 0xFFFF0010 	      	     # Load the display address
    
    Loop: # while($t0 < 10)           	     # Loop to display all digits
    	lb $t1, seven_seg_lookup_table($t0)  # Load value from the table
    	sb $t1, 0($s0)                	     # Store it in the display address
    	addi $t0, $t0, 1              	     # Increment the index for the next digit
    	slti $t2, $t0, 10             	     # Repeat if there are more digits to display
    	bne $t2, $zero, Loop
    	
