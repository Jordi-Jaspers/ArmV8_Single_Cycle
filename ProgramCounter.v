/*
 *  Module: ProgramCounter
 *  onthoud het adres voor de huidige instructie en gaat erna verder naar de volgende
 *  instructie voor uit te voeren. Deze moet gekoppeld met een ALU die alleen de ADD instructie doet.
 *
 */

module ProgramCounter (NextPC, CurrentPC, SignExt, Branch, ALUZero, Clk, Rst);

input [63:0] CurrentPC;
input [63:0] SignExt;  

input Rst;
input Clk;         
input Branch;
input ALUZero;

output reg [NextPC];

always @ (posedge Clk)
begin
	if(Rst == 1)                                //Als reset HIGH is dan reset PC
        NextPC <= 0;
    else if (branch == 1 && ALUZero == 1)       //Als CBZ (compare and branche on zero) dan pc + 1 met signext Binary shift left
        NextPC <= CurrentPC + (SignExt << 1);
    else
        NextPC <= CurrentPC + 2
end
endmodule