
module programmer
(

  input wire clk_i,
  input wire rst_ni,

  input wire        prog_i,
  input wire        rx_i,
  input wire [15:0] clks_per_bit,

  output wire 	     we_o,
  output wire [11:0] addr_o,
  output wire [31:0] wdata_o,
  output wire 	     reset_o
);

  wire       rx_dv;
  wire [7:0] rx_byte;

iccm_controller u_iccm_ctrl(
 .clk_i		(clk_i),
 .rst_ni	(rst_ni),
 .prog_i	(prog_i),
 .rx_dv_i	(rx_dv),
 .rx_byte_i	(rx_byte),
 .we_o		(we_o),
 .addr_o	(addr_o),
 .wdata_o	(wdata_o),
 .reset_o	(reset_o)
);


uart_rx_prog u_prog_uart(
  .clk_i	(clk_i),
  .rst_ni	(rst_ni),
  .i_Rx_Serial	(rx_i),
  .CLKS_PER_BIT	(clks_per_bit),
  .o_Rx_DV	(rx_dv),
  .o_Rx_Byte	(rx_byte)
);


endmodule
