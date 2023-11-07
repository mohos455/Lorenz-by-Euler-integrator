

module Euler_integrator
// #(parameter dt= 1/256 ,sigma = 10 , beta = 8/3 ,roh = 28, x0 = -1 ,y0= 0.1 ,z0 = 25)
 (
	input signed [26:0] funct,     //the dV/dt function
	input clk, reset,
	input signed [26:0] InitialOut,  //the initial state variable V
	output signed [26:0] out		//the state variable V
);
	wire signed	[26:0] v1new ;
	reg signed	[26:0] v1 ;
	
	always @ (posedge clk) 
	begin
		if (reset==0) //reset	
			v1 <= InitialOut ; // 
		else 
			v1 <= v1new ;	
	end
	assign v1new = v1 + funct ;
	assign out = v1 ;
	
endmodule