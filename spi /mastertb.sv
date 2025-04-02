

module tb ;
  reg clk;
  reg rst;
  reg [7:0]data_in;
  reg en;
  reg miso;
  wire scl;   
  wire mosi;
  wire cs;
  wire [7:0]data_out;
  
  spi_master  #(1) dut(
    . clk(clk),             
    .rst(rst),
    .data_in(data_in),
    .en(en),
    .miso(miso),
    .scl(scl),
    .mosi(mosi),
    .cs(cs),
    .data_out(data_out));
  
  initial begin 
    clk =0;
    miso=1;
    en=0;
    rst =1;
    #4 rst =0;
    #4;
    data_in =8'b11011010;
    en =1;
    for (int i=0;i<8;i++) 
   #5 miso =i;
    
    #34 en =0;
    #20 $finish;
  end
  always #2 clk =~clk;
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
    
endmodule
