Microcontroller design

Introduction

The purpose of this project is to design, simulate, and synthesize a behavioral embedded microcontroller. We will design a microcontroller that is compact, capable, and cost-effective fully embedded 8-bit RISC microcontroller core optimized for the many FPGA families.
In this design, the focus is to bring the most significant advantages that a processor can offer to a design environment at minimum cost. For this reason, these small processors have been considered to be "Programmable State Machines" and are referred to as "PSM". A PSM, like any other processor, will execute a program. A program is formed by a set of instructions that are defined by the user and held in a memory. Each instruction is encoded into a machine code.

Architecture

Features of the target CPU are as follows:

 The CPU has an 8-bit data bus and an 8-bit address bus, so it can support 256 bytes of memory to hold both instructions and data.

 Internally, there are four 8-bit registers, R0 to R3, an Instruction Register IR, the Program Counter PC, and an 8-bit immediate register that holds immediate values.

 The ALU is the same one that we designed this week. It performs the four operations AND, OR, ADD, SUB, on two 8-bit values, and supports signed ADDs and SUBs.

 The CPU is a load/store architecture: data must be brought into registers for manipulation, as the ALU only reads from and writes back to the registers.

 The ALU operations have two operands: one register is a source register, and the second register is both source and destination register, i.e. destination register = destination register OP source register. (As you completed in task 2).

 All the jump operations perform absolute jumps; there are no PC-relative branches. There are conditional jumps based on the zero-ness or negativity of the destination register, as well as a "jump always" instruction.

 The dbus and sbus labels indicate the lines coming out from the register file which hold the value of the destination and source registers.

 Note the data loop involving the registers and the ALU, whose output can only go back into a register.

 The dataout bus is only connected to the dbus line, so the only value which can be written to memory is the destination register.

 Also note that there are only 3 multiplexors:

o The address bus multiplexor can get a memory address from the PC, the immediate register (for direct addressing), or from the source or destination registers (for register indirect addressing).

o The PC multiplexor either lets the PC increment, or jump to the value in the immediate register.

o The multiplexor in front of the registers determines where a register write comes from: the ALU, the immediate register, another register or the data bus.

Instruction Set

•	Half of the instructions in the instruction set fit into one byte:

Op1	Op2	Rd	Rs
2	2	2	2

•	These instructions are identified by a 0 in the most-significant bit in the instruction, i.e. op1 = 0X.

•	The 4 bits of opcode are split into op1 and op2: details are given below.
•	Rd is the destination register, and Rs is the source register.
•	The other half of the instruction set are two-byte instructions. The first byte has the same format as

above, and it is followed by an 8-bit constant or immediate value:	
										
	Op1		Op2	Rd	Rs	Immediate		
	2		2	2	2	8		
•  These two-byte	instructions	are	identified	by a 1	in the most-significant bit in the instruction, i.e. op1
= 1X.								
•  With 4 operation bits, there are 16 instructions:	

	op1			op2				Mnemonic		Purpose

	00			00				AND Rd, Rs		Rd = Rd AND Rs

	00			01				OR Rd, Rs		Rd = Rd OR Rs

	00			10				ADD Rd, Rs		Rd = Rd + Rs

	00			11				SUB Rd, Rs		Rd = Rd - Rs

	01			00				LW Rd, (Rs)		Rd = Mem[Rs]

	01			01				SW Rd, (Rs)		Mem[Rs] = Rd

	01			10				MOV Rd, Rs		Rd = Rs

	01			11				NOP			Do nothing

	10			00				JEQ Rd, immed	 	PC = immed if Rd == 0

	10			01				JNE Rd, immed		PC = immed if Rd != 0

	10			10				JGT Rd, immed		PC = immed if Rd > 0

	10			11				JLT Rd, immed		PC = immed if Rd < 0

	11			00				LW Rd, immed		Rd = Mem[immed]

	11			01				SW Rd, immed		Mem[immed] = Rd

•	Note the regularity of the ALU operations and the jump operations: we can feed the op2 bits directly into the ALU, and use op2 to control the branch decision.

•	The rest of the instruction set is less regular, which will require special decoding for certain of the 16 instructions.

Instruction Phases

•	The CPU internally has three stages for the execution of each instruction.

•	On stage 1, the instruction is fetched from memory and stored in the Instruction Register.

•	On stage 2, if the fetched instruction is a two-byte instruction, the second byte is fetched from memory and stored in the Immediate Register. For one-byte instructions, nothing occurs in stage 2.

•	On stage 3, everything else is done as required, which can include:

o	An ALU operation, reading from two registers. o A jump decision which updates the PC.

o  A register write.

o A read from a memory location. o A write to a memory location.

•	After stage 3, the CPU starts the next instruction in stage 1

Stage Zero (Instruction Fetch)

•	On stage zero, the PC's value must be placed on the address bus, so the addrsel line must be 0. The irload line needs to be 1 so that the IR is loaded from the datain bus. Finally, the PC must be incremented in case we need to fetch an immediate value in stage 1.

•	All of this can be done using multiplexors which output different values depending on the current phase. Here is the control logic for the irload line.

•	We only need to load the IR on stage 0, so we can wire true to the 0 input of the irload multiplexor, and false to the other inputs. Note: input 11 (i.e. decimal 3) to the multiplexor is never used. Another way to look at each stage is the value which needs to be set for each control line, for each instruction.

•	'x' stands for any value, i.e. accept any opcode value, output any control line value.

Stage One

•	The values for control lines are generated by the Decode Logic, which gets as input the value from the Instruction Register, and the zero & negative lines of the destination register.
Inside the decode logic

•	Inside the Decode Logic block, the value from the Instruction Register is split into individual lines irbit4, irbit5, irbit6 and irbit7. op1 and op2 are split out, with op2 exported as aluop. The 4 opcode bits from the instruction are split out as the op1op2 line.

•	Several of the bits from the instruction register value are wired directly to these 2-bit outputs: dregsel, sregsel and aluop.

•	On stage 1, we need to load the Immediate Register with a value from memory if the irbit7 from the IR is true. The PC's value must be placed on the address bus, so the addrsel line must be 0. The imload line needs to be 1 so that the Immediate Register is loaded from the datain bus. Finally, the PC must be incremented so that we are ready to fetch the next instruction on the next stage 0.

•	The imload logic is shown above. It is very similar to the irload logic, but this time an enable value is output only on stage 1, and only if the irbit7 is set.

•	Some of the pcload logic is shown above. The PC is always incremented at stage 0. It is incremented at stage 1 if irbit7 is set, i.e. a two-byte instruction. Finally, the PC can be loaded with an immediate value in stage 2 if we are performing a jump instruction and the jump test is true.

•	We can tabulate the values of the control lines for stage 1. This time, what is output depends on the top bit of the op1 value.

Stage Two
The ALU instructions (op1=00) and the jump instructions (op1=10) are regular. All the op1=1x instructions use the Immediate Register, while the op1=0x instructions do not.

•	We can always tie dregsel to Rd from the instruction, and the same goes for sregsel = Rs and aluop = op2. And irload and imload are always 0 for stage 2.

•	With the remaining control lines, the regularities cease.

Test Program

 Consider an example program for your CPU.

 In memory starting at location 0x80 is a list of 8-bit numbers; the last number in the list is 0.

 We want a program to sum the numbers, store the result into memory location 0x40, and loop indefinitely after that.

 We have 4 registers to use. They are allocated as follows:

o R0 holds the pointer to the next number to add.

o R1 holds the running sum.

o R2 holds the next number to add to the running sum.

o R3 is used as a temporary register.

 The machine code, is shown in the hex values to put into memory starting at location 0:

				LI R1,0x00	e4 00
				
				LI R0,0x80	e0 80
				
				LW R2, (R0)	48
				
				JEQ R2, end	88 0d
				
				ADD R1, R2	26
				
				LI R3, 0x01	ec 01
				
				ADD R0, R3	23
				
				JMP loop	ff 04
				
				SW R1, 0x40	d4 40
				
				JMP inf	ff 0f
Deliverables

•	Using the description provided, implement the CPU in VHDL. Use the entities, as defined here to implement the important design blocks. In addition to these entities described here, add design elements as required.

•	In addition to the design, write a detailed report which describes the implementation of each module and any extra design elements that you might have added. Also mention any design, implementation considerations and issues that you ran into for this design.

•	Each module must first be designed and verified with a test bench individually.

•	It must be noted that you are free to decide on the implementation of a module and the implementation provided in the document is for providing an understanding.

•	For the ALU, you can reuse your already implemented design of ALU and modify it for this lab.

•	Your report need to include following steps:

o	With the memory loaded with the above data values, start the program. o Show the stages of operation. Watch the IR get loaded with an instruction. o Show the Immediate Register get loaded with a value.

o On the LW instruction, watch as the sbus value is selected to be placed on the address bus, and the datain value is written to the destination register.

o On ALU instructions, show the sbus and dbus values, the aluop, and the result which is written back into the destination register.

o On the JEQ instruction, show the value of N and Z into the Decode Logic, and the resulting pcsel and pcload values.
