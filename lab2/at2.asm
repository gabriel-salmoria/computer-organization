.data
	# Lookup table
	seven_seg_table: .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
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

	# Load I/O adresses
	li $s0, 0xFFFF0012
	li $s1, 0xFFFF0014
	li $s2, 0xFFFF0010
	
	# Intial command row value
	li $t0, 1 
	
    MainLoop: # while(1) # Main loop 
    	sb $t0, 0($s0)                 # Set a value to comand row
	lw $t1, 0($s1)                 # Get the value from receive row

	# if(t1 != 0)
	beq $t1, $zero, MainLoopEnd              
	
	# Row Mask 
	li $t2, 0x0F      
	and $t4, $t1, $t2 
	li $t2, 0         
	
	# Row correction shift
	srl $t4, $t4, 1    
	
    RowLoop: # while($t4 != 0)
	beq $t4, $zero, OutRowLoop
	srl $t4, $t4, 1  
	addi $t2, $t2, 1
	j RowLoop
    OutRowLoop:
	
	# Column Mask
    	li $t3, 0xF0 
	and $t4, $t1, $t3
	li $t3, 0
	
	# Column correction shift
	srl $t4, $t4, 5
	
    ColLoop: # while($t4 != 0)
	beq $t4, $zero, OutColLoop
	srl $t4, $t4, 1
	addi $t3, $t3, 1
	j ColLoop
    OutColLoop:
    
    	# Calculate value = (ROW*4) + COL
	sll $t2, $t2, 2
    	add $t4, $t2, $t3
    	
    	lbu $t4, seven_seg_table($t4)  # Load value from the table
    	sb $t4, 0($s2)                 # Store it in the display address
    	
    MainLoopEnd:
	sll $t0, $t0, 1                # Increment command row value to next 
	blt $t0, 16, MainLoop          # Call the loop if command value is less than 16
	
	# Reset command row value
	srl $t0, $t0, 4
	j MainLoop