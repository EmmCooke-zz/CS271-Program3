TITLE Sum of Negative Numbers     (EmmetCookeProgram3.asm)

; Author: Emmet Cooke	
; Course / Project ID : cs271 / Program 3         Date: 10/23/2017
; Description: This program asks the users for a series of negative numbers between
; -100 and -1. It will continue to prompt them for numbers until they enter a non-negative
; number. Then it will display the sum and average of the entered numbers.
; EC #1: This program displays a number as the user enters them

INCLUDE Irvine32.inc

; Constant Definitions
LOWER_LIMIT = -100

.data
	; Strings to display the programmers name and the program title
	programTitle		BYTE	"Program: Sum of Negative Numbers",0
	programmerName		BYTE	"Author : Emmet Cooke",0
	extraCredit1		BYTE	"EC#1: This program numbers the lines during input.",0

	; Variables to get the users name, store the input, and greet them
	namePrompt			BYTE	"What's your name? ",0
	userName			BYTE	21 DUP(0)
	userNameSize		DWORD	?
	greeting			BYTE	"Hello, ",0

	; Strings to instruct the user
	instruction			BYTE	"This program will average a sum of numbers between -100 and -1.", 0ah
						BYTE	"It will continue to ask you to enter a number in this range",0ah
						BYTE	"until a non-negative number is entered.", 0ah
						BYTE	"Then, it will output the sum and average of those values.",0
	negativeNumPrompt	BYTE	"Please enter a number between -100 and -1. Enter 0 or greater to quit. ",0
	belowNeg100Warn		BYTE	"That is below -100. ",0
	numberString		BYTE	"Number ",0
	colon				BYTE	": ",0

	; Variables to hold the values input by the user
	inputValue			DWORD	?
	negativeSum			DWORD	0
	numEntries			DWORD	1

	; Strings to display the results
	output0				BYTE	"You entered no numbers.",0
	output1				BYTE	"You entered ",0
	output2				BYTE	" numbers.",0
	sum					BYTE	"Sum: ",0
	average				BYTE	"Average: ",0
	negativeSign		BYTE	"-",0

	; Goodbye message
	thanksMessage		BYTE	"Thanks for using this program, ",0
	goodbye				BYTE	". Goodbye!",0

.code
main PROC
	; Introduce the Programmer
	call	introduceProgrammer	
	mov		edx, OFFSET extraCredit1
	call	WriteString
	call	Crlf
	call	Crlf

	; Gets the users name and greets them
	call	getName				
	call	greetUser			

	; Instruct the user on how to use the program
	call	instructUser
	call	Crlf

	; Get a number between -100 and -1 from the user
negNumLoop:
	; Prompts the user for a value
	mov		edx, OFFSET numberString
	call	WriteString
	mov		eax, numEntries
	call	WriteDec
	mov		edx, OFFSET colon
	call	WriteString
	call	ReadInt

	; Checks the value of the input int
	mov		inputValue, eax
	cmp		inputValue, 0		; non-negative has been entered
	jge		loopEnd

	; Check if the value is within range
	cmp		inputValue, LOWER_LIMIT
	jae		valueInRange
	jmp		belowNegative100

	; The value is within range and it is added to the sum
valueInRange:
	mov		eax, inputValue
	neg		eax
	add		negativeSum, eax
	inc		numEntries
	jmp		negNumLoop

	; The value is below -100
belowNegative100:
	mov		edx, OFFSET belowNeg100Warn
	call	WriteString
	call	Crlf
	jmp		negNumLoop

loopEnd:

; Display sum and average
	cmp		numEntries, 1
	je		noEntries
	; if 1 or more entry
	mov		edx, OFFSET output1
	call	WriteString
	mov		eax, numEntries
	dec		eax
	call	WriteDec
	mov		edx, OFFSET output2
	call	WriteString
	call	Crlf

	; Sum
	call	displaySum

	; Average
	call	displayAverage
	jmp		endProgram

noEntries:
	mov		edx, OFFSET output0
	call	WriteString
	call	Crlf

endProgram:
	call	displayGoodbye

	exit	; exits to operating system
main ENDP


;-------------------------------------
; Procedure to introduce the programmer
; recieves: none
; returns: none
; preconditions: none
; registers changed: edx
;-------------------------------------
introduceProgrammer PROC USES edx
	mov		edx, OFFSET programTitle
	call	WriteString
	call	Crlf
	mov		edx, OFFSET programmerName
	call	WriteString
	call	Crlf
	ret
introduceProgrammer ENDP

;-------------------------------------
; Procedure to get the users name
; recieves: none
; returns: user input for the global variable userName
; preconditions: none
; registers changed: eax, ecx, edx
;-------------------------------------
getName PROC USES eax ecx edx
	mov		edx, OFFSET namePrompt
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, SIZEOF	userName
	call	ReadString
	mov		userNameSize, eax
	call	Crlf
	ret
getName ENDP

;-------------------------------------
; Procedure to greet the user
; recieves: none
; returns: none
; preconditions: none
; registers changed: edx
;-------------------------------------
greetUser PROC USES edx
	mov		edx, OFFSET greeting
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	Crlf
	call	Crlf
	ret
greetUser ENDP

;-------------------------------------
; Procedure to instruct the user on how to proceed
; recieves: none
; returns: none
; preconditions: none
; registers changed: edx
;-------------------------------------
instructUser PROC USES edx
	mov		edx, OFFSET instruction
	call	WriteString
	call	Crlf
	mov		edx, OFFSET negativeNumPrompt
	call	WriteString
	call	Crlf
	ret
instructUser ENDP

;-------------------------------------
; Procedure to display sum
; recieves: none
; returns: none
; preconditions: none
; registers changed: eax edx
;-------------------------------------
displaySum PROC USES eax edx
	mov		edx, OFFSET sum
	call	WriteString
	mov		edx, OFFSET negativeSign
	call	WriteString
	mov		eax, negativeSum
	call	WriteDec
	call	Crlf
	ret
displaySum ENDP

;-------------------------------------
; Procedure to display average
; recieves: none
; returns: none
; preconditions: none
; registers changed: eax, ebx, edx
;-------------------------------------
displayAverage PROC USES eax ebx edx 
	mov		edx, OFFSET average
	call	WriteString
	mov		edx, OFFSET negativeSign
	call	WriteString
	dec		numEntries
	mov		ebx, numEntries
	xor		edx, edx
	mov		eax, negativeSum
	div		ebx
	call	WriteDec
	call	Crlf
	ret
displayAverage ENDP

;-------------------------------------
; Procedure to display goodbye Message
; recieves: none
; returns: none
; preconditions: there is a userName variable
; registers changed: edx
;-------------------------------------
displayGoodbye PROC USES edx
	mov		edx, OFFSET thanksMessage
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET goodbye
	call	WriteString
	call	Crlf
	ret
displayGoodbye ENDP

END main
