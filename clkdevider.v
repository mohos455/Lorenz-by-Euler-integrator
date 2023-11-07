module clkdev (
    input CLOCK_50,reset,
    output AnalogClock
);
    reg [4:0] count;
// analog update divided clock
always @ (posedge CLOCK_50) 
begin
	if(reset==0)
	count <= 0; 
	else
        count <= count + 1; 
end	
assign AnalogClock = (count==0);	

endmodule