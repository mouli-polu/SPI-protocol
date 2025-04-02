  module tb;
    parameter trig =1;
    reg clk;
    reg rst;
    reg [7:0]data_in_master;
    reg [7:0] data_in_slave;
	reg en;
    wire[7:0] data_out_slave;
    wire [7:0] data_out_master;
    
    SPI_intf #(trig) spp(
      .clk(clk),
      .rst(rst),
      .data_in_master(data_in_master),
      . data_in_slave(data_in_slave),
      . en(en),
      .data_out_slave(data_out_slave),
      .data_out_master(data_out_master)
    );
    always #2 clk=~clk;
    
    initial begin 
      clk=0;
      rst=1;
      en =0;
      
      repeat (2) @(posedge clk);
      rst =0;
      @(posedge clk);
      en =1;
      data_in_master =8'b10110101;
      data_in_slave  =8'b11011001;
      #66 en =0;
      #20 $finish;
    end
    initial begin
   $dumpfile("dump.vcd"); 
     $dumpvars;
    end
  endmodule
         
