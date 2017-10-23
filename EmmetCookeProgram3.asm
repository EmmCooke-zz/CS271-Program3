TITLE Sum of Negative Numbers     (EmmetCookeProgram3.asm)

; Author: Emmet Cooke	
; Course / Project ID : cs271 / Program 3         Date: 10/23/2017
; Description: This program asks the users for a series of negative numbers between
; -100 and -1. It will continue to prompt them for numbers until they enter a non-negative
; number. Then it will display the sum and average of the entered numbers.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
	; Strings to display the programmers name and the program title
	programTitle		BYTE	"Program: Sum of Negative Numbers",0
	programmerName		BYTE	"Author : Emmet Cooke",0

	; Variables to get the users name, store the input, and greet them
	namePrompt			BYTE	"What's your name? ",0
	userName			BYTE	21 DUP(0)
	userNameSize		DWORD	?
	greeting			BYTE	"Hello, ",0

.code
main PROC
	; Introduce the Programmer
	call	introduceProgrammer	; Goes to the introduceProgrammer procedure

	; Gets the users name and greets them
	call	getName				; Goes to the getName procedure
	call	Crlf
	mov		edx, OFFSET greeting
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	Crlf


	exit	; exit to operating system
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
getName PROC USES eax, ecx, edx
	mov		edx, OFFSET namePrompt
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, SIZEOF	userName
	call	ReadString
	mov		userNameSize, eax
	ret
getName ENDP

END main
