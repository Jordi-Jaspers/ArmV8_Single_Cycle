/*
 * Module: InstructionMemory
 *
 * Test - Instructies:
 *
 * 38: ADD X9, XZR, XZR         zero out X9     =>  10001011000 11111 000000 11111 01001
 * 3c: ORRI X9, X9,             load 0x123      =>  1011001000 0001 0010 0011 01001 01001
 * 40: LSL X9, X9, #12          shift over      =>  11010011011 11111 001100 01001 01001
 * 44: ORRI X9, X9,             load 0x456      =>  1011001000 0100 0101 0110 01001 01001
 * 48: LSL X9, X9, #12          shift over      =>  11010011011 11111 001100 01001 01001
 * 4c: ORRI X9, X9,             load 0x789      =>  1011001000 0111 1000 1001 01001 01001
 * 50: LSL X9, X9, #12          shift over      =>  11010011011 11111 001100 01001 01001
 * 54: ORRI X9, X9,             laod 0xabc      =>  1011001000 1010 1011 1100 01001 01001
 * 58: LSL X9, X9, #12          shift over      =>  11010011011 11111 001100 01001 01001  
 * 5c: ORRI X9, X9,             laod 0xdef      =>  1011001000 1101 1110 1111 01001 01001
 * 60: LSL X9, X9, #4           shift over      =>  11010011011 11111 000100 01001 01001
 * xx: STUR X9, [XZR, 0x28]     store to memory =>  11111000000 000101000 00 11111 01001
 * xx: LDUR X10, [XZR, 0x28]    Correct?        =>  11111000010 000101000 00 11111 01010
 *
*/

module InstructionMemory(Instruction, Address);
    input [64:0] Address            //64bit adres-code

    output [31:0] Instruction       //32bit instructiecode uitvoer

    reg [31:0] Instruction
    
    always @ (Address) begin
        case(Address)
            63'h038: Data = 32'h8B1F03E9;
            63'h03c: Data = 32'hB2048D29;
            63'h040: Data = 32'hD37F3129;
            63'h044: Data = 32'hB2115929;
            63'h048: Data = 32'hD37F3129;
            63'h04c: Data = 32'hB21E2529;
            63'h050: Data = 32'hD37F3129; 
            63'h054: Data = 32'hB22AF129; 
            63'h058: Data = 32'hD37F3129; 
            63'h05c: Data = 32'hB237BD29;
            63'h060: Data = 32'hD37F1129; 
            63'h064: Data = 32'hF80283E9;
            63'h068: Data = 32'hF84283EA;
            default: Instruction = 32'hXXXXXXXX;
        endcase
    end
endmodule   
