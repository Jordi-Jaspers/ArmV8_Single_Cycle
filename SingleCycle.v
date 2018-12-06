/*
 *  @Author: Jordi Jaspers
 *  
 *  This project contains the composition of all the made modules. The wiring done in this program follows
 *  the paths made in the picture in the book at page 276. This is a fully working single cycle ARM processor.
 *
 */

module SingleCycleProc(Clk, Reset, startPC, currentPC, dMemOut);
   input Clk;
   input Reset;
   input [63:0] startPC;
   output [63:0] currentPC;
   output [63:0] dMemOut;
   
   //PC Logic -- 64 bit programcounter aangemaakt
   wire [63:0] 	 nextPC;
   reg [63:0] 	 currentPC;
   
   //Instruction Decode -- Book page 272
   wire [31:0] 	 currentInstruction;
   wire [10:0] 	 opcode;
   wire [4:0] 	 rm,rn,rd;
   wire [5:0] 	 shamt;

   assign {opcode, rm, shamt, rn, rd} = currentInstruction;
   
   //RegisterFile wires
   wire [63:0] 	 Out1;
   wire [63:0] 	 Out2;
   wire [63:0] 	 Data;

   wire [4:0]    R1;
   wire [4:0] 	 R2; 
   
   //Control & ALUControl Logic Wires
   wire 	     Reg2Loc, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite;
   wire [1:0] 	 ALUOP;
   wire [3:0] 	 Operation;
   
   //ALU Wires
   wire [63:0] 	 SignExt, InALU;
   wire [63:0] 	 OutALU;
   wire 	     ALUZero;
   
   //Data Memory Wires -- ReadData in module
   wire [63:0] 	 dMemOut;

   //Instruction Memory
   InstructionMemory instrMem(.Data(currentInstruction), 
                              .Address(currentPC));	
   
   //PC Logic	
   ProgramCounter next(	.NextPC(nextPC),
                        .CurrentPC(currentPC),
                        .SignExt(signExt),
                        .Branch(Branch), 
                        .ALUZero(ALUZero);


	always @ (posedge Clk, posedge Reset) 
	begin
		if(Reset == 1)
			currentPC = startPC;
		else
			currentPC = nextPC;
	end
   
   //Control
   SingleCycleControl control(.Reg2Loc(Reg2Loc), 
   							  .ALUSrc(ALUSrc),
   							  .MemToReg(MemToReg), 
   							  .RegWrite(RegWrite), 
   							  .MemRead(MemRead), 
   							  .MemWrite(MemWrite), 
   							  .Branch(Branch),  
   							  .OALUOP(ALUOP), 
   							  .Opcode(opcode));
   
   //Register file
   /* Create the Reg2Loc Mux with a ternary statement. */
	assign rB = Reg2Loc ? rd : rm;
	// rd if true, rm if false

   RegisterFile registers(.BusA(busA), 
   						  .BusB(busB), 
   						  .BusW(busW), 
   						  .RA(rn), 
   						  .RB(rB), 
   						  .RW(rd), 
   						  .RegWr(RegWrite), 
   						  .Clk(Clk));
   
   //Sign Extender
   /*instantiate your sign extender*/
   SignExtender SignExt(.BusImm(signExtImm64), .Inst(currentInstruction)); //
   //ALU
   ALUControl ALUCont(.ALUCtrl(ALUCtrl), 
                      .ALUop(ALUOp), 
                      .Opcode(opcode));

   assign #2 ALUImmRegChoice = ALUSrc ? signExtImm64 : busB;
   
   ALU mainALU(.BusW(ALUResult), 
		       .Zero(ALUZero), 
		       .BusA(busA), 
		       .BusB(ALUImmRegChoice), 
		       .ALUCtrl(ALUCtrl));
   
   //Data Memory
   DataMemory data(.ReadData(dMemOut), 
                   .Address(ALUResult), 
                   .WriteData(busB), 
                   .MemoryRead(MemRead), 
                   .MemoryWrite(MemWrite), 
                   .Clock(CLK));
  
   /* create MemToReg mux - another ternary statement */
	assign busW = MemToReg ? dMemOut : ALUResult;
   
endmodule
