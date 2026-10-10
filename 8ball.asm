section .data
	inlen equ 8
	prompt db "Ask the oracle (ENTER = wisdom, q + ENTER = quit): ", 10
	plen equ $ - prompt
	hello db "Hello! Always standing by, ASM 8ball!!! The 8ball for devs", 10
	hl equ $ - hello   ; So I don't have to count manually how many bytes (len: a var (length), equ: set const, $: current loc, msg: a var)
	msg0 db "Go for it", 10
	len0 equ $ - msg0
	msg1 db "Don't worry, it's not a bug. It's a feature.", 10 
	len1 equ $ - msg1
	msg2 db "Perhaps you forgot to add a semicolon", 10 
	len2 equ $ - msg2
	msg3 db "Try again... ", 10 
	len3 equ $ - msg3
	msg4 db "If it works, it works, don't you dare touch it.", 10 
	len4 equ $ - msg4
	msg5 db "Perhaps you should try low level", 10
	len5 equ $ - msg5

	msgs dq msg0, msg1, msg2, msg3, msg4, msg5 ; creates a list sort of stuff
	lens dq len0, len1, len2, len3, len4, len5
section .bss 
	input resb inlen ;reserve 8 bytes 

section .text
	global _start
_start:
	mov rax, 1 
	mov rdi, 1 
	mov rsi, hello 
	mov rdx, hl 
	syscall
again:
	mov rax, 1 
	mov rdi, 1 
	mov rsi, prompt 
	mov rdx, plen
	syscall 

	mov rax, 0 ; sys_read
	mov rdi, 0 ; keyboard 
	mov rsi, input
	mov rdx, inlen 
	syscall

	cmp byte [input], 'q' ; first typed byte  = 'q'?  cmp = sort of like compare, but it subtracts then throws is it 0 (throws flag ZF = 0 or 1)? byte to specify the size to operate, which here is one byte, might be dword qword also.
	je done ; if yes, jump to exit. je = jmp only if equal (ZF = 1, which means true in language)

	rdtsc ; basically this reads a timestamp and dumps it into edx:eax eax changes fast and edx changes slowly
	xor edx, edx ; since we want randomness we use lower half (xoring edx leaves 0 which clears the upper half) 'cause it spins faster
	mov ecx, 6 ; this is the msg count we have, which we will use to divide
	div ecx ; div ecx divides edx:eax and the result is edx: remainder, eax: quotient
	mov ecx, edx ; store num in ecx
	shl rcx, 3 ; left shift 3 so multiply 8 which is used later to search address

	;==========================================================
	mov rax, 1 ; What should it do? 1 = sys_write
	mov rdi, 1 ; And to where? 1 = screen (0 = keyboard)
	mov rsi, [msgs + rcx] ; Which bytes? the address? 
	mov rdx, [lens + rcx] ; How many?
	syscall ; Linux gets instructions and does the work, prints
	
	jmp again ; jump back to the start of the prompt, forever
	;===================================================================================
done:
	mov rax, 60 ; 60 = sys_exit 
	xor rdi, rdi ; basically mov rdi, 0, but it's somehow faster, using xor technique, rdi = rdi for each bit so = 0
	syscall ; exits code cleanly else CPU wanders past my code into garbage and crashes.
