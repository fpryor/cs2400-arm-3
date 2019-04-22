		;		ARM Programming Assignment #3: IEEE 754 to TNS bit-level marshaller
		;
		;		Write a program to convert a 32-bit single-precision IEEE 754 floating-point
		;       number to the Tandem Non-stop Series (TNS) format. Refer to the README for a
		;       description of the format. Convert the numbers in `floats` and write the TNS
		;       equivalents into the `tns` area, one after the other.

		;		Your code here

ADR		r0, count
		LDR		r10, [r0]
		ADR		r0, ieee
		LDR		r3, [r0]
		LDR		r4, [r0, #4]
		LDR		r5, [r0, #8]
		ADR		r2, tns
		ADR		r0, floats


loop
		LDR		r1, [r0, r9]
		AND		r6, r1, r3		;checking for 1 in sign bit
		AND		r7, r1, r4		;extracting exponent
		AND		r8, r1, r5		;extracting fraction
		LSR		r7, r7, #23		;move exponent to tns format
		LSR		r8, r8, #1		;truncate fraction
		LSL		r8, r8, #9		;move fraction to tns format
		SUB		r7, r7, #127	;account for bias
		ADD		r7, r7, #256	;account for bias
		ORR		r6, r6, r8		;merge sign with fraction
		ORR		r6, r6, r7		;merge sign and fraction with exp
		STR		r6, [r2, r9]		;store converted value
		ADD		r9, r9, #4
		SUB		r10, r10, #1
		CMP		r10, #0
		BGT		loop
		END

count	DCD		2	;counter
ieee		DCD		0x80000000, 0x7F800000, 0x007FFFFF
floats	DCD		0xa0bcff0d, 0x13c0adea
tns		FILL		16

