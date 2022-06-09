# Soc Now 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

# SoC-Now Google SKY130 Shuttle
### SoC-Now is a CHISEL based SoC. It has RV32I ISA support, 32 GPIO pins and UART to program the SoC. 
![image](https://user-images.githubusercontent.com/52505840/172834779-152d220e-06a2-4419-8650-636f324d3d3a.png)

## GDS
![image](https://user-images.githubusercontent.com/52505840/172838414-5f9890b0-d31c-49a0-846c-013d76b066c9.png)

## Design Hierarchy
The emitted verilog is present here.
```
verilog/
├── rtl
│   ├──Top.V
│   ├──iccm_controler.V
│   ├──prog_uart_top.V
│   ├──programmer.V
│   ├──sky130_sram_1kbyte_1rw1r_32x256_8.v
│   ├──uart_rx_prog.v

```
The synthesized netlist is present here:
```
verilog/
├── gl
│   └── soc_now_caravel_top.v
```
The hardened macros are placed here:
```
def/
└── soc_now_caravel_top.def
```
```
lef/
└── soc_now_caravel_top.lef
```
```
gds/
└── soc_now_caravel_top.gds
```


SoC-Now is a CHISEL based SoC Generator with a Web-Application for generating SoC with your required configurations.

SoC-Now is implemented in chisel and all the components of SoC has generic interface which can be easily attached and form any System on Chip (SoC) by using [Jigsaw](https://github.com/talha-ahmed-1/jigsaw) framework and it also depends upon [Caravan](https://github.com/merledu/caravan). It uses [NucleusRV](https://github.com/merledu/nucleusrv) core.

#### Jigsaw
Jigsaw aims to be a helpful utility that provides the designers with pre-made useful peripherals + other ip blocks that provides re-usability and agile development of System On Chips.

#### Caravan
Caravan intends to be equipped with a fully fledged API for easily creating open source bus protocols in Chisel based designs.

## Full Scope of SoC-Now Generator
- There will be parameters to select the extensions, which will be included in core.
    - (I) Integer extension will be the base extension
    - (M) Multiplication extension will be optional
    - (F) Floating-Point extension will be optional
    - (C) Compressed extenison will be optional
- There will be parameters to select device(s) as well, to include in the SoC (any one or all can be selected). The list of devices are as follows.
    - GPIO
    - UART
    - SPI
    - SPI-Flash
    - TIMER
    - I2C
- There will be parameters to select Bus Architecture which will be the communication medium within the SoC. The choices for Bus Architecture are:
    - Tilelink Uncached (TL-UL)
    - Wishbone
    - Tilelink Cache (TL-C)

## Contributors
Main contributors are:
1. Usman Zain (RTL Design based on CHISEL)
2. Talha Ahmed (RTL Design based on CHISEL)
3. Muhammad Shahzaib (RTL Design based on CHISEL)
4. Shahzaib Kashif (RTL Design based on CHISEL)
5. Nimra Khan (APR flow with Cadence and OpenLane RTL-GDSII)
