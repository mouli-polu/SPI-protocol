module tb ;
  reg clk;
  reg rst;
  reg [7:0]data_in;
 
  reg scl;   
  reg mosi;
  reg cs;
  wire miso;
  wire [7:0]data_out;
  
  spi_slave   dut(
    .clk(clk),             
    .rst(rst),
    .data_in(data_in),
    .miso(miso),
    .scl(scl),
    .mosi(mosi),
    .cs(cs),
    .data_out(data_out)
  );
  
  initial begin 
    scl=0;
    clk =0;
    cs=1;
    mosi=1;
    rst =1;
    #4 rst =0;
    #4;
    cs=0;
    data_in =8'b11011010;
    for (int i=0;i<8;i++) 
   #5 mosi =i;
    #5 cs=1;
    #20 $finish;
  end
  always #2 clk =~clk;
  always #2 scl =~scl;
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
    
endmodule
