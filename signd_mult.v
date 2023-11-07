module signed_mult (

	input 	signed	[26:0] 	a,
	input 	signed	[26:0] 	b,
	output 	signed  [26:0]	out
);
	// intermediate full bit length
	wire 	signed	[53:0]	mult_out;
	assign mult_out = a * b;
	// select bits for 7.20 fixed point
	assign out = {mult_out[53], mult_out[45:20]};
	
endmodule
