.text
.global start
start:
wait: 
	swi 0x202; checks if one of the black buttons is pressed, r0=black button pattern, left button: r0=2 (0..0010), right button r0=1 (0..0001)
	cmp r0, #0
	beq wait
	ldr r5, =zero
	ldr r3, =nine
	mov r1, #0
	cmp r0, #1
	bgt loop2
loop1: 
	ldrb r0, [r5]
	add  r1, r1, #1
	cmp  r1, #11
	beq  end
	swi  0x200; 8 segment display lights up and prints the pattern in r0
	add  r5, r5, #1
	bl   count 
	b    loop1
loop2:
	ldrb r0, [r3]
	add  r1, r1, #1
	cmp  r1, #11
	beq  end
	swi  0x200; 8 segment display lights up and prints the pattern in r0
	sub  r3, r3, #1
	bl   count
	b    loop2

count: 
	mov  r4, #64000
count1: 
	cmp  r4, #0
	subgt r4, r4, #1
	bgt  count1
	swi  0x206; clear the display on the LCD Screen
	mov  pc, lr
end:
	b wait
.data
	zero:	.byte 0b11101101
	one:  	.byte 0b01100000
	two:    .byte 0b11001110   ; These values are calculated as shown in tiny.cc/arm8seg
	three:	.byte 0b11101010
	four: 	.byte 0b01100011
	five:   .byte 0b10101011
	six:    .byte 0b10101111
	seven:  .byte 0b11100000
	eight:  .byte 0b11101111
	nine:   .byte 0b11101011
.end
