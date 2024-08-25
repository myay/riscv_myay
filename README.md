RV32I processor implementation.

Required:
- Verilator
- GTKWave

Run testbenches with
`./run_tb.sh <component_name>`
e.g.
`./run_tb.sh riscvsc_top`.

Supported instructions:
- R-type: add, sub, and, or, slt
- Memory: lw, sw
- Branches: beq

TODOs:
- Register reset
