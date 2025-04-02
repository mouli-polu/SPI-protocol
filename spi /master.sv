//https://edaplayground.com/x/LnnK 
module spi_master #(parameter trig=1) (
  input clk,
  input rst,
  input [7:0]data_in,
  input en,
  input miso,
  
  output wire  scl,
  output wire  mosi,
  output wire  cs,
  output wire [7:0] data_out
);
  reg [1:0] state;
  parameter idel =1;
  parameter send =2;
  parameter stop=3;
  
  reg SCL,CS;
  reg [7:0] rcv_data;
  reg [2:0] count;
  reg Mmosi;
  
  always @(posedge clk) begin
    if(rst ) begin
      Mmosi <=0;
      state <=idel;
      SCL <=0;
      CS <=1;
      rcv_data <=0;
      count<=0;
    end
    
    else begin
      case (state)
        idel : begin
          CS <=1;
          SCL <=~trig;
          Mmosi <=0;
          rcv_data <=0;
          count<=0;
          state <= en ?send :idel ;
        end
        send : begin
          CS <=0;
          SCL <=trig;
          Mmosi <= data_in[count];
          rcv_data[count] <=miso;
          count<=count+1;
          if(en ==0) begin
            CS<= 1;
            state <=idel;
          end
          else state<=stop;
        end
        
        stop :begin
          SCL <=~trig;
          if(en ==0) begin
            CS<= 1;
            state <=idel;
          end
          else state<=send;
        end
      endcase
    end
  end
  assign scl =SCL;
  assign cs =CS;
  assign mosi =Mmosi;
  assign data_out =rcv_data;
endmodule

