# RISC-V_32IM: A SystemVerilog Implementation of RISC-V Single Cycle CPU

![RISC-V Logo](https://www.riscv.org/wp-content/uploads/2019/09/cropped-RISC-V_Logo.png)

## Table of Contents
- [RISC-V\_32IM: A SystemVerilog Implementation of RISC-V Single Cycle CPU](#risc-v_32im-a-systemverilog-implementation-of-risc-v-single-cycle-cpu)
  - [Table of Contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Objectives](#objectives)
  - [Technology Stack](#technology-stack)
  - [System Features](#system-features)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Planned Enhancements](#planned-enhancements)
  - [License](#license)
  - [Acknowledgements](#acknowledgements)
---

## Project Overview

The **RISC-V_32IM** project represents a comprehensive effort to develop a fully functional single-cycle CPU based on the RISC-V Instruction Set Architecture (ISA). This project is designed to deepen my understanding of SystemVerilog, computer architecture, and hardware verification techniques while providing hands-on experience in creating production-ready intellectual property (IP) components that meet industrial standards.

## Objectives

- **Develop a RISC-V compliant single cycle CPU** that successfully implements the integer and multiplication instruction set specified by the official RISC-V organization.
- **Lay the groundwork for future developments** 
  - 5-stage pipeline architecture
  - Tomasulo algorithm for OoO execution
  - Re-order Buffer (RoB) for in-order commits
  - TAGE branch predictor
- **Enhance proficiency in SystemVerilog**, focusing on design and verification methodologies that are relevant in industry settings.

## Technology Stack

- **Language:** SystemVerilog
- **Simulation Tools:** Vivado 2024.1
- **Synthesis Tools:** Xilinx Vivado
- **Linter:** xvlog

## System Features

- **Single Cycle Execution:** Each instruction is completed in one clock cycle, providing a straightforward simulation of RISC-V operations.
- **Instruction Set Implementation:** Full support for the RISC-V 32I integer instruction set, including R-type, I-type, and control flow instructions.
- **Modular Design:** Utilizes a modular architecture to facilitate easy modifications and extensions to the CPU.
- **Verification Environment:** A robust testbench designed for comprehensive functional verification of the CPU.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- A SystemVerilog simulator (e.g., ModelSim or Verilator)
- Git to download repo

### Installation

1. Clone the repository to your local machine using the following command:
   ```bash
   git clone https://github.com/kalmaniii/RISC-V_32IM.git
   ```

2. Open your preferred simulator and set up the project by pointing it to the cloned directory.

## Planned Enhancements

- **5-Stage Pipelined CPU:** Future iterations will incorporate a 5-stage pipeline architecture to improve instruction throughput.
- **Extended Instruction Set Support:** Investigating the implementation of additional RISC-V extensions and custom instructions.
- **Performance Optimization:** Analyze and optimize resource utilization and clock cycles for enhanced performance.

## License

This project is licensed under the GPL License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

Special thanks to the RISC-V Foundation for the specifications and guidelines that helped shape this project. Acknowledgments also extend to the open-source community for their invaluable resources and tools.

* [Digital Design & Comp Arch - Lecture 10: Microarchitecture Fudamental and Design](https://www.youtube.com/watch?v=SX2xMDV2lAA&list=PL5Q2soXY2Zi-EImKxYYY1SZuGiOAOBKaf&index=13) by Onur Mutlu. Mar 24, 2023.
   
    
   
   
Thank you for your interest in the RISC-V_32I project! Your support and engagement are greatly appreciated.