`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:23 08/16/2021 
// Design Name: 
// Module Name:    multiplier 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module multiplier(
    input [3:0]mcand,
    input [3:0]mplier,
	 input clk,reset,
    output reg [7:0]prod
    );

reg [3:0]N = 0;
reg [2:0]cur_s,nex_s;
parameter s0 = 3'b000,s1 = 3'b001,s2 = 3'b010,s3 = 3'b011,done = 3'b100;

reg [3:0]mcand_reg,mplier_reg;


always @(posedge clk)
begin
if(!reset)
cur_s <= s0;
else
cur_s <= nex_s;
end

always @(cur_s or mcand or mplier or mplier_reg or mcand_reg or N)
begin
case(cur_s)
s0:begin
	if(mplier_reg[0] == 1)
	begin
	prod = {4'b0000,mcand_reg} + prod;
	nex_s = s1;
	end
	else
	nex_s = s1;
	end
s1: begin
	mcand_reg = mcand_reg<<1;
	nex_s = s2;
	end
s2:begin
	mplier_reg = mplier_reg>>1;
	nex_s = s3;
	end
s3:begin
	if(N == 4'b0100)
	nex_s = done;
	else
	begin
	N = N+4'b0001;
	nex_s  = s0;
	end
	end
done: begin end
default: begin
			prod = 8'b00000000;
			mcand_reg = mcand;
			mplier_reg = mplier;
			nex_s = s0;
			end
endcase
end


endmodule
