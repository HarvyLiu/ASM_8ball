# ASM_8ball
#### An 8ball program for devs written in pure assembly for my personal assembly learning.


## What it does
### Enter anything, it replies with a suggestion.


## How to run
Ensure nasm and ld are installed, then run the command below:
``` bash
nasm -f elf64 8ball.asm -o 8ball.o
ld 8ball.o -o 8ball

```


## Roadmap
* ~~Prints text~~
* ~~Random text output~~
* ~~Input availible~~
* ~~Added quit functionality~~
* Fix input and loop bugs
* Read file and output text from a fixed file
* File customization with random output
