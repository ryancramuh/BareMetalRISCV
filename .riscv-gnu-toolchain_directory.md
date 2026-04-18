# riscv-gnu-toolchain directory 

 - qemu: RISCV emulator 
 - riscv-binutils: binary utilities 
 - riscv-gcc: the core C compiler 
 - riscv-gdb: the GNU debugger 
 - riscv-glibc: the Posix C standard library 
 - riscv-newlib: the bare-metal standard C libary 

Four ways to test program: 
 1. Behavioral Simulation with RISC-V ISA simualator - SPIKE 
 	- syscall() interface provided in original RISC-V proxy kernel is not comptabible with I/O interfaces provided. Spike can be used to run programs that do not access I/O devices or user mode programs that run ainside the RISC-V Linux. 

 2. RTL simulation: simulate in Verilator ($Top/vsim/) 
 - No I/O devices available in RTL simulation 
 3. FPGA simulation (using Xilinx ISim), behavioral modules for I/O are provided. 
 4. FPGA run: actually program on an FPGA (UART/SD) 
 
Programs run in three different modes: 
 1. Bare metal mode: supervisor programs with no I/O access 
 	- Behavioural and RTL simulation 

 	- no peripheral support. Used for ISA and cache regression tests. 

 	- return value of program indicates the result of an ISA test case. 
 	- 0 is success while non-zero identifies No of the failing case. 
 
 2. Newlib Mode (supervisor programs with access to I/O): 
	- FPGA sim and run 
	- programs have full control (priority) of periperals but are single-threaded (bootloaders run in this mode) 

 3. Linux mode: user programs with Linux support
	- behavioural simulation and FPGA run 
	- Program runs in the RISC-V Linux 

Compiling depends on tools: 
	1. Bare Metal 
		- riscv-gnu-toolchain (newlib), riscv-isa-sim, riscv-fesvr
		- RTL simulation: riscv-gnu-toolchain, verilator 
	2. Newlib mode: 
		- FPGA sim: riscv-gnu-toolchain, Vivado
	3. Linux mode: 
		- riscv-gnu-toolchain, riscv-isa-sim, riscv-fesvr, riscv-pk  
