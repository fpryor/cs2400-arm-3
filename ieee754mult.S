		;		ARM Programming Assignment #3: 32 bit IEEE 754 single-precision multiplier
		;
		;		Write a 32-bit floating point multiplier. The numbers will be represented
		;       in the single-precision IEEE 754 floating-point standard. The result should
		;       also be in IEEE 754 binary32. Assume you only have normalized numbers, i.e.
		;       the exponent is never 0b00000000.
		;		Write the result in the provided "fill" word.

		;		Your code here

main
		ADR		r0, floats
		LDR		r1, [r0]			;first number
		LDR		r2, [r0, #4] 		;second number
		LSR		r3, r1, #24 		;get biased exponent
		LSR		r4, r2, #24		;get biased exponent
		ADD		r7, r3, r4		;add exponents
		SUB		r7, r7, #127	;subtract bias
		MOV		r3, #1			;masking bit for AND
		MOV		r4, #0			;holds result of AND
		MOV		r8, #23			;counter
loop
		AND		r4, r1, r3		;check for 1
		SUBS		r4, r4, r3		;if positive
		ADDSpl	r5, r5, r2		;add to accumulaor
		LSLS		r2, r2, #1
		LSR		r1, r1, #1
		SUBS		r8, r8, #1		;decrement counter
		BNE		loop
		LSR		r5, r5, #9		;truncate to 23 bits
		LSL		r7, r7, #24		;move exponent
		ADD		r5, r5, r7		;merge exponent with fraction

		ADR		r10, result
		STR		r5, [r10]
		END


floats	DCD		0xa0bcff0d, 0x13c0adea
result	FILL		8

