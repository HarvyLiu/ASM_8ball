section .data
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

	msgs dq msg0, msg1, msg2, msg3, msg4, msg5
	lens dq len0, len1, len2, len3, len4, len5


section .text
	global _start
_start:
	mov rax, 1 ; What should it do? 1 = sys_write
	mov rdi, 1 ; And to where? 1 = screen (0 = keyboard)
	mov rsi, [msgs] ; Which bytes? the address? 
	mov rdx, [lens] ; How many?
	syscall ; Linux gets instructions and does the work, prints
	;===================================================================================
	mov rax, 60 ; 60 = sys_exit 
	xor rdi, rdi ; basically mov rdi, 0, but it's somehow faster, using xor technique, rdi = rdi for each bit so = 0
	syscall ; exits code cleanly else CPU wanders past my code into garbage and crashes.
