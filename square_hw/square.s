	#PERSONAL JOURNALISM
	#Assignment Program -Done in first trial
	#Feels like i'm actually learning assembly
	#I love this book
	
	#PURPOSE: This program returns the square of the arg number.
	#		arg- n
	#		answer - n^2

	.section .data
			# No external memory required
	.section .text

	.globl _start	# Start is a special type of symbol thats why
			# It start with '_' instead of ' . '
	.globl .square	# Telling the linker so we use this functions in other places 

_start:
	pushl $9	#Push the argument
	call square	#Call our function
	addl $4, %esp	#free the stack from the arg

	movl %eax, %ebx	#square returns the answer in eax, we need to save it
	movl $1, %eax	#Return code
	int $0x80	#Exit main, call primitive 

	.type .square, @function 
square:
	pushl %ebp	#Standard calling convention stuff
	movl %esp, %ebp	#

	#Our pre-multiplied number and result both will live in eax
	movl 8(%ebp), %eax	#move the arg in eax for multiplication purposes
	
	imull 8(%ebp), %eax	#multiply basically the same numbers and put the result
				#in eax
	#Now our answer is in eax
	#We just need to exit
	#End function routines 
	movl %ebp, %esp
	popl %ebp
	ret
	




	
