	.section .data 	#Data Field 

	.section .text 	#Instructions(code) Field 

	.globl _start	

_start:
	pushl $3 #Passing the args in reverse order
	pushl $2 
	call power
	addl $8, %esp	#Free the stack space from two params 
	pushl %eax	#Save the result of the last call on the stack	

	pushl $2	#Second function call begins 
	pushl $5 
	call power
	addl $8, %esp
			#At this point the top of stack is eax/ the previous call's result
	popl %ebx	#Move the result at the top of stack to ebx, save the first result
	addl %eax, %ebx	#Add the second result and first result and save it into ebx
	movl $1, %eax	#Exit code 
	int $0x80	#Exit the program

	#Defining our own functions 
	.type power, @function
power:
	pushl %ebp		#Save the old base ptr register
	movl %esp, %ebp		#ebp == esp
	subl $4, %esp		#save space for the result 
	movl  8(%ebp), %ebx	#first argument/ base number-> ebx
	movl  12(%ebp), %ecx	#second argument/ power-> ecx
	movl  %ebx, -4(%ebp) 	#store the current result
				#which at this moment is the first argument itself
power_loop_start:
	cmpl  $1, %ecx		#IF power == 1, 
	je    end_power		#exit the function
	movl  -4(%ebp), %eax	#move the current result into eax for the operation
	imull %ebx, %eax 	#multiply the base number by current result and put it into
				#eax
	movl  %eax, -4(%ebp)	#move the new current result into -4(ebp)
	decl  %ecx 		#decrement power
	jmp   power_loop_start	#start the loop againx
	
end_power:
				#ON EXITING THE LOOP
	movl -4(%ebp), %eax	#move the result into eax
	movl %ebp, %esp 	#move the stack ptr to the original location
	popl %ebp		#remove the base ptr
	ret			#Exit the function using return address

	
