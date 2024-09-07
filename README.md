# RISC-V_32IM: A RISC-V Single Cycle CPU Implementation

## Project Overview

The **RISC-V_32IM** project represents a comprehensive effort to develop a fully functional single-cycle CPU based on the RISC-V Instruction Set Architecture (ISA). This personal project was started to deepen my understanding of SystemVerilog, computer architecture, and hardware verification techniques while providing hands-on experience in creating production-ready intellectual property (IP) components that meet industry standards.

## Table of Contents
- [RISC-V\_32IM: A RISC-V Single Cycle CPU Implementation](#risc-v_32im-a-risc-v-single-cycle-cpu-implementation)
  - [Project Overview](#project-overview)
  - [Table of Contents](#table-of-contents)
  - [Objectives](#objectives)
  - [Technology Stack](#technology-stack)
  - [System Features](#system-features)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Planned Enhancements](#planned-enhancements)
  - [License](#license)
  - [Acknowledgements](#acknowledgements)
  - [Disclaimer](#disclaimer)
---


## Objectives

- **Develop a RISC-V compliant single-cycle CPU:** Successfully implements the integer and multiplication instruction sets specified by the official RISC-V organization.
- **Lay the groundwork for future developments**:
  - 5-stage pipeline architecture
  - Tomasulo algorithm for out-of-order (OoO) execution
  - Re-order Buffer (RoB) for in-order commits
  - TAGE branch predictor
- **Enhance proficiency in SystemVerilog:** Focusing on design and verification methodologies that are relevant in industry settings.

## Technology Stack

- **Language:** SystemVerilog
- **Simulation Tools:** Vivado 2024.1
- **Synthesis Tools:** Xilinx Vivado
- **Linter:** xvlog

## System Features
 
- **Modular Design:** Utilizes a modular architecture to facilitate easy modifications and extensions to the CPU.
- **Verification Environment:** A simple application to stimulate the CPU with a clk and rst.
- **Integer and Multiplication Instruction Set Implementation:** A work-in-progress as of 9/7/2024.
- **Single Cycle Execution:** Each implemented instruction is completed in one clock cycle, providing a straightforward simulation of RISC-V operations.

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
3. Replace ```instructions.mem``` file with your hex dump assembly code.
4. Run ```simulate_cpu.sv``` to view the CPU output.

## Planned Enhancements

- **5-Stage Pipelined CPU:** Future iterations will incorporate a 5-stage pipeline architecture to improve instruction throughput.
- **Tomasulo Algorithm:** Reservation stations, functional units, and a Common Data Bus (CDB) for OoO.
- **Re-order Buffer (RoB):** Buffer to provide in-order commits.
- **TAGE Branch Predictor:** A 5-component TAGE predictor to help branch stalls. 

## License

This project is licensed under the GPL License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

Special thanks to the RISC-V Foundation for the specifications and guidelines that helped shape this project. Acknowledgments also extend to the open-source community for their invaluable resources and tools.

* [Digital Design & Comp Arch - Lecture 10: Microarchitecture Fudamental and Design](https://www.youtube.com/watch?v=SX2xMDV2lAA&list=PL5Q2soXY2Zi-EImKxYYY1SZuGiOAOBKaf&index=13) by Onur Mutlu, March 24, 2023.


Thank you for your interest in the RISC-V_32IM project! Your support and engagement are greatly appreciated.

## Disclaimer
This is not an official RISC-V product.
