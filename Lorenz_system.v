
module Lorenz_system
//#(parameter dt= 1/256 ,sigma = 10 , beta = 8/3 ,roh = 28, x0 = -1 ,y0= 0.1 ,z0 = 25)
(
    	input clk, reset,
    	input signed [26:0] dt,sigma,beta,rho,X0,Y0,Z0,
    	output signed [26:0] X_K ,Y_k , Z_K
    );
    
    wire signed [26:0] functX,functY,functZ;
    wire signed [26:0] outX,outY,outZ ;
    ////////////////////////////////////////////
     /// To Avoid Overflow I rearange the multplication
    /// Calcultae X(k+1)
    wire signed [26:0] SubXY,OutXmult1;
    // claculate y(k)- x(k)
    assign SubXY = (outY - outX);
    // calcultae  dt.(y-x)
    signed_mult Xmult1(
        .a(SubXY),
        .b(dt),
        .out(OutXmult1)
      );
      
      // calculate  sigma.dt.(dx/dt)
      signed_mult Xmult2(
        .a(OutXmult1),
        .b(sigma),
        .out(functX)
      );
      // integrator of x
    Euler_integrator X_integrator(
    .funct(functX),
    .clk(clk),
    .reset(reset),
    .InitialOut(X0),
    .out(outX)
    );

    /// To Avoid Overflow I rearange the multplication
    /////////////////////////////////////
    // claculate y(K+1)   
    // dy/dt = x*(rho-z)-y
    
   wire signed [26:0] SubZRoh , Xdtmult0 ,Ydt_out,dtxzrho_out ;
    assign SubZRoh = rho - outZ ;
    /// x* dt
    
    signed_mult XSubZRohmult(
        .a(outX),
        .b(dt),
        .out(Xdtmult0)
      );
      
      /// XmultSubZRoh - y 
      /// calculate dt.y
       signed_mult dymult(
        .a(outY),
        .b(dt),
        .out(Ydt_out)
      );
      // dy*X*(rho - z)
 signed_mult mult22(
        .a(Xdtmult0),
        .b(SubZRoh),
        .out(dtxzrho_out)
      );      
      // func Y
	assign functY = dtxzrho_out - Ydt_out ;
      /// dy integrator 
      Euler_integrator Y_integrator(
    .funct(functY),
    .clk(clk),
    .reset(reset),
    .InitialOut(Y0),
    .out(outY)
    );
    ////////////////////////////////////////
    
    /// calculate Z(k+1)
    /// xy??z
    
    wire signed [26:0] Xdtmult, Zdtmult , xdty_out,zdtbeta_out;
    
    // calculate X*dt
    signed_mult Xdt_mult(
        .a(outX),
        .b(dt),
        .out(Xdtmult)
      );
      
      // calculate dt*z
      signed_mult Zdt_mult(
        .a(dt),
        .b(outZ),
        .out(Zdtmult)
      );

	// calculate y*X*dt
      signed_mult xdty_mult(
        .a(Xdtmult),
        .b(outY),
        .out(xdty_out)
      );
      // beta*z*dt
	signed_mult zdtbeta_mult(
        .a(Zdtmult),
        .b(beta),
        .out(zdtbeta_out)
      );
      
      // calculate function
      assign functZ = xdty_out - zdtbeta_out ;
      

   // dz integrator 
   Euler_integrator Z_integrator(
    .funct(functZ),
    .clk(clk),
    .reset(reset),
    .InitialOut(Z0),
    .out(outZ)
    );
    /// OUTPUT
    assign X_K = outX;
    assign  Y_k = outY;
    assign Z_K = outZ ;
endmodule
