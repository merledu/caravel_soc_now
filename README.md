# Soc Now 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

# SoC-Now Google SKY130 Shuttle
### SoC-Now is a CHISEL based SoC. It has RV32I ISA support, 32 GPIO pins and UART to program the SoC. 

SoC-Now is a CHISEL-based SoC Generator with a Web-Application for generating SoC with your required configurations.

SoC-Now is implemented in chisel and all the components of SoC has generic interface which can be easily attached and form any System on Chip (SoC) by using [Jigsaw](https://github.com/talha-ahmed-1/jigsaw) framework and it also depends upon [Caravan](https://github.com/merledu/caravan). It uses [NucleusRV](https://github.com/merledu/nucleusrv) core.

#### Jigsaw
Jigsaw aims to be a helpful utility that provides the designers with pre-made useful peripherals + other ip blocks that provides re-usability and agile development of System On Chips.

#### Caravan
Caravan intends to be equipped with a fully fledged API for easily creating open source bus protocols in Chisel based designs.

## Full Scope of SoC-Now Generator
- There will be parameters to select the extensions, which will be included in core.
    - Integer (I) extension will be the base extension
    - Multiplication (M) extension will be optional
    - Floating-Point (F) extension will be optional
    - Compressed (C) extenison will be optional
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

