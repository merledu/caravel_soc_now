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

module WishboneHost(
  input         clock,
  input         reset,
  input         io_wbMasterTransmitter_ready,
  output        io_wbMasterTransmitter_valid,
  output        io_wbMasterTransmitter_bits_cyc,
  output        io_wbMasterTransmitter_bits_stb,
  output        io_wbMasterTransmitter_bits_we,
  output [31:0] io_wbMasterTransmitter_bits_adr,
  output [31:0] io_wbMasterTransmitter_bits_dat,
  output [3:0]  io_wbMasterTransmitter_bits_sel,
  output        io_wbSlaveReceiver_ready,
  input         io_wbSlaveReceiver_bits_ack,
  input  [31:0] io_wbSlaveReceiver_bits_dat,
  input         io_wbSlaveReceiver_bits_err,
  output        io_reqIn_ready,
  input         io_reqIn_valid,
  input  [31:0] io_reqIn_bits_addrRequest,
  input  [31:0] io_reqIn_bits_dataRequest,
  input  [3:0]  io_reqIn_bits_activeByteLane,
  input         io_reqIn_bits_isWrite,
  output        io_rspOut_valid,
  output [31:0] io_rspOut_bits_dataResponse
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg  startWBTransaction; // @[WishboneHost.scala 39:35]
  reg [31:0] dataReg; // @[WishboneHost.scala 41:24]
  reg  respReg; // @[WishboneHost.scala 42:24]
  reg  stbReg; // @[WishboneHost.scala 45:23]
  reg  cycReg; // @[WishboneHost.scala 46:23]
  reg  weReg; // @[WishboneHost.scala 47:22]
  reg [31:0] datReg; // @[WishboneHost.scala 48:23]
  reg [31:0] adrReg; // @[WishboneHost.scala 49:23]
  reg [3:0] selReg; // @[WishboneHost.scala 50:23]
  reg  stateReg; // @[WishboneHost.scala 55:25]
  reg  readyReg; // @[WishboneHost.scala 61:25]
  wire  _T_2 = io_reqIn_valid & io_wbMasterTransmitter_ready; // @[WishboneHost.scala 18:37]
  wire  _GEN_0 = _T_2 ? 1'h0 : readyReg; // @[WishboneHost.scala 62:14 WishboneHost.scala 63:14 WishboneHost.scala 61:25]
  wire  _GEN_1 = stateReg | _GEN_0; // @[WishboneHost.scala 65:33 WishboneHost.scala 66:14]
  wire  _GEN_2 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | startWBTransaction; // @[WishboneHost.scala 84:92 WishboneHost.scala 85:26 WishboneHost.scala 39:35]
  wire  _GEN_3 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | stbReg; // @[WishboneHost.scala 84:92 WishboneHost.scala 86:14 WishboneHost.scala 45:23]
  wire  _GEN_4 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | cycReg; // @[WishboneHost.scala 84:92 WishboneHost.scala 87:14 WishboneHost.scala 46:23]
  wire  _GEN_9 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_2; // @[WishboneHost.scala 76:86 WishboneHost.scala 77:26]
  wire  _GEN_10 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_3; // @[WishboneHost.scala 76:86 WishboneHost.scala 78:14]
  wire  _GEN_11 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_4; // @[WishboneHost.scala 76:86 WishboneHost.scala 79:14]
  wire  _GEN_23 = io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack | respReg; // @[WishboneHost.scala 111:78 WishboneHost.scala 113:15 WishboneHost.scala 42:24]
  wire  _GEN_27 = io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err | _GEN_23; // @[WishboneHost.scala 105:71 WishboneHost.scala 107:15]
  assign io_wbMasterTransmitter_valid = io_wbMasterTransmitter_bits_stb; // @[WishboneHost.scala 23:32]
  assign io_wbMasterTransmitter_bits_cyc = ~startWBTransaction ? 1'h0 : cycReg; // @[WishboneHost.scala 101:31 WishboneHost.scala 102:118 WishboneHost.scala 95:37]
  assign io_wbMasterTransmitter_bits_stb = ~startWBTransaction ? 1'h0 : stbReg; // @[WishboneHost.scala 101:31 WishboneHost.scala 102:118 WishboneHost.scala 94:37]
  assign io_wbMasterTransmitter_bits_we = ~startWBTransaction ? 1'h0 : weReg; // @[WishboneHost.scala 101:31 WishboneHost.scala 102:118 WishboneHost.scala 96:36]
  assign io_wbMasterTransmitter_bits_adr = ~startWBTransaction ? 32'h0 : adrReg; // @[WishboneHost.scala 101:31 WishboneHost.scala 102:118 WishboneHost.scala 97:37]
  assign io_wbMasterTransmitter_bits_dat = ~startWBTransaction ? 32'h0 : datReg; // @[WishboneHost.scala 101:31 WishboneHost.scala 102:118 WishboneHost.scala 98:37]
  assign io_wbMasterTransmitter_bits_sel = ~startWBTransaction ? 4'h0 : selReg; // @[WishboneHost.scala 101:31 WishboneHost.scala 102:118 WishboneHost.scala 99:37]
  assign io_wbSlaveReceiver_ready = 1'h1; // @[WishboneHost.scala 26:28]
  assign io_reqIn_ready = readyReg; // @[WishboneHost.scala 75:20]
  assign io_rspOut_valid = respReg; // @[WishboneHost.scala 127:21]
  assign io_rspOut_bits_dataResponse = dataReg; // @[WishboneHost.scala 128:33]
  always @(posedge clock) begin
    if (reset) begin // @[WishboneHost.scala 39:35]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 39:35]
    end else if (io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err) begin // @[WishboneHost.scala 105:71]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 110:26]
    end else if (io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack) begin // @[WishboneHost.scala 111:78]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 115:26]
    end else begin
      startWBTransaction <= _GEN_9;
    end
    if (reset) begin // @[WishboneHost.scala 41:24]
      dataReg <= 32'h0; // @[WishboneHost.scala 41:24]
    end else if (io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err) begin // @[WishboneHost.scala 105:71]
      dataReg <= io_wbSlaveReceiver_bits_dat; // @[WishboneHost.scala 106:15]
    end else if (io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack) begin // @[WishboneHost.scala 111:78]
      dataReg <= io_wbSlaveReceiver_bits_dat; // @[WishboneHost.scala 112:15]
    end
    if (reset) begin // @[WishboneHost.scala 42:24]
      respReg <= 1'h0; // @[WishboneHost.scala 42:24]
    end else if (~stateReg) begin // @[WishboneHost.scala 118:29]
      respReg <= _GEN_27;
    end else if (stateReg) begin // @[WishboneHost.scala 120:42]
      respReg <= 1'h0; // @[WishboneHost.scala 121:15]
    end else begin
      respReg <= _GEN_27;
    end
    if (reset) begin // @[WishboneHost.scala 45:23]
      stbReg <= 1'h0; // @[WishboneHost.scala 45:23]
    end else begin
      stbReg <= _GEN_10;
    end
    if (reset) begin // @[WishboneHost.scala 46:23]
      cycReg <= 1'h0; // @[WishboneHost.scala 46:23]
    end else begin
      cycReg <= _GEN_11;
    end
    if (reset) begin // @[WishboneHost.scala 47:22]
      weReg <= 1'h0; // @[WishboneHost.scala 47:22]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 76:86]
      weReg <= io_reqIn_bits_isWrite; // @[WishboneHost.scala 80:13]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 84:92]
      weReg <= io_reqIn_bits_isWrite; // @[WishboneHost.scala 88:13]
    end
    if (reset) begin // @[WishboneHost.scala 48:23]
      datReg <= 32'h0; // @[WishboneHost.scala 48:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 76:86]
      datReg <= 32'h0; // @[WishboneHost.scala 82:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 84:92]
      datReg <= io_reqIn_bits_dataRequest; // @[WishboneHost.scala 90:14]
    end
    if (reset) begin // @[WishboneHost.scala 49:23]
      adrReg <= 32'h0; // @[WishboneHost.scala 49:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 76:86]
      adrReg <= io_reqIn_bits_addrRequest; // @[WishboneHost.scala 81:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 84:92]
      adrReg <= io_reqIn_bits_addrRequest; // @[WishboneHost.scala 89:14]
    end
    if (reset) begin // @[WishboneHost.scala 50:23]
      selReg <= 4'h0; // @[WishboneHost.scala 50:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 76:86]
      selReg <= io_reqIn_bits_activeByteLane; // @[WishboneHost.scala 83:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 84:92]
      selReg <= io_reqIn_bits_activeByteLane; // @[WishboneHost.scala 91:14]
    end
    if (reset) begin // @[WishboneHost.scala 55:25]
      stateReg <= 1'h0; // @[WishboneHost.scala 55:25]
    end else if (~stateReg) begin // @[WishboneHost.scala 118:29]
      stateReg <= io_wbSlaveReceiver_bits_ack | io_wbSlaveReceiver_bits_err; // @[WishboneHost.scala 119:16]
    end else if (stateReg) begin // @[WishboneHost.scala 120:42]
      stateReg <= 1'h0; // @[WishboneHost.scala 122:16]
    end
    readyReg <= reset | _GEN_1; // @[WishboneHost.scala 61:25 WishboneHost.scala 61:25]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  startWBTransaction = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  respReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  stbReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  cycReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  weReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  datReg = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  adrReg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  selReg = _RAND_8[3:0];
  _RAND_9 = {1{`RANDOM}};
  stateReg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  readyReg = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WishboneDevice(
  input         io_wbSlaveTransmitter_ready,
  output        io_wbSlaveTransmitter_bits_ack,
  output [31:0] io_wbSlaveTransmitter_bits_dat,
  output        io_wbSlaveTransmitter_bits_err,
  output        io_wbMasterReceiver_ready,
  input         io_wbMasterReceiver_valid,
  input         io_wbMasterReceiver_bits_cyc,
  input         io_wbMasterReceiver_bits_stb,
  input         io_wbMasterReceiver_bits_we,
  input  [31:0] io_wbMasterReceiver_bits_adr,
  input  [31:0] io_wbMasterReceiver_bits_dat,
  input  [3:0]  io_wbMasterReceiver_bits_sel,
  output        io_reqOut_valid,
  output [31:0] io_reqOut_bits_addrRequest,
  output [31:0] io_reqOut_bits_dataRequest,
  output [3:0]  io_reqOut_bits_activeByteLane,
  output        io_reqOut_bits_isWrite,
  input         io_rspIn_valid,
  input  [31:0] io_rspIn_bits_dataResponse,
  input         io_rspIn_bits_error
);
  wire  _T_1 = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneDevice.scala 16:80]
  wire  _T_4 = io_rspIn_valid & ~io_rspIn_bits_error; // @[WishboneDevice.scala 36:27]
  wire  _T_5 = io_rspIn_valid & io_rspIn_bits_error; // @[WishboneDevice.scala 42:34]
  wire  _GEN_5 = io_rspIn_valid & ~io_rspIn_bits_error ? 1'h0 : _T_5; // @[WishboneDevice.scala 36:52 WishboneDevice.scala 40:40]
  wire  _GEN_18 = ~io_wbMasterReceiver_bits_we ? _T_4 : _T_4; // @[WishboneDevice.scala 26:40]
  wire  _GEN_19 = ~io_wbMasterReceiver_bits_we ? _GEN_5 : _GEN_5; // @[WishboneDevice.scala 26:40]
  assign io_wbSlaveTransmitter_bits_ack = _T_1 & _GEN_18; // @[WishboneDevice.scala 25:16 WishboneDevice.scala 88:9]
  assign io_wbSlaveTransmitter_bits_dat = io_rspIn_bits_dataResponse; // @[WishboneDevice.scala 36:52 WishboneDevice.scala 41:40]
  assign io_wbSlaveTransmitter_bits_err = _T_1 & _GEN_19; // @[WishboneDevice.scala 25:16 WishboneDevice.scala 89:36]
  assign io_wbMasterReceiver_ready = 1'h1; // @[WishboneDevice.scala 19:29]
  assign io_reqOut_valid = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneDevice.scala 16:80]
  assign io_reqOut_bits_addrRequest = io_wbMasterReceiver_bits_adr; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 32:34 WishboneDevice.scala 56:34]
  assign io_reqOut_bits_dataRequest = io_wbMasterReceiver_bits_dat; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 57:34]
  assign io_reqOut_bits_activeByteLane = io_wbMasterReceiver_bits_sel; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 34:37 WishboneDevice.scala 58:37]
  assign io_reqOut_bits_isWrite = ~io_wbMasterReceiver_bits_we ? 1'h0 : io_wbMasterReceiver_bits_we; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 35:30 WishboneDevice.scala 59:30]
endmodule
module SRAM1kb(
  input         clock,
  input         reset,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  sram_clk0; // @[SRAM1kb.scala 24:20]
  wire  sram_csb0; // @[SRAM1kb.scala 24:20]
  wire  sram_web0; // @[SRAM1kb.scala 24:20]
  wire [3:0] sram_wmask0; // @[SRAM1kb.scala 24:20]
  wire [9:0] sram_addr0; // @[SRAM1kb.scala 24:20]
  wire [31:0] sram_din0; // @[SRAM1kb.scala 24:20]
  wire [31:0] sram_dout0; // @[SRAM1kb.scala 24:20]
  wire  sram_clk1; // @[SRAM1kb.scala 24:20]
  wire  sram_csb1; // @[SRAM1kb.scala 24:20]
  wire [9:0] sram_addr1; // @[SRAM1kb.scala 24:20]
  wire [31:0] sram_dout1; // @[SRAM1kb.scala 24:20]
  reg  validReg; // @[SRAM1kb.scala 16:25]
  wire  _T_2 = io_req_valid & io_req_bits_isWrite; // @[SRAM1kb.scala 51:28]
  wire  _GEN_0 = io_req_valid & io_req_bits_isWrite ? 1'h0 : 1'h1; // @[SRAM1kb.scala 51:52 SRAM1kb.scala 56:18 SRAM1kb.scala 29:16]
  wire  _GEN_6 = io_req_valid & ~io_req_bits_isWrite | _T_2; // @[SRAM1kb.scala 42:46 SRAM1kb.scala 45:14]
  sky130_sram_1kbyte_1rw1r_32x256_8 dccm ( // @[SRAM1kb.scala 24:20]
    .clk0(sram_clk0),
    .csb0(sram_csb0),
    .web0(sram_web0),
    .wmask0(sram_wmask0),
    .addr0(sram_addr0),
    .din0(sram_din0),
    .dout0(sram_dout0),
    .clk1(sram_clk1),
    .csb1(sram_csb1),
    .addr1(sram_addr1),
    .dout1(sram_dout1)
  );
  assign io_rsp_valid = validReg; // @[SRAM1kb.scala 17:16]
  assign io_rsp_bits_dataResponse = sram_dout0; // @[SRAM1kb.scala 42:46 SRAM1kb.scala 50:11]
  assign sram_clk0 = clock; // @[SRAM1kb.scala 26:34]
  assign sram_csb0 = io_req_valid & ~io_req_bits_isWrite ? 1'h0 : _GEN_0; // @[SRAM1kb.scala 42:46 SRAM1kb.scala 46:18]
  assign sram_web0 = io_req_valid & ~io_req_bits_isWrite; // @[SRAM1kb.scala 42:21]
  assign sram_wmask0 = io_req_bits_activeByteLane; // @[SRAM1kb.scala 51:52 SRAM1kb.scala 58:20]
  assign sram_addr0 = io_req_bits_addrRequest[9:0];
  assign sram_din0 = io_req_bits_dataRequest; // @[SRAM1kb.scala 51:52 SRAM1kb.scala 60:18]
  assign sram_clk1 = 1'h0;
  assign sram_csb1 = 1'h0;
  assign sram_addr1 = 10'h0;
  always @(posedge clock) begin
    if (reset) begin // @[SRAM1kb.scala 16:25]
      validReg <= 1'h0; // @[SRAM1kb.scala 16:25]
    end else begin
      validReg <= _GEN_6;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  validReg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SramImem(
  input         clock,
  input         reset,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  input         io_writeEnable,
  input  [31:0] io_addrIn,
  input  [31:0] io_dataIn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  sram_clk0; // @[SramImem.scala 28:20]
  wire  sram_csb0; // @[SramImem.scala 28:20]
  wire  sram_web0; // @[SramImem.scala 28:20]
  wire [3:0] sram_wmask0; // @[SramImem.scala 28:20]
  wire [9:0] sram_addr0; // @[SramImem.scala 28:20]
  wire [31:0] sram_din0; // @[SramImem.scala 28:20]
  wire [31:0] sram_dout0; // @[SramImem.scala 28:20]
  wire  sram_clk1; // @[SramImem.scala 28:20]
  wire  sram_csb1; // @[SramImem.scala 28:20]
  wire [9:0] sram_addr1; // @[SramImem.scala 28:20]
  wire [31:0] sram_dout1; // @[SramImem.scala 28:20]
  reg  validReg; // @[SramImem.scala 20:25]
  wire  _T_2 = ~io_writeEnable; // @[SramImem.scala 55:15]
  wire  _GEN_0 = ~io_writeEnable ? 1'h0 : 1'h1; // @[SramImem.scala 55:32 SramImem.scala 60:18 SramImem.scala 33:16]
  wire  _GEN_6 = io_req_valid & ~io_req_bits_isWrite | _T_2; // @[SramImem.scala 46:46 SramImem.scala 49:14]
  wire [31:0] _GEN_9 = io_req_valid & ~io_req_bits_isWrite ? io_req_bits_addrRequest : io_addrIn; // @[SramImem.scala 46:46 SramImem.scala 52:19]
  sky130_sram_1kbyte_1rw1r_32x256_8 iccm ( // @[SramImem.scala 28:20]
    .clk0(sram_clk0),
    .csb0(sram_csb0),
    .web0(sram_web0),
    .wmask0(sram_wmask0),
    .addr0(sram_addr0),
    .din0(sram_din0),
    .dout0(sram_dout0),
    .clk1(sram_clk1),
    .csb1(sram_csb1),
    .addr1(sram_addr1),
    .dout1(sram_dout1)
  );
  assign io_rsp_valid = validReg; // @[SramImem.scala 21:16]
  assign io_rsp_bits_dataResponse = sram_dout0; // @[SramImem.scala 46:46 SramImem.scala 54:11]
  assign sram_clk0 = clock; // @[SramImem.scala 30:34]
  assign sram_csb0 = io_req_valid & ~io_req_bits_isWrite ? 1'h0 : _GEN_0; // @[SramImem.scala 46:46 SramImem.scala 50:18]
  assign sram_web0 = io_req_valid & ~io_req_bits_isWrite | io_writeEnable; // @[SramImem.scala 46:46 SramImem.scala 51:18]
  assign sram_wmask0 = 4'hf; // @[SramImem.scala 55:32 SramImem.scala 62:20]
  assign sram_addr0 = _GEN_9[9:0];
  assign sram_din0 = io_dataIn; // @[SramImem.scala 55:32 SramImem.scala 64:18]
  assign sram_clk1 = 1'h0;
  assign sram_csb1 = 1'h0;
  assign sram_addr1 = 10'h0;
  always @(posedge clock) begin
    if (reset) begin // @[SramImem.scala 20:25]
      validReg <= 1'h0; // @[SramImem.scala 20:25]
    end else begin
      validReg <= _GEN_6;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  validReg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubReg(
  input         clock,
  input         reset,
  input         io_we,
  input  [31:0] io_wd,
  input         io_de,
  input  [31:0] io_d,
  output [31:0] io_q,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  wire  wr_en = io_we | io_de; // @[SubReg.scala 33:20]
  wire [31:0] _wr_data_T = io_de ? io_d : q_reg; // @[SubReg.scala 34:19]
  wire [31:0] _wr_data_T_1 = ~io_wd; // @[SubReg.scala 34:53]
  wire [31:0] _wr_data_T_3 = io_we ? _wr_data_T_1 : 32'hffffffff; // @[SubReg.scala 34:45]
  wire [31:0] wr_data = _wr_data_T & _wr_data_T_3; // @[SubReg.scala 34:40]
  assign io_q = q_reg; // @[SubReg.scala 52:8]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else if (wr_en) begin // @[SubReg.scala 47:15]
      q_reg <= wr_data; // @[SubReg.scala 48:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubReg_1(
  input         clock,
  input         reset,
  input         io_we,
  input  [31:0] io_wd,
  output [31:0] io_q,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  assign io_q = q_reg; // @[SubReg.scala 52:8]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else if (io_we) begin // @[SubReg.scala 47:15]
      if (io_we) begin // @[SubReg.scala 28:19]
        q_reg <= io_wd;
      end else begin
        q_reg <= 32'h0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubRegExt(
  input         io_we,
  input  [31:0] io_wd,
  input  [31:0] io_d,
  output        io_qe,
  output [31:0] io_q,
  output [31:0] io_qs
);
  assign io_qe = io_we; // @[SubRegExt.scala 25:9]
  assign io_q = io_wd; // @[SubRegExt.scala 24:8]
  assign io_qs = io_d; // @[SubRegExt.scala 23:9]
endmodule
module SubReg_2(
  input         clock,
  input         reset,
  input  [31:0] io_d,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else begin
      q_reg <= io_d;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubRegExt_2(
  input         io_we,
  input  [15:0] io_wd,
  input  [15:0] io_d,
  output        io_qe,
  output [15:0] io_q,
  output [15:0] io_qs
);
  assign io_qe = io_we; // @[SubRegExt.scala 25:9]
  assign io_q = io_wd; // @[SubRegExt.scala 24:8]
  assign io_qs = io_d; // @[SubRegExt.scala 23:9]
endmodule
module GpioRegTop(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  output [31:0] io_reg2hw_intr_state_q,
  output [31:0] io_reg2hw_intr_test_q,
  output        io_reg2hw_intr_test_qe,
  output [31:0] io_reg2hw_direct_out_q,
  output        io_reg2hw_direct_out_qe,
  output [15:0] io_reg2hw_masked_out_lower_data_q,
  output        io_reg2hw_masked_out_lower_data_qe,
  output [15:0] io_reg2hw_masked_out_lower_mask_q,
  output [15:0] io_reg2hw_masked_out_upper_data_q,
  output        io_reg2hw_masked_out_upper_data_qe,
  output [15:0] io_reg2hw_masked_out_upper_mask_q,
  output [31:0] io_reg2hw_direct_oe_q,
  output        io_reg2hw_direct_oe_qe,
  output [15:0] io_reg2hw_masked_oe_lower_data_q,
  output        io_reg2hw_masked_oe_lower_data_qe,
  output [15:0] io_reg2hw_masked_oe_lower_mask_q,
  output [15:0] io_reg2hw_masked_oe_upper_data_q,
  output        io_reg2hw_masked_oe_upper_data_qe,
  output [15:0] io_reg2hw_masked_oe_upper_mask_q,
  output [31:0] io_reg2hw_intr_ctrl_en_rising_q,
  output [31:0] io_reg2hw_intr_ctrl_en_falling_q,
  output [31:0] io_reg2hw_intr_ctrl_en_lvlHigh_q,
  output [31:0] io_reg2hw_intr_ctrl_en_lvlLow_q,
  input  [31:0] io_hw2reg_intr_state_d,
  input         io_hw2reg_intr_state_de,
  input  [31:0] io_hw2reg_data_in_d,
  input  [31:0] io_hw2reg_direct_out_d,
  input  [15:0] io_hw2reg_masked_out_lower_data_d,
  input  [15:0] io_hw2reg_masked_out_upper_data_d,
  input  [31:0] io_hw2reg_direct_oe_d,
  input  [15:0] io_hw2reg_masked_oe_lower_data_d,
  input  [15:0] io_hw2reg_masked_oe_upper_data_d
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  intr_state_reg_clock; // @[GpioRegTop.scala 93:30]
  wire  intr_state_reg_reset; // @[GpioRegTop.scala 93:30]
  wire  intr_state_reg_io_we; // @[GpioRegTop.scala 93:30]
  wire [31:0] intr_state_reg_io_wd; // @[GpioRegTop.scala 93:30]
  wire  intr_state_reg_io_de; // @[GpioRegTop.scala 93:30]
  wire [31:0] intr_state_reg_io_d; // @[GpioRegTop.scala 93:30]
  wire [31:0] intr_state_reg_io_q; // @[GpioRegTop.scala 93:30]
  wire [31:0] intr_state_reg_io_qs; // @[GpioRegTop.scala 93:30]
  wire  intr_enable_reg_clock; // @[GpioRegTop.scala 108:31]
  wire  intr_enable_reg_reset; // @[GpioRegTop.scala 108:31]
  wire  intr_enable_reg_io_we; // @[GpioRegTop.scala 108:31]
  wire [31:0] intr_enable_reg_io_wd; // @[GpioRegTop.scala 108:31]
  wire [31:0] intr_enable_reg_io_q; // @[GpioRegTop.scala 108:31]
  wire [31:0] intr_enable_reg_io_qs; // @[GpioRegTop.scala 108:31]
  wire  intr_test_reg_io_we; // @[GpioRegTop.scala 117:29]
  wire [31:0] intr_test_reg_io_wd; // @[GpioRegTop.scala 117:29]
  wire [31:0] intr_test_reg_io_d; // @[GpioRegTop.scala 117:29]
  wire  intr_test_reg_io_qe; // @[GpioRegTop.scala 117:29]
  wire [31:0] intr_test_reg_io_q; // @[GpioRegTop.scala 117:29]
  wire [31:0] intr_test_reg_io_qs; // @[GpioRegTop.scala 117:29]
  wire  data_in_reg_clock; // @[GpioRegTop.scala 126:27]
  wire  data_in_reg_reset; // @[GpioRegTop.scala 126:27]
  wire [31:0] data_in_reg_io_d; // @[GpioRegTop.scala 126:27]
  wire [31:0] data_in_reg_io_qs; // @[GpioRegTop.scala 126:27]
  wire  direct_out_reg_io_we; // @[GpioRegTop.scala 134:30]
  wire [31:0] direct_out_reg_io_wd; // @[GpioRegTop.scala 134:30]
  wire [31:0] direct_out_reg_io_d; // @[GpioRegTop.scala 134:30]
  wire  direct_out_reg_io_qe; // @[GpioRegTop.scala 134:30]
  wire [31:0] direct_out_reg_io_q; // @[GpioRegTop.scala 134:30]
  wire [31:0] direct_out_reg_io_qs; // @[GpioRegTop.scala 134:30]
  wire  masked_out_lower_data_reg_io_we; // @[GpioRegTop.scala 145:41]
  wire [15:0] masked_out_lower_data_reg_io_wd; // @[GpioRegTop.scala 145:41]
  wire [15:0] masked_out_lower_data_reg_io_d; // @[GpioRegTop.scala 145:41]
  wire  masked_out_lower_data_reg_io_qe; // @[GpioRegTop.scala 145:41]
  wire [15:0] masked_out_lower_data_reg_io_q; // @[GpioRegTop.scala 145:41]
  wire [15:0] masked_out_lower_data_reg_io_qs; // @[GpioRegTop.scala 145:41]
  wire  masked_out_lower_mask_reg_io_we; // @[GpioRegTop.scala 156:41]
  wire [15:0] masked_out_lower_mask_reg_io_wd; // @[GpioRegTop.scala 156:41]
  wire [15:0] masked_out_lower_mask_reg_io_d; // @[GpioRegTop.scala 156:41]
  wire  masked_out_lower_mask_reg_io_qe; // @[GpioRegTop.scala 156:41]
  wire [15:0] masked_out_lower_mask_reg_io_q; // @[GpioRegTop.scala 156:41]
  wire [15:0] masked_out_lower_mask_reg_io_qs; // @[GpioRegTop.scala 156:41]
  wire  masked_out_upper_data_reg_io_we; // @[GpioRegTop.scala 166:41]
  wire [15:0] masked_out_upper_data_reg_io_wd; // @[GpioRegTop.scala 166:41]
  wire [15:0] masked_out_upper_data_reg_io_d; // @[GpioRegTop.scala 166:41]
  wire  masked_out_upper_data_reg_io_qe; // @[GpioRegTop.scala 166:41]
  wire [15:0] masked_out_upper_data_reg_io_q; // @[GpioRegTop.scala 166:41]
  wire [15:0] masked_out_upper_data_reg_io_qs; // @[GpioRegTop.scala 166:41]
  wire  masked_out_upper_mask_reg_io_we; // @[GpioRegTop.scala 177:41]
  wire [15:0] masked_out_upper_mask_reg_io_wd; // @[GpioRegTop.scala 177:41]
  wire [15:0] masked_out_upper_mask_reg_io_d; // @[GpioRegTop.scala 177:41]
  wire  masked_out_upper_mask_reg_io_qe; // @[GpioRegTop.scala 177:41]
  wire [15:0] masked_out_upper_mask_reg_io_q; // @[GpioRegTop.scala 177:41]
  wire [15:0] masked_out_upper_mask_reg_io_qs; // @[GpioRegTop.scala 177:41]
  wire  direct_oe_reg_io_we; // @[GpioRegTop.scala 186:29]
  wire [31:0] direct_oe_reg_io_wd; // @[GpioRegTop.scala 186:29]
  wire [31:0] direct_oe_reg_io_d; // @[GpioRegTop.scala 186:29]
  wire  direct_oe_reg_io_qe; // @[GpioRegTop.scala 186:29]
  wire [31:0] direct_oe_reg_io_q; // @[GpioRegTop.scala 186:29]
  wire [31:0] direct_oe_reg_io_qs; // @[GpioRegTop.scala 186:29]
  wire  masked_oe_lower_data_reg_io_we; // @[GpioRegTop.scala 197:40]
  wire [15:0] masked_oe_lower_data_reg_io_wd; // @[GpioRegTop.scala 197:40]
  wire [15:0] masked_oe_lower_data_reg_io_d; // @[GpioRegTop.scala 197:40]
  wire  masked_oe_lower_data_reg_io_qe; // @[GpioRegTop.scala 197:40]
  wire [15:0] masked_oe_lower_data_reg_io_q; // @[GpioRegTop.scala 197:40]
  wire [15:0] masked_oe_lower_data_reg_io_qs; // @[GpioRegTop.scala 197:40]
  wire  masked_oe_lower_mask_reg_io_we; // @[GpioRegTop.scala 208:40]
  wire [15:0] masked_oe_lower_mask_reg_io_wd; // @[GpioRegTop.scala 208:40]
  wire [15:0] masked_oe_lower_mask_reg_io_d; // @[GpioRegTop.scala 208:40]
  wire  masked_oe_lower_mask_reg_io_qe; // @[GpioRegTop.scala 208:40]
  wire [15:0] masked_oe_lower_mask_reg_io_q; // @[GpioRegTop.scala 208:40]
  wire [15:0] masked_oe_lower_mask_reg_io_qs; // @[GpioRegTop.scala 208:40]
  wire  masked_oe_upper_data_reg_io_we; // @[GpioRegTop.scala 219:40]
  wire [15:0] masked_oe_upper_data_reg_io_wd; // @[GpioRegTop.scala 219:40]
  wire [15:0] masked_oe_upper_data_reg_io_d; // @[GpioRegTop.scala 219:40]
  wire  masked_oe_upper_data_reg_io_qe; // @[GpioRegTop.scala 219:40]
  wire [15:0] masked_oe_upper_data_reg_io_q; // @[GpioRegTop.scala 219:40]
  wire [15:0] masked_oe_upper_data_reg_io_qs; // @[GpioRegTop.scala 219:40]
  wire  masked_oe_upper_mask_reg_io_we; // @[GpioRegTop.scala 230:40]
  wire [15:0] masked_oe_upper_mask_reg_io_wd; // @[GpioRegTop.scala 230:40]
  wire [15:0] masked_oe_upper_mask_reg_io_d; // @[GpioRegTop.scala 230:40]
  wire  masked_oe_upper_mask_reg_io_qe; // @[GpioRegTop.scala 230:40]
  wire [15:0] masked_oe_upper_mask_reg_io_q; // @[GpioRegTop.scala 230:40]
  wire [15:0] masked_oe_upper_mask_reg_io_qs; // @[GpioRegTop.scala 230:40]
  wire  intr_ctrl_en_rising_reg_clock; // @[GpioRegTop.scala 240:39]
  wire  intr_ctrl_en_rising_reg_reset; // @[GpioRegTop.scala 240:39]
  wire  intr_ctrl_en_rising_reg_io_we; // @[GpioRegTop.scala 240:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_wd; // @[GpioRegTop.scala 240:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_q; // @[GpioRegTop.scala 240:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_qs; // @[GpioRegTop.scala 240:39]
  wire  intr_ctrl_en_falling_reg_clock; // @[GpioRegTop.scala 249:40]
  wire  intr_ctrl_en_falling_reg_reset; // @[GpioRegTop.scala 249:40]
  wire  intr_ctrl_en_falling_reg_io_we; // @[GpioRegTop.scala 249:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_wd; // @[GpioRegTop.scala 249:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_q; // @[GpioRegTop.scala 249:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_qs; // @[GpioRegTop.scala 249:40]
  wire  intr_ctrl_en_lvlhigh_reg_clock; // @[GpioRegTop.scala 258:40]
  wire  intr_ctrl_en_lvlhigh_reg_reset; // @[GpioRegTop.scala 258:40]
  wire  intr_ctrl_en_lvlhigh_reg_io_we; // @[GpioRegTop.scala 258:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_wd; // @[GpioRegTop.scala 258:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_q; // @[GpioRegTop.scala 258:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_qs; // @[GpioRegTop.scala 258:40]
  wire  intr_ctrl_en_lvllow_reg_clock; // @[GpioRegTop.scala 267:39]
  wire  intr_ctrl_en_lvllow_reg_reset; // @[GpioRegTop.scala 267:39]
  wire  intr_ctrl_en_lvllow_reg_io_we; // @[GpioRegTop.scala 267:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_wd; // @[GpioRegTop.scala 267:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_q; // @[GpioRegTop.scala 267:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_qs; // @[GpioRegTop.scala 267:39]
  wire  _reg_we_T = io_req_ready & io_req_valid; // @[Decoupled.scala 40:37]
  wire  reg_we = _reg_we_T & io_req_bits_isWrite; // @[GpioRegTop.scala 33:16]
  wire  reg_re = _reg_we_T & ~io_req_bits_isWrite; // @[GpioRegTop.scala 34:16]
  reg  io_rsp_valid_REG; // @[GpioRegTop.scala 39:26]
  wire [5:0] reg_addr = io_req_bits_addrRequest[5:0]; // @[GpioRegTop.scala 26:22 GpioRegTop.scala 36:12]
  wire  addr_hit_0 = reg_addr == 6'h0; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_1 = reg_addr == 6'h4; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_2 = reg_addr == 6'h8; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_3 = reg_addr == 6'hc; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_4 = reg_addr == 6'h10; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_5 = reg_addr == 6'h14; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_6 = reg_addr == 6'h18; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_7 = reg_addr == 6'h1c; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_8 = reg_addr == 6'h20; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_9 = reg_addr == 6'h24; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_10 = reg_addr == 6'h28; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_11 = reg_addr == 6'h2c; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_12 = reg_addr == 6'h30; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_13 = reg_addr == 6'h34; // @[GpioRegTop.scala 277:29]
  wire  addr_miss = (reg_re | reg_we) & ~(addr_hit_0 | addr_hit_1 | addr_hit_2 | addr_hit_3 | addr_hit_4 | addr_hit_5 |
    addr_hit_6 | addr_hit_7 | addr_hit_8 | addr_hit_9 | addr_hit_10 | addr_hit_11 | addr_hit_12 | addr_hit_13); // @[GpioRegTop.scala 280:19]
  wire  _T = addr_hit_0 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_3 = addr_hit_0 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_4 = addr_hit_1 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_7 = addr_hit_1 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_8 = addr_hit_2 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_11 = addr_hit_2 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_15 = addr_hit_3 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_16 = addr_hit_4 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_19 = addr_hit_4 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_20 = addr_hit_5 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_23 = addr_hit_5 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_24 = addr_hit_6 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_27 = addr_hit_6 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_28 = addr_hit_7 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_31 = addr_hit_7 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_32 = addr_hit_8 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_35 = addr_hit_8 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_36 = addr_hit_9 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_39 = addr_hit_9 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_40 = addr_hit_10 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_43 = addr_hit_10 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_44 = addr_hit_11 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_47 = addr_hit_11 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_48 = addr_hit_12 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_51 = addr_hit_12 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_52 = addr_hit_13 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_55 = addr_hit_13 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  wr_err = _T_3 | (_T_7 | (_T_11 | (_T_15 | (_T_19 | (_T_23 | (_T_27 | (_T_31 | (_T_35 | (_T_39 | (_T_43 | (_T_47
     | (_T_51 | _T_55)))))))))))); // @[Mux.scala 98:16]
  wire  _intr_state_we_T_1 = ~wr_err; // @[GpioRegTop.scala 296:43]
  wire [15:0] masked_out_lower_data_qs = masked_out_lower_data_reg_io_qs; // @[GpioRegTop.scala 61:90 GpioRegTop.scala 152:28]
  wire [31:0] _reg_rdata_next_T = {16'h0,masked_out_lower_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_out_upper_data_qs = masked_out_upper_data_reg_io_qs; // @[GpioRegTop.scala 64:90 GpioRegTop.scala 173:28]
  wire [31:0] _reg_rdata_next_T_1 = {16'h0,masked_out_upper_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_oe_lower_mask_qs = masked_oe_lower_mask_reg_io_qs; // @[GpioRegTop.scala 71:112 GpioRegTop.scala 215:27]
  wire [15:0] masked_oe_lower_data_qs = masked_oe_lower_data_reg_io_qs; // @[GpioRegTop.scala 71:112 GpioRegTop.scala 204:27]
  wire [31:0] _reg_rdata_next_T_2 = {masked_oe_lower_mask_qs,masked_oe_lower_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_oe_upper_mask_qs = masked_oe_upper_mask_reg_io_qs; // @[GpioRegTop.scala 74:112 GpioRegTop.scala 237:27]
  wire [15:0] masked_oe_upper_data_qs = masked_oe_upper_data_reg_io_qs; // @[GpioRegTop.scala 74:112 GpioRegTop.scala 226:27]
  wire [31:0] _reg_rdata_next_T_3 = {masked_oe_upper_mask_qs,masked_oe_upper_data_qs}; // @[Cat.scala 30:58]
  wire [31:0] intr_ctrl_en_lvllow_qs = intr_ctrl_en_lvllow_reg_io_qs; // @[GpioRegTop.scala 86:60 GpioRegTop.scala 273:26]
  wire [31:0] _GEN_0 = addr_hit_13 ? intr_ctrl_en_lvllow_qs : 32'hffffffff; // @[GpioRegTop.scala 382:28 GpioRegTop.scala 383:20 GpioRegTop.scala 385:20]
  wire [31:0] intr_ctrl_en_lvlhigh_qs = intr_ctrl_en_lvlhigh_reg_io_qs; // @[GpioRegTop.scala 83:62 GpioRegTop.scala 264:27]
  wire [31:0] _GEN_1 = addr_hit_12 ? intr_ctrl_en_lvlhigh_qs : _GEN_0; // @[GpioRegTop.scala 380:28 GpioRegTop.scala 381:20]
  wire [31:0] intr_ctrl_en_falling_qs = intr_ctrl_en_falling_reg_io_qs; // @[GpioRegTop.scala 80:62 GpioRegTop.scala 255:27]
  wire [31:0] _GEN_2 = addr_hit_11 ? intr_ctrl_en_falling_qs : _GEN_1; // @[GpioRegTop.scala 378:28 GpioRegTop.scala 379:20]
  wire [31:0] intr_ctrl_en_rising_qs = intr_ctrl_en_rising_reg_io_qs; // @[GpioRegTop.scala 77:60 GpioRegTop.scala 246:26]
  wire [31:0] _GEN_3 = addr_hit_10 ? intr_ctrl_en_rising_qs : _GEN_2; // @[GpioRegTop.scala 376:28 GpioRegTop.scala 377:20]
  wire [31:0] _GEN_4 = addr_hit_9 ? _reg_rdata_next_T_3 : _GEN_3; // @[GpioRegTop.scala 374:27 GpioRegTop.scala 375:20]
  wire [31:0] _GEN_5 = addr_hit_8 ? _reg_rdata_next_T_2 : _GEN_4; // @[GpioRegTop.scala 372:27 GpioRegTop.scala 373:20]
  wire [31:0] direct_oe_qs = direct_oe_reg_io_qs; // @[GpioRegTop.scala 67:26 GpioRegTop.scala 193:16]
  wire [31:0] _GEN_6 = addr_hit_7 ? direct_oe_qs : _GEN_5; // @[GpioRegTop.scala 370:27 GpioRegTop.scala 371:20]
  wire [31:0] _GEN_7 = addr_hit_6 ? _reg_rdata_next_T_1 : _GEN_6; // @[GpioRegTop.scala 368:27 GpioRegTop.scala 369:20]
  wire [31:0] _GEN_8 = addr_hit_5 ? _reg_rdata_next_T : _GEN_7; // @[GpioRegTop.scala 366:27 GpioRegTop.scala 367:20]
  wire [31:0] direct_out_qs = direct_out_reg_io_qs; // @[GpioRegTop.scala 58:42 GpioRegTop.scala 141:17]
  wire [31:0] _GEN_9 = addr_hit_4 ? direct_out_qs : _GEN_8; // @[GpioRegTop.scala 364:27 GpioRegTop.scala 365:20]
  wire [31:0] data_in_qs = data_in_reg_io_qs; // @[GpioRegTop.scala 56:24 GpioRegTop.scala 131:14]
  wire [31:0] _GEN_10 = addr_hit_3 ? data_in_qs : _GEN_9; // @[GpioRegTop.scala 362:27 GpioRegTop.scala 363:20]
  wire [31:0] _GEN_11 = addr_hit_2 ? 32'h0 : _GEN_10; // @[GpioRegTop.scala 360:27 GpioRegTop.scala 361:20]
  wire [31:0] intr_enable_qs = intr_enable_reg_io_qs; // @[GpioRegTop.scala 50:44 GpioRegTop.scala 114:18]
  wire [31:0] _GEN_12 = addr_hit_1 ? intr_enable_qs : _GEN_11; // @[GpioRegTop.scala 358:27 GpioRegTop.scala 359:20]
  wire [31:0] intr_state_qs = intr_state_reg_io_qs; // @[GpioRegTop.scala 47:42 GpioRegTop.scala 105:17]
  SubReg intr_state_reg ( // @[GpioRegTop.scala 93:30]
    .clock(intr_state_reg_clock),
    .reset(intr_state_reg_reset),
    .io_we(intr_state_reg_io_we),
    .io_wd(intr_state_reg_io_wd),
    .io_de(intr_state_reg_io_de),
    .io_d(intr_state_reg_io_d),
    .io_q(intr_state_reg_io_q),
    .io_qs(intr_state_reg_io_qs)
  );
  SubReg_1 intr_enable_reg ( // @[GpioRegTop.scala 108:31]
    .clock(intr_enable_reg_clock),
    .reset(intr_enable_reg_reset),
    .io_we(intr_enable_reg_io_we),
    .io_wd(intr_enable_reg_io_wd),
    .io_q(intr_enable_reg_io_q),
    .io_qs(intr_enable_reg_io_qs)
  );
  SubRegExt intr_test_reg ( // @[GpioRegTop.scala 117:29]
    .io_we(intr_test_reg_io_we),
    .io_wd(intr_test_reg_io_wd),
    .io_d(intr_test_reg_io_d),
    .io_qe(intr_test_reg_io_qe),
    .io_q(intr_test_reg_io_q),
    .io_qs(intr_test_reg_io_qs)
  );
  SubReg_2 data_in_reg ( // @[GpioRegTop.scala 126:27]
    .clock(data_in_reg_clock),
    .reset(data_in_reg_reset),
    .io_d(data_in_reg_io_d),
    .io_qs(data_in_reg_io_qs)
  );
  SubRegExt direct_out_reg ( // @[GpioRegTop.scala 134:30]
    .io_we(direct_out_reg_io_we),
    .io_wd(direct_out_reg_io_wd),
    .io_d(direct_out_reg_io_d),
    .io_qe(direct_out_reg_io_qe),
    .io_q(direct_out_reg_io_q),
    .io_qs(direct_out_reg_io_qs)
  );
  SubRegExt_2 masked_out_lower_data_reg ( // @[GpioRegTop.scala 145:41]
    .io_we(masked_out_lower_data_reg_io_we),
    .io_wd(masked_out_lower_data_reg_io_wd),
    .io_d(masked_out_lower_data_reg_io_d),
    .io_qe(masked_out_lower_data_reg_io_qe),
    .io_q(masked_out_lower_data_reg_io_q),
    .io_qs(masked_out_lower_data_reg_io_qs)
  );
  SubRegExt_2 masked_out_lower_mask_reg ( // @[GpioRegTop.scala 156:41]
    .io_we(masked_out_lower_mask_reg_io_we),
    .io_wd(masked_out_lower_mask_reg_io_wd),
    .io_d(masked_out_lower_mask_reg_io_d),
    .io_qe(masked_out_lower_mask_reg_io_qe),
    .io_q(masked_out_lower_mask_reg_io_q),
    .io_qs(masked_out_lower_mask_reg_io_qs)
  );
  SubRegExt_2 masked_out_upper_data_reg ( // @[GpioRegTop.scala 166:41]
    .io_we(masked_out_upper_data_reg_io_we),
    .io_wd(masked_out_upper_data_reg_io_wd),
    .io_d(masked_out_upper_data_reg_io_d),
    .io_qe(masked_out_upper_data_reg_io_qe),
    .io_q(masked_out_upper_data_reg_io_q),
    .io_qs(masked_out_upper_data_reg_io_qs)
  );
  SubRegExt_2 masked_out_upper_mask_reg ( // @[GpioRegTop.scala 177:41]
    .io_we(masked_out_upper_mask_reg_io_we),
    .io_wd(masked_out_upper_mask_reg_io_wd),
    .io_d(masked_out_upper_mask_reg_io_d),
    .io_qe(masked_out_upper_mask_reg_io_qe),
    .io_q(masked_out_upper_mask_reg_io_q),
    .io_qs(masked_out_upper_mask_reg_io_qs)
  );
  SubRegExt direct_oe_reg ( // @[GpioRegTop.scala 186:29]
    .io_we(direct_oe_reg_io_we),
    .io_wd(direct_oe_reg_io_wd),
    .io_d(direct_oe_reg_io_d),
    .io_qe(direct_oe_reg_io_qe),
    .io_q(direct_oe_reg_io_q),
    .io_qs(direct_oe_reg_io_qs)
  );
  SubRegExt_2 masked_oe_lower_data_reg ( // @[GpioRegTop.scala 197:40]
    .io_we(masked_oe_lower_data_reg_io_we),
    .io_wd(masked_oe_lower_data_reg_io_wd),
    .io_d(masked_oe_lower_data_reg_io_d),
    .io_qe(masked_oe_lower_data_reg_io_qe),
    .io_q(masked_oe_lower_data_reg_io_q),
    .io_qs(masked_oe_lower_data_reg_io_qs)
  );
  SubRegExt_2 masked_oe_lower_mask_reg ( // @[GpioRegTop.scala 208:40]
    .io_we(masked_oe_lower_mask_reg_io_we),
    .io_wd(masked_oe_lower_mask_reg_io_wd),
    .io_d(masked_oe_lower_mask_reg_io_d),
    .io_qe(masked_oe_lower_mask_reg_io_qe),
    .io_q(masked_oe_lower_mask_reg_io_q),
    .io_qs(masked_oe_lower_mask_reg_io_qs)
  );
  SubRegExt_2 masked_oe_upper_data_reg ( // @[GpioRegTop.scala 219:40]
    .io_we(masked_oe_upper_data_reg_io_we),
    .io_wd(masked_oe_upper_data_reg_io_wd),
    .io_d(masked_oe_upper_data_reg_io_d),
    .io_qe(masked_oe_upper_data_reg_io_qe),
    .io_q(masked_oe_upper_data_reg_io_q),
    .io_qs(masked_oe_upper_data_reg_io_qs)
  );
  SubRegExt_2 masked_oe_upper_mask_reg ( // @[GpioRegTop.scala 230:40]
    .io_we(masked_oe_upper_mask_reg_io_we),
    .io_wd(masked_oe_upper_mask_reg_io_wd),
    .io_d(masked_oe_upper_mask_reg_io_d),
    .io_qe(masked_oe_upper_mask_reg_io_qe),
    .io_q(masked_oe_upper_mask_reg_io_q),
    .io_qs(masked_oe_upper_mask_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_rising_reg ( // @[GpioRegTop.scala 240:39]
    .clock(intr_ctrl_en_rising_reg_clock),
    .reset(intr_ctrl_en_rising_reg_reset),
    .io_we(intr_ctrl_en_rising_reg_io_we),
    .io_wd(intr_ctrl_en_rising_reg_io_wd),
    .io_q(intr_ctrl_en_rising_reg_io_q),
    .io_qs(intr_ctrl_en_rising_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_falling_reg ( // @[GpioRegTop.scala 249:40]
    .clock(intr_ctrl_en_falling_reg_clock),
    .reset(intr_ctrl_en_falling_reg_reset),
    .io_we(intr_ctrl_en_falling_reg_io_we),
    .io_wd(intr_ctrl_en_falling_reg_io_wd),
    .io_q(intr_ctrl_en_falling_reg_io_q),
    .io_qs(intr_ctrl_en_falling_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_lvlhigh_reg ( // @[GpioRegTop.scala 258:40]
    .clock(intr_ctrl_en_lvlhigh_reg_clock),
    .reset(intr_ctrl_en_lvlhigh_reg_reset),
    .io_we(intr_ctrl_en_lvlhigh_reg_io_we),
    .io_wd(intr_ctrl_en_lvlhigh_reg_io_wd),
    .io_q(intr_ctrl_en_lvlhigh_reg_io_q),
    .io_qs(intr_ctrl_en_lvlhigh_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_lvllow_reg ( // @[GpioRegTop.scala 267:39]
    .clock(intr_ctrl_en_lvllow_reg_clock),
    .reset(intr_ctrl_en_lvllow_reg_reset),
    .io_we(intr_ctrl_en_lvllow_reg_io_we),
    .io_wd(intr_ctrl_en_lvllow_reg_io_wd),
    .io_q(intr_ctrl_en_lvllow_reg_io_q),
    .io_qs(intr_ctrl_en_lvllow_reg_io_qs)
  );
  assign io_req_ready = 1'h1; // @[GpioRegTop.scala 18:16]
  assign io_rsp_valid = io_rsp_valid_REG; // @[GpioRegTop.scala 39:16]
  assign io_rsp_bits_dataResponse = addr_hit_0 ? intr_state_qs : _GEN_12; // @[GpioRegTop.scala 356:21 GpioRegTop.scala 357:20]
  assign io_rsp_bits_error = addr_miss | wr_err; // @[GpioRegTop.scala 44:26]
  assign io_reg2hw_intr_state_q = intr_state_reg_io_q; // @[GpioRegTop.scala 103:26]
  assign io_reg2hw_intr_test_q = intr_test_reg_io_q; // @[GpioRegTop.scala 123:25]
  assign io_reg2hw_intr_test_qe = intr_test_reg_io_qe; // @[GpioRegTop.scala 122:26]
  assign io_reg2hw_direct_out_q = direct_out_reg_io_q; // @[GpioRegTop.scala 140:26]
  assign io_reg2hw_direct_out_qe = direct_out_reg_io_qe; // @[GpioRegTop.scala 139:27]
  assign io_reg2hw_masked_out_lower_data_q = masked_out_lower_data_reg_io_q; // @[GpioRegTop.scala 151:37]
  assign io_reg2hw_masked_out_lower_data_qe = masked_out_lower_data_reg_io_qe; // @[GpioRegTop.scala 150:38]
  assign io_reg2hw_masked_out_lower_mask_q = masked_out_lower_mask_reg_io_q; // @[GpioRegTop.scala 162:37]
  assign io_reg2hw_masked_out_upper_data_q = masked_out_upper_data_reg_io_q; // @[GpioRegTop.scala 172:37]
  assign io_reg2hw_masked_out_upper_data_qe = masked_out_upper_data_reg_io_qe; // @[GpioRegTop.scala 171:38]
  assign io_reg2hw_masked_out_upper_mask_q = masked_out_upper_mask_reg_io_q; // @[GpioRegTop.scala 183:37]
  assign io_reg2hw_direct_oe_q = direct_oe_reg_io_q; // @[GpioRegTop.scala 192:25]
  assign io_reg2hw_direct_oe_qe = direct_oe_reg_io_qe; // @[GpioRegTop.scala 191:26]
  assign io_reg2hw_masked_oe_lower_data_q = masked_oe_lower_data_reg_io_q; // @[GpioRegTop.scala 203:36]
  assign io_reg2hw_masked_oe_lower_data_qe = masked_oe_lower_data_reg_io_qe; // @[GpioRegTop.scala 202:37]
  assign io_reg2hw_masked_oe_lower_mask_q = masked_oe_lower_mask_reg_io_q; // @[GpioRegTop.scala 214:36]
  assign io_reg2hw_masked_oe_upper_data_q = masked_oe_upper_data_reg_io_q; // @[GpioRegTop.scala 225:36]
  assign io_reg2hw_masked_oe_upper_data_qe = masked_oe_upper_data_reg_io_qe; // @[GpioRegTop.scala 224:37]
  assign io_reg2hw_masked_oe_upper_mask_q = masked_oe_upper_mask_reg_io_q; // @[GpioRegTop.scala 236:36]
  assign io_reg2hw_intr_ctrl_en_rising_q = intr_ctrl_en_rising_reg_io_q; // @[GpioRegTop.scala 245:35]
  assign io_reg2hw_intr_ctrl_en_falling_q = intr_ctrl_en_falling_reg_io_q; // @[GpioRegTop.scala 254:36]
  assign io_reg2hw_intr_ctrl_en_lvlHigh_q = intr_ctrl_en_lvlhigh_reg_io_q; // @[GpioRegTop.scala 263:36]
  assign io_reg2hw_intr_ctrl_en_lvlLow_q = intr_ctrl_en_lvllow_reg_io_q; // @[GpioRegTop.scala 272:35]
  assign intr_state_reg_clock = clock;
  assign intr_state_reg_reset = reset;
  assign intr_state_reg_io_we = _T & ~wr_err; // @[GpioRegTop.scala 296:41]
  assign intr_state_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_state_reg_io_de = io_hw2reg_intr_state_de; // @[GpioRegTop.scala 99:24]
  assign intr_state_reg_io_d = io_hw2reg_intr_state_d; // @[GpioRegTop.scala 101:23]
  assign intr_enable_reg_clock = clock;
  assign intr_enable_reg_reset = reset;
  assign intr_enable_reg_io_we = _T_4 & _intr_state_we_T_1; // @[GpioRegTop.scala 299:42]
  assign intr_enable_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_test_reg_io_we = _T_8 & _intr_state_we_T_1; // @[GpioRegTop.scala 302:40]
  assign intr_test_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_test_reg_io_d = 32'h0; // @[GpioRegTop.scala 121:22]
  assign data_in_reg_clock = clock;
  assign data_in_reg_reset = reset;
  assign data_in_reg_io_d = io_hw2reg_data_in_d; // @[GpioRegTop.scala 130:20]
  assign direct_out_reg_io_we = _T_16 & _intr_state_we_T_1; // @[GpioRegTop.scala 305:41]
  assign direct_out_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign direct_out_reg_io_d = io_hw2reg_direct_out_d; // @[GpioRegTop.scala 138:23]
  assign masked_out_lower_data_reg_io_we = _T_20 & _intr_state_we_T_1; // @[GpioRegTop.scala 309:52]
  assign masked_out_lower_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 310:40]
  assign masked_out_lower_data_reg_io_d = io_hw2reg_masked_out_lower_data_d; // @[GpioRegTop.scala 149:34]
  assign masked_out_lower_mask_reg_io_we = _T_20 & _intr_state_we_T_1; // @[GpioRegTop.scala 313:52]
  assign masked_out_lower_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 314:40]
  assign masked_out_lower_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 160:34]
  assign masked_out_upper_data_reg_io_we = _T_24 & _intr_state_we_T_1; // @[GpioRegTop.scala 316:52]
  assign masked_out_upper_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 317:40]
  assign masked_out_upper_data_reg_io_d = io_hw2reg_masked_out_upper_data_d; // @[GpioRegTop.scala 170:34]
  assign masked_out_upper_mask_reg_io_we = _T_24 & _intr_state_we_T_1; // @[GpioRegTop.scala 320:52]
  assign masked_out_upper_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 321:40]
  assign masked_out_upper_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 181:34]
  assign direct_oe_reg_io_we = _T_28 & _intr_state_we_T_1; // @[GpioRegTop.scala 323:40]
  assign direct_oe_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign direct_oe_reg_io_d = io_hw2reg_direct_oe_d; // @[GpioRegTop.scala 190:22]
  assign masked_oe_lower_data_reg_io_we = _T_32 & _intr_state_we_T_1; // @[GpioRegTop.scala 327:51]
  assign masked_oe_lower_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 328:39]
  assign masked_oe_lower_data_reg_io_d = io_hw2reg_masked_oe_lower_data_d; // @[GpioRegTop.scala 201:33]
  assign masked_oe_lower_mask_reg_io_we = _T_32 & _intr_state_we_T_1; // @[GpioRegTop.scala 331:51]
  assign masked_oe_lower_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 332:39]
  assign masked_oe_lower_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 212:33]
  assign masked_oe_upper_data_reg_io_we = _T_36 & _intr_state_we_T_1; // @[GpioRegTop.scala 335:51]
  assign masked_oe_upper_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 336:39]
  assign masked_oe_upper_data_reg_io_d = io_hw2reg_masked_oe_upper_data_d; // @[GpioRegTop.scala 223:33]
  assign masked_oe_upper_mask_reg_io_we = _T_36 & _intr_state_we_T_1; // @[GpioRegTop.scala 339:51]
  assign masked_oe_upper_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 340:39]
  assign masked_oe_upper_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 234:33]
  assign intr_ctrl_en_rising_reg_clock = clock;
  assign intr_ctrl_en_rising_reg_reset = reset;
  assign intr_ctrl_en_rising_reg_io_we = _T_40 & _intr_state_we_T_1; // @[GpioRegTop.scala 343:51]
  assign intr_ctrl_en_rising_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_falling_reg_clock = clock;
  assign intr_ctrl_en_falling_reg_reset = reset;
  assign intr_ctrl_en_falling_reg_io_we = _T_44 & _intr_state_we_T_1; // @[GpioRegTop.scala 346:52]
  assign intr_ctrl_en_falling_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_lvlhigh_reg_clock = clock;
  assign intr_ctrl_en_lvlhigh_reg_reset = reset;
  assign intr_ctrl_en_lvlhigh_reg_io_we = _T_48 & _intr_state_we_T_1; // @[GpioRegTop.scala 349:52]
  assign intr_ctrl_en_lvlhigh_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_lvllow_reg_clock = clock;
  assign intr_ctrl_en_lvllow_reg_reset = reset;
  assign intr_ctrl_en_lvllow_reg_io_we = _T_52 & _intr_state_we_T_1; // @[GpioRegTop.scala 352:51]
  assign intr_ctrl_en_lvllow_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  always @(posedge clock) begin
    io_rsp_valid_REG <= reg_we | reg_re; // @[GpioRegTop.scala 39:38]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_rsp_valid_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IntrHardware(
  input  [31:0] io_event_intr_i,
  input  [31:0] io_reg2hw_intr_test_q_i,
  input         io_reg2hw_intr_test_qe_i,
  input  [31:0] io_reg2hw_intr_state_q_i,
  output        io_hw2reg_intr_state_de_o,
  output [31:0] io_hw2reg_intr_state_d_o
);
  wire [31:0] _new_event_T_1 = io_reg2hw_intr_test_qe_i ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _new_event_T_2 = _new_event_T_1 & io_reg2hw_intr_test_q_i; // @[IntrHardware.scala 25:54]
  wire [31:0] new_event = _new_event_T_2 | io_event_intr_i; // @[IntrHardware.scala 25:80]
  assign io_hw2reg_intr_state_de_o = |new_event; // @[IntrHardware.scala 26:45]
  assign io_hw2reg_intr_state_d_o = new_event | io_reg2hw_intr_state_q_i; // @[IntrHardware.scala 27:41]
endmodule
module Gpio(
  input         clock,
  input         reset,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  input  [31:0] io_cio_gpio_i,
  output [31:0] io_cio_gpio_o,
  output [31:0] io_cio_gpio_en_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  gpioRegTop_clock; // @[Gpio.scala 23:26]
  wire  gpioRegTop_reset; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_ready; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_valid; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_req_bits_addrRequest; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_req_bits_dataRequest; // @[Gpio.scala 23:26]
  wire [3:0] gpioRegTop_io_req_bits_activeByteLane; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_bits_isWrite; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_rsp_valid; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_rsp_bits_dataResponse; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_rsp_bits_error; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_state_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_test_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_intr_test_qe; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_direct_out_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_direct_out_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_lower_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_out_lower_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_upper_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_out_upper_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_direct_oe_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_direct_oe_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_lower_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_oe_lower_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_upper_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_oe_upper_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_intr_state_d; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_hw2reg_intr_state_de; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_data_in_d; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_direct_out_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_out_lower_data_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_out_upper_data_d; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_direct_oe_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_oe_lower_data_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_oe_upper_data_d; // @[Gpio.scala 23:26]
  wire [31:0] intr_hw_io_event_intr_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_test_q_i; // @[Gpio.scala 115:23]
  wire  intr_hw_io_reg2hw_intr_test_qe_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_state_q_i; // @[Gpio.scala 115:23]
  wire  intr_hw_io_hw2reg_intr_state_de_o; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_hw2reg_intr_state_d_o; // @[Gpio.scala 115:23]
  reg [31:0] cio_gpio_q; // @[Gpio.scala 31:27]
  reg [31:0] cio_gpio_en_q; // @[Gpio.scala 32:30]
  reg [31:0] data_in_q; // @[Gpio.scala 33:26]
  wire [15:0] hw2reg_masked_out_upper_data_d = cio_gpio_q[31:16]; // @[Gpio.scala 48:47]
  wire [15:0] hw2reg_masked_out_lower_data_d = cio_gpio_q[15:0]; // @[Gpio.scala 50:47]
  wire [15:0] reg2hw_masked_out_upper_data_q = gpioRegTop_io_reg2hw_masked_out_upper_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_out_upper_mask_q = gpioRegTop_io_reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_q_T = reg2hw_masked_out_upper_data_q & reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 57:39]
  wire [15:0] _cio_gpio_q_T_1 = ~reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 58:10]
  wire [15:0] _cio_gpio_q_T_3 = _cio_gpio_q_T_1 & hw2reg_masked_out_upper_data_d; // @[Gpio.scala 58:42]
  wire [15:0] cio_gpio_q_hi = _cio_gpio_q_T | _cio_gpio_q_T_3; // @[Gpio.scala 57:73]
  wire [31:0] _cio_gpio_q_T_4 = {cio_gpio_q_hi,16'h0}; // @[Cat.scala 30:58]
  wire [15:0] reg2hw_masked_out_lower_data_q = gpioRegTop_io_reg2hw_masked_out_lower_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_out_lower_mask_q = gpioRegTop_io_reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_q_T_5 = reg2hw_masked_out_lower_data_q & reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 67:66]
  wire [15:0] _cio_gpio_q_T_6 = ~reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 68:8]
  wire [15:0] _cio_gpio_q_T_8 = _cio_gpio_q_T_6 & hw2reg_masked_out_lower_data_d; // @[Gpio.scala 68:40]
  wire [15:0] cio_gpio_q_lo = _cio_gpio_q_T_5 | _cio_gpio_q_T_8; // @[Gpio.scala 67:100]
  wire [31:0] _cio_gpio_q_T_9 = {16'h0,cio_gpio_q_lo}; // @[Cat.scala 30:58]
  wire  reg2hw_masked_out_lower_data_qe = gpioRegTop_io_reg2hw_masked_out_lower_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_masked_out_upper_data_qe = gpioRegTop_io_reg2hw_masked_out_upper_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_direct_out_qe = gpioRegTop_io_reg2hw_direct_out_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] reg2hw_direct_out_q = gpioRegTop_io_reg2hw_direct_out_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] hw2reg_masked_oe_upper_data_d = cio_gpio_en_q[31:16]; // @[Gpio.scala 73:49]
  wire [15:0] hw2reg_masked_oe_lower_data_d = cio_gpio_en_q[15:0]; // @[Gpio.scala 75:49]
  wire [15:0] reg2hw_masked_oe_upper_data_q = gpioRegTop_io_reg2hw_masked_oe_upper_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_oe_upper_mask_q = gpioRegTop_io_reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_en_q_T = reg2hw_masked_oe_upper_data_q & reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 81:57]
  wire [15:0] _cio_gpio_en_q_T_1 = ~reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 82:8]
  wire [15:0] _cio_gpio_en_q_T_3 = _cio_gpio_en_q_T_1 & hw2reg_masked_oe_upper_data_d; // @[Gpio.scala 82:39]
  wire [15:0] cio_gpio_en_q_hi = _cio_gpio_en_q_T | _cio_gpio_en_q_T_3; // @[Gpio.scala 81:90]
  wire [31:0] _cio_gpio_en_q_T_4 = {cio_gpio_en_q_hi,16'h0}; // @[Cat.scala 30:58]
  wire [15:0] reg2hw_masked_oe_lower_data_q = gpioRegTop_io_reg2hw_masked_oe_lower_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_oe_lower_mask_q = gpioRegTop_io_reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_en_q_T_5 = reg2hw_masked_oe_lower_data_q & reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 84:68]
  wire [15:0] _cio_gpio_en_q_T_6 = ~reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 85:8]
  wire [15:0] _cio_gpio_en_q_T_8 = _cio_gpio_en_q_T_6 & hw2reg_masked_oe_lower_data_d; // @[Gpio.scala 85:39]
  wire [15:0] cio_gpio_en_q_lo = _cio_gpio_en_q_T_5 | _cio_gpio_en_q_T_8; // @[Gpio.scala 84:101]
  wire [31:0] _cio_gpio_en_q_T_9 = {16'h0,cio_gpio_en_q_lo}; // @[Cat.scala 30:58]
  wire  reg2hw_masked_oe_lower_data_qe = gpioRegTop_io_reg2hw_masked_oe_lower_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_masked_oe_upper_data_qe = gpioRegTop_io_reg2hw_masked_oe_upper_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_direct_oe_qe = gpioRegTop_io_reg2hw_direct_oe_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] reg2hw_direct_oe_q = gpioRegTop_io_reg2hw_direct_oe_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] _event_intr_rise_T = ~data_in_q; // @[Gpio.scala 95:23]
  wire [31:0] _event_intr_rise_T_1 = _event_intr_rise_T & io_cio_gpio_i; // @[Gpio.scala 95:34]
  wire [31:0] reg2hw_intr_ctrl_en_rising_q = gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_rise = _event_intr_rise_T_1 & reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 95:47]
  wire [31:0] _event_intr_fall_T = ~io_cio_gpio_i; // @[Gpio.scala 99:35]
  wire [31:0] _event_intr_fall_T_1 = data_in_q & _event_intr_fall_T; // @[Gpio.scala 99:33]
  wire [31:0] reg2hw_intr_ctrl_en_falling_q = gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_fall = _event_intr_fall_T_1 & reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 99:47]
  wire [31:0] reg2hw_intr_ctrl_en_lvlHigh_q = gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_acthigh = io_cio_gpio_i & reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 105:35]
  wire [31:0] reg2hw_intr_ctrl_en_lvlLow_q = gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_actlow = _event_intr_fall_T & reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 111:35]
  wire [31:0] _event_intr_combined_T = event_intr_rise | event_intr_fall; // @[Gpio.scala 113:42]
  wire [31:0] _event_intr_combined_T_1 = _event_intr_combined_T | event_intr_acthigh; // @[Gpio.scala 113:60]
  GpioRegTop gpioRegTop ( // @[Gpio.scala 23:26]
    .clock(gpioRegTop_clock),
    .reset(gpioRegTop_reset),
    .io_req_ready(gpioRegTop_io_req_ready),
    .io_req_valid(gpioRegTop_io_req_valid),
    .io_req_bits_addrRequest(gpioRegTop_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(gpioRegTop_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(gpioRegTop_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(gpioRegTop_io_req_bits_isWrite),
    .io_rsp_valid(gpioRegTop_io_rsp_valid),
    .io_rsp_bits_dataResponse(gpioRegTop_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(gpioRegTop_io_rsp_bits_error),
    .io_reg2hw_intr_state_q(gpioRegTop_io_reg2hw_intr_state_q),
    .io_reg2hw_intr_test_q(gpioRegTop_io_reg2hw_intr_test_q),
    .io_reg2hw_intr_test_qe(gpioRegTop_io_reg2hw_intr_test_qe),
    .io_reg2hw_direct_out_q(gpioRegTop_io_reg2hw_direct_out_q),
    .io_reg2hw_direct_out_qe(gpioRegTop_io_reg2hw_direct_out_qe),
    .io_reg2hw_masked_out_lower_data_q(gpioRegTop_io_reg2hw_masked_out_lower_data_q),
    .io_reg2hw_masked_out_lower_data_qe(gpioRegTop_io_reg2hw_masked_out_lower_data_qe),
    .io_reg2hw_masked_out_lower_mask_q(gpioRegTop_io_reg2hw_masked_out_lower_mask_q),
    .io_reg2hw_masked_out_upper_data_q(gpioRegTop_io_reg2hw_masked_out_upper_data_q),
    .io_reg2hw_masked_out_upper_data_qe(gpioRegTop_io_reg2hw_masked_out_upper_data_qe),
    .io_reg2hw_masked_out_upper_mask_q(gpioRegTop_io_reg2hw_masked_out_upper_mask_q),
    .io_reg2hw_direct_oe_q(gpioRegTop_io_reg2hw_direct_oe_q),
    .io_reg2hw_direct_oe_qe(gpioRegTop_io_reg2hw_direct_oe_qe),
    .io_reg2hw_masked_oe_lower_data_q(gpioRegTop_io_reg2hw_masked_oe_lower_data_q),
    .io_reg2hw_masked_oe_lower_data_qe(gpioRegTop_io_reg2hw_masked_oe_lower_data_qe),
    .io_reg2hw_masked_oe_lower_mask_q(gpioRegTop_io_reg2hw_masked_oe_lower_mask_q),
    .io_reg2hw_masked_oe_upper_data_q(gpioRegTop_io_reg2hw_masked_oe_upper_data_q),
    .io_reg2hw_masked_oe_upper_data_qe(gpioRegTop_io_reg2hw_masked_oe_upper_data_qe),
    .io_reg2hw_masked_oe_upper_mask_q(gpioRegTop_io_reg2hw_masked_oe_upper_mask_q),
    .io_reg2hw_intr_ctrl_en_rising_q(gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q),
    .io_reg2hw_intr_ctrl_en_falling_q(gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q),
    .io_reg2hw_intr_ctrl_en_lvlHigh_q(gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q),
    .io_reg2hw_intr_ctrl_en_lvlLow_q(gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q),
    .io_hw2reg_intr_state_d(gpioRegTop_io_hw2reg_intr_state_d),
    .io_hw2reg_intr_state_de(gpioRegTop_io_hw2reg_intr_state_de),
    .io_hw2reg_data_in_d(gpioRegTop_io_hw2reg_data_in_d),
    .io_hw2reg_direct_out_d(gpioRegTop_io_hw2reg_direct_out_d),
    .io_hw2reg_masked_out_lower_data_d(gpioRegTop_io_hw2reg_masked_out_lower_data_d),
    .io_hw2reg_masked_out_upper_data_d(gpioRegTop_io_hw2reg_masked_out_upper_data_d),
    .io_hw2reg_direct_oe_d(gpioRegTop_io_hw2reg_direct_oe_d),
    .io_hw2reg_masked_oe_lower_data_d(gpioRegTop_io_hw2reg_masked_oe_lower_data_d),
    .io_hw2reg_masked_oe_upper_data_d(gpioRegTop_io_hw2reg_masked_oe_upper_data_d)
  );
  IntrHardware intr_hw ( // @[Gpio.scala 115:23]
    .io_event_intr_i(intr_hw_io_event_intr_i),
    .io_reg2hw_intr_test_q_i(intr_hw_io_reg2hw_intr_test_q_i),
    .io_reg2hw_intr_test_qe_i(intr_hw_io_reg2hw_intr_test_qe_i),
    .io_reg2hw_intr_state_q_i(intr_hw_io_reg2hw_intr_state_q_i),
    .io_hw2reg_intr_state_de_o(intr_hw_io_hw2reg_intr_state_de_o),
    .io_hw2reg_intr_state_d_o(intr_hw_io_hw2reg_intr_state_d_o)
  );
  assign io_rsp_valid = gpioRegTop_io_rsp_valid; // @[Gpio.scala 26:10]
  assign io_rsp_bits_dataResponse = gpioRegTop_io_rsp_bits_dataResponse; // @[Gpio.scala 26:10]
  assign io_rsp_bits_error = gpioRegTop_io_rsp_bits_error; // @[Gpio.scala 26:10]
  assign io_cio_gpio_o = cio_gpio_q; // @[Gpio.scala 44:17]
  assign io_cio_gpio_en_o = cio_gpio_en_q; // @[Gpio.scala 45:20]
  assign gpioRegTop_clock = clock;
  assign gpioRegTop_reset = reset;
  assign gpioRegTop_io_req_valid = io_req_valid; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_addrRequest = io_req_bits_addrRequest; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_dataRequest = io_req_bits_dataRequest; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_activeByteLane = io_req_bits_activeByteLane; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_isWrite = io_req_bits_isWrite; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_hw2reg_intr_state_d = intr_hw_io_hw2reg_intr_state_d_o; // @[Gpio.scala 21:20 Gpio.scala 122:23]
  assign gpioRegTop_io_hw2reg_intr_state_de = intr_hw_io_hw2reg_intr_state_de_o; // @[Gpio.scala 21:20 Gpio.scala 121:24]
  assign gpioRegTop_io_hw2reg_data_in_d = io_cio_gpio_i; // @[Gpio.scala 35:23 Gpio.scala 36:13]
  assign gpioRegTop_io_hw2reg_direct_out_d = cio_gpio_q; // @[Gpio.scala 21:20 Gpio.scala 47:23]
  assign gpioRegTop_io_hw2reg_masked_out_lower_data_d = cio_gpio_q[15:0]; // @[Gpio.scala 50:47]
  assign gpioRegTop_io_hw2reg_masked_out_upper_data_d = cio_gpio_q[31:16]; // @[Gpio.scala 48:47]
  assign gpioRegTop_io_hw2reg_direct_oe_d = cio_gpio_en_q; // @[Gpio.scala 21:20 Gpio.scala 72:22]
  assign gpioRegTop_io_hw2reg_masked_oe_lower_data_d = cio_gpio_en_q[15:0]; // @[Gpio.scala 75:49]
  assign gpioRegTop_io_hw2reg_masked_oe_upper_data_d = cio_gpio_en_q[31:16]; // @[Gpio.scala 73:49]
  assign intr_hw_io_event_intr_i = _event_intr_combined_T_1 | event_intr_actlow; // @[Gpio.scala 113:81]
  assign intr_hw_io_reg2hw_intr_test_q_i = gpioRegTop_io_reg2hw_intr_test_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  assign intr_hw_io_reg2hw_intr_test_qe_i = gpioRegTop_io_reg2hw_intr_test_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  assign intr_hw_io_reg2hw_intr_state_q_i = gpioRegTop_io_reg2hw_intr_state_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  always @(posedge clock) begin
    if (reset) begin // @[Gpio.scala 31:27]
      cio_gpio_q <= 32'h0; // @[Gpio.scala 31:27]
    end else if (reg2hw_direct_out_qe) begin // @[Gpio.scala 53:30]
      cio_gpio_q <= reg2hw_direct_out_q; // @[Gpio.scala 54:16]
    end else if (reg2hw_masked_out_upper_data_qe) begin // @[Gpio.scala 55:48]
      cio_gpio_q <= _cio_gpio_q_T_4; // @[Gpio.scala 56:16]
    end else if (reg2hw_masked_out_lower_data_qe) begin // @[Gpio.scala 66:48]
      cio_gpio_q <= _cio_gpio_q_T_9; // @[Gpio.scala 67:16]
    end
    if (reset) begin // @[Gpio.scala 32:30]
      cio_gpio_en_q <= 32'h0; // @[Gpio.scala 32:30]
    end else if (reg2hw_direct_oe_qe) begin // @[Gpio.scala 78:29]
      cio_gpio_en_q <= reg2hw_direct_oe_q; // @[Gpio.scala 79:19]
    end else if (reg2hw_masked_oe_upper_data_qe) begin // @[Gpio.scala 80:47]
      cio_gpio_en_q <= _cio_gpio_en_q_T_4; // @[Gpio.scala 81:19]
    end else if (reg2hw_masked_oe_lower_data_qe) begin // @[Gpio.scala 83:47]
      cio_gpio_en_q <= _cio_gpio_en_q_T_9; // @[Gpio.scala 84:19]
    end
    if (reset) begin // @[Gpio.scala 33:26]
      data_in_q <= 32'h0; // @[Gpio.scala 33:26]
    end else begin
      data_in_q <= io_cio_gpio_i; // @[Gpio.scala 37:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cio_gpio_q = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  cio_gpio_en_q = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  data_in_q = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WishboneErr(
  input         clock,
  input         reset,
  output [31:0] io_wbSlaveTransmitter_bits_dat,
  output        io_wbSlaveTransmitter_bits_err,
  input         io_wbMasterReceiver_valid,
  input         io_wbMasterReceiver_bits_cyc,
  input         io_wbMasterReceiver_bits_stb
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dataReg; // @[WishboneErr.scala 15:24]
  reg  errReg; // @[WishboneErr.scala 16:23]
  wire  _T_1 = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneErr.scala 12:80]
  assign io_wbSlaveTransmitter_bits_dat = dataReg; // @[WishboneErr.scala 44:34]
  assign io_wbSlaveTransmitter_bits_err = errReg; // @[WishboneErr.scala 45:35]
  always @(posedge clock) begin
    if (reset) begin // @[WishboneErr.scala 15:24]
      dataReg <= 32'h0; // @[WishboneErr.scala 15:24]
    end else if (_T_1) begin // @[WishboneErr.scala 21:16]
      dataReg <= 32'hffffffff;
    end else begin
      dataReg <= 32'h0; // @[WishboneErr.scala 37:13]
    end
    if (reset) begin // @[WishboneErr.scala 16:23]
      errReg <= 1'h0; // @[WishboneErr.scala 16:23]
    end else begin
      errReg <= _T_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  dataReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  errReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstructionFetch(
  input  [31:0] io_address,
  output [31:0] io_instruction,
  input         io_coreInstrReq_ready,
  output        io_coreInstrReq_valid,
  output [31:0] io_coreInstrReq_bits_addrRequest,
  input         io_coreInstrResp_valid,
  input  [31:0] io_coreInstrResp_bits_dataResponse
);
  assign io_instruction = io_coreInstrResp_valid ? io_coreInstrResp_bits_dataResponse : 32'h0; // @[InstructionFetch.scala 26:24]
  assign io_coreInstrReq_valid = io_coreInstrReq_ready; // @[InstructionFetch.scala 24:31]
  assign io_coreInstrReq_bits_addrRequest = {{2'd0}, io_address[31:2]}; // @[InstructionFetch.scala 23:50]
endmodule
module HazardUnit(
  input        io_id_ex_memRead,
  input        io_ex_mem_memRead,
  input        io_id_ex_branch,
  input  [4:0] io_id_ex_rd,
  input  [4:0] io_ex_mem_rd,
  input  [4:0] io_id_rs1,
  input  [4:0] io_id_rs2,
  input        io_taken,
  input  [1:0] io_jump,
  input        io_branch,
  output       io_if_reg_write,
  output       io_pc_write,
  output       io_ctl_mux,
  output       io_ifid_flush,
  output       io_take_branch
);
  wire  _T_3 = io_id_ex_rd == io_id_rs1 | io_id_ex_rd == io_id_rs2; // @[HazardUnit.scala 35:34]
  wire  _T_4 = (io_id_ex_memRead | io_branch) & _T_3; // @[HazardUnit.scala 34:37]
  wire  _T_5 = io_id_ex_rd != 5'h0; // @[HazardUnit.scala 36:21]
  wire  _T_10 = _T_5 & io_id_rs2 != 5'h0; // @[HazardUnit.scala 37:28]
  wire  _T_11 = io_id_ex_rd != 5'h0 & io_id_rs1 != 5'h0 | _T_10; // @[HazardUnit.scala 36:51]
  wire  _T_12 = _T_4 & _T_11; // @[HazardUnit.scala 35:65]
  wire  _T_13 = ~io_id_ex_branch; // @[HazardUnit.scala 38:7]
  wire  _T_14 = _T_12 & _T_13; // @[HazardUnit.scala 37:51]
  wire  _GEN_0 = _T_14 ? 1'h0 : 1'h1; // @[HazardUnit.scala 40:3 HazardUnit.scala 41:16 HazardUnit.scala 26:14]
  assign io_if_reg_write = io_ex_mem_memRead & io_branch & (io_ex_mem_rd == io_id_rs1 | io_ex_mem_rd == io_id_rs2) ? 1'h0
     : _GEN_0; // @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
  assign io_pc_write = io_ex_mem_memRead & io_branch & (io_ex_mem_rd == io_id_rs1 | io_ex_mem_rd == io_id_rs2) ? 1'h0 :
    _GEN_0; // @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
  assign io_ctl_mux = io_ex_mem_memRead & io_branch & (io_ex_mem_rd == io_id_rs1 | io_ex_mem_rd == io_id_rs2) ? 1'h0 :
    _GEN_0; // @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
  assign io_ifid_flush = io_taken | io_jump != 2'h0; // @[HazardUnit.scala 55:17]
  assign io_take_branch = io_ex_mem_memRead & io_branch & (io_ex_mem_rd == io_id_rs1 | io_ex_mem_rd == io_id_rs2) ? 1'h0
     : _GEN_0; // @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
endmodule
module Control(
  input  [31:0] io_in,
  output        io_aluSrc,
  output [1:0]  io_memToReg,
  output        io_regWrite,
  output        io_memRead,
  output        io_memWrite,
  output        io_branch,
  output [1:0]  io_aluOp,
  output [1:0]  io_jump,
  output [1:0]  io_aluSrc1
);
  wire [31:0] _signals_T = io_in & 32'h7f; // @[Lookup.scala 31:38]
  wire  _signals_T_1 = 32'h33 == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_3 = 32'h13 == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_5 = 32'h3 == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_7 = 32'h23 == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_9 = 32'h63 == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_11 = 32'h37 == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_13 = 32'h17 == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_15 = 32'h6f == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_17 = 32'h67 == _signals_T; // @[Lookup.scala 31:38]
  wire  _signals_T_23 = _signals_T_7 ? 1'h0 : _signals_T_9; // @[Lookup.scala 33:37]
  wire  _signals_T_24 = _signals_T_5 ? 1'h0 : _signals_T_23; // @[Lookup.scala 33:37]
  wire  _signals_T_25 = _signals_T_3 ? 1'h0 : _signals_T_24; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_26 = _signals_T_17 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_27 = _signals_T_15 ? 2'h2 : _signals_T_26; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_28 = _signals_T_13 ? 2'h0 : _signals_T_27; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_29 = _signals_T_11 ? 2'h0 : _signals_T_28; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_30 = _signals_T_9 ? 2'h0 : _signals_T_29; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_31 = _signals_T_7 ? 2'h0 : _signals_T_30; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_32 = _signals_T_5 ? 2'h1 : _signals_T_31; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_33 = _signals_T_3 ? 2'h0 : _signals_T_32; // @[Lookup.scala 33:37]
  wire  _signals_T_38 = _signals_T_9 ? 1'h0 : _signals_T_11 | (_signals_T_13 | (_signals_T_15 | _signals_T_17)); // @[Lookup.scala 33:37]
  wire  _signals_T_39 = _signals_T_7 ? 1'h0 : _signals_T_38; // @[Lookup.scala 33:37]
  wire  _signals_T_49 = _signals_T_3 ? 1'h0 : _signals_T_5; // @[Lookup.scala 33:37]
  wire  _signals_T_56 = _signals_T_5 ? 1'h0 : _signals_T_7; // @[Lookup.scala 33:37]
  wire  _signals_T_57 = _signals_T_3 ? 1'h0 : _signals_T_56; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_67 = _signals_T_15 ? 2'h1 : _signals_T_26; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_68 = _signals_T_13 ? 2'h0 : _signals_T_67; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_69 = _signals_T_11 ? 2'h0 : _signals_T_68; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_70 = _signals_T_9 ? 2'h0 : _signals_T_69; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_71 = _signals_T_7 ? 2'h0 : _signals_T_70; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_72 = _signals_T_5 ? 2'h0 : _signals_T_71; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_73 = _signals_T_3 ? 2'h0 : _signals_T_72; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_81 = _signals_T_3 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_85 = _signals_T_11 ? 2'h2 : {{1'd0}, _signals_T_13}; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_86 = _signals_T_9 ? 2'h0 : _signals_T_85; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_87 = _signals_T_7 ? 2'h0 : _signals_T_86; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_88 = _signals_T_5 ? 2'h0 : _signals_T_87; // @[Lookup.scala 33:37]
  wire [1:0] _signals_T_89 = _signals_T_3 ? 2'h0 : _signals_T_88; // @[Lookup.scala 33:37]
  assign io_aluSrc = _signals_T_1 | _signals_T_25; // @[Lookup.scala 33:37]
  assign io_memToReg = _signals_T_1 ? 2'h0 : _signals_T_33; // @[Lookup.scala 33:37]
  assign io_regWrite = _signals_T_1 | (_signals_T_3 | (_signals_T_5 | _signals_T_39)); // @[Lookup.scala 33:37]
  assign io_memRead = _signals_T_1 ? 1'h0 : _signals_T_49; // @[Lookup.scala 33:37]
  assign io_memWrite = _signals_T_1 ? 1'h0 : _signals_T_57; // @[Lookup.scala 33:37]
  assign io_branch = _signals_T_1 ? 1'h0 : _signals_T_25; // @[Lookup.scala 33:37]
  assign io_aluOp = _signals_T_1 ? 2'h2 : _signals_T_81; // @[Lookup.scala 33:37]
  assign io_jump = _signals_T_1 ? 2'h0 : _signals_T_73; // @[Lookup.scala 33:37]
  assign io_aluSrc1 = _signals_T_1 ? 2'h0 : _signals_T_89; // @[Lookup.scala 33:37]
endmodule
module Registers(
  input         clock,
  input         reset,
  input  [4:0]  io_readAddress_0,
  input  [4:0]  io_readAddress_1,
  input         io_writeEnable,
  input  [4:0]  io_writeAddress,
  input  [31:0] io_writeData,
  output [31:0] io_readData_0,
  output [31:0] io_readData_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_0; // @[Registers.scala 14:20]
  reg [31:0] reg_1; // @[Registers.scala 14:20]
  reg [31:0] reg_2; // @[Registers.scala 14:20]
  reg [31:0] reg_3; // @[Registers.scala 14:20]
  reg [31:0] reg_4; // @[Registers.scala 14:20]
  reg [31:0] reg_5; // @[Registers.scala 14:20]
  reg [31:0] reg_6; // @[Registers.scala 14:20]
  reg [31:0] reg_7; // @[Registers.scala 14:20]
  reg [31:0] reg_8; // @[Registers.scala 14:20]
  reg [31:0] reg_9; // @[Registers.scala 14:20]
  reg [31:0] reg_10; // @[Registers.scala 14:20]
  reg [31:0] reg_11; // @[Registers.scala 14:20]
  reg [31:0] reg_12; // @[Registers.scala 14:20]
  reg [31:0] reg_13; // @[Registers.scala 14:20]
  reg [31:0] reg_14; // @[Registers.scala 14:20]
  reg [31:0] reg_15; // @[Registers.scala 14:20]
  reg [31:0] reg_16; // @[Registers.scala 14:20]
  reg [31:0] reg_17; // @[Registers.scala 14:20]
  reg [31:0] reg_18; // @[Registers.scala 14:20]
  reg [31:0] reg_19; // @[Registers.scala 14:20]
  reg [31:0] reg_20; // @[Registers.scala 14:20]
  reg [31:0] reg_21; // @[Registers.scala 14:20]
  reg [31:0] reg_22; // @[Registers.scala 14:20]
  reg [31:0] reg_23; // @[Registers.scala 14:20]
  reg [31:0] reg_24; // @[Registers.scala 14:20]
  reg [31:0] reg_25; // @[Registers.scala 14:20]
  reg [31:0] reg_26; // @[Registers.scala 14:20]
  reg [31:0] reg_27; // @[Registers.scala 14:20]
  reg [31:0] reg_28; // @[Registers.scala 14:20]
  reg [31:0] reg_29; // @[Registers.scala 14:20]
  reg [31:0] reg_30; // @[Registers.scala 14:20]
  reg [31:0] reg_31; // @[Registers.scala 14:20]
  wire [31:0] _GEN_65 = 5'h1 == io_readAddress_0 ? reg_1 : reg_0; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_66 = 5'h2 == io_readAddress_0 ? reg_2 : _GEN_65; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_67 = 5'h3 == io_readAddress_0 ? reg_3 : _GEN_66; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_68 = 5'h4 == io_readAddress_0 ? reg_4 : _GEN_67; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_69 = 5'h5 == io_readAddress_0 ? reg_5 : _GEN_68; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_70 = 5'h6 == io_readAddress_0 ? reg_6 : _GEN_69; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_71 = 5'h7 == io_readAddress_0 ? reg_7 : _GEN_70; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_72 = 5'h8 == io_readAddress_0 ? reg_8 : _GEN_71; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_73 = 5'h9 == io_readAddress_0 ? reg_9 : _GEN_72; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_74 = 5'ha == io_readAddress_0 ? reg_10 : _GEN_73; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_75 = 5'hb == io_readAddress_0 ? reg_11 : _GEN_74; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_76 = 5'hc == io_readAddress_0 ? reg_12 : _GEN_75; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_77 = 5'hd == io_readAddress_0 ? reg_13 : _GEN_76; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_78 = 5'he == io_readAddress_0 ? reg_14 : _GEN_77; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_79 = 5'hf == io_readAddress_0 ? reg_15 : _GEN_78; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_80 = 5'h10 == io_readAddress_0 ? reg_16 : _GEN_79; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_81 = 5'h11 == io_readAddress_0 ? reg_17 : _GEN_80; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_82 = 5'h12 == io_readAddress_0 ? reg_18 : _GEN_81; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_83 = 5'h13 == io_readAddress_0 ? reg_19 : _GEN_82; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_84 = 5'h14 == io_readAddress_0 ? reg_20 : _GEN_83; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_85 = 5'h15 == io_readAddress_0 ? reg_21 : _GEN_84; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_86 = 5'h16 == io_readAddress_0 ? reg_22 : _GEN_85; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_87 = 5'h17 == io_readAddress_0 ? reg_23 : _GEN_86; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_88 = 5'h18 == io_readAddress_0 ? reg_24 : _GEN_87; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_89 = 5'h19 == io_readAddress_0 ? reg_25 : _GEN_88; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_90 = 5'h1a == io_readAddress_0 ? reg_26 : _GEN_89; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_91 = 5'h1b == io_readAddress_0 ? reg_27 : _GEN_90; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_92 = 5'h1c == io_readAddress_0 ? reg_28 : _GEN_91; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_93 = 5'h1d == io_readAddress_0 ? reg_29 : _GEN_92; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_94 = 5'h1e == io_readAddress_0 ? reg_30 : _GEN_93; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_95 = 5'h1f == io_readAddress_0 ? reg_31 : _GEN_94; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_98 = 5'h1 == io_readAddress_1 ? reg_1 : reg_0; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_99 = 5'h2 == io_readAddress_1 ? reg_2 : _GEN_98; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_100 = 5'h3 == io_readAddress_1 ? reg_3 : _GEN_99; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_101 = 5'h4 == io_readAddress_1 ? reg_4 : _GEN_100; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_102 = 5'h5 == io_readAddress_1 ? reg_5 : _GEN_101; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_103 = 5'h6 == io_readAddress_1 ? reg_6 : _GEN_102; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_104 = 5'h7 == io_readAddress_1 ? reg_7 : _GEN_103; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_105 = 5'h8 == io_readAddress_1 ? reg_8 : _GEN_104; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_106 = 5'h9 == io_readAddress_1 ? reg_9 : _GEN_105; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_107 = 5'ha == io_readAddress_1 ? reg_10 : _GEN_106; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_108 = 5'hb == io_readAddress_1 ? reg_11 : _GEN_107; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_109 = 5'hc == io_readAddress_1 ? reg_12 : _GEN_108; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_110 = 5'hd == io_readAddress_1 ? reg_13 : _GEN_109; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_111 = 5'he == io_readAddress_1 ? reg_14 : _GEN_110; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_112 = 5'hf == io_readAddress_1 ? reg_15 : _GEN_111; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_113 = 5'h10 == io_readAddress_1 ? reg_16 : _GEN_112; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_114 = 5'h11 == io_readAddress_1 ? reg_17 : _GEN_113; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_115 = 5'h12 == io_readAddress_1 ? reg_18 : _GEN_114; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_116 = 5'h13 == io_readAddress_1 ? reg_19 : _GEN_115; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_117 = 5'h14 == io_readAddress_1 ? reg_20 : _GEN_116; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_118 = 5'h15 == io_readAddress_1 ? reg_21 : _GEN_117; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_119 = 5'h16 == io_readAddress_1 ? reg_22 : _GEN_118; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_120 = 5'h17 == io_readAddress_1 ? reg_23 : _GEN_119; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_121 = 5'h18 == io_readAddress_1 ? reg_24 : _GEN_120; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_122 = 5'h19 == io_readAddress_1 ? reg_25 : _GEN_121; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_123 = 5'h1a == io_readAddress_1 ? reg_26 : _GEN_122; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_124 = 5'h1b == io_readAddress_1 ? reg_27 : _GEN_123; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_125 = 5'h1c == io_readAddress_1 ? reg_28 : _GEN_124; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_126 = 5'h1d == io_readAddress_1 ? reg_29 : _GEN_125; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_127 = 5'h1e == io_readAddress_1 ? reg_30 : _GEN_126; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_128 = 5'h1f == io_readAddress_1 ? reg_31 : _GEN_127; // @[Registers.scala 23:22 Registers.scala 23:22]
  assign io_readData_0 = io_readAddress_0 == 5'h0 ? 32'h0 : _GEN_95; // @[Registers.scala 20:37 Registers.scala 21:22 Registers.scala 23:22]
  assign io_readData_1 = io_readAddress_1 == 5'h0 ? 32'h0 : _GEN_128; // @[Registers.scala 20:37 Registers.scala 21:22 Registers.scala 23:22]
  always @(posedge clock) begin
    if (reset) begin // @[Registers.scala 14:20]
      reg_0 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h0 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_0 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_1 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_1 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_2 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h2 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_2 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_3 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h3 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_3 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_4 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h4 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_4 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_5 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h5 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_5 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_6 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h6 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_6 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_7 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h7 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_7 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_8 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h8 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_8 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_9 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h9 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_9 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_10 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'ha == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_10 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_11 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'hb == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_11 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_12 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'hc == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_12 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_13 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'hd == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_13 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_14 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'he == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_14 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_15 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'hf == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_15 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_16 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h10 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_16 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_17 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h11 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_17 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_18 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h12 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_18 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_19 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h13 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_19 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_20 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h14 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_20 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_21 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h15 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_21 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_22 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h16 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_22 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_23 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h17 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_23 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_24 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h18 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_24 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_25 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h19 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_25 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_26 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1a == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_26 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_27 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1b == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_27 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_28 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1c == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_28 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_29 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1d == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_29 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_30 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1e == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_30 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_31 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1f == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_31 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  reg_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  reg_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  reg_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  reg_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  reg_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  reg_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  reg_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  reg_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  reg_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  reg_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  reg_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  reg_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  reg_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  reg_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  reg_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  reg_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  reg_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  reg_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  reg_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  reg_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  reg_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  reg_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  reg_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  reg_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ImmediateGen(
  input  [31:0] io_instruction,
  output [31:0] io_out
);
  wire [6:0] opcode = io_instruction[6:0]; // @[ImmediateGen.scala 11:30]
  wire  _T_10 = opcode == 7'h3 | opcode == 7'hf | opcode == 7'h13 | opcode == 7'h1b | opcode == 7'h67 | opcode == 7'h73; // @[ImmediateGen.scala 15:97]
  wire [11:0] ext_i_lo = io_instruction[31:20]; // @[ImmediateGen.scala 17:31]
  wire [19:0] ext_i_hi = ext_i_lo[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] ext_i = {ext_i_hi,ext_i_lo}; // @[Cat.scala 30:58]
  wire [19:0] ext_u_hi = io_instruction[31:12]; // @[ImmediateGen.scala 24:33]
  wire [31:0] ext_u = {ext_u_hi,12'h0}; // @[Cat.scala 30:58]
  wire [6:0] imm_s_hi = io_instruction[31:25]; // @[ImmediateGen.scala 30:37]
  wire [4:0] imm_s_lo = io_instruction[11:7]; // @[ImmediateGen.scala 30:61]
  wire [11:0] ext_s_lo = {imm_s_hi,imm_s_lo}; // @[Cat.scala 30:58]
  wire [19:0] ext_s_hi = ext_s_lo[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] ext_s = {ext_s_hi,imm_s_hi,imm_s_lo}; // @[Cat.scala 30:58]
  wire  imm_sb_hi_hi = io_instruction[31]; // @[ImmediateGen.scala 37:23]
  wire  imm_sb_hi_lo = io_instruction[7]; // @[ImmediateGen.scala 38:23]
  wire [5:0] imm_sb_lo_hi = io_instruction[30:25]; // @[ImmediateGen.scala 39:23]
  wire [3:0] imm_sb_lo_lo = io_instruction[11:8]; // @[ImmediateGen.scala 40:23]
  wire [11:0] ext_sb_hi_lo = {imm_sb_hi_hi,imm_sb_hi_lo,imm_sb_lo_hi,imm_sb_lo_lo}; // @[Cat.scala 30:58]
  wire [18:0] ext_sb_hi_hi = ext_sb_hi_lo[11] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [31:0] ext_sb = {ext_sb_hi_hi,imm_sb_hi_hi,imm_sb_hi_lo,imm_sb_lo_hi,imm_sb_lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [7:0] imm_uj_hi_lo = io_instruction[19:12]; // @[ImmediateGen.scala 50:21]
  wire  imm_uj_lo_hi = io_instruction[20]; // @[ImmediateGen.scala 51:21]
  wire [9:0] imm_uj_lo_lo = io_instruction[30:21]; // @[ImmediateGen.scala 52:21]
  wire [19:0] ext_uj_hi_lo = {imm_sb_hi_hi,imm_uj_hi_lo,imm_uj_lo_hi,imm_uj_lo_lo}; // @[Cat.scala 30:58]
  wire [10:0] ext_uj_hi_hi = ext_uj_hi_lo[19] ? 11'h7ff : 11'h0; // @[Bitwise.scala 72:12]
  wire [31:0] ext_uj = {ext_uj_hi_hi,imm_sb_hi_hi,imm_uj_hi_lo,imm_uj_lo_hi,imm_uj_lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_0 = opcode == 7'h63 ? ext_sb : ext_uj; // @[ImmediateGen.scala 35:32 ImmediateGen.scala 43:14 ImmediateGen.scala 55:12]
  wire [31:0] _GEN_1 = opcode == 7'h23 ? ext_s : _GEN_0; // @[ImmediateGen.scala 29:32 ImmediateGen.scala 32:14]
  wire [31:0] _GEN_2 = opcode == 7'h17 | opcode == 7'h37 ? ext_u : _GEN_1; // @[ImmediateGen.scala 23:51 ImmediateGen.scala 26:14]
  assign io_out = _T_10 ? ext_i : _GEN_2; // @[ImmediateGen.scala 16:5 ImmediateGen.scala 19:12]
endmodule
module BranchUnit(
  input         io_branch,
  input  [2:0]  io_funct3,
  input  [31:0] io_rd1,
  input  [31:0] io_rd2,
  input         io_take_branch,
  output        io_taken
);
  wire  _T = 3'h0 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_1 = 3'h1 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_2 = 3'h4 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_3 = 3'h5 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_4 = 3'h6 == io_funct3; // @[Conditional.scala 37:30]
  wire  _check_T_9 = io_rd1 >= io_rd2; // @[BranchUnit.scala 28:32]
  wire  _GEN_1 = _T_4 ? io_rd1 < io_rd2 : _check_T_9; // @[Conditional.scala 39:67 BranchUnit.scala 27:21]
  wire  _GEN_2 = _T_3 ? $signed(io_rd1) >= $signed(io_rd2) : _GEN_1; // @[Conditional.scala 39:67 BranchUnit.scala 26:21]
  wire  _GEN_3 = _T_2 ? $signed(io_rd1) < $signed(io_rd2) : _GEN_2; // @[Conditional.scala 39:67 BranchUnit.scala 25:21]
  wire  _GEN_4 = _T_1 ? io_rd1 != io_rd2 : _GEN_3; // @[Conditional.scala 39:67 BranchUnit.scala 24:21]
  wire  check = _T ? io_rd1 == io_rd2 : _GEN_4; // @[Conditional.scala 40:58 BranchUnit.scala 23:21]
  assign io_taken = check & io_branch & io_take_branch; // @[BranchUnit.scala 31:33]
endmodule
module InstructionDecode(
  input         clock,
  input         reset,
  input  [31:0] io_id_instruction,
  input  [31:0] io_writeData,
  input  [4:0]  io_writeReg,
  input  [31:0] io_pcAddress,
  input         io_ctl_writeEnable,
  input         io_id_ex_mem_read,
  input         io_ex_mem_mem_read,
  input  [4:0]  io_id_ex_rd,
  input  [4:0]  io_ex_mem_rd,
  input         io_id_ex_branch,
  input  [31:0] io_ex_mem_ins,
  input  [31:0] io_mem_wb_ins,
  input  [31:0] io_ex_ins,
  input  [31:0] io_ex_result,
  input  [31:0] io_ex_mem_result,
  input  [31:0] io_mem_wb_result,
  output [31:0] io_immediate,
  output [4:0]  io_writeRegAddress,
  output [31:0] io_readData1,
  output [31:0] io_readData2,
  output        io_func7,
  output [2:0]  io_func3,
  output        io_ctl_aluSrc,
  output [1:0]  io_ctl_memToReg,
  output        io_ctl_regWrite,
  output        io_ctl_memRead,
  output        io_ctl_memWrite,
  output        io_ctl_branch,
  output [1:0]  io_ctl_aluOp,
  output [1:0]  io_ctl_jump,
  output [1:0]  io_ctl_aluSrc1,
  output        io_hdu_pcWrite,
  output        io_hdu_if_reg_write,
  output        io_pcSrc,
  output [31:0] io_pcPlusOffset,
  output        io_ifid_flush
);
  wire  hdu_io_id_ex_memRead; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_ex_mem_memRead; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_id_ex_branch; // @[InstructionDecode.scala 51:19]
  wire [4:0] hdu_io_id_ex_rd; // @[InstructionDecode.scala 51:19]
  wire [4:0] hdu_io_ex_mem_rd; // @[InstructionDecode.scala 51:19]
  wire [4:0] hdu_io_id_rs1; // @[InstructionDecode.scala 51:19]
  wire [4:0] hdu_io_id_rs2; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_taken; // @[InstructionDecode.scala 51:19]
  wire [1:0] hdu_io_jump; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_branch; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_if_reg_write; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_pc_write; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_ctl_mux; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_ifid_flush; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_take_branch; // @[InstructionDecode.scala 51:19]
  wire [31:0] control_io_in; // @[InstructionDecode.scala 67:23]
  wire  control_io_aluSrc; // @[InstructionDecode.scala 67:23]
  wire [1:0] control_io_memToReg; // @[InstructionDecode.scala 67:23]
  wire  control_io_regWrite; // @[InstructionDecode.scala 67:23]
  wire  control_io_memRead; // @[InstructionDecode.scala 67:23]
  wire  control_io_memWrite; // @[InstructionDecode.scala 67:23]
  wire  control_io_branch; // @[InstructionDecode.scala 67:23]
  wire [1:0] control_io_aluOp; // @[InstructionDecode.scala 67:23]
  wire [1:0] control_io_jump; // @[InstructionDecode.scala 67:23]
  wire [1:0] control_io_aluSrc1; // @[InstructionDecode.scala 67:23]
  wire  registers_clock; // @[InstructionDecode.scala 86:25]
  wire  registers_reset; // @[InstructionDecode.scala 86:25]
  wire [4:0] registers_io_readAddress_0; // @[InstructionDecode.scala 86:25]
  wire [4:0] registers_io_readAddress_1; // @[InstructionDecode.scala 86:25]
  wire  registers_io_writeEnable; // @[InstructionDecode.scala 86:25]
  wire [4:0] registers_io_writeAddress; // @[InstructionDecode.scala 86:25]
  wire [31:0] registers_io_writeData; // @[InstructionDecode.scala 86:25]
  wire [31:0] registers_io_readData_0; // @[InstructionDecode.scala 86:25]
  wire [31:0] registers_io_readData_1; // @[InstructionDecode.scala 86:25]
  wire [31:0] immediate_io_instruction; // @[InstructionDecode.scala 117:25]
  wire [31:0] immediate_io_out; // @[InstructionDecode.scala 117:25]
  wire  bu_io_branch; // @[InstructionDecode.scala 143:18]
  wire [2:0] bu_io_funct3; // @[InstructionDecode.scala 143:18]
  wire [31:0] bu_io_rd1; // @[InstructionDecode.scala 143:18]
  wire [31:0] bu_io_rd2; // @[InstructionDecode.scala 143:18]
  wire  bu_io_take_branch; // @[InstructionDecode.scala 143:18]
  wire  bu_io_taken; // @[InstructionDecode.scala 143:18]
  wire [31:0] _GEN_2 = io_id_instruction[19:15] == 5'h0 ? 32'h0 : io_writeData; // @[InstructionDecode.scala 98:30 InstructionDecode.scala 99:20 InstructionDecode.scala 101:20]
  wire [31:0] _GEN_4 = io_id_instruction[24:20] == 5'h0 ? 32'h0 : io_writeData; // @[InstructionDecode.scala 107:30 InstructionDecode.scala 108:20 InstructionDecode.scala 110:20]
  wire  _T_9 = io_id_instruction[19:15] == io_ex_mem_ins[11:7]; // @[InstructionDecode.scala 125:20]
  wire  _T_11 = io_id_instruction[19:15] == io_mem_wb_ins[11:7]; // @[InstructionDecode.scala 127:26]
  wire [31:0] _GEN_6 = io_id_instruction[19:15] == io_mem_wb_ins[11:7] ? io_mem_wb_result : io_readData1; // @[InstructionDecode.scala 127:52 InstructionDecode.scala 128:14 InstructionDecode.scala 131:14]
  wire [31:0] _GEN_8 = io_id_instruction[24:20] == io_mem_wb_ins[11:7] ? io_mem_wb_result : io_readData2; // @[InstructionDecode.scala 135:52 InstructionDecode.scala 136:14 InstructionDecode.scala 139:14]
  wire  _T_17 = io_id_instruction[19:15] == io_ex_ins[11:7]; // @[InstructionDecode.scala 153:22]
  wire [31:0] _GEN_10 = _T_17 ? io_ex_result : io_readData1; // @[InstructionDecode.scala 159:47 InstructionDecode.scala 160:14 InstructionDecode.scala 162:16]
  wire [31:0] _GEN_11 = _T_11 ? io_mem_wb_result : _GEN_10; // @[InstructionDecode.scala 157:52 InstructionDecode.scala 158:14]
  wire [31:0] _GEN_12 = _T_9 ? io_ex_mem_result : _GEN_11; // @[InstructionDecode.scala 155:54 InstructionDecode.scala 156:14]
  wire [31:0] j_offset = io_id_instruction[19:15] == io_ex_ins[11:7] ? io_ex_result : _GEN_12; // @[InstructionDecode.scala 153:43 InstructionDecode.scala 154:16]
  wire [31:0] _io_pcPlusOffset_T_1 = io_pcAddress + io_immediate; // @[InstructionDecode.scala 167:37]
  wire [31:0] _io_pcPlusOffset_T_3 = j_offset + io_immediate; // @[InstructionDecode.scala 169:35]
  wire [31:0] _io_pcPlusOffset_T_5 = io_pcAddress + immediate_io_out; // @[InstructionDecode.scala 172:39]
  wire [31:0] _GEN_14 = io_ctl_jump == 2'h2 ? _io_pcPlusOffset_T_3 : _io_pcPlusOffset_T_5; // @[InstructionDecode.scala 168:35 InstructionDecode.scala 169:23 InstructionDecode.scala 172:23]
  HazardUnit hdu ( // @[InstructionDecode.scala 51:19]
    .io_id_ex_memRead(hdu_io_id_ex_memRead),
    .io_ex_mem_memRead(hdu_io_ex_mem_memRead),
    .io_id_ex_branch(hdu_io_id_ex_branch),
    .io_id_ex_rd(hdu_io_id_ex_rd),
    .io_ex_mem_rd(hdu_io_ex_mem_rd),
    .io_id_rs1(hdu_io_id_rs1),
    .io_id_rs2(hdu_io_id_rs2),
    .io_taken(hdu_io_taken),
    .io_jump(hdu_io_jump),
    .io_branch(hdu_io_branch),
    .io_if_reg_write(hdu_io_if_reg_write),
    .io_pc_write(hdu_io_pc_write),
    .io_ctl_mux(hdu_io_ctl_mux),
    .io_ifid_flush(hdu_io_ifid_flush),
    .io_take_branch(hdu_io_take_branch)
  );
  Control control ( // @[InstructionDecode.scala 67:23]
    .io_in(control_io_in),
    .io_aluSrc(control_io_aluSrc),
    .io_memToReg(control_io_memToReg),
    .io_regWrite(control_io_regWrite),
    .io_memRead(control_io_memRead),
    .io_memWrite(control_io_memWrite),
    .io_branch(control_io_branch),
    .io_aluOp(control_io_aluOp),
    .io_jump(control_io_jump),
    .io_aluSrc1(control_io_aluSrc1)
  );
  Registers registers ( // @[InstructionDecode.scala 86:25]
    .clock(registers_clock),
    .reset(registers_reset),
    .io_readAddress_0(registers_io_readAddress_0),
    .io_readAddress_1(registers_io_readAddress_1),
    .io_writeEnable(registers_io_writeEnable),
    .io_writeAddress(registers_io_writeAddress),
    .io_writeData(registers_io_writeData),
    .io_readData_0(registers_io_readData_0),
    .io_readData_1(registers_io_readData_1)
  );
  ImmediateGen immediate ( // @[InstructionDecode.scala 117:25]
    .io_instruction(immediate_io_instruction),
    .io_out(immediate_io_out)
  );
  BranchUnit bu ( // @[InstructionDecode.scala 143:18]
    .io_branch(bu_io_branch),
    .io_funct3(bu_io_funct3),
    .io_rd1(bu_io_rd1),
    .io_rd2(bu_io_rd2),
    .io_take_branch(bu_io_take_branch),
    .io_taken(bu_io_taken)
  );
  assign io_immediate = immediate_io_out; // @[InstructionDecode.scala 119:16]
  assign io_writeRegAddress = io_id_instruction[11:7]; // @[InstructionDecode.scala 184:42]
  assign io_readData1 = io_ctl_writeEnable & io_writeReg == io_id_instruction[19:15] ? _GEN_2 : registers_io_readData_0; // @[InstructionDecode.scala 97:60 InstructionDecode.scala 104:18]
  assign io_readData2 = io_ctl_writeEnable & io_writeReg == io_id_instruction[24:20] ? _GEN_4 : registers_io_readData_1; // @[InstructionDecode.scala 106:60 InstructionDecode.scala 113:18]
  assign io_func7 = io_id_instruction[30]; // @[InstructionDecode.scala 186:32]
  assign io_func3 = io_id_instruction[14:12]; // @[InstructionDecode.scala 185:32]
  assign io_ctl_aluSrc = control_io_aluSrc; // @[InstructionDecode.scala 70:17]
  assign io_ctl_memToReg = control_io_memToReg; // @[InstructionDecode.scala 74:19]
  assign io_ctl_regWrite = hdu_io_ctl_mux & io_id_instruction != 32'h13 & control_io_regWrite; // @[InstructionDecode.scala 76:57 InstructionDecode.scala 78:21 InstructionDecode.scala 82:21]
  assign io_ctl_memRead = control_io_memRead; // @[InstructionDecode.scala 73:18]
  assign io_ctl_memWrite = hdu_io_ctl_mux & io_id_instruction != 32'h13 & control_io_memWrite; // @[InstructionDecode.scala 76:57 InstructionDecode.scala 77:21 InstructionDecode.scala 81:21]
  assign io_ctl_branch = control_io_branch; // @[InstructionDecode.scala 72:17]
  assign io_ctl_aluOp = control_io_aluOp; // @[InstructionDecode.scala 69:16]
  assign io_ctl_jump = control_io_jump; // @[InstructionDecode.scala 75:15]
  assign io_ctl_aluSrc1 = control_io_aluSrc1; // @[InstructionDecode.scala 71:18]
  assign io_hdu_pcWrite = hdu_io_pc_write; // @[InstructionDecode.scala 63:18]
  assign io_hdu_if_reg_write = hdu_io_if_reg_write; // @[InstructionDecode.scala 64:23]
  assign io_pcSrc = bu_io_taken | io_ctl_jump != 2'h0; // @[InstructionDecode.scala 175:20]
  assign io_pcPlusOffset = io_ctl_jump == 2'h1 ? _io_pcPlusOffset_T_1 : _GEN_14; // @[InstructionDecode.scala 166:29 InstructionDecode.scala 167:21]
  assign io_ifid_flush = hdu_io_ifid_flush; // @[InstructionDecode.scala 182:17]
  assign hdu_io_id_ex_memRead = io_id_ex_mem_read; // @[InstructionDecode.scala 53:24]
  assign hdu_io_ex_mem_memRead = io_ex_mem_mem_read; // @[InstructionDecode.scala 55:25]
  assign hdu_io_id_ex_branch = io_id_ex_branch; // @[InstructionDecode.scala 57:23]
  assign hdu_io_id_ex_rd = io_id_ex_rd; // @[InstructionDecode.scala 56:19]
  assign hdu_io_ex_mem_rd = io_ex_mem_rd; // @[InstructionDecode.scala 58:20]
  assign hdu_io_id_rs1 = io_id_instruction[19:15]; // @[InstructionDecode.scala 59:37]
  assign hdu_io_id_rs2 = io_id_instruction[24:20]; // @[InstructionDecode.scala 60:37]
  assign hdu_io_taken = bu_io_taken; // @[InstructionDecode.scala 149:16]
  assign hdu_io_jump = io_ctl_jump; // @[InstructionDecode.scala 61:15]
  assign hdu_io_branch = io_ctl_branch; // @[InstructionDecode.scala 62:17]
  assign control_io_in = io_id_instruction; // @[InstructionDecode.scala 68:17]
  assign registers_clock = clock;
  assign registers_reset = reset;
  assign registers_io_readAddress_0 = io_id_instruction[19:15]; // @[InstructionDecode.scala 88:38]
  assign registers_io_readAddress_1 = io_id_instruction[24:20]; // @[InstructionDecode.scala 89:38]
  assign registers_io_writeEnable = io_ctl_writeEnable; // @[InstructionDecode.scala 92:28]
  assign registers_io_writeAddress = io_writeReg; // @[InstructionDecode.scala 93:29]
  assign registers_io_writeData = io_writeData; // @[InstructionDecode.scala 94:26]
  assign immediate_io_instruction = io_id_instruction; // @[InstructionDecode.scala 118:28]
  assign bu_io_branch = io_ctl_branch; // @[InstructionDecode.scala 144:16]
  assign bu_io_funct3 = io_id_instruction[14:12]; // @[InstructionDecode.scala 145:36]
  assign bu_io_rd1 = io_id_instruction[19:15] == io_ex_mem_ins[11:7] ? io_ex_mem_result : _GEN_6; // @[InstructionDecode.scala 125:46 InstructionDecode.scala 126:12]
  assign bu_io_rd2 = io_id_instruction[24:20] == io_ex_mem_ins[11:7] ? io_ex_mem_result : _GEN_8; // @[InstructionDecode.scala 133:46 InstructionDecode.scala 134:12]
  assign bu_io_take_branch = hdu_io_take_branch; // @[InstructionDecode.scala 148:21]
endmodule
module ALU(
  input  [31:0] io_input1,
  input  [31:0] io_input2,
  input  [3:0]  io_aluCtl,
  output [31:0] io_result
);
  wire  _io_result_T = io_aluCtl == 4'h0; // @[ALU.scala 17:18]
  wire [31:0] _io_result_T_1 = io_input1 & io_input2; // @[ALU.scala 17:41]
  wire  _io_result_T_2 = io_aluCtl == 4'h1; // @[ALU.scala 18:18]
  wire [31:0] _io_result_T_3 = io_input1 | io_input2; // @[ALU.scala 18:41]
  wire  _io_result_T_4 = io_aluCtl == 4'h2; // @[ALU.scala 19:18]
  wire [31:0] _io_result_T_6 = io_input1 + io_input2; // @[ALU.scala 19:41]
  wire  _io_result_T_7 = io_aluCtl == 4'h3; // @[ALU.scala 20:18]
  wire [31:0] _io_result_T_9 = io_input1 - io_input2; // @[ALU.scala 20:41]
  wire  _io_result_T_10 = io_aluCtl == 4'h4; // @[ALU.scala 21:18]
  wire  _io_result_T_13 = $signed(io_input1) < $signed(io_input2); // @[ALU.scala 21:48]
  wire  _io_result_T_14 = io_aluCtl == 4'h5; // @[ALU.scala 22:18]
  wire  _io_result_T_15 = io_input1 < io_input2; // @[ALU.scala 22:41]
  wire  _io_result_T_16 = io_aluCtl == 4'h6; // @[ALU.scala 23:18]
  wire [62:0] _GEN_0 = {{31'd0}, io_input1}; // @[ALU.scala 23:41]
  wire [62:0] _io_result_T_18 = _GEN_0 << io_input2[4:0]; // @[ALU.scala 23:41]
  wire  _io_result_T_19 = io_aluCtl == 4'h7; // @[ALU.scala 24:18]
  wire [31:0] _io_result_T_21 = io_input1 >> io_input2[4:0]; // @[ALU.scala 24:41]
  wire  _io_result_T_22 = io_aluCtl == 4'h8; // @[ALU.scala 25:18]
  wire [31:0] _io_result_T_26 = $signed(io_input1) >>> io_input2[4:0]; // @[ALU.scala 25:68]
  wire  _io_result_T_27 = io_aluCtl == 4'h9; // @[ALU.scala 26:18]
  wire [31:0] _io_result_T_28 = io_input1 ^ io_input2; // @[ALU.scala 26:41]
  wire [31:0] _io_result_T_29 = _io_result_T_27 ? _io_result_T_28 : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _io_result_T_30 = _io_result_T_22 ? _io_result_T_26 : _io_result_T_29; // @[Mux.scala 98:16]
  wire [31:0] _io_result_T_31 = _io_result_T_19 ? _io_result_T_21 : _io_result_T_30; // @[Mux.scala 98:16]
  wire [62:0] _io_result_T_32 = _io_result_T_16 ? _io_result_T_18 : {{31'd0}, _io_result_T_31}; // @[Mux.scala 98:16]
  wire [62:0] _io_result_T_33 = _io_result_T_14 ? {{62'd0}, _io_result_T_15} : _io_result_T_32; // @[Mux.scala 98:16]
  wire [62:0] _io_result_T_34 = _io_result_T_10 ? {{62'd0}, _io_result_T_13} : _io_result_T_33; // @[Mux.scala 98:16]
  wire [62:0] _io_result_T_35 = _io_result_T_7 ? {{31'd0}, _io_result_T_9} : _io_result_T_34; // @[Mux.scala 98:16]
  wire [62:0] _io_result_T_36 = _io_result_T_4 ? {{31'd0}, _io_result_T_6} : _io_result_T_35; // @[Mux.scala 98:16]
  wire [62:0] _io_result_T_37 = _io_result_T_2 ? {{31'd0}, _io_result_T_3} : _io_result_T_36; // @[Mux.scala 98:16]
  wire [62:0] _io_result_T_38 = _io_result_T ? {{31'd0}, _io_result_T_1} : _io_result_T_37; // @[Mux.scala 98:16]
  assign io_result = _io_result_T_38[31:0]; // @[ALU.scala 14:13]
endmodule
module AluControl(
  input  [1:0] io_aluOp,
  input        io_f7,
  input  [2:0] io_f3,
  input        io_aluSrc,
  output [3:0] io_out
);
  wire  _T_1 = 3'h0 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_3 = ~io_f7; // @[AluControl.scala 38:34]
  wire [1:0] _GEN_0 = ~io_aluSrc | ~io_f7 ? 2'h2 : 2'h3; // @[AluControl.scala 38:43 AluControl.scala 39:18 AluControl.scala 42:20]
  wire  _T_5 = 3'h1 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_6 = 3'h2 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_7 = 3'h3 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_8 = 3'h5 == io_f3; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_1 = _T_3 ? 4'h7 : 4'h8; // @[AluControl.scala 55:29 AluControl.scala 56:18 AluControl.scala 58:18]
  wire  _T_10 = 3'h7 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_11 = 3'h6 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_12 = 3'h4 == io_f3; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_2 = _T_12 ? 4'h9 : 4'hf; // @[Conditional.scala 39:67 AluControl.scala 68:16 AluControl.scala 31:10]
  wire [3:0] _GEN_3 = _T_11 ? 4'h1 : _GEN_2; // @[Conditional.scala 39:67 AluControl.scala 65:16]
  wire [3:0] _GEN_4 = _T_10 ? 4'h0 : _GEN_3; // @[Conditional.scala 39:67 AluControl.scala 62:16]
  wire [3:0] _GEN_5 = _T_8 ? _GEN_1 : _GEN_4; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_6 = _T_7 ? 4'h5 : _GEN_5; // @[Conditional.scala 39:67 AluControl.scala 52:16]
  wire [3:0] _GEN_7 = _T_6 ? 4'h4 : _GEN_6; // @[Conditional.scala 39:67 AluControl.scala 49:16]
  wire [3:0] _GEN_8 = _T_5 ? 4'h6 : _GEN_7; // @[Conditional.scala 39:67 AluControl.scala 46:16]
  wire [3:0] _GEN_9 = _T_1 ? {{2'd0}, _GEN_0} : _GEN_8; // @[Conditional.scala 40:58]
  assign io_out = io_aluOp == 2'h0 ? 4'h2 : _GEN_9; // @[AluControl.scala 33:26 AluControl.scala 34:12]
endmodule
module ForwardingUnit(
  input  [4:0] io_ex_reg_rd,
  input  [4:0] io_mem_reg_rd,
  input  [4:0] io_reg_rs1,
  input  [4:0] io_reg_rs2,
  input        io_ex_regWrite,
  input        io_mem_regWrite,
  output [1:0] io_forwardA,
  output [1:0] io_forwardB
);
  wire  _T_1 = io_ex_reg_rd != 5'h0; // @[ForwardingUnit.scala 21:52]
  wire  _T_5 = io_mem_reg_rd != 5'h0; // @[ForwardingUnit.scala 24:53]
  wire  _T_7 = io_reg_rs1 == io_mem_reg_rd & io_mem_reg_rd != 5'h0 & io_mem_regWrite; // @[ForwardingUnit.scala 24:61]
  wire [1:0] _GEN_0 = _T_7 ? 2'h2 : 2'h0; // @[ForwardingUnit.scala 25:7 ForwardingUnit.scala 26:19 ForwardingUnit.scala 29:19]
  wire  _T_15 = io_reg_rs2 == io_mem_reg_rd & _T_5 & io_mem_regWrite; // @[ForwardingUnit.scala 35:61]
  wire [1:0] _GEN_2 = _T_15 ? 2'h2 : 2'h0; // @[ForwardingUnit.scala 36:7 ForwardingUnit.scala 37:19 ForwardingUnit.scala 40:19]
  assign io_forwardA = io_reg_rs1 == io_ex_reg_rd & io_ex_reg_rd != 5'h0 & io_ex_regWrite ? 2'h1 : _GEN_0; // @[ForwardingUnit.scala 21:79 ForwardingUnit.scala 22:17]
  assign io_forwardB = io_reg_rs2 == io_ex_reg_rd & _T_1 & io_ex_regWrite ? 2'h1 : _GEN_2; // @[ForwardingUnit.scala 32:79 ForwardingUnit.scala 33:17]
endmodule
module Execute(
  input  [31:0] io_immediate,
  input  [31:0] io_readData1,
  input  [31:0] io_readData2,
  input  [31:0] io_pcAddress,
  input         io_func7,
  input  [2:0]  io_func3,
  input  [31:0] io_mem_result,
  input  [31:0] io_wb_result,
  input         io_ex_mem_regWrite,
  input         io_mem_wb_regWrite,
  input  [31:0] io_id_ex_ins,
  input  [31:0] io_ex_mem_ins,
  input  [31:0] io_mem_wb_ins,
  input         io_ctl_aluSrc,
  input  [1:0]  io_ctl_aluOp,
  input  [1:0]  io_ctl_aluSrc1,
  output [31:0] io_writeData,
  output [31:0] io_ALUresult
);
  wire [31:0] alu_io_input1; // @[Execute.scala 31:19]
  wire [31:0] alu_io_input2; // @[Execute.scala 31:19]
  wire [3:0] alu_io_aluCtl; // @[Execute.scala 31:19]
  wire [31:0] alu_io_result; // @[Execute.scala 31:19]
  wire [1:0] aluCtl_io_aluOp; // @[Execute.scala 32:22]
  wire  aluCtl_io_f7; // @[Execute.scala 32:22]
  wire [2:0] aluCtl_io_f3; // @[Execute.scala 32:22]
  wire  aluCtl_io_aluSrc; // @[Execute.scala 32:22]
  wire [3:0] aluCtl_io_out; // @[Execute.scala 32:22]
  wire [4:0] ForwardingUnit_io_ex_reg_rd; // @[Execute.scala 33:18]
  wire [4:0] ForwardingUnit_io_mem_reg_rd; // @[Execute.scala 33:18]
  wire [4:0] ForwardingUnit_io_reg_rs1; // @[Execute.scala 33:18]
  wire [4:0] ForwardingUnit_io_reg_rs2; // @[Execute.scala 33:18]
  wire  ForwardingUnit_io_ex_regWrite; // @[Execute.scala 33:18]
  wire  ForwardingUnit_io_mem_regWrite; // @[Execute.scala 33:18]
  wire [1:0] ForwardingUnit_io_forwardA; // @[Execute.scala 33:18]
  wire [1:0] ForwardingUnit_io_forwardB; // @[Execute.scala 33:18]
  wire  _inputMux1_T = ForwardingUnit_io_forwardA == 2'h0; // @[Execute.scala 47:20]
  wire  _inputMux1_T_1 = ForwardingUnit_io_forwardA == 2'h1; // @[Execute.scala 48:20]
  wire  _inputMux1_T_2 = ForwardingUnit_io_forwardA == 2'h2; // @[Execute.scala 49:20]
  wire [31:0] _inputMux1_T_3 = _inputMux1_T_2 ? io_wb_result : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _inputMux1_T_4 = _inputMux1_T_1 ? io_mem_result : _inputMux1_T_3; // @[Mux.scala 98:16]
  wire [31:0] inputMux1 = _inputMux1_T ? io_readData1 : _inputMux1_T_4; // @[Mux.scala 98:16]
  wire  _inputMux2_T = ForwardingUnit_io_forwardB == 2'h0; // @[Execute.scala 55:20]
  wire  _inputMux2_T_1 = ForwardingUnit_io_forwardB == 2'h1; // @[Execute.scala 56:20]
  wire  _inputMux2_T_2 = ForwardingUnit_io_forwardB == 2'h2; // @[Execute.scala 57:20]
  wire [31:0] _inputMux2_T_3 = _inputMux2_T_2 ? io_wb_result : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _inputMux2_T_4 = _inputMux2_T_1 ? io_mem_result : _inputMux2_T_3; // @[Mux.scala 98:16]
  wire [31:0] inputMux2 = _inputMux2_T ? io_readData2 : _inputMux2_T_4; // @[Mux.scala 98:16]
  wire  _aluIn1_T = io_ctl_aluSrc1 == 2'h1; // @[Execute.scala 64:23]
  wire  _aluIn1_T_1 = io_ctl_aluSrc1 == 2'h2; // @[Execute.scala 65:23]
  wire [31:0] _aluIn1_T_2 = _aluIn1_T_1 ? 32'h0 : inputMux1; // @[Mux.scala 98:16]
  ALU alu ( // @[Execute.scala 31:19]
    .io_input1(alu_io_input1),
    .io_input2(alu_io_input2),
    .io_aluCtl(alu_io_aluCtl),
    .io_result(alu_io_result)
  );
  AluControl aluCtl ( // @[Execute.scala 32:22]
    .io_aluOp(aluCtl_io_aluOp),
    .io_f7(aluCtl_io_f7),
    .io_f3(aluCtl_io_f3),
    .io_aluSrc(aluCtl_io_aluSrc),
    .io_out(aluCtl_io_out)
  );
  ForwardingUnit ForwardingUnit ( // @[Execute.scala 33:18]
    .io_ex_reg_rd(ForwardingUnit_io_ex_reg_rd),
    .io_mem_reg_rd(ForwardingUnit_io_mem_reg_rd),
    .io_reg_rs1(ForwardingUnit_io_reg_rs1),
    .io_reg_rs2(ForwardingUnit_io_reg_rs2),
    .io_ex_regWrite(ForwardingUnit_io_ex_regWrite),
    .io_mem_regWrite(ForwardingUnit_io_mem_regWrite),
    .io_forwardA(ForwardingUnit_io_forwardA),
    .io_forwardB(ForwardingUnit_io_forwardB)
  );
  assign io_writeData = _inputMux2_T ? io_readData2 : _inputMux2_T_4; // @[Mux.scala 98:16]
  assign io_ALUresult = alu_io_result; // @[Execute.scala 78:16]
  assign alu_io_input1 = _aluIn1_T ? io_pcAddress : _aluIn1_T_2; // @[Mux.scala 98:16]
  assign alu_io_input2 = io_ctl_aluSrc ? inputMux2 : io_immediate; // @[Execute.scala 68:19]
  assign alu_io_aluCtl = aluCtl_io_out; // @[Execute.scala 77:17]
  assign aluCtl_io_aluOp = io_ctl_aluOp; // @[Execute.scala 72:19]
  assign aluCtl_io_f7 = io_func7; // @[Execute.scala 71:16]
  assign aluCtl_io_f3 = io_func3; // @[Execute.scala 70:16]
  assign aluCtl_io_aluSrc = io_ctl_aluSrc; // @[Execute.scala 73:20]
  assign ForwardingUnit_io_ex_reg_rd = io_ex_mem_ins[11:7]; // @[Execute.scala 39:32]
  assign ForwardingUnit_io_mem_reg_rd = io_mem_wb_ins[11:7]; // @[Execute.scala 40:33]
  assign ForwardingUnit_io_reg_rs1 = io_id_ex_ins[19:15]; // @[Execute.scala 41:29]
  assign ForwardingUnit_io_reg_rs2 = io_id_ex_ins[24:20]; // @[Execute.scala 42:29]
  assign ForwardingUnit_io_ex_regWrite = io_ex_mem_regWrite; // @[Execute.scala 37:18]
  assign ForwardingUnit_io_mem_regWrite = io_mem_wb_regWrite; // @[Execute.scala 38:19]
endmodule
module MemoryFetch(
  input         clock,
  input         reset,
  input  [31:0] io_aluResultIn,
  input  [31:0] io_writeData,
  input         io_writeEnable,
  input         io_readEnable,
  output [31:0] io_readData,
  output        io_stall,
  input  [2:0]  io_f3,
  output        io_dccmReq_valid,
  output [31:0] io_dccmReq_bits_addrRequest,
  output [31:0] io_dccmReq_bits_dataRequest,
  output [3:0]  io_dccmReq_bits_activeByteLane,
  output        io_dccmReq_bits_isWrite,
  input         io_dccmRsp_valid,
  input  [31:0] io_dccmRsp_bits_dataResponse
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] offset; // @[MemoryFetch.scala 26:23]
  reg [2:0] funct3; // @[MemoryFetch.scala 27:23]
  wire [1:0] offsetSW = io_aluResultIn[1:0]; // @[MemoryFetch.scala 28:32]
  wire  _T_3 = offsetSW == 2'h0; // @[MemoryFetch.scala 45:19]
  wire  _T_4 = offsetSW == 2'h1; // @[MemoryFetch.scala 47:25]
  wire [7:0] _GEN_2 = offsetSW == 2'h2 ? io_writeData[15:8] : io_writeData[15:8]; // @[MemoryFetch.scala 53:33 MemoryFetch.scala 54:16 MemoryFetch.scala 60:16]
  wire [7:0] _GEN_3 = offsetSW == 2'h2 ? io_writeData[23:16] : io_writeData[23:16]; // @[MemoryFetch.scala 53:33 MemoryFetch.scala 55:16 MemoryFetch.scala 61:16]
  wire [7:0] _GEN_4 = offsetSW == 2'h2 ? io_writeData[7:0] : io_writeData[31:24]; // @[MemoryFetch.scala 53:33 MemoryFetch.scala 56:16 MemoryFetch.scala 62:16]
  wire [7:0] _GEN_5 = offsetSW == 2'h2 ? io_writeData[31:24] : io_writeData[7:0]; // @[MemoryFetch.scala 53:33 MemoryFetch.scala 57:16 MemoryFetch.scala 63:16]
  wire [3:0] _GEN_6 = offsetSW == 2'h2 ? 4'h4 : 4'h8; // @[MemoryFetch.scala 53:33 MemoryFetch.scala 58:38 MemoryFetch.scala 64:38]
  wire [7:0] _GEN_7 = offsetSW == 2'h1 ? io_writeData[15:8] : _GEN_2; // @[MemoryFetch.scala 47:33 MemoryFetch.scala 48:16]
  wire [7:0] _GEN_8 = offsetSW == 2'h1 ? io_writeData[7:0] : _GEN_3; // @[MemoryFetch.scala 47:33 MemoryFetch.scala 49:16]
  wire [7:0] _GEN_9 = offsetSW == 2'h1 ? io_writeData[23:16] : _GEN_4; // @[MemoryFetch.scala 47:33 MemoryFetch.scala 50:16]
  wire [7:0] _GEN_10 = offsetSW == 2'h1 ? io_writeData[31:24] : _GEN_5; // @[MemoryFetch.scala 47:33 MemoryFetch.scala 51:16]
  wire [3:0] _GEN_11 = offsetSW == 2'h1 ? 4'h2 : _GEN_6; // @[MemoryFetch.scala 47:33 MemoryFetch.scala 52:38]
  wire [3:0] _GEN_12 = offsetSW == 2'h0 ? 4'h1 : _GEN_11; // @[MemoryFetch.scala 45:27 MemoryFetch.scala 46:38]
  wire [7:0] _GEN_13 = offsetSW == 2'h0 ? io_writeData[7:0] : _GEN_7; // @[MemoryFetch.scala 45:27 MemoryFetch.scala 38:12]
  wire [7:0] _GEN_14 = offsetSW == 2'h0 ? io_writeData[15:8] : _GEN_8; // @[MemoryFetch.scala 45:27 MemoryFetch.scala 39:12]
  wire [7:0] _GEN_15 = offsetSW == 2'h0 ? io_writeData[23:16] : _GEN_9; // @[MemoryFetch.scala 45:27 MemoryFetch.scala 40:12]
  wire [7:0] _GEN_16 = offsetSW == 2'h0 ? io_writeData[31:24] : _GEN_10; // @[MemoryFetch.scala 45:27 MemoryFetch.scala 41:12]
  wire [3:0] _GEN_17 = _T_4 ? 4'h6 : 4'hc; // @[MemoryFetch.scala 73:33 MemoryFetch.scala 75:38 MemoryFetch.scala 82:38]
  wire [7:0] _GEN_18 = _T_4 ? io_writeData[23:16] : io_writeData[23:16]; // @[MemoryFetch.scala 73:33 MemoryFetch.scala 76:16 MemoryFetch.scala 85:16]
  wire [7:0] _GEN_19 = _T_4 ? io_writeData[7:0] : io_writeData[31:24]; // @[MemoryFetch.scala 73:33 MemoryFetch.scala 77:16 MemoryFetch.scala 86:16]
  wire [7:0] _GEN_20 = _T_4 ? io_writeData[15:8] : io_writeData[7:0]; // @[MemoryFetch.scala 73:33 MemoryFetch.scala 78:16 MemoryFetch.scala 83:16]
  wire [7:0] _GEN_21 = _T_4 ? io_writeData[31:24] : io_writeData[15:8]; // @[MemoryFetch.scala 73:33 MemoryFetch.scala 79:16 MemoryFetch.scala 84:16]
  wire [3:0] _GEN_22 = _T_3 ? 4'h3 : _GEN_17; // @[MemoryFetch.scala 70:27 MemoryFetch.scala 72:38]
  wire [7:0] _GEN_23 = _T_3 ? io_writeData[7:0] : _GEN_18; // @[MemoryFetch.scala 70:27 MemoryFetch.scala 38:12]
  wire [7:0] _GEN_24 = _T_3 ? io_writeData[15:8] : _GEN_19; // @[MemoryFetch.scala 70:27 MemoryFetch.scala 39:12]
  wire [7:0] _GEN_25 = _T_3 ? io_writeData[23:16] : _GEN_20; // @[MemoryFetch.scala 70:27 MemoryFetch.scala 40:12]
  wire [7:0] _GEN_26 = _T_3 ? io_writeData[31:24] : _GEN_21; // @[MemoryFetch.scala 70:27 MemoryFetch.scala 41:12]
  wire [3:0] _GEN_27 = io_writeEnable & io_f3 == 3'h1 ? _GEN_22 : 4'hf; // @[MemoryFetch.scala 68:52 MemoryFetch.scala 91:36]
  wire [7:0] _GEN_28 = io_writeEnable & io_f3 == 3'h1 ? _GEN_23 : io_writeData[7:0]; // @[MemoryFetch.scala 68:52 MemoryFetch.scala 38:12]
  wire [7:0] _GEN_29 = io_writeEnable & io_f3 == 3'h1 ? _GEN_24 : io_writeData[15:8]; // @[MemoryFetch.scala 68:52 MemoryFetch.scala 39:12]
  wire [7:0] _GEN_30 = io_writeEnable & io_f3 == 3'h1 ? _GEN_25 : io_writeData[23:16]; // @[MemoryFetch.scala 68:52 MemoryFetch.scala 40:12]
  wire [7:0] _GEN_31 = io_writeEnable & io_f3 == 3'h1 ? _GEN_26 : io_writeData[31:24]; // @[MemoryFetch.scala 68:52 MemoryFetch.scala 41:12]
  wire [7:0] wdata_0 = io_writeEnable & io_f3 == 3'h0 ? _GEN_13 : _GEN_28; // @[MemoryFetch.scala 44:45]
  wire [7:0] wdata_1 = io_writeEnable & io_f3 == 3'h0 ? _GEN_14 : _GEN_29; // @[MemoryFetch.scala 44:45]
  wire [7:0] wdata_2 = io_writeEnable & io_f3 == 3'h0 ? _GEN_15 : _GEN_30; // @[MemoryFetch.scala 44:45]
  wire [7:0] wdata_3 = io_writeEnable & io_f3 == 3'h0 ? _GEN_16 : _GEN_31; // @[MemoryFetch.scala 44:45]
  wire [15:0] io_dccmReq_bits_dataRequest_lo = {wdata_1,wdata_0}; // @[MemoryFetch.scala 94:46]
  wire [15:0] io_dccmReq_bits_dataRequest_hi = {wdata_3,wdata_2}; // @[MemoryFetch.scala 94:46]
  wire  _io_dccmReq_valid_T = io_writeEnable | io_readEnable; // @[MemoryFetch.scala 97:42]
  wire [31:0] rdata = io_dccmRsp_valid ? io_dccmRsp_bits_dataResponse : 32'h0; // @[MemoryFetch.scala 101:15]
  wire  _T_12 = offset == 2'h0; // @[MemoryFetch.scala 111:21]
  wire [23:0] io_readData_hi = rdata[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [7:0] io_readData_lo = rdata[7:0]; // @[MemoryFetch.scala 113:53]
  wire [31:0] _io_readData_T_2 = {io_readData_hi,io_readData_lo}; // @[Cat.scala 30:58]
  wire  _T_13 = offset == 2'h1; // @[MemoryFetch.scala 114:28]
  wire [23:0] io_readData_hi_1 = rdata[15] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [7:0] io_readData_lo_1 = rdata[15:8]; // @[MemoryFetch.scala 116:55]
  wire [31:0] _io_readData_T_5 = {io_readData_hi_1,io_readData_lo_1}; // @[Cat.scala 30:58]
  wire  _T_14 = offset == 2'h2; // @[MemoryFetch.scala 117:28]
  wire [23:0] io_readData_hi_2 = rdata[23] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [7:0] io_readData_lo_2 = rdata[23:16]; // @[MemoryFetch.scala 119:55]
  wire [31:0] _io_readData_T_8 = {io_readData_hi_2,io_readData_lo_2}; // @[Cat.scala 30:58]
  wire [23:0] io_readData_hi_3 = rdata[31] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [7:0] io_readData_lo_3 = rdata[31:24]; // @[MemoryFetch.scala 122:55]
  wire [31:0] _io_readData_T_11 = {io_readData_hi_3,io_readData_lo_3}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_38 = offset == 2'h2 ? _io_readData_T_8 : _io_readData_T_11; // @[MemoryFetch.scala 117:41 MemoryFetch.scala 119:23]
  wire [31:0] _GEN_39 = offset == 2'h1 ? _io_readData_T_5 : _GEN_38; // @[MemoryFetch.scala 114:41 MemoryFetch.scala 116:23]
  wire [31:0] _GEN_40 = offset == 2'h0 ? _io_readData_T_2 : _GEN_39; // @[MemoryFetch.scala 111:34 MemoryFetch.scala 113:23]
  wire [31:0] _io_readData_T_12 = {24'h0,io_readData_lo}; // @[Cat.scala 30:58]
  wire [31:0] _io_readData_T_13 = {24'h0,io_readData_lo_1}; // @[Cat.scala 30:58]
  wire [31:0] _io_readData_T_14 = {24'h0,io_readData_lo_2}; // @[Cat.scala 30:58]
  wire [31:0] _io_readData_T_15 = {24'h0,io_readData_lo_3}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_42 = _T_14 ? _io_readData_T_14 : _io_readData_T_15; // @[MemoryFetch.scala 136:40 MemoryFetch.scala 138:23]
  wire [31:0] _GEN_43 = _T_13 ? _io_readData_T_13 : _GEN_42; // @[MemoryFetch.scala 133:40 MemoryFetch.scala 135:23]
  wire [31:0] _GEN_44 = _T_12 ? _io_readData_T_12 : _GEN_43; // @[MemoryFetch.scala 130:34 MemoryFetch.scala 132:23]
  wire [15:0] io_readData_lo_8 = rdata[15:0]; // @[MemoryFetch.scala 151:49]
  wire [31:0] _io_readData_T_16 = {16'h0,io_readData_lo_8}; // @[Cat.scala 30:58]
  wire [15:0] io_readData_lo_9 = rdata[23:8]; // @[MemoryFetch.scala 154:49]
  wire [31:0] _io_readData_T_17 = {16'h0,io_readData_lo_9}; // @[Cat.scala 30:58]
  wire [15:0] io_readData_lo_10 = rdata[31:16]; // @[MemoryFetch.scala 157:49]
  wire [31:0] _io_readData_T_18 = {16'h0,io_readData_lo_10}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_46 = _T_13 ? _io_readData_T_17 : _io_readData_T_18; // @[MemoryFetch.scala 152:41 MemoryFetch.scala 154:23]
  wire [31:0] _GEN_47 = _T_12 ? _io_readData_T_16 : _GEN_46; // @[MemoryFetch.scala 149:34 MemoryFetch.scala 151:23]
  wire [15:0] io_readData_hi_11 = rdata[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _io_readData_T_21 = {io_readData_hi_11,io_readData_lo_8}; // @[Cat.scala 30:58]
  wire [15:0] io_readData_hi_12 = rdata[23] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _io_readData_T_24 = {io_readData_hi_12,io_readData_lo_9}; // @[Cat.scala 30:58]
  wire [15:0] io_readData_hi_13 = rdata[31] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _io_readData_T_27 = {io_readData_hi_13,io_readData_lo_10}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_49 = _T_13 ? _io_readData_T_24 : _io_readData_T_27; // @[MemoryFetch.scala 168:41 MemoryFetch.scala 170:23]
  wire [31:0] _GEN_50 = _T_12 ? _io_readData_T_21 : _GEN_49; // @[MemoryFetch.scala 165:34 MemoryFetch.scala 167:23]
  wire [31:0] _GEN_52 = funct3 == 3'h5 ? _GEN_47 : _GEN_50; // @[MemoryFetch.scala 147:38]
  wire [31:0] _GEN_53 = funct3 == 3'h4 ? _GEN_44 : _GEN_52; // @[MemoryFetch.scala 128:38]
  wire [31:0] _GEN_54 = funct3 == 3'h0 ? _GEN_40 : _GEN_53; // @[MemoryFetch.scala 109:38]
  wire  _T_31 = io_writeEnable & io_aluResultIn[31:28] == 4'h8; // @[MemoryFetch.scala 188:23]
  assign io_readData = funct3 == 3'h2 ? rdata : _GEN_54; // @[MemoryFetch.scala 105:31 MemoryFetch.scala 107:19]
  assign io_stall = _io_dccmReq_valid_T & ~io_dccmRsp_valid; // @[MemoryFetch.scala 99:49]
  assign io_dccmReq_valid = io_writeEnable | io_readEnable; // @[MemoryFetch.scala 97:42]
  assign io_dccmReq_bits_addrRequest = io_aluResultIn; // @[MemoryFetch.scala 95:31]
  assign io_dccmReq_bits_dataRequest = {io_dccmReq_bits_dataRequest_hi,io_dccmReq_bits_dataRequest_lo}; // @[MemoryFetch.scala 94:46]
  assign io_dccmReq_bits_activeByteLane = io_writeEnable & io_f3 == 3'h0 ? _GEN_12 : _GEN_27; // @[MemoryFetch.scala 44:45]
  assign io_dccmReq_bits_isWrite = io_writeEnable; // @[MemoryFetch.scala 96:27]
  always @(posedge clock) begin
    if (reset) begin // @[MemoryFetch.scala 26:23]
      offset <= 2'h0; // @[MemoryFetch.scala 26:23]
    end else if (io_aluResultIn != 32'h0) begin // @[MemoryFetch.scala 30:31]
      offset <= offsetSW; // @[MemoryFetch.scala 32:12]
    end
    if (reset) begin // @[MemoryFetch.scala 27:23]
      funct3 <= 3'h0; // @[MemoryFetch.scala 27:23]
    end else if (io_aluResultIn != 32'h0) begin // @[MemoryFetch.scala 30:31]
      funct3 <= io_f3; // @[MemoryFetch.scala 31:12]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_31 & ~reset) begin
          $fwrite(32'h80000002,"%x\n",io_writeData); // @[MemoryFetch.scala 189:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  offset = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  funct3 = _RAND_1[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PC(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  input         io_halt,
  output [31:0] io_out,
  output [31:0] io_pc4
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc_reg; // @[PC.scala 12:23]
  wire [31:0] _io_pc4_T_2 = $signed(pc_reg) + 32'sh4; // @[PC.scala 15:41]
  assign io_out = pc_reg; // @[PC.scala 14:10]
  assign io_pc4 = io_halt ? $signed(pc_reg) : $signed(_io_pc4_T_2); // @[PC.scala 15:16]
  always @(posedge clock) begin
    if (reset) begin // @[PC.scala 12:23]
      pc_reg <= -32'sh4; // @[PC.scala 12:23]
    end else begin
      pc_reg <= io_in; // @[PC.scala 13:10]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Core(
  input         clock,
  input         reset,
  output        io_dmemReq_valid,
  output [31:0] io_dmemReq_bits_addrRequest,
  output [31:0] io_dmemReq_bits_dataRequest,
  output [3:0]  io_dmemReq_bits_activeByteLane,
  output        io_dmemReq_bits_isWrite,
  input         io_dmemRsp_valid,
  input  [31:0] io_dmemRsp_bits_dataResponse,
  input         io_imemReq_ready,
  output        io_imemReq_valid,
  output [31:0] io_imemReq_bits_addrRequest,
  input         io_imemRsp_valid,
  input  [31:0] io_imemRsp_bits_dataResponse
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] InstructionFetch_io_address; // @[Core.scala 71:18]
  wire [31:0] InstructionFetch_io_instruction; // @[Core.scala 71:18]
  wire  InstructionFetch_io_coreInstrReq_ready; // @[Core.scala 71:18]
  wire  InstructionFetch_io_coreInstrReq_valid; // @[Core.scala 71:18]
  wire [31:0] InstructionFetch_io_coreInstrReq_bits_addrRequest; // @[Core.scala 71:18]
  wire  InstructionFetch_io_coreInstrResp_valid; // @[Core.scala 71:18]
  wire [31:0] InstructionFetch_io_coreInstrResp_bits_dataResponse; // @[Core.scala 71:18]
  wire  InstructionDecode_clock; // @[Core.scala 72:18]
  wire  InstructionDecode_reset; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_id_instruction; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_writeData; // @[Core.scala 72:18]
  wire [4:0] InstructionDecode_io_writeReg; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_pcAddress; // @[Core.scala 72:18]
  wire  InstructionDecode_io_ctl_writeEnable; // @[Core.scala 72:18]
  wire  InstructionDecode_io_id_ex_mem_read; // @[Core.scala 72:18]
  wire  InstructionDecode_io_ex_mem_mem_read; // @[Core.scala 72:18]
  wire [4:0] InstructionDecode_io_id_ex_rd; // @[Core.scala 72:18]
  wire [4:0] InstructionDecode_io_ex_mem_rd; // @[Core.scala 72:18]
  wire  InstructionDecode_io_id_ex_branch; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_ex_mem_ins; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_mem_wb_ins; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_ex_ins; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_ex_result; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_ex_mem_result; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_mem_wb_result; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_immediate; // @[Core.scala 72:18]
  wire [4:0] InstructionDecode_io_writeRegAddress; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_readData1; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_readData2; // @[Core.scala 72:18]
  wire  InstructionDecode_io_func7; // @[Core.scala 72:18]
  wire [2:0] InstructionDecode_io_func3; // @[Core.scala 72:18]
  wire  InstructionDecode_io_ctl_aluSrc; // @[Core.scala 72:18]
  wire [1:0] InstructionDecode_io_ctl_memToReg; // @[Core.scala 72:18]
  wire  InstructionDecode_io_ctl_regWrite; // @[Core.scala 72:18]
  wire  InstructionDecode_io_ctl_memRead; // @[Core.scala 72:18]
  wire  InstructionDecode_io_ctl_memWrite; // @[Core.scala 72:18]
  wire  InstructionDecode_io_ctl_branch; // @[Core.scala 72:18]
  wire [1:0] InstructionDecode_io_ctl_aluOp; // @[Core.scala 72:18]
  wire [1:0] InstructionDecode_io_ctl_jump; // @[Core.scala 72:18]
  wire [1:0] InstructionDecode_io_ctl_aluSrc1; // @[Core.scala 72:18]
  wire  InstructionDecode_io_hdu_pcWrite; // @[Core.scala 72:18]
  wire  InstructionDecode_io_hdu_if_reg_write; // @[Core.scala 72:18]
  wire  InstructionDecode_io_pcSrc; // @[Core.scala 72:18]
  wire [31:0] InstructionDecode_io_pcPlusOffset; // @[Core.scala 72:18]
  wire  InstructionDecode_io_ifid_flush; // @[Core.scala 72:18]
  wire [31:0] Execute_io_immediate; // @[Core.scala 73:18]
  wire [31:0] Execute_io_readData1; // @[Core.scala 73:18]
  wire [31:0] Execute_io_readData2; // @[Core.scala 73:18]
  wire [31:0] Execute_io_pcAddress; // @[Core.scala 73:18]
  wire  Execute_io_func7; // @[Core.scala 73:18]
  wire [2:0] Execute_io_func3; // @[Core.scala 73:18]
  wire [31:0] Execute_io_mem_result; // @[Core.scala 73:18]
  wire [31:0] Execute_io_wb_result; // @[Core.scala 73:18]
  wire  Execute_io_ex_mem_regWrite; // @[Core.scala 73:18]
  wire  Execute_io_mem_wb_regWrite; // @[Core.scala 73:18]
  wire [31:0] Execute_io_id_ex_ins; // @[Core.scala 73:18]
  wire [31:0] Execute_io_ex_mem_ins; // @[Core.scala 73:18]
  wire [31:0] Execute_io_mem_wb_ins; // @[Core.scala 73:18]
  wire  Execute_io_ctl_aluSrc; // @[Core.scala 73:18]
  wire [1:0] Execute_io_ctl_aluOp; // @[Core.scala 73:18]
  wire [1:0] Execute_io_ctl_aluSrc1; // @[Core.scala 73:18]
  wire [31:0] Execute_io_writeData; // @[Core.scala 73:18]
  wire [31:0] Execute_io_ALUresult; // @[Core.scala 73:18]
  wire  MEM_clock; // @[Core.scala 74:19]
  wire  MEM_reset; // @[Core.scala 74:19]
  wire [31:0] MEM_io_aluResultIn; // @[Core.scala 74:19]
  wire [31:0] MEM_io_writeData; // @[Core.scala 74:19]
  wire  MEM_io_writeEnable; // @[Core.scala 74:19]
  wire  MEM_io_readEnable; // @[Core.scala 74:19]
  wire [31:0] MEM_io_readData; // @[Core.scala 74:19]
  wire  MEM_io_stall; // @[Core.scala 74:19]
  wire [2:0] MEM_io_f3; // @[Core.scala 74:19]
  wire  MEM_io_dccmReq_valid; // @[Core.scala 74:19]
  wire [31:0] MEM_io_dccmReq_bits_addrRequest; // @[Core.scala 74:19]
  wire [31:0] MEM_io_dccmReq_bits_dataRequest; // @[Core.scala 74:19]
  wire [3:0] MEM_io_dccmReq_bits_activeByteLane; // @[Core.scala 74:19]
  wire  MEM_io_dccmReq_bits_isWrite; // @[Core.scala 74:19]
  wire  MEM_io_dccmRsp_valid; // @[Core.scala 74:19]
  wire [31:0] MEM_io_dccmRsp_bits_dataResponse; // @[Core.scala 74:19]
  wire  pc_clock; // @[Core.scala 80:18]
  wire  pc_reset; // @[Core.scala 80:18]
  wire [31:0] pc_io_in; // @[Core.scala 80:18]
  wire  pc_io_halt; // @[Core.scala 80:18]
  wire [31:0] pc_io_out; // @[Core.scala 80:18]
  wire [31:0] pc_io_pc4; // @[Core.scala 80:18]
  reg [31:0] if_reg_pc; // @[Core.scala 24:26]
  reg [31:0] if_reg_ins; // @[Core.scala 25:27]
  reg [31:0] id_reg_pc; // @[Core.scala 28:26]
  reg [31:0] id_reg_rd1; // @[Core.scala 29:27]
  reg [31:0] id_reg_rd2; // @[Core.scala 30:27]
  reg [31:0] id_reg_imm; // @[Core.scala 31:27]
  reg [4:0] id_reg_wra; // @[Core.scala 32:27]
  reg  id_reg_f7; // @[Core.scala 33:26]
  reg [2:0] id_reg_f3; // @[Core.scala 34:26]
  reg [31:0] id_reg_ins; // @[Core.scala 35:27]
  reg  id_reg_ctl_aluSrc; // @[Core.scala 36:34]
  reg [1:0] id_reg_ctl_aluSrc1; // @[Core.scala 37:35]
  reg [1:0] id_reg_ctl_memToReg; // @[Core.scala 38:36]
  reg  id_reg_ctl_regWrite; // @[Core.scala 39:36]
  reg  id_reg_ctl_memRead; // @[Core.scala 40:35]
  reg  id_reg_ctl_memWrite; // @[Core.scala 41:36]
  reg [1:0] id_reg_ctl_aluOp; // @[Core.scala 43:33]
  reg [31:0] ex_reg_result; // @[Core.scala 49:30]
  reg [31:0] ex_reg_wd; // @[Core.scala 50:26]
  reg [4:0] ex_reg_wra; // @[Core.scala 51:27]
  reg [31:0] ex_reg_ins; // @[Core.scala 52:27]
  reg [1:0] ex_reg_ctl_memToReg; // @[Core.scala 53:36]
  reg  ex_reg_ctl_regWrite; // @[Core.scala 54:36]
  reg  ex_reg_ctl_memRead; // @[Core.scala 55:35]
  reg  ex_reg_ctl_memWrite; // @[Core.scala 56:36]
  reg [31:0] ex_reg_pc; // @[Core.scala 58:26]
  reg [31:0] mem_reg_ins; // @[Core.scala 62:28]
  reg [31:0] mem_reg_result; // @[Core.scala 63:31]
  reg [4:0] mem_reg_wra; // @[Core.scala 65:28]
  reg [1:0] mem_reg_ctl_memToReg; // @[Core.scala 66:37]
  reg  mem_reg_ctl_regWrite; // @[Core.scala 67:37]
  reg [31:0] mem_reg_pc; // @[Core.scala 68:27]
  wire  _pc_io_in_T = ~MEM_io_stall; // @[Core.scala 91:37]
  wire [31:0] _pc_io_in_T_3 = InstructionDecode_io_pcSrc ? $signed(InstructionDecode_io_pcPlusOffset) : $signed(
    pc_io_pc4); // @[Core.scala 91:55]
  wire [4:0] _wb_addr_T = io_dmemRsp_valid ? mem_reg_wra : 5'h0; // @[Core.scala 229:19]
  wire [31:0] _GEN_14 = mem_reg_ctl_memToReg == 2'h2 ? mem_reg_pc : mem_reg_result; // @[Core.scala 230:44 Core.scala 231:15 Core.scala 235:15]
  InstructionFetch InstructionFetch ( // @[Core.scala 71:18]
    .io_address(InstructionFetch_io_address),
    .io_instruction(InstructionFetch_io_instruction),
    .io_coreInstrReq_ready(InstructionFetch_io_coreInstrReq_ready),
    .io_coreInstrReq_valid(InstructionFetch_io_coreInstrReq_valid),
    .io_coreInstrReq_bits_addrRequest(InstructionFetch_io_coreInstrReq_bits_addrRequest),
    .io_coreInstrResp_valid(InstructionFetch_io_coreInstrResp_valid),
    .io_coreInstrResp_bits_dataResponse(InstructionFetch_io_coreInstrResp_bits_dataResponse)
  );
  InstructionDecode InstructionDecode ( // @[Core.scala 72:18]
    .clock(InstructionDecode_clock),
    .reset(InstructionDecode_reset),
    .io_id_instruction(InstructionDecode_io_id_instruction),
    .io_writeData(InstructionDecode_io_writeData),
    .io_writeReg(InstructionDecode_io_writeReg),
    .io_pcAddress(InstructionDecode_io_pcAddress),
    .io_ctl_writeEnable(InstructionDecode_io_ctl_writeEnable),
    .io_id_ex_mem_read(InstructionDecode_io_id_ex_mem_read),
    .io_ex_mem_mem_read(InstructionDecode_io_ex_mem_mem_read),
    .io_id_ex_rd(InstructionDecode_io_id_ex_rd),
    .io_ex_mem_rd(InstructionDecode_io_ex_mem_rd),
    .io_id_ex_branch(InstructionDecode_io_id_ex_branch),
    .io_ex_mem_ins(InstructionDecode_io_ex_mem_ins),
    .io_mem_wb_ins(InstructionDecode_io_mem_wb_ins),
    .io_ex_ins(InstructionDecode_io_ex_ins),
    .io_ex_result(InstructionDecode_io_ex_result),
    .io_ex_mem_result(InstructionDecode_io_ex_mem_result),
    .io_mem_wb_result(InstructionDecode_io_mem_wb_result),
    .io_immediate(InstructionDecode_io_immediate),
    .io_writeRegAddress(InstructionDecode_io_writeRegAddress),
    .io_readData1(InstructionDecode_io_readData1),
    .io_readData2(InstructionDecode_io_readData2),
    .io_func7(InstructionDecode_io_func7),
    .io_func3(InstructionDecode_io_func3),
    .io_ctl_aluSrc(InstructionDecode_io_ctl_aluSrc),
    .io_ctl_memToReg(InstructionDecode_io_ctl_memToReg),
    .io_ctl_regWrite(InstructionDecode_io_ctl_regWrite),
    .io_ctl_memRead(InstructionDecode_io_ctl_memRead),
    .io_ctl_memWrite(InstructionDecode_io_ctl_memWrite),
    .io_ctl_branch(InstructionDecode_io_ctl_branch),
    .io_ctl_aluOp(InstructionDecode_io_ctl_aluOp),
    .io_ctl_jump(InstructionDecode_io_ctl_jump),
    .io_ctl_aluSrc1(InstructionDecode_io_ctl_aluSrc1),
    .io_hdu_pcWrite(InstructionDecode_io_hdu_pcWrite),
    .io_hdu_if_reg_write(InstructionDecode_io_hdu_if_reg_write),
    .io_pcSrc(InstructionDecode_io_pcSrc),
    .io_pcPlusOffset(InstructionDecode_io_pcPlusOffset),
    .io_ifid_flush(InstructionDecode_io_ifid_flush)
  );
  Execute Execute ( // @[Core.scala 73:18]
    .io_immediate(Execute_io_immediate),
    .io_readData1(Execute_io_readData1),
    .io_readData2(Execute_io_readData2),
    .io_pcAddress(Execute_io_pcAddress),
    .io_func7(Execute_io_func7),
    .io_func3(Execute_io_func3),
    .io_mem_result(Execute_io_mem_result),
    .io_wb_result(Execute_io_wb_result),
    .io_ex_mem_regWrite(Execute_io_ex_mem_regWrite),
    .io_mem_wb_regWrite(Execute_io_mem_wb_regWrite),
    .io_id_ex_ins(Execute_io_id_ex_ins),
    .io_ex_mem_ins(Execute_io_ex_mem_ins),
    .io_mem_wb_ins(Execute_io_mem_wb_ins),
    .io_ctl_aluSrc(Execute_io_ctl_aluSrc),
    .io_ctl_aluOp(Execute_io_ctl_aluOp),
    .io_ctl_aluSrc1(Execute_io_ctl_aluSrc1),
    .io_writeData(Execute_io_writeData),
    .io_ALUresult(Execute_io_ALUresult)
  );
  MemoryFetch MEM ( // @[Core.scala 74:19]
    .clock(MEM_clock),
    .reset(MEM_reset),
    .io_aluResultIn(MEM_io_aluResultIn),
    .io_writeData(MEM_io_writeData),
    .io_writeEnable(MEM_io_writeEnable),
    .io_readEnable(MEM_io_readEnable),
    .io_readData(MEM_io_readData),
    .io_stall(MEM_io_stall),
    .io_f3(MEM_io_f3),
    .io_dccmReq_valid(MEM_io_dccmReq_valid),
    .io_dccmReq_bits_addrRequest(MEM_io_dccmReq_bits_addrRequest),
    .io_dccmReq_bits_dataRequest(MEM_io_dccmReq_bits_dataRequest),
    .io_dccmReq_bits_activeByteLane(MEM_io_dccmReq_bits_activeByteLane),
    .io_dccmReq_bits_isWrite(MEM_io_dccmReq_bits_isWrite),
    .io_dccmRsp_valid(MEM_io_dccmRsp_valid),
    .io_dccmRsp_bits_dataResponse(MEM_io_dccmRsp_bits_dataResponse)
  );
  PC pc ( // @[Core.scala 80:18]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_in(pc_io_in),
    .io_halt(pc_io_halt),
    .io_out(pc_io_out),
    .io_pc4(pc_io_pc4)
  );
  assign io_dmemReq_valid = MEM_io_dccmReq_valid; // @[Core.scala 180:14]
  assign io_dmemReq_bits_addrRequest = MEM_io_dccmReq_bits_addrRequest; // @[Core.scala 180:14]
  assign io_dmemReq_bits_dataRequest = MEM_io_dccmReq_bits_dataRequest; // @[Core.scala 180:14]
  assign io_dmemReq_bits_activeByteLane = MEM_io_dccmReq_bits_activeByteLane; // @[Core.scala 180:14]
  assign io_dmemReq_bits_isWrite = MEM_io_dccmReq_bits_isWrite; // @[Core.scala 180:14]
  assign io_imemReq_valid = InstructionFetch_io_coreInstrReq_valid; // @[Core.scala 84:14]
  assign io_imemReq_bits_addrRequest = InstructionFetch_io_coreInstrReq_bits_addrRequest; // @[Core.scala 84:14]
  assign InstructionFetch_io_address = pc_io_in; // @[Core.scala 87:32]
  assign InstructionFetch_io_coreInstrReq_ready = io_imemReq_ready; // @[Core.scala 84:14]
  assign InstructionFetch_io_coreInstrResp_valid = io_imemRsp_valid; // @[Core.scala 85:20]
  assign InstructionFetch_io_coreInstrResp_bits_dataResponse = io_imemRsp_bits_dataResponse; // @[Core.scala 85:20]
  assign InstructionDecode_clock = clock;
  assign InstructionDecode_reset = reset;
  assign InstructionDecode_io_id_instruction = if_reg_ins; // @[Core.scala 125:21]
  assign InstructionDecode_io_writeData = mem_reg_ctl_memToReg == 2'h1 ? MEM_io_readData : _GEN_14; // @[Core.scala 227:38 Core.scala 228:13]
  assign InstructionDecode_io_writeReg = mem_reg_ctl_memToReg == 2'h1 ? _wb_addr_T : mem_reg_wra; // @[Core.scala 227:38 Core.scala 229:13]
  assign InstructionDecode_io_pcAddress = if_reg_pc; // @[Core.scala 126:16]
  assign InstructionDecode_io_ctl_writeEnable = mem_reg_ctl_regWrite; // @[Core.scala 244:22]
  assign InstructionDecode_io_id_ex_mem_read = id_reg_ctl_memRead; // @[Core.scala 162:21]
  assign InstructionDecode_io_ex_mem_mem_read = ex_reg_ctl_memRead; // @[Core.scala 163:22]
  assign InstructionDecode_io_id_ex_rd = id_reg_ins[11:7]; // @[Core.scala 170:28]
  assign InstructionDecode_io_ex_mem_rd = ex_reg_ins[11:7]; // @[Core.scala 172:29]
  assign InstructionDecode_io_id_ex_branch = id_reg_ins[6:0] == 7'h63; // @[Core.scala 171:42]
  assign InstructionDecode_io_ex_mem_ins = ex_reg_ins; // @[Core.scala 131:17]
  assign InstructionDecode_io_mem_wb_ins = mem_reg_ins; // @[Core.scala 132:17]
  assign InstructionDecode_io_ex_ins = id_reg_ins; // @[Core.scala 130:13]
  assign InstructionDecode_io_ex_result = Execute_io_ALUresult; // @[Core.scala 173:16]
  assign InstructionDecode_io_ex_mem_result = ex_reg_result; // @[Core.scala 133:20]
  assign InstructionDecode_io_mem_wb_result = mem_reg_ctl_memToReg == 2'h1 ? MEM_io_readData : _GEN_14; // @[Core.scala 227:38 Core.scala 228:13]
  assign Execute_io_immediate = id_reg_imm; // @[Core.scala 144:16]
  assign Execute_io_readData1 = id_reg_rd1; // @[Core.scala 145:16]
  assign Execute_io_readData2 = id_reg_rd2; // @[Core.scala 146:16]
  assign Execute_io_pcAddress = id_reg_pc; // @[Core.scala 147:16]
  assign Execute_io_func7 = id_reg_f7; // @[Core.scala 149:12]
  assign Execute_io_func3 = id_reg_f3; // @[Core.scala 148:12]
  assign Execute_io_mem_result = ex_reg_result; // @[Core.scala 218:17]
  assign Execute_io_wb_result = mem_reg_ctl_memToReg == 2'h1 ? MEM_io_readData : _GEN_14; // @[Core.scala 227:38 Core.scala 228:13]
  assign Execute_io_ex_mem_regWrite = ex_reg_ctl_regWrite; // @[Core.scala 212:22]
  assign Execute_io_mem_wb_regWrite = mem_reg_ctl_regWrite; // @[Core.scala 242:22]
  assign Execute_io_id_ex_ins = id_reg_ins; // @[Core.scala 167:16]
  assign Execute_io_ex_mem_ins = ex_reg_ins; // @[Core.scala 168:17]
  assign Execute_io_mem_wb_ins = mem_reg_ins; // @[Core.scala 169:17]
  assign Execute_io_ctl_aluSrc = id_reg_ctl_aluSrc; // @[Core.scala 150:17]
  assign Execute_io_ctl_aluOp = id_reg_ctl_aluOp; // @[Core.scala 151:16]
  assign Execute_io_ctl_aluSrc1 = id_reg_ctl_aluSrc1; // @[Core.scala 152:18]
  assign MEM_clock = clock;
  assign MEM_reset = reset;
  assign MEM_io_aluResultIn = ex_reg_result; // @[Core.scala 213:22]
  assign MEM_io_writeData = ex_reg_wd; // @[Core.scala 214:20]
  assign MEM_io_writeEnable = ex_reg_ctl_memWrite; // @[Core.scala 216:22]
  assign MEM_io_readEnable = ex_reg_ctl_memRead; // @[Core.scala 215:21]
  assign MEM_io_f3 = ex_reg_ins[14:12]; // @[Core.scala 217:26]
  assign MEM_io_dccmRsp_valid = io_dmemRsp_valid; // @[Core.scala 181:18]
  assign MEM_io_dccmRsp_bits_dataResponse = io_dmemRsp_bits_dataResponse; // @[Core.scala 181:18]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign pc_io_in = InstructionDecode_io_hdu_pcWrite & ~MEM_io_stall ? $signed(_pc_io_in_T_3) : $signed(pc_io_out); // @[Core.scala 91:18]
  assign pc_io_halt = io_imemReq_valid ? 1'h0 : 1'h1; // @[Core.scala 90:20]
  always @(posedge clock) begin
    if (reset) begin // @[Core.scala 24:26]
      if_reg_pc <= 32'h0; // @[Core.scala 24:26]
    end else if (InstructionDecode_io_hdu_if_reg_write & _pc_io_in_T) begin // @[Core.scala 94:46]
      if_reg_pc <= pc_io_out; // @[Core.scala 95:15]
    end
    if (reset) begin // @[Core.scala 25:27]
      if_reg_ins <= 32'h0; // @[Core.scala 25:27]
    end else if (InstructionDecode_io_ifid_flush) begin // @[Core.scala 98:23]
      if_reg_ins <= 32'h0; // @[Core.scala 99:16]
    end else if (InstructionDecode_io_hdu_if_reg_write & _pc_io_in_T) begin // @[Core.scala 94:46]
      if (io_imemRsp_valid) begin // @[Core.scala 88:24]
        if_reg_ins <= InstructionFetch_io_instruction;
      end else begin
        if_reg_ins <= 32'h13;
      end
    end
    if (reset) begin // @[Core.scala 28:26]
      id_reg_pc <= 32'h0; // @[Core.scala 28:26]
    end else begin
      id_reg_pc <= if_reg_pc; // @[Core.scala 114:13]
    end
    if (reset) begin // @[Core.scala 29:27]
      id_reg_rd1 <= 32'h0; // @[Core.scala 29:27]
    end else begin
      id_reg_rd1 <= InstructionDecode_io_readData1; // @[Core.scala 107:14]
    end
    if (reset) begin // @[Core.scala 30:27]
      id_reg_rd2 <= 32'h0; // @[Core.scala 30:27]
    end else begin
      id_reg_rd2 <= InstructionDecode_io_readData2; // @[Core.scala 108:14]
    end
    if (reset) begin // @[Core.scala 31:27]
      id_reg_imm <= 32'h0; // @[Core.scala 31:27]
    end else begin
      id_reg_imm <= InstructionDecode_io_immediate; // @[Core.scala 109:14]
    end
    if (reset) begin // @[Core.scala 32:27]
      id_reg_wra <= 5'h0; // @[Core.scala 32:27]
    end else begin
      id_reg_wra <= InstructionDecode_io_writeRegAddress; // @[Core.scala 110:14]
    end
    if (reset) begin // @[Core.scala 33:26]
      id_reg_f7 <= 1'h0; // @[Core.scala 33:26]
    end else begin
      id_reg_f7 <= InstructionDecode_io_func7; // @[Core.scala 112:13]
    end
    if (reset) begin // @[Core.scala 34:26]
      id_reg_f3 <= 3'h0; // @[Core.scala 34:26]
    end else begin
      id_reg_f3 <= InstructionDecode_io_func3; // @[Core.scala 111:13]
    end
    if (reset) begin // @[Core.scala 35:27]
      id_reg_ins <= 32'h0; // @[Core.scala 35:27]
    end else begin
      id_reg_ins <= if_reg_ins; // @[Core.scala 113:14]
    end
    if (reset) begin // @[Core.scala 36:34]
      id_reg_ctl_aluSrc <= 1'h0; // @[Core.scala 36:34]
    end else begin
      id_reg_ctl_aluSrc <= InstructionDecode_io_ctl_aluSrc; // @[Core.scala 115:21]
    end
    if (reset) begin // @[Core.scala 37:35]
      id_reg_ctl_aluSrc1 <= 2'h0; // @[Core.scala 37:35]
    end else begin
      id_reg_ctl_aluSrc1 <= InstructionDecode_io_ctl_aluSrc1; // @[Core.scala 123:22]
    end
    if (reset) begin // @[Core.scala 38:36]
      id_reg_ctl_memToReg <= 2'h0; // @[Core.scala 38:36]
    end else begin
      id_reg_ctl_memToReg <= InstructionDecode_io_ctl_memToReg; // @[Core.scala 116:23]
    end
    if (reset) begin // @[Core.scala 39:36]
      id_reg_ctl_regWrite <= 1'h0; // @[Core.scala 39:36]
    end else begin
      id_reg_ctl_regWrite <= InstructionDecode_io_ctl_regWrite; // @[Core.scala 117:23]
    end
    if (reset) begin // @[Core.scala 40:35]
      id_reg_ctl_memRead <= 1'h0; // @[Core.scala 40:35]
    end else begin
      id_reg_ctl_memRead <= InstructionDecode_io_ctl_memRead; // @[Core.scala 118:22]
    end
    if (reset) begin // @[Core.scala 41:36]
      id_reg_ctl_memWrite <= 1'h0; // @[Core.scala 41:36]
    end else begin
      id_reg_ctl_memWrite <= InstructionDecode_io_ctl_memWrite; // @[Core.scala 119:23]
    end
    if (reset) begin // @[Core.scala 43:33]
      id_reg_ctl_aluOp <= 2'h0; // @[Core.scala 43:33]
    end else begin
      id_reg_ctl_aluOp <= InstructionDecode_io_ctl_aluOp; // @[Core.scala 121:20]
    end
    if (reset) begin // @[Core.scala 49:30]
      ex_reg_result <= 32'h0; // @[Core.scala 49:30]
    end else begin
      ex_reg_result <= Execute_io_ALUresult; // @[Core.scala 142:17]
    end
    if (reset) begin // @[Core.scala 50:26]
      ex_reg_wd <= 32'h0; // @[Core.scala 50:26]
    end else begin
      ex_reg_wd <= Execute_io_writeData; // @[Core.scala 141:13]
    end
    if (reset) begin // @[Core.scala 51:27]
      ex_reg_wra <= 5'h0; // @[Core.scala 51:27]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 184:21]
      ex_reg_wra <= id_reg_wra; // @[Core.scala 156:14]
    end
    if (reset) begin // @[Core.scala 52:27]
      ex_reg_ins <= 32'h0; // @[Core.scala 52:27]
    end else begin
      ex_reg_ins <= id_reg_ins; // @[Core.scala 157:14]
    end
    if (reset) begin // @[Core.scala 53:36]
      ex_reg_ctl_memToReg <= 2'h0; // @[Core.scala 53:36]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 184:21]
      ex_reg_ctl_memToReg <= id_reg_ctl_memToReg; // @[Core.scala 158:23]
    end
    if (reset) begin // @[Core.scala 54:36]
      ex_reg_ctl_regWrite <= 1'h0; // @[Core.scala 54:36]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 184:21]
      ex_reg_ctl_regWrite <= id_reg_ctl_regWrite; // @[Core.scala 159:23]
    end
    if (reset) begin // @[Core.scala 55:35]
      ex_reg_ctl_memRead <= 1'h0; // @[Core.scala 55:35]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 184:21]
      ex_reg_ctl_memRead <= id_reg_ctl_memRead; // @[Core.scala 207:24]
    end
    if (reset) begin // @[Core.scala 56:36]
      ex_reg_ctl_memWrite <= 1'h0; // @[Core.scala 56:36]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 184:21]
      ex_reg_ctl_memWrite <= id_reg_ctl_memWrite; // @[Core.scala 208:25]
    end
    if (reset) begin // @[Core.scala 58:26]
      ex_reg_pc <= 32'h0; // @[Core.scala 58:26]
    end else begin
      ex_reg_pc <= id_reg_pc; // @[Core.scala 155:13]
    end
    if (reset) begin // @[Core.scala 62:28]
      mem_reg_ins <= 32'h0; // @[Core.scala 62:28]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 184:21]
      mem_reg_ins <= ex_reg_ins; // @[Core.scala 204:17]
    end
    if (reset) begin // @[Core.scala 63:31]
      mem_reg_result <= 32'h0; // @[Core.scala 63:31]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 184:21]
      mem_reg_result <= ex_reg_result; // @[Core.scala 201:20]
    end
    if (reset) begin // @[Core.scala 65:28]
      mem_reg_wra <= 5'h0; // @[Core.scala 65:28]
    end else begin
      mem_reg_wra <= ex_reg_wra; // @[Core.scala 210:15]
    end
    if (reset) begin // @[Core.scala 66:37]
      mem_reg_ctl_memToReg <= 2'h0; // @[Core.scala 66:37]
    end else begin
      mem_reg_ctl_memToReg <= ex_reg_ctl_memToReg; // @[Core.scala 211:24]
    end
    if (reset) begin // @[Core.scala 67:37]
      mem_reg_ctl_regWrite <= 1'h0; // @[Core.scala 67:37]
    end else begin
      mem_reg_ctl_regWrite <= ex_reg_ctl_regWrite;
    end
    if (reset) begin // @[Core.scala 68:27]
      mem_reg_pc <= 32'h0; // @[Core.scala 68:27]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 184:21]
      mem_reg_pc <= ex_reg_pc; // @[Core.scala 205:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  if_reg_pc = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  if_reg_ins = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  id_reg_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  id_reg_rd1 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  id_reg_rd2 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  id_reg_imm = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  id_reg_wra = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  id_reg_f7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  id_reg_f3 = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  id_reg_ins = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  id_reg_ctl_aluSrc = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  id_reg_ctl_aluSrc1 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  id_reg_ctl_memToReg = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  id_reg_ctl_regWrite = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  id_reg_ctl_memRead = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  id_reg_ctl_memWrite = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  id_reg_ctl_aluOp = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  ex_reg_result = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  ex_reg_wd = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  ex_reg_wra = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  ex_reg_ins = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  ex_reg_ctl_memToReg = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  ex_reg_ctl_regWrite = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  ex_reg_ctl_memRead = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  ex_reg_ctl_memWrite = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  ex_reg_pc = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  mem_reg_ins = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  mem_reg_result = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  mem_reg_wra = _RAND_28[4:0];
  _RAND_29 = {1{`RANDOM}};
  mem_reg_ctl_memToReg = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  mem_reg_ctl_regWrite = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  mem_reg_pc = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Switch1toN(
  input         io_hostIn_valid,
  input         io_hostIn_bits_cyc,
  input         io_hostIn_bits_stb,
  input         io_hostIn_bits_we,
  input  [31:0] io_hostIn_bits_adr,
  input  [31:0] io_hostIn_bits_dat,
  input  [3:0]  io_hostIn_bits_sel,
  output        io_hostOut_bits_ack,
  output [31:0] io_hostOut_bits_dat,
  output        io_hostOut_bits_err,
  output        io_devOut_0_valid,
  output        io_devOut_0_bits_cyc,
  output        io_devOut_0_bits_stb,
  output        io_devOut_0_bits_we,
  output [31:0] io_devOut_0_bits_adr,
  output [31:0] io_devOut_0_bits_dat,
  output [3:0]  io_devOut_0_bits_sel,
  output        io_devOut_1_valid,
  output        io_devOut_1_bits_cyc,
  output        io_devOut_1_bits_stb,
  output        io_devOut_1_bits_we,
  output [31:0] io_devOut_1_bits_adr,
  output [31:0] io_devOut_1_bits_dat,
  output [3:0]  io_devOut_1_bits_sel,
  output        io_devOut_2_valid,
  output        io_devOut_2_bits_cyc,
  output        io_devOut_2_bits_stb,
  input         io_devIn_0_bits_ack,
  input  [31:0] io_devIn_0_bits_dat,
  input         io_devIn_0_bits_err,
  input         io_devIn_1_bits_ack,
  input  [31:0] io_devIn_1_bits_dat,
  input         io_devIn_1_bits_err,
  input  [31:0] io_devIn_2_bits_dat,
  input         io_devIn_2_bits_err,
  input  [1:0]  io_devSel
);
  wire  _io_devOut_0_valid_T = io_devSel == 2'h0; // @[Switch1toN.scala 33:57]
  wire  _io_devOut_1_valid_T = io_devSel == 2'h1; // @[Switch1toN.scala 33:57]
  wire  _GEN_0 = _io_devOut_0_valid_T ? io_devIn_0_bits_err : io_devIn_2_bits_err; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  wire [31:0] _GEN_1 = _io_devOut_0_valid_T ? io_devIn_0_bits_dat : io_devIn_2_bits_dat; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  wire  _GEN_2 = _io_devOut_0_valid_T & io_devIn_0_bits_ack; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  assign io_hostOut_bits_ack = _io_devOut_1_valid_T ? io_devIn_1_bits_ack : _GEN_2; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_hostOut_bits_dat = _io_devOut_1_valid_T ? io_devIn_1_bits_dat : _GEN_1; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_hostOut_bits_err = _io_devOut_1_valid_T ? io_devIn_1_bits_err : _GEN_0; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_devOut_0_valid = io_hostIn_valid & io_devSel == 2'h0; // @[Switch1toN.scala 33:43]
  assign io_devOut_0_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_we = io_hostIn_bits_we; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_adr = io_hostIn_bits_adr; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_dat = io_hostIn_bits_dat; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_sel = io_hostIn_bits_sel; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_valid = io_hostIn_valid & io_devSel == 2'h1; // @[Switch1toN.scala 33:43]
  assign io_devOut_1_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_we = io_hostIn_bits_we; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_adr = io_hostIn_bits_adr; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_dat = io_hostIn_bits_dat; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_sel = io_hostIn_bits_sel; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_valid = io_hostIn_valid & io_devSel == 2'h2; // @[Switch1toN.scala 23:41]
  assign io_devOut_2_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
endmodule
module Top(
  input         clock,
  input         reset,
  output [31:0] io_gpio_o,
  output [31:0] io_gpio_en_o,
  input  [31:0] io_gpio_i,
  input         io_rx_we_i,
  input  [31:0] io_rx_addr_i,
  input  [31:0] io_rx_wdata_i,
  input         io_rx_reset_i
);
  wire  wb_imem_host_clock; // @[Top.scala 67:28]
  wire  wb_imem_host_reset; // @[Top.scala 67:28]
  wire  wb_imem_host_io_wbMasterTransmitter_ready; // @[Top.scala 67:28]
  wire  wb_imem_host_io_wbMasterTransmitter_valid; // @[Top.scala 67:28]
  wire  wb_imem_host_io_wbMasterTransmitter_bits_cyc; // @[Top.scala 67:28]
  wire  wb_imem_host_io_wbMasterTransmitter_bits_stb; // @[Top.scala 67:28]
  wire  wb_imem_host_io_wbMasterTransmitter_bits_we; // @[Top.scala 67:28]
  wire [31:0] wb_imem_host_io_wbMasterTransmitter_bits_adr; // @[Top.scala 67:28]
  wire [31:0] wb_imem_host_io_wbMasterTransmitter_bits_dat; // @[Top.scala 67:28]
  wire [3:0] wb_imem_host_io_wbMasterTransmitter_bits_sel; // @[Top.scala 67:28]
  wire  wb_imem_host_io_wbSlaveReceiver_ready; // @[Top.scala 67:28]
  wire  wb_imem_host_io_wbSlaveReceiver_bits_ack; // @[Top.scala 67:28]
  wire [31:0] wb_imem_host_io_wbSlaveReceiver_bits_dat; // @[Top.scala 67:28]
  wire  wb_imem_host_io_wbSlaveReceiver_bits_err; // @[Top.scala 67:28]
  wire  wb_imem_host_io_reqIn_ready; // @[Top.scala 67:28]
  wire  wb_imem_host_io_reqIn_valid; // @[Top.scala 67:28]
  wire [31:0] wb_imem_host_io_reqIn_bits_addrRequest; // @[Top.scala 67:28]
  wire [31:0] wb_imem_host_io_reqIn_bits_dataRequest; // @[Top.scala 67:28]
  wire [3:0] wb_imem_host_io_reqIn_bits_activeByteLane; // @[Top.scala 67:28]
  wire  wb_imem_host_io_reqIn_bits_isWrite; // @[Top.scala 67:28]
  wire  wb_imem_host_io_rspOut_valid; // @[Top.scala 67:28]
  wire [31:0] wb_imem_host_io_rspOut_bits_dataResponse; // @[Top.scala 67:28]
  wire  wb_imem_slave_io_wbSlaveTransmitter_ready; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 68:29]
  wire [31:0] wb_imem_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_wbMasterReceiver_ready; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_wbMasterReceiver_valid; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_wbMasterReceiver_bits_cyc; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_wbMasterReceiver_bits_stb; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_wbMasterReceiver_bits_we; // @[Top.scala 68:29]
  wire [31:0] wb_imem_slave_io_wbMasterReceiver_bits_adr; // @[Top.scala 68:29]
  wire [31:0] wb_imem_slave_io_wbMasterReceiver_bits_dat; // @[Top.scala 68:29]
  wire [3:0] wb_imem_slave_io_wbMasterReceiver_bits_sel; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_reqOut_valid; // @[Top.scala 68:29]
  wire [31:0] wb_imem_slave_io_reqOut_bits_addrRequest; // @[Top.scala 68:29]
  wire [31:0] wb_imem_slave_io_reqOut_bits_dataRequest; // @[Top.scala 68:29]
  wire [3:0] wb_imem_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_reqOut_bits_isWrite; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_rspIn_valid; // @[Top.scala 68:29]
  wire [31:0] wb_imem_slave_io_rspIn_bits_dataResponse; // @[Top.scala 68:29]
  wire  wb_imem_slave_io_rspIn_bits_error; // @[Top.scala 68:29]
  wire  wb_dmem_host_clock; // @[Top.scala 69:28]
  wire  wb_dmem_host_reset; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_ready; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_valid; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_bits_cyc; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_bits_stb; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_bits_we; // @[Top.scala 69:28]
  wire [31:0] wb_dmem_host_io_wbMasterTransmitter_bits_adr; // @[Top.scala 69:28]
  wire [31:0] wb_dmem_host_io_wbMasterTransmitter_bits_dat; // @[Top.scala 69:28]
  wire [3:0] wb_dmem_host_io_wbMasterTransmitter_bits_sel; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_wbSlaveReceiver_ready; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_wbSlaveReceiver_bits_ack; // @[Top.scala 69:28]
  wire [31:0] wb_dmem_host_io_wbSlaveReceiver_bits_dat; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_wbSlaveReceiver_bits_err; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_reqIn_ready; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_reqIn_valid; // @[Top.scala 69:28]
  wire [31:0] wb_dmem_host_io_reqIn_bits_addrRequest; // @[Top.scala 69:28]
  wire [31:0] wb_dmem_host_io_reqIn_bits_dataRequest; // @[Top.scala 69:28]
  wire [3:0] wb_dmem_host_io_reqIn_bits_activeByteLane; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_reqIn_bits_isWrite; // @[Top.scala 69:28]
  wire  wb_dmem_host_io_rspOut_valid; // @[Top.scala 69:28]
  wire [31:0] wb_dmem_host_io_rspOut_bits_dataResponse; // @[Top.scala 69:28]
  wire  wb_dmem_slave_io_wbSlaveTransmitter_ready; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 70:29]
  wire [31:0] wb_dmem_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_ready; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_valid; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_bits_cyc; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_bits_stb; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_bits_we; // @[Top.scala 70:29]
  wire [31:0] wb_dmem_slave_io_wbMasterReceiver_bits_adr; // @[Top.scala 70:29]
  wire [31:0] wb_dmem_slave_io_wbMasterReceiver_bits_dat; // @[Top.scala 70:29]
  wire [3:0] wb_dmem_slave_io_wbMasterReceiver_bits_sel; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_reqOut_valid; // @[Top.scala 70:29]
  wire [31:0] wb_dmem_slave_io_reqOut_bits_addrRequest; // @[Top.scala 70:29]
  wire [31:0] wb_dmem_slave_io_reqOut_bits_dataRequest; // @[Top.scala 70:29]
  wire [3:0] wb_dmem_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_reqOut_bits_isWrite; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_rspIn_valid; // @[Top.scala 70:29]
  wire [31:0] wb_dmem_slave_io_rspIn_bits_dataResponse; // @[Top.scala 70:29]
  wire  wb_dmem_slave_io_rspIn_bits_error; // @[Top.scala 70:29]
  wire  wb_gpio_slave_io_wbSlaveTransmitter_ready; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 71:29]
  wire [31:0] wb_gpio_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_ready; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_valid; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_bits_cyc; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_bits_stb; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_bits_we; // @[Top.scala 71:29]
  wire [31:0] wb_gpio_slave_io_wbMasterReceiver_bits_adr; // @[Top.scala 71:29]
  wire [31:0] wb_gpio_slave_io_wbMasterReceiver_bits_dat; // @[Top.scala 71:29]
  wire [3:0] wb_gpio_slave_io_wbMasterReceiver_bits_sel; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_reqOut_valid; // @[Top.scala 71:29]
  wire [31:0] wb_gpio_slave_io_reqOut_bits_addrRequest; // @[Top.scala 71:29]
  wire [31:0] wb_gpio_slave_io_reqOut_bits_dataRequest; // @[Top.scala 71:29]
  wire [3:0] wb_gpio_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_reqOut_bits_isWrite; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_rspIn_valid; // @[Top.scala 71:29]
  wire [31:0] wb_gpio_slave_io_rspIn_bits_dataResponse; // @[Top.scala 71:29]
  wire  wb_gpio_slave_io_rspIn_bits_error; // @[Top.scala 71:29]
  wire  dmem_clock; // @[Top.scala 74:20]
  wire  dmem_reset; // @[Top.scala 74:20]
  wire  dmem_io_req_valid; // @[Top.scala 74:20]
  wire [31:0] dmem_io_req_bits_addrRequest; // @[Top.scala 74:20]
  wire [31:0] dmem_io_req_bits_dataRequest; // @[Top.scala 74:20]
  wire [3:0] dmem_io_req_bits_activeByteLane; // @[Top.scala 74:20]
  wire  dmem_io_req_bits_isWrite; // @[Top.scala 74:20]
  wire  dmem_io_rsp_valid; // @[Top.scala 74:20]
  wire [31:0] dmem_io_rsp_bits_dataResponse; // @[Top.scala 74:20]
  wire  imem_clock; // @[Top.scala 75:20]
  wire  imem_reset; // @[Top.scala 75:20]
  wire  imem_io_req_valid; // @[Top.scala 75:20]
  wire [31:0] imem_io_req_bits_addrRequest; // @[Top.scala 75:20]
  wire  imem_io_req_bits_isWrite; // @[Top.scala 75:20]
  wire  imem_io_rsp_valid; // @[Top.scala 75:20]
  wire [31:0] imem_io_rsp_bits_dataResponse; // @[Top.scala 75:20]
  wire  imem_io_writeEnable; // @[Top.scala 75:20]
  wire [31:0] imem_io_addrIn; // @[Top.scala 75:20]
  wire [31:0] imem_io_dataIn; // @[Top.scala 75:20]
  wire  gpio_clock; // @[Top.scala 76:20]
  wire  gpio_reset; // @[Top.scala 76:20]
  wire  gpio_io_req_valid; // @[Top.scala 76:20]
  wire [31:0] gpio_io_req_bits_addrRequest; // @[Top.scala 76:20]
  wire [31:0] gpio_io_req_bits_dataRequest; // @[Top.scala 76:20]
  wire [3:0] gpio_io_req_bits_activeByteLane; // @[Top.scala 76:20]
  wire  gpio_io_req_bits_isWrite; // @[Top.scala 76:20]
  wire  gpio_io_rsp_valid; // @[Top.scala 76:20]
  wire [31:0] gpio_io_rsp_bits_dataResponse; // @[Top.scala 76:20]
  wire  gpio_io_rsp_bits_error; // @[Top.scala 76:20]
  wire [31:0] gpio_io_cio_gpio_i; // @[Top.scala 76:20]
  wire [31:0] gpio_io_cio_gpio_o; // @[Top.scala 76:20]
  wire [31:0] gpio_io_cio_gpio_en_o; // @[Top.scala 76:20]
  wire  wbErr_clock; // @[Top.scala 77:21]
  wire  wbErr_reset; // @[Top.scala 77:21]
  wire [31:0] wbErr_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 77:21]
  wire  wbErr_io_wbSlaveTransmitter_bits_err; // @[Top.scala 77:21]
  wire  wbErr_io_wbMasterReceiver_valid; // @[Top.scala 77:21]
  wire  wbErr_io_wbMasterReceiver_bits_cyc; // @[Top.scala 77:21]
  wire  wbErr_io_wbMasterReceiver_bits_stb; // @[Top.scala 77:21]
  wire  core_clock; // @[Top.scala 79:20]
  wire  core_reset; // @[Top.scala 79:20]
  wire  core_io_dmemReq_valid; // @[Top.scala 79:20]
  wire [31:0] core_io_dmemReq_bits_addrRequest; // @[Top.scala 79:20]
  wire [31:0] core_io_dmemReq_bits_dataRequest; // @[Top.scala 79:20]
  wire [3:0] core_io_dmemReq_bits_activeByteLane; // @[Top.scala 79:20]
  wire  core_io_dmemReq_bits_isWrite; // @[Top.scala 79:20]
  wire  core_io_dmemRsp_valid; // @[Top.scala 79:20]
  wire [31:0] core_io_dmemRsp_bits_dataResponse; // @[Top.scala 79:20]
  wire  core_io_imemReq_ready; // @[Top.scala 79:20]
  wire  core_io_imemReq_valid; // @[Top.scala 79:20]
  wire [31:0] core_io_imemReq_bits_addrRequest; // @[Top.scala 79:20]
  wire  core_io_imemRsp_valid; // @[Top.scala 79:20]
  wire [31:0] core_io_imemRsp_bits_dataResponse; // @[Top.scala 79:20]
  wire  switch_io_hostIn_valid; // @[Top.scala 88:22]
  wire  switch_io_hostIn_bits_cyc; // @[Top.scala 88:22]
  wire  switch_io_hostIn_bits_stb; // @[Top.scala 88:22]
  wire  switch_io_hostIn_bits_we; // @[Top.scala 88:22]
  wire [31:0] switch_io_hostIn_bits_adr; // @[Top.scala 88:22]
  wire [31:0] switch_io_hostIn_bits_dat; // @[Top.scala 88:22]
  wire [3:0] switch_io_hostIn_bits_sel; // @[Top.scala 88:22]
  wire  switch_io_hostOut_bits_ack; // @[Top.scala 88:22]
  wire [31:0] switch_io_hostOut_bits_dat; // @[Top.scala 88:22]
  wire  switch_io_hostOut_bits_err; // @[Top.scala 88:22]
  wire  switch_io_devOut_0_valid; // @[Top.scala 88:22]
  wire  switch_io_devOut_0_bits_cyc; // @[Top.scala 88:22]
  wire  switch_io_devOut_0_bits_stb; // @[Top.scala 88:22]
  wire  switch_io_devOut_0_bits_we; // @[Top.scala 88:22]
  wire [31:0] switch_io_devOut_0_bits_adr; // @[Top.scala 88:22]
  wire [31:0] switch_io_devOut_0_bits_dat; // @[Top.scala 88:22]
  wire [3:0] switch_io_devOut_0_bits_sel; // @[Top.scala 88:22]
  wire  switch_io_devOut_1_valid; // @[Top.scala 88:22]
  wire  switch_io_devOut_1_bits_cyc; // @[Top.scala 88:22]
  wire  switch_io_devOut_1_bits_stb; // @[Top.scala 88:22]
  wire  switch_io_devOut_1_bits_we; // @[Top.scala 88:22]
  wire [31:0] switch_io_devOut_1_bits_adr; // @[Top.scala 88:22]
  wire [31:0] switch_io_devOut_1_bits_dat; // @[Top.scala 88:22]
  wire [3:0] switch_io_devOut_1_bits_sel; // @[Top.scala 88:22]
  wire  switch_io_devOut_2_valid; // @[Top.scala 88:22]
  wire  switch_io_devOut_2_bits_cyc; // @[Top.scala 88:22]
  wire  switch_io_devOut_2_bits_stb; // @[Top.scala 88:22]
  wire  switch_io_devIn_0_bits_ack; // @[Top.scala 88:22]
  wire [31:0] switch_io_devIn_0_bits_dat; // @[Top.scala 88:22]
  wire  switch_io_devIn_0_bits_err; // @[Top.scala 88:22]
  wire  switch_io_devIn_1_bits_ack; // @[Top.scala 88:22]
  wire [31:0] switch_io_devIn_1_bits_dat; // @[Top.scala 88:22]
  wire  switch_io_devIn_1_bits_err; // @[Top.scala 88:22]
  wire [31:0] switch_io_devIn_2_bits_dat; // @[Top.scala 88:22]
  wire  switch_io_devIn_2_bits_err; // @[Top.scala 88:22]
  wire [1:0] switch_io_devSel; // @[Top.scala 88:22]
  wire [31:0] _switch_io_devSel_addr_hit_0_T_1 = 32'hfffff000 & wb_dmem_host_io_wbMasterTransmitter_bits_adr; // @[BusDecoder.scala 45:60]
  wire  switch_io_devSel_addr_hit_0 = _switch_io_devSel_addr_hit_0_T_1 == 32'h40000000; // @[BusDecoder.scala 45:68]
  wire [1:0] switch_io_devSel_id_0 = switch_io_devSel_addr_hit_0 ? 2'h1 : 2'h2; // @[BusDecoder.scala 46:19]
  wire  switch_io_devSel_addr_hit_1 = _switch_io_devSel_addr_hit_0_T_1 == 32'h40001000; // @[BusDecoder.scala 45:68]
  wire [1:0] switch_io_devSel_id_1 = switch_io_devSel_addr_hit_1 ? 2'h0 : 2'h2; // @[BusDecoder.scala 46:19]
  wire [1:0] _switch_io_devSel_T = switch_io_devSel_addr_hit_1 ? switch_io_devSel_id_1 : 2'h2; // @[Mux.scala 98:16]
  WishboneHost wb_imem_host ( // @[Top.scala 67:28]
    .clock(wb_imem_host_clock),
    .reset(wb_imem_host_reset),
    .io_wbMasterTransmitter_ready(wb_imem_host_io_wbMasterTransmitter_ready),
    .io_wbMasterTransmitter_valid(wb_imem_host_io_wbMasterTransmitter_valid),
    .io_wbMasterTransmitter_bits_cyc(wb_imem_host_io_wbMasterTransmitter_bits_cyc),
    .io_wbMasterTransmitter_bits_stb(wb_imem_host_io_wbMasterTransmitter_bits_stb),
    .io_wbMasterTransmitter_bits_we(wb_imem_host_io_wbMasterTransmitter_bits_we),
    .io_wbMasterTransmitter_bits_adr(wb_imem_host_io_wbMasterTransmitter_bits_adr),
    .io_wbMasterTransmitter_bits_dat(wb_imem_host_io_wbMasterTransmitter_bits_dat),
    .io_wbMasterTransmitter_bits_sel(wb_imem_host_io_wbMasterTransmitter_bits_sel),
    .io_wbSlaveReceiver_ready(wb_imem_host_io_wbSlaveReceiver_ready),
    .io_wbSlaveReceiver_bits_ack(wb_imem_host_io_wbSlaveReceiver_bits_ack),
    .io_wbSlaveReceiver_bits_dat(wb_imem_host_io_wbSlaveReceiver_bits_dat),
    .io_wbSlaveReceiver_bits_err(wb_imem_host_io_wbSlaveReceiver_bits_err),
    .io_reqIn_ready(wb_imem_host_io_reqIn_ready),
    .io_reqIn_valid(wb_imem_host_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(wb_imem_host_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(wb_imem_host_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_activeByteLane(wb_imem_host_io_reqIn_bits_activeByteLane),
    .io_reqIn_bits_isWrite(wb_imem_host_io_reqIn_bits_isWrite),
    .io_rspOut_valid(wb_imem_host_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(wb_imem_host_io_rspOut_bits_dataResponse)
  );
  WishboneDevice wb_imem_slave ( // @[Top.scala 68:29]
    .io_wbSlaveTransmitter_ready(wb_imem_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(wb_imem_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(wb_imem_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wb_imem_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(wb_imem_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(wb_imem_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wb_imem_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wb_imem_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(wb_imem_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(wb_imem_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(wb_imem_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(wb_imem_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(wb_imem_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(wb_imem_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(wb_imem_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(wb_imem_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(wb_imem_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(wb_imem_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(wb_imem_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(wb_imem_slave_io_rspIn_bits_error)
  );
  WishboneHost wb_dmem_host ( // @[Top.scala 69:28]
    .clock(wb_dmem_host_clock),
    .reset(wb_dmem_host_reset),
    .io_wbMasterTransmitter_ready(wb_dmem_host_io_wbMasterTransmitter_ready),
    .io_wbMasterTransmitter_valid(wb_dmem_host_io_wbMasterTransmitter_valid),
    .io_wbMasterTransmitter_bits_cyc(wb_dmem_host_io_wbMasterTransmitter_bits_cyc),
    .io_wbMasterTransmitter_bits_stb(wb_dmem_host_io_wbMasterTransmitter_bits_stb),
    .io_wbMasterTransmitter_bits_we(wb_dmem_host_io_wbMasterTransmitter_bits_we),
    .io_wbMasterTransmitter_bits_adr(wb_dmem_host_io_wbMasterTransmitter_bits_adr),
    .io_wbMasterTransmitter_bits_dat(wb_dmem_host_io_wbMasterTransmitter_bits_dat),
    .io_wbMasterTransmitter_bits_sel(wb_dmem_host_io_wbMasterTransmitter_bits_sel),
    .io_wbSlaveReceiver_ready(wb_dmem_host_io_wbSlaveReceiver_ready),
    .io_wbSlaveReceiver_bits_ack(wb_dmem_host_io_wbSlaveReceiver_bits_ack),
    .io_wbSlaveReceiver_bits_dat(wb_dmem_host_io_wbSlaveReceiver_bits_dat),
    .io_wbSlaveReceiver_bits_err(wb_dmem_host_io_wbSlaveReceiver_bits_err),
    .io_reqIn_ready(wb_dmem_host_io_reqIn_ready),
    .io_reqIn_valid(wb_dmem_host_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(wb_dmem_host_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(wb_dmem_host_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_activeByteLane(wb_dmem_host_io_reqIn_bits_activeByteLane),
    .io_reqIn_bits_isWrite(wb_dmem_host_io_reqIn_bits_isWrite),
    .io_rspOut_valid(wb_dmem_host_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(wb_dmem_host_io_rspOut_bits_dataResponse)
  );
  WishboneDevice wb_dmem_slave ( // @[Top.scala 70:29]
    .io_wbSlaveTransmitter_ready(wb_dmem_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(wb_dmem_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(wb_dmem_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wb_dmem_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(wb_dmem_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(wb_dmem_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wb_dmem_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wb_dmem_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(wb_dmem_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(wb_dmem_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(wb_dmem_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(wb_dmem_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(wb_dmem_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(wb_dmem_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(wb_dmem_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(wb_dmem_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(wb_dmem_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(wb_dmem_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(wb_dmem_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(wb_dmem_slave_io_rspIn_bits_error)
  );
  WishboneDevice wb_gpio_slave ( // @[Top.scala 71:29]
    .io_wbSlaveTransmitter_ready(wb_gpio_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(wb_gpio_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(wb_gpio_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wb_gpio_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(wb_gpio_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(wb_gpio_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wb_gpio_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wb_gpio_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(wb_gpio_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(wb_gpio_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(wb_gpio_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(wb_gpio_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(wb_gpio_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(wb_gpio_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(wb_gpio_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(wb_gpio_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(wb_gpio_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(wb_gpio_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(wb_gpio_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(wb_gpio_slave_io_rspIn_bits_error)
  );
  SRAM1kb dmem ( // @[Top.scala 74:20]
    .clock(dmem_clock),
    .reset(dmem_reset),
    .io_req_valid(dmem_io_req_valid),
    .io_req_bits_addrRequest(dmem_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(dmem_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(dmem_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(dmem_io_req_bits_isWrite),
    .io_rsp_valid(dmem_io_rsp_valid),
    .io_rsp_bits_dataResponse(dmem_io_rsp_bits_dataResponse)
  );
  SramImem imem ( // @[Top.scala 75:20]
    .clock(imem_clock),
    .reset(imem_reset),
    .io_req_valid(imem_io_req_valid),
    .io_req_bits_addrRequest(imem_io_req_bits_addrRequest),
    .io_req_bits_isWrite(imem_io_req_bits_isWrite),
    .io_rsp_valid(imem_io_rsp_valid),
    .io_rsp_bits_dataResponse(imem_io_rsp_bits_dataResponse),
    .io_writeEnable(imem_io_writeEnable),
    .io_addrIn(imem_io_addrIn),
    .io_dataIn(imem_io_dataIn)
  );
  Gpio gpio ( // @[Top.scala 76:20]
    .clock(gpio_clock),
    .reset(gpio_reset),
    .io_req_valid(gpio_io_req_valid),
    .io_req_bits_addrRequest(gpio_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(gpio_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(gpio_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(gpio_io_req_bits_isWrite),
    .io_rsp_valid(gpio_io_rsp_valid),
    .io_rsp_bits_dataResponse(gpio_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(gpio_io_rsp_bits_error),
    .io_cio_gpio_i(gpio_io_cio_gpio_i),
    .io_cio_gpio_o(gpio_io_cio_gpio_o),
    .io_cio_gpio_en_o(gpio_io_cio_gpio_en_o)
  );
  WishboneErr wbErr ( // @[Top.scala 77:21]
    .clock(wbErr_clock),
    .reset(wbErr_reset),
    .io_wbSlaveTransmitter_bits_dat(wbErr_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wbErr_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_valid(wbErr_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wbErr_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wbErr_io_wbMasterReceiver_bits_stb)
  );
  Core core ( // @[Top.scala 79:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_dmemReq_valid(core_io_dmemReq_valid),
    .io_dmemReq_bits_addrRequest(core_io_dmemReq_bits_addrRequest),
    .io_dmemReq_bits_dataRequest(core_io_dmemReq_bits_dataRequest),
    .io_dmemReq_bits_activeByteLane(core_io_dmemReq_bits_activeByteLane),
    .io_dmemReq_bits_isWrite(core_io_dmemReq_bits_isWrite),
    .io_dmemRsp_valid(core_io_dmemRsp_valid),
    .io_dmemRsp_bits_dataResponse(core_io_dmemRsp_bits_dataResponse),
    .io_imemReq_ready(core_io_imemReq_ready),
    .io_imemReq_valid(core_io_imemReq_valid),
    .io_imemReq_bits_addrRequest(core_io_imemReq_bits_addrRequest),
    .io_imemRsp_valid(core_io_imemRsp_valid),
    .io_imemRsp_bits_dataResponse(core_io_imemRsp_bits_dataResponse)
  );
  Switch1toN switch ( // @[Top.scala 88:22]
    .io_hostIn_valid(switch_io_hostIn_valid),
    .io_hostIn_bits_cyc(switch_io_hostIn_bits_cyc),
    .io_hostIn_bits_stb(switch_io_hostIn_bits_stb),
    .io_hostIn_bits_we(switch_io_hostIn_bits_we),
    .io_hostIn_bits_adr(switch_io_hostIn_bits_adr),
    .io_hostIn_bits_dat(switch_io_hostIn_bits_dat),
    .io_hostIn_bits_sel(switch_io_hostIn_bits_sel),
    .io_hostOut_bits_ack(switch_io_hostOut_bits_ack),
    .io_hostOut_bits_dat(switch_io_hostOut_bits_dat),
    .io_hostOut_bits_err(switch_io_hostOut_bits_err),
    .io_devOut_0_valid(switch_io_devOut_0_valid),
    .io_devOut_0_bits_cyc(switch_io_devOut_0_bits_cyc),
    .io_devOut_0_bits_stb(switch_io_devOut_0_bits_stb),
    .io_devOut_0_bits_we(switch_io_devOut_0_bits_we),
    .io_devOut_0_bits_adr(switch_io_devOut_0_bits_adr),
    .io_devOut_0_bits_dat(switch_io_devOut_0_bits_dat),
    .io_devOut_0_bits_sel(switch_io_devOut_0_bits_sel),
    .io_devOut_1_valid(switch_io_devOut_1_valid),
    .io_devOut_1_bits_cyc(switch_io_devOut_1_bits_cyc),
    .io_devOut_1_bits_stb(switch_io_devOut_1_bits_stb),
    .io_devOut_1_bits_we(switch_io_devOut_1_bits_we),
    .io_devOut_1_bits_adr(switch_io_devOut_1_bits_adr),
    .io_devOut_1_bits_dat(switch_io_devOut_1_bits_dat),
    .io_devOut_1_bits_sel(switch_io_devOut_1_bits_sel),
    .io_devOut_2_valid(switch_io_devOut_2_valid),
    .io_devOut_2_bits_cyc(switch_io_devOut_2_bits_cyc),
    .io_devOut_2_bits_stb(switch_io_devOut_2_bits_stb),
    .io_devIn_0_bits_ack(switch_io_devIn_0_bits_ack),
    .io_devIn_0_bits_dat(switch_io_devIn_0_bits_dat),
    .io_devIn_0_bits_err(switch_io_devIn_0_bits_err),
    .io_devIn_1_bits_ack(switch_io_devIn_1_bits_ack),
    .io_devIn_1_bits_dat(switch_io_devIn_1_bits_dat),
    .io_devIn_1_bits_err(switch_io_devIn_1_bits_err),
    .io_devIn_2_bits_dat(switch_io_devIn_2_bits_dat),
    .io_devIn_2_bits_err(switch_io_devIn_2_bits_err),
    .io_devSel(switch_io_devSel)
  );
  assign io_gpio_o = gpio_io_cio_gpio_o; // @[Top.scala 256:34]
  assign io_gpio_en_o = gpio_io_cio_gpio_en_o; // @[Top.scala 257:40]
  assign wb_imem_host_clock = clock;
  assign wb_imem_host_reset = reset;
  assign wb_imem_host_io_wbMasterTransmitter_ready = wb_imem_slave_io_wbMasterReceiver_ready; // @[Top.scala 231:39]
  assign wb_imem_host_io_wbSlaveReceiver_bits_ack = wb_imem_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 232:39]
  assign wb_imem_host_io_wbSlaveReceiver_bits_dat = wb_imem_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 232:39]
  assign wb_imem_host_io_wbSlaveReceiver_bits_err = wb_imem_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 232:39]
  assign wb_imem_host_io_reqIn_valid = core_io_imemReq_valid; // @[Top.scala 225:25]
  assign wb_imem_host_io_reqIn_bits_addrRequest = core_io_imemReq_bits_addrRequest; // @[Top.scala 225:25]
  assign wb_imem_host_io_reqIn_bits_dataRequest = 32'h0; // @[Top.scala 225:25]
  assign wb_imem_host_io_reqIn_bits_activeByteLane = 4'hf; // @[Top.scala 225:25]
  assign wb_imem_host_io_reqIn_bits_isWrite = 1'h0; // @[Top.scala 225:25]
  assign wb_imem_slave_io_wbSlaveTransmitter_ready = wb_imem_host_io_wbSlaveReceiver_ready; // @[Top.scala 232:39]
  assign wb_imem_slave_io_wbMasterReceiver_valid = wb_imem_host_io_wbMasterTransmitter_valid; // @[Top.scala 231:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_cyc = wb_imem_host_io_wbMasterTransmitter_bits_cyc; // @[Top.scala 231:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_stb = wb_imem_host_io_wbMasterTransmitter_bits_stb; // @[Top.scala 231:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_we = wb_imem_host_io_wbMasterTransmitter_bits_we; // @[Top.scala 231:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_adr = wb_imem_host_io_wbMasterTransmitter_bits_adr; // @[Top.scala 231:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_dat = wb_imem_host_io_wbMasterTransmitter_bits_dat; // @[Top.scala 231:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_sel = wb_imem_host_io_wbMasterTransmitter_bits_sel; // @[Top.scala 231:39]
  assign wb_imem_slave_io_rspIn_valid = imem_io_rsp_valid; // @[Top.scala 228:26]
  assign wb_imem_slave_io_rspIn_bits_dataResponse = imem_io_rsp_bits_dataResponse; // @[Top.scala 228:26]
  assign wb_imem_slave_io_rspIn_bits_error = 1'h0; // @[Top.scala 228:26]
  assign wb_dmem_host_clock = clock;
  assign wb_dmem_host_reset = reset;
  assign wb_dmem_host_io_wbMasterTransmitter_ready = 1'h1; // @[Top.scala 242:20]
  assign wb_dmem_host_io_wbSlaveReceiver_bits_ack = switch_io_hostOut_bits_ack; // @[Top.scala 243:21]
  assign wb_dmem_host_io_wbSlaveReceiver_bits_dat = switch_io_hostOut_bits_dat; // @[Top.scala 243:21]
  assign wb_dmem_host_io_wbSlaveReceiver_bits_err = switch_io_hostOut_bits_err; // @[Top.scala 243:21]
  assign wb_dmem_host_io_reqIn_valid = core_io_dmemReq_valid; // @[Top.scala 235:25]
  assign wb_dmem_host_io_reqIn_bits_addrRequest = core_io_dmemReq_bits_addrRequest; // @[Top.scala 235:25]
  assign wb_dmem_host_io_reqIn_bits_dataRequest = core_io_dmemReq_bits_dataRequest; // @[Top.scala 235:25]
  assign wb_dmem_host_io_reqIn_bits_activeByteLane = core_io_dmemReq_bits_activeByteLane; // @[Top.scala 235:25]
  assign wb_dmem_host_io_reqIn_bits_isWrite = core_io_dmemReq_bits_isWrite; // @[Top.scala 235:25]
  assign wb_dmem_slave_io_wbSlaveTransmitter_ready = 1'h1; // @[Top.scala 245:53]
  assign wb_dmem_slave_io_wbMasterReceiver_valid = switch_io_devOut_1_valid; // @[Top.scala 246:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_cyc = switch_io_devOut_1_bits_cyc; // @[Top.scala 246:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_stb = switch_io_devOut_1_bits_stb; // @[Top.scala 246:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_we = switch_io_devOut_1_bits_we; // @[Top.scala 246:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_adr = switch_io_devOut_1_bits_adr; // @[Top.scala 246:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_dat = switch_io_devOut_1_bits_dat; // @[Top.scala 246:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_sel = switch_io_devOut_1_bits_sel; // @[Top.scala 246:54]
  assign wb_dmem_slave_io_rspIn_valid = dmem_io_rsp_valid; // @[Top.scala 238:26]
  assign wb_dmem_slave_io_rspIn_bits_dataResponse = dmem_io_rsp_bits_dataResponse; // @[Top.scala 238:26]
  assign wb_dmem_slave_io_rspIn_bits_error = 1'h0; // @[Top.scala 238:26]
  assign wb_gpio_slave_io_wbSlaveTransmitter_ready = 1'h1; // @[Top.scala 245:53]
  assign wb_gpio_slave_io_wbMasterReceiver_valid = switch_io_devOut_0_valid; // @[Top.scala 246:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_cyc = switch_io_devOut_0_bits_cyc; // @[Top.scala 246:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_stb = switch_io_devOut_0_bits_stb; // @[Top.scala 246:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_we = switch_io_devOut_0_bits_we; // @[Top.scala 246:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_adr = switch_io_devOut_0_bits_adr; // @[Top.scala 246:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_dat = switch_io_devOut_0_bits_dat; // @[Top.scala 246:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_sel = switch_io_devOut_0_bits_sel; // @[Top.scala 246:54]
  assign wb_gpio_slave_io_rspIn_valid = gpio_io_rsp_valid; // @[Top.scala 254:26]
  assign wb_gpio_slave_io_rspIn_bits_dataResponse = gpio_io_rsp_bits_dataResponse; // @[Top.scala 254:26]
  assign wb_gpio_slave_io_rspIn_bits_error = gpio_io_rsp_bits_error; // @[Top.scala 254:26]
  assign dmem_clock = clock;
  assign dmem_reset = reset;
  assign dmem_io_req_valid = wb_dmem_slave_io_reqOut_valid; // @[Top.scala 237:27]
  assign dmem_io_req_bits_addrRequest = wb_dmem_slave_io_reqOut_bits_addrRequest; // @[Top.scala 237:27]
  assign dmem_io_req_bits_dataRequest = wb_dmem_slave_io_reqOut_bits_dataRequest; // @[Top.scala 237:27]
  assign dmem_io_req_bits_activeByteLane = wb_dmem_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 237:27]
  assign dmem_io_req_bits_isWrite = wb_dmem_slave_io_reqOut_bits_isWrite; // @[Top.scala 237:27]
  assign imem_clock = clock;
  assign imem_reset = reset;
  assign imem_io_req_valid = wb_imem_slave_io_reqOut_valid; // @[Top.scala 227:27]
  assign imem_io_req_bits_addrRequest = wb_imem_slave_io_reqOut_bits_addrRequest; // @[Top.scala 227:27]
  assign imem_io_req_bits_isWrite = wb_imem_slave_io_reqOut_bits_isWrite; // @[Top.scala 227:27]
  assign imem_io_writeEnable = io_rx_we_i; // @[Top.scala 220:23]
  assign imem_io_addrIn = io_rx_addr_i; // @[Top.scala 221:18]
  assign imem_io_dataIn = io_rx_wdata_i; // @[Top.scala 222:18]
  assign gpio_clock = clock;
  assign gpio_reset = reset;
  assign gpio_io_req_valid = wb_gpio_slave_io_reqOut_valid; // @[Top.scala 253:27]
  assign gpio_io_req_bits_addrRequest = wb_gpio_slave_io_reqOut_bits_addrRequest; // @[Top.scala 253:27]
  assign gpio_io_req_bits_dataRequest = wb_gpio_slave_io_reqOut_bits_dataRequest; // @[Top.scala 253:27]
  assign gpio_io_req_bits_activeByteLane = wb_gpio_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 253:27]
  assign gpio_io_req_bits_isWrite = wb_gpio_slave_io_reqOut_bits_isWrite; // @[Top.scala 253:27]
  assign gpio_io_cio_gpio_i = io_gpio_i; // @[Top.scala 258:22]
  assign wbErr_clock = clock;
  assign wbErr_reset = reset;
  assign wbErr_io_wbMasterReceiver_valid = switch_io_devOut_2_valid; // @[Top.scala 249:34]
  assign wbErr_io_wbMasterReceiver_bits_cyc = switch_io_devOut_2_bits_cyc; // @[Top.scala 249:34]
  assign wbErr_io_wbMasterReceiver_bits_stb = switch_io_devOut_2_bits_stb; // @[Top.scala 249:34]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_dmemRsp_valid = wb_dmem_host_io_rspOut_valid; // @[Top.scala 236:19]
  assign core_io_dmemRsp_bits_dataResponse = wb_dmem_host_io_rspOut_bits_dataResponse; // @[Top.scala 236:19]
  assign core_io_imemReq_ready = wb_imem_host_io_reqIn_ready; // @[Top.scala 225:25]
  assign core_io_imemRsp_valid = wb_imem_host_io_rspOut_valid; // @[Top.scala 226:19]
  assign core_io_imemRsp_bits_dataResponse = wb_imem_host_io_rspOut_bits_dataResponse; // @[Top.scala 226:19]
  assign switch_io_hostIn_valid = wb_dmem_host_io_wbMasterTransmitter_valid; // @[Top.scala 242:20]
  assign switch_io_hostIn_bits_cyc = wb_dmem_host_io_wbMasterTransmitter_bits_cyc; // @[Top.scala 242:20]
  assign switch_io_hostIn_bits_stb = wb_dmem_host_io_wbMasterTransmitter_bits_stb; // @[Top.scala 242:20]
  assign switch_io_hostIn_bits_we = wb_dmem_host_io_wbMasterTransmitter_bits_we; // @[Top.scala 242:20]
  assign switch_io_hostIn_bits_adr = wb_dmem_host_io_wbMasterTransmitter_bits_adr; // @[Top.scala 242:20]
  assign switch_io_hostIn_bits_dat = wb_dmem_host_io_wbMasterTransmitter_bits_dat; // @[Top.scala 242:20]
  assign switch_io_hostIn_bits_sel = wb_dmem_host_io_wbMasterTransmitter_bits_sel; // @[Top.scala 242:20]
  assign switch_io_devIn_0_bits_ack = wb_gpio_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 245:53]
  assign switch_io_devIn_0_bits_dat = wb_gpio_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 245:53]
  assign switch_io_devIn_0_bits_err = wb_gpio_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 245:53]
  assign switch_io_devIn_1_bits_ack = wb_dmem_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 245:53]
  assign switch_io_devIn_1_bits_dat = wb_dmem_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 245:53]
  assign switch_io_devIn_1_bits_err = wb_dmem_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 245:53]
  assign switch_io_devIn_2_bits_dat = wbErr_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 248:33]
  assign switch_io_devIn_2_bits_err = wbErr_io_wbSlaveTransmitter_bits_err; // @[Top.scala 248:33]
  assign switch_io_devSel = switch_io_devSel_addr_hit_0 ? switch_io_devSel_id_0 : _switch_io_devSel_T; // @[Mux.scala 98:16]
endmodule
