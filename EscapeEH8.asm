%include "/usr/local/share/csc314/asm_io.inc"


segment .data

Intro				db		"You're working on your project in East Hall Room 8. It's 10 pm.",10,"You're learning how to make your own neural network. Little by little, your peers leave and you're eventually left alone.",10,"A little while later, you look at the clock, and it's midnight. You have no idea how it got to be that late. You check the door.",10,"It's locked. You're trapped in East Hall Room 8, and you have to find a way out. Mostly because you're hungry and Classic is open.",10,"[Press Enter to continue]",10,0
Explore_no			db		"You die of hunger and loneliness.",10,"THE End.",10,0
First_Door			db		"You find another door. Head towards it?",10,"[y = yes , n = no]",10,0
Keypad_Dialogue		db		"The door is locked with a standard keypad password.",10,"[Press Enter to continue]",10,0
Explore_More		db		"You explore the room more.",10,"[Press Enter to continue]",10,0
Card_1				db		"After exploring for some time, you find a piece of paper taped under one of the tables with a weird ancient artifact on it.",10,"You take a closer look.",10,"[Pull out card 1 and press Enter]",10,0
Back_to_door		db		"You feel like it's tied to the keypad somehow, so you sit down to figure it out.",10,"[Press Enter to continue]",10,0
Keypad_Attempt		db		"What's the keypad code?",10,"[Put numbers all on one line, then press Enter]",10,0
Back_Room			db		"You're in! You hear the door click and the keypad beep, signaling you to freedom! ...or so you think.",10,"You find yourself in a 'back room' so to speak, filled with boxes and a couple of offices. You shuffle through the boxes and find nothing.",10,"You jiggle the doorknobs of the offices and see they're locked. You then remember you have a lock picking set in EH8 and a plethora of knowledge from all those",10,"GenCyber lockpicking classes you took with Andrew, so next thing you know, you're breaking into one of the offices, and sitting at the computer trying to see",10,"if you can figure out how to get out of here!",10,"[Press Enter to continue]",10,0
Computer_Pass_Dia	db		"The computer is locked with a password, but next to the computer is a piece of paper with a seemingly random email printed on it. You take a closer look.",10,"[Pull out card 2 and press Enter to Continue]",10,0
Computer_Pass		db		"Have you figured out the password yet?",10,"[Type the answer on one line, in lowercase, then press Enter]",10,0
After				db		"You type in the password, and you're greeted by a cluttered computer desktop. You search the Desktop, and find Outlook. You attempt to open it, but are greeted",10,"with yet another password screen. You search the files of the computer for the answer, and find a text document labelled, 'Key'. You take a look at it,",10,"and find it's a riddle.",10,"[Pull out card 3 and press Enter to continue]",10,0
YouMessedUp			db		"Wrong. Try again.",10,0
Scan				db		"%s",0
Riddle				db		"Have you solved the riddle?",10,"[type the answer in lowercase on one line, press Enter to continue]",10,0
Escape				db		"That's it! Promise! Wait, promise? You look around the room, hoping to find a clue, then you spot a promise box sitting on top of the filing cabinet.",10,"You open up the box and find a small gold key inside. Before getting too excited, you run back out into the main room and try the key in the lock.",10,"*Click* 'Freedom!' You cry as you escape East Hall Room 8.",10,"[Press Enter to enjoy your freedom]",10,0
segment .text


segment .bss

Arr1				resb	64
Arr2				resb	64

segment .text
	global  asm_main
	extern	scanf

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

 	mov		eax, Intro
	call	print_string
	call	read_char
	jmp		next
		no:
	mov		eax, Explore_no
	call	print_string
	jmp		end
		next:
	mov		eax, First_Door
	call	print_string
	call	read_char
	mov		bh, al
	call	read_char
	cmp		bh, 'y'
	je		keypad
	jne		no
		keypad:
	mov		eax, Keypad_Dialogue
	call	print_string
	call	read_char
	jmp		more
		more:
	mov		eax, Explore_More
	call	print_string
	call	read_char
	jmp		card1
		card1:
	mov		eax, Card_1
	call	print_string
	call	read_char
	mov		eax, Back_to_door
	call	print_string
	call	read_char
	jmp		keypad_attempt
		keypad_attempt:
	mov		eax, Keypad_Attempt
	call	print_string
	call	read_int
	cmp		eax, 3717
	jne		keypad_attempt
		keypad_ans:
	mov		eax, Back_Room
	call	print_string
	call	read_char
	call	read_char
	jmp		comp_dia
		comp_dia:
	mov		eax, Computer_Pass_Dia
	call	print_string
	call	read_char
		comp_pass:
	mov		eax, Computer_Pass
	call	print_string

		here:
		push	Arr1
		push	Scan
        call    scanf
		add		esp, 8
		cmp		DWORD[Arr1], "assembly"
		je		after
		jne		wrong

		wrong:
	mov		eax, YouMessedUp
	call	print_string
	jmp		here

		after:
	mov		eax, After
	call	print_string
	call	read_char
	call	read_char

		riddle:
	mov		eax, Riddle
	call	print_string
	here2:
	push	Arr2
	push	Scan
    call    scanf
	add		esp, 8
	cmp		DWORD[Arr2], "promise"
	je		escape
	jne		wrong2
		wrong2:
	mov		eax, YouMessedUp
	call	print_string
	jmp		here2
		escape:
	mov		eax, Escape
	call	print_string
	call	read_char
	call	read_char

	; *********** CODE ENDS HERE ***********
	end:
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

