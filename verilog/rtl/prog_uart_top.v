// SPDX-FileCopyrightText: 2022 Wuhan University of Technology
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

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
