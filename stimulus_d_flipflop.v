`define STRLEN 15 
module stimulus_d_flipflop;
task passTest;
input actualOut,expectedOut; 
input [`STRLEN*8:0] testType;
inout [7:0] passed;
if ( actualOut == expectedOut ) 
begin 
$display("%s passed" , testType ); 
passed = passed + 1; 
end 
else 
$display ("%s failed : %d should be %d" , testType , actualOut , expectedOut );
endtask
task allPassed ;
input [7:0] passed; 
input [7:0] numTests;
if ( passed == numTests) 
$display ("All tests passed"); 
else 
$display ("Some tests failed");
endtask
// Inputs 
reg d; reg clk ; reg reset;
reg [7:0] passed ;
// Outputs 
wire out ;
// Instantiate the Unit Under Test (UUT) 
d_flipflop uut ( . out ( out ) , . d (d) , . clk ( clk ) , . reset ( reset ) );
initial 
begin // Initialize Inputs 
d= 0; clk = 0; reset = 1; passed = 0;
// Wait 100 ns for global reset to finish 
#100;

// Add stimulus here 
reset = 0;
#90; d =1; #7; clk = 1; #3; clk = 0; 
#90; passTest (out , 1, "Set" , passed );
#90; d =1; #7; clk = 1; #3; clk = 0; 
#90; passTest (out , 1, "Set" , passed );
#90; d =0; #7; clk = 1; #3; clk = 0; 
#90; passTest (out , 0, "Reset" , passed );

#90; allPassed ( passed , 3);
#100 $stop;
end
endmodule 
