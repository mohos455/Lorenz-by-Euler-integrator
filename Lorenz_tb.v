
module Lorenz_tb();

reg CLOCK_50, reset ;
wire clk;
reg signed [26:0] dt,sigma,beta,rho,X0,Y0,Z0 ;

wire signed [26:0] X_K ,Y_k , Z_K ;


initial begin
//#(parameter dt= 1/256 ,sigma = 10 , beta = 8/3 ,roh = 28, x0 = -1 ,y0= 0.1 ,z0 = 25)
		dt  =   27'b000000000000001000000000000; // 4096  
		sigma = 27'b000101000000000000000000000; // 10485760
		beta =  27'b000001010101010101010101011 ; // 2796202.667 // 2.6666666667
		rho =   27'b001110000000000000000000000; // 28 // 29360128
		X0 =    27'b111111100000000000000000000; // -1 // 1048576
		Y0 =    27'b000000000011001100110011010 ;// 0.1 // 104857.6
		Z0 =    27'b001100100000000000000000000 ; // 25 // 26214400
		//testbench_out = 15'd0 ;
		
		
	end

initial begin
		CLOCK_50 = 1'b0;
		//testbench_out = 15'd0 ;
	end	
	//Toggle the clocks
	always begin
		#10
		CLOCK_50 = !CLOCK_50;
	end
	

initial begin
		reset  = 1'b1;
		#10 
		reset  = 1'b0;
		#30
		reset  = 1'b1;
	end
	clkdev clkdev1(
		.CLOCK_50(CLOCK_50),
		.reset(reset),
		.AnalogClock(clk)
	);
	Lorenz_system DUT(
	.clk(clk),
	.reset(reset),
	.dt(dt),
	.sigma(sigma),
	.beta(beta),
	.rho(rho),
	.X0(X0),
	.Y0(Y0),
	.Z0(Z0),
	.X_K(X_K),
	.Y_k(Y_k),
	.Z_K(Z_K)
	);


endmodule
