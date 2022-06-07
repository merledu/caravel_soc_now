module prog_uart_top(  
  input           clock,
  input           reset,
  output [31:0]   io_gpio_o,
  output [31:0]   io_gpio_en_o,
  input  [31:0]   io_gpio_i,
  input           io_rx_i,
  input  [15:0]   io_CLK_PER_BIT,
  output          boot,
  input           prog_i);

wire        io_rx_we;
wire [31:0] io_rx_wdata;
wire        rst;
wire [31:0] io_rx_addr;
wire        a_clk;

assign boot = rst;

Top u_top(
  .clock(clock),
  .reset(reset | ~rst),
  .io_gpio_o(io_gpio_o),
  .io_gpio_en_o(io_gpio_en_o),
  .io_gpio_i(io_gpio_i),
  .io_rx_we_i(~io_rx_we),
  .io_rx_addr_i(io_rx_addr),
  .io_rx_wdata_i(io_rx_wdata),
  .io_rx_reset_i(rst)
);

programmer u_programmer(
  .clk_i(clock),
  .rst_ni(~reset),
  .prog_i(prog_i),
  .rx_i(io_rx_i),
  .clks_per_bit(io_CLK_PER_BIT),
  .we_o(io_rx_we),
  .addr_o(io_rx_addr),
  .wdata_o(io_rx_wdata),
  .reset_o(rst));




endmodule
