/*
 *  Module: ALUControl
 *  Dit geeft instructies aan de alu via 11bit opcodes 2bit ALUOP en 4bit operation
 *  pagina 273 in het boek
 *  pagina 272 in het boekt geeft aan welke instrcutie nodig zijn + andere instructies in appendix C
 *
 */


module ALUControl(Operation, ALUOP, OPCode);

input [1:0] ALUOP;                          //2bit ALUOP
input [10:0] OPCode;                        //11bit OPCode
output reg [3:0] Operation;                 //4bit operation

always @ (*)
begin
	Operation <= 4'b1;                      // initialiseer
	if (ALUOP == 2'b00)                     // ALUOP[00] D-type
		Operation <= #2 4'b0010;
	if (ALUOP == 2'b01)                     // ALUOP[01] B-type
		Operation <= #2 4'b0111;
	if (ALUOP == 2'b10)                     // ALUOP[10] R-types
	begin                                   
		if (OPCode == 11'b10001011000)      //ADD-instruction
			Operation <= #2 4'b0010;
		if (OPCode == 11'b11001011000)      //SUB-instruction
			Operation <= #2 4'b0110;
		if (OPCode == 11'b10001010000)      //AND-instruction
			Operation <= #2 4'b0000;
		if (OPCode == 11'b10101010000)      //OR -instruction
			Operation <= #2 4'b0001;
		if (OPCode[10:1] == 10'b1011001000) // ORRI instruction: grab the first 10 bits
			Operation <= #2 4'b0001;       
		if (OPCode == 11'b11010011011)      // LSL instruction
			Operation <= #2 4'b0011;        
	end
end
endmodule
