    Copyright(c) 2022-
    Author: Chaitanya Tejaswi (github.com/CRTejaswi)    License: GPL v3.0+

# CPU Design
> 32-bit CPU Design.

# Implementations

## [v1](v1/): 10 function
__Documentation__: [📄](docs/v1.pdf) <br>
__Reports__: [timing](v1/reports/timing.txt), [power](v1/reports/power.txt) <br>
__Features__: <br>
<img src="v1/files/blockdiagram.png" width="720" title="Block Diagram">

- Register Bank (32): R0-R31.
- No flag register.
- ALU Operations (10): ADD SUB SLL SLT SLTU XOR SRL SRA OR AND.
- Memory-Addressable instructions only (no immediate/conditional instructions).
- Instructions are directly fed by testbench instead of dedicated instruction memory.
- Testbench feeds A,B, and monitors A,B,Y for changes.
- Testbench feeds instruction to decoder which relays I/O info to register bank & control instructions to controller.
- Register bank feeds input to ALU; controller feeds execution logic to ALU. The results are written back to `rd` in register bank.

<img src="v1/files/isa1.png" width="720" title="Instruction Set"><br>
<img src="v1/files/isa2.png" width="720" title="Instruction Set"><br>

__Results__ <br>

<img src="v1/files/schematic1.png" width="720" title="RTL Schematic"><br>
<img src="v1/files/schematic2.png" width="720" title="RTL Schematic"><br>
<img src="v1/files/sim-behavioral.png" width="720" title="Simulation: Testbench Evaluation"><br>
<img src="v1/files/sim1.png" width="720" title="Simulation: SLL, SLT/SLTU<br>, SRL/SRA"><br>
<img src="v1/files/usage1.png" width="720" title="Usage: Power/Timing"><br>
<img src="v1/files/usage2.png" width="720" title="Usage: FPGA"><br>


## [v2](v2/): + pipelining
__Documentation__: [📄](docs/v2.pdf) <br>
__Reports__: [timing](v1/reports/timing.txt), [power](v1/reports/power.txt) <br>



# References
