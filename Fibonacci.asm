.386								; Enables the 80386 processor instructions and disables newer instructions
.MODEL FLAT, stdcall				; Sets the memory model to flat and the function calling convention to stdcall
.STACK 4096							; Sets the size of the stack to 4096

ExitProcess PROTO, dwExitCode:DWORD	; Sets up the exit code for the program

.data								; Header for data section

total DWORD ?
tmp1 DWORD ?
tmp2 DWORD ?

.code								; Header for code section

main PROC							; Starts main
	
	MOV ebx, 0						; Move 0 into ebx
	MOV edx, 1						; Move 1 into edx

	top:							; Label top

		MOV eax, ebx				; Move the value in ebx into eax
		MOV ebx, edx				; Move the value in edx into edx

		MOV edx, eax				; Move the value of eax into edx
		ADD edx, ebx				; Add the value in ebx into edx

		mov tmp1, edx				; Save the value of edx into tmp1
		mov tmp2, eax				; Save the value of eax into tmp2

		mov eax, edx				; Move the value in edx into eax
		mov edx, 0					; Move 0 into edx (makes sure div sees the value in eax correctly)
		mov ecx, 2					; Move 2 into ecx
		div ecx						; Divide the value in eax by the value in ecx

		CMP edx, 0					; Compare the remainder (in edx) with 0

		mov edx, tmp1				; Restore the value of edx from tmp1
		mov eax, tmp2				; Restore the value of eax from tmp2

		JNZ addvalue				; If the remainder in edx was 1, jump to addvalue
		JMP top						; Jump to top
		
	addvalue:						; Label addvalue

		CMP edx, 1000000			; Compare the value of edx with 1000000
		JNBE exit					; If the value of edx is greater, jump to exit

		ADD total, edx				; Add the value of edx into total
		JMP top						; Jump to top

exit:								; Label exit

INVOKE ExitProcess, 0				; Calls the function ExitProcess with value 0
main ENDP							; Ends main
END									; Ends the program