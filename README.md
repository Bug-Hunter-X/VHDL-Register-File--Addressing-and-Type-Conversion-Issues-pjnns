# VHDL Register File Bug

This repository contains a VHDL implementation of a register file and demonstrates a potential bug related to address range handling and type conversion.  The bug is subtle and might not be immediately apparent.

## Description
The code implements a simple register file with a generic address width. The issue arises from the way addresses are handled during both writes and reads.  Potentially incorrect unsigned conversion from std_logic_vector to integer might cause issues. 

## Bug
The main issue is the lack of robust error handling.  If the address exceeds the valid range, the code could exhibit undefined behavior.  This becomes particularly important during simulation or synthesis depending on the tool's handling of out-of-bounds array accesses.

## Solution
The solution involves adding explicit checks to ensure address values remain within the valid bounds of the register array.  The solution also implements improved type conversions and potentially adds error handling.

## How to Reproduce
1. Clone this repository.
2. Compile and simulate the VHDL code using your preferred simulator (e.g., ModelSim, GHDL).
3.  Observe the behavior when addresses outside the valid range (0 to 2**address_width - 1) are used.

## Mitigation and Prevention
- Always add range checks to prevent out-of-bounds errors.
- Utilize VHDL's built-in type conversion functions carefully.
- Implement thorough testing to uncover unexpected behavior.
