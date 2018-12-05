/*
 *	Module: RegisterFile
 *  Dit zorgt ervoor dat de inkomende 32bit instructie omgezet wordt naar een 64bit.
 *  32bit instructie, 9bit voor load, 19bit voor compare
 *  boek pagina 266.
 *
 */

module signextend(needtoextend, extended);

input [31:0] needtoextend;
output [63:0] extended;

//Zoals in het boek beschreven 31 getallen van de van de MSB [0] aan de voorkant toevoegen.
assign extended = {{31{needtoextend[31]}},needtoextend};
endmodule
