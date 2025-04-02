`include "master.v"
`include "slave.sv"
module SPI_intf #(parameter trig=1)(
  input clk,
  input rst,
  input [7:0] data_in_master,
  input en,
  input [7:0]data_in_slave,
  
  output [7:0] data_out_master,
  output [7:0] data_out_slave
);
  wire scl;
  wire mosi;
  wire miso;
  wire cs;
  
  spi_master  #(trig ) master (
    .clk(clk),
    .rst(rst),
    .data_in(data_in_master),
    .en(en),
      .miso(miso),
    .scl(scl),
    .mosi(mosi),
    .cs(cs),
    .data_out(data_out_master)
);

  spi_slave slave (
    .clk(clk),
    .rst(rst),
    .data_in( data_in_slave),
    .scl(scl),
    .cs(cs),
    .mosi(mosi),
    .miso(miso),
    .data_out(data_out_slave)
);
endmodule

