
module spi_slave ( 
  input clk,
  input rst,
  input [7:0] data_in,
  input scl,
  input cs,
  input mosi,
  output  miso,
  output  [7:0] data_out
);
  
  reg [7:0]recv_data;
  reg [2:0]count ;
  reg MISO;
  
  always@(posedge clk) begin
    if(rst) begin
      MISO   <=0 ;
      count  <=0 ;
      recv_data <=0;
    end
  end
  
      
  always @(posedge scl ) begin
    if (!cs ) begin
      recv_data[count]<=mosi;
      MISO <=data_in[count];
      count<=count+1;
      end  
    end
  assign data_out=recv_data;
  assign miso=MISO;
endmodule
      
