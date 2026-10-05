section .data
	msg db "ASM Oracle says hi!", 10
	len equ $ - msg   # So I don't have to count manually how many bytes (len: a var (length), equ: set const, $: current loc, msg: a var)
section .text
	global _start
_start:
	mov rax, 1 # What should it do? 1 = write
	mov rdi, 1 # And to where? 1 = screen (0 = keyboard)
	mov rsi, msg # Which bytes? the address? 
	mov rdx, len # How many?
	syscall # Linux gets instructions and does the work, prints
	mov rax, 60 # 60 = sys_exit 
	xor rdi, rdi # basically mov rdi, 0, but it's somehow faster, using xor technique, rdi = rdi for each bit so = 0
	syscall # exits code cleanly else CPU wanders past my code into garbage and crashes.
