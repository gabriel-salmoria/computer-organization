.data
	seven_seg_lookup_table: .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
.text
# Register Usage:
# $s0 - command row number of hexadecimal keyboard address
# $s1 - receive row and column of the key pressed address
# $s2 - command right seven segment display adress
# $t0 - command row value {1,2,4,8}
# $t1 - receive row value {0x11,0x21,0x41,0x81,0x12,0x22,0x42,0x82,0x14,0x24,0x44,0x84,0x18,0x28,0x48,0x88}
# $t2 - index row calculus
# $t3 - index column calculus
# $t4 - calculus number value
# $t5 - loop condition value

	li $s0, 0xFFFF0012		     # Load I/O adresses
	li $s1, 0xFFFF0014
	li $s2, 0xFFFF0010
	
	li $t0, 1 			     # Intial command row value
	
    MainLoop:               		     # while(1)  
    	sb $t0, 0($s0)                       # Set a value to comand row
	lw $t1, 0($s1)                       # Get the value from receive row

	beq $t1, $zero, VerifiedInput 	     # if($t1 != 0)   
	
	li $t2, 0x0F                         # Row Mask   
	and $t4, $t1, $t2 
	li $t2, 0         
	
	srl $t4, $t4, 1  	             # Row correction shift  
	
    RowLoop: 				     # while($t4 != 0)
	beq $t4, $zero, OutRowLoop	     # Calculate row value
	srl $t4, $t4, 1  
	addi $t2, $t2, 1
	j RowLoop
    OutRowLoop:
	
    	li $t3, 0xF0 	                     # Column Mask
	and $t4, $t1, $t3
	li $t3, 0
	
	srl $t4, $t4, 5 	             # Column correction shift
	
    ColLoop:                                 # while($t4 != 0)
	beq $t4, $zero, OutColLoop	     # Calculate column value
	srl $t4, $t4, 1
	addi $t3, $t3, 1
	j ColLoop
    OutColLoop:
    	
	sll $t2, $t2, 2                      # Calculate value = (ROW*4) + COL
    	add $t4, $t2, $t3
    	
    	lb $t4, seven_seg_lookup_table($t4)  # Load value from the table
    	sb $t4, 0($s2)                 	     # Store it in the display address
    	
    VerifiedInput:
	sll $t0, $t0, 1                      # Increment command row value to next 
	slti $t5, $t0, 16             	     # Repeat MainLoop
    	bne $t5, $zero, MainLoop
	
	
	srl $t0, $t0, 4                      # Reset command row value
	j MainLoop