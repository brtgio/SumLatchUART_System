# UART 4 BIT LATCH ALU

- ![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg)

- [Read the documentation for project](docs/info.md)

## Project Description

The UART 4-BIT LATCH ALU is a digital system designed to reduce the number of inputs required for input data and minimize the number of outputs needed to obtain the output data. It comprises:

1. Dual 4-Bit Latch.
2. 4-Bit ALU.
3. UART Transmitter.

With these components, the system is capable of receiving data using 4 bits for two operands, which leaves room for using 4 bits to select which operation it's going to perform by the ALU. The output is driven by an 8-bit UART transmitter, which reduces the number of output bits needed to obtain the operation result. The data can be read using any UART interface, which is common among microcontrollers or other standalone UART interfaces.

## Block diagram
<p align="center">
  <img src="4-BIT%20UART%20ALU.svg" alt="4-BIT UART ALU" width="1700">
</p>

## Input and Output Description

| Pin Name   | Direction | Bit Number | Description                               |
|------------|-----------|------------|-------------------------------------------|
| clk        | Input     |            | Clock signal input                        |
| reset_n    | Input     |            | Reset signal input                        |
| data_input | Input     | [3:0]      | Input data to the ALU                     |
| save_a_n   | Input     |            | Save to latch A                           |
| save_b_n   | Input     |            | Save to latch B                           |
| OP_SELECT  | Input     | [3:0]      | Operation select input                    |
| uart_tx_en | Input     | [7:0]      | UART transmitter enable                   |
| uart_txd   | Output    |            | UART transmitter data output signal       |
| uartbusy   | Output    |            | UART busy indicator signal                |


## Design Components

### Dual 4-Bit Latch
<p align="center">
  <img src="dual%20four%20bit%20latch.svg" alt="Dual Four Bit Latch" width="850">
</p>

This module serves as a 4-bit dual latch system, designed to capture and retain input data on the rising edge of the clock signal (clk). Upon activation of the save_a_n signal, data is stored in latch A, providing a mechanism for temporary data storage. Similarly, when the save_b_n signal is triggered, the module saves data in latch B, facilitating independent data storage in two separate registers. If both save signals are activated simultaneously, no data will be saved due to the NAND design which triggers the multiplexers.

In the event of a reset condition, indicated by the reset_n signal, both latches are cleared, causing the stored data to be reset to zero. It's essential to note that the use of D-type flip-flops for data storage ensures data integrity during normal operation. However, as with most volatile memory elements, data stored in the latches is lost upon power-off, as the memory contents are not persistent.
#### Simulation

Simulation was conducted using Quartus Prime Lite software, employing a 50 MHz clock with a 20 ns period for the clk signal. The remaining signals were simulated with random values.
<center>

<img src="dual_four_bit_latch_sim.JPG" alt="Dual Four Bit Latch Simulation" width="1000" />
As observed in the simulation, when the reset_n signal is high, the output q_a and q_b transition to zero, indicating that the registers have been cleared. Additionally, we can observe how values change in memory when save_a_n or save_b_n are triggered.

</center>

### UART (Universal Asynchronous Receiver/Transmitter)
<p align="center">
  <img src="uart.svg" alt="uart" width="3000">
</p>

UART is a communication protocol that operates asynchronously, eliminating the need for both devices to share a common clock signal. Instead, it relies on individual clocks on each device to synchronize data transmission. This simplicity allows UART to require only two cables: one for transmitting data (Tx) and another for receiving data. However, for successful communication, both devices must operate at the same baud rate, ensuring that data is transmitted and received at the correct speed.


In this project, a UART is only used to transmit the ALU operation result to a compatible UART device. This allows us to maintain the output with the least amount of pins, due to the constraints of the TinyTapeout template. This UART transmitter replaces two 7-segment displays, which would require 14 pins to be driven. With this transmitter, we reduce it to two signals: one to indicate if the UART is sending data, and one for the Tx signal. Our UART transmiter operates at a 9600 baudrate wich is a really coman badrate amoung UART capable devices. This UART implementation is based on ben-marshall uart project.

### Arithmetic Logic Unit (ALU)
<p align="center">
  <img src="alu.svg" alt="ALU" width="1000">
</p>
The ALU (Arithmetic Logic Unit) performs arithmetic and logical operations on 4-bit data. It is designed using regular Verilog supported operators, allowing for various operations to be executed based on the `OP_select` signal.


## Possible Arithmetic Operations

The ALU can perform the following arithmetic and logical operations on input data:

| OP_select | Operation        |
|-----------|------------------|
| 4'b0001   | Addition         |
| 4'b0010   | Signed Subtraction |
| 4'b1110   | Signed Division  |
| 4'b0011   | AND              |
| 4'b0100   | OR               |
| 4'b0101   | XOR              |
| 4'b0110   | Multiplication   |
| 4'b0111   | Left Shift       |
| 4'b1000   | Right Shift      |
| 4'b1001   | Ones' Complement |
| 4'b1010   | Equality         |
| 4'b1011   | Inequality       |
| 4'b1100   | Greater than     |
| 4'b1101   | Less than        |
| default   | Result is 0      |


## Simulation

Simulation is conducted similarly to how we performed the latch simulation. However, this time, we leave reset_n inactive, as triggering it would set the output to zero. For the remainder, we utilize random values to validate various inputs and operations. During simulation, we observe that operations are triggered as intended when the clk signal transitions on its rising edge.
<p align="center">
  <img src="alu_sim.JPG" alt="ALU Simulation" width="1700">
</p>

### Top Module

The top module its designe to instance evry module so each module serves as stage on the way to transmiting the information.

## Testing
Testing was conducted using the Terasic DE10-Lite development board with the following hardware configuration:
| Hardware Component       | Description                                               |
|---------------------------|------------------------------------------------------------|
| FPGA                      | MAX 10 10M50DAF484C7G FPGA                                |
| Input Switches            | 10 input switches                                         |
| LED Indicator             | 1 LED for UART busy indicator                             |
| Push Buttons              | 2 push buttons with debouncing using Schmitt Trigger circuit |
| UART Tx Signal            | 1 I/O pin for Tx signal                                   |
| Additional Components     | Arduino Uno as UART receiver                              |






## Resources Employed

- **OpenLane:** Used to automatically compile ASIC files.
- **Verilog:** Hardware description language used to implement the design.
- **Verilog Simulator:** Employed to verify the functionality of the design through simulations.

## What's Next?

- [Submit your design for the next shuttle](https://app.tinytapeout.com/).
- Update [this README](README.md) to provide details about the project's functionality, operation, and testing procedures.
- Share your project on your preferred social media platform:
  - LinkedIn [#UART4BITLATCHALU](https://www.linkedin.com/search/results/content/?keywords=%23UART4BITLATCHALU) [@TinyTapeout](https://www.linkedin.com/company/100708654/)
  - Mastodon [#UART4BITLATCHALU](https://chaos.social/tags/UART4BITLATCHALU) [@matthewvenn](https://chaos.social/@matthewvenn)
  - Twitter [#UART4BITLATCHALU](https://twitter.com/hashtag/UART4BITLATCHALU) [@matthewvenn](https://twitter.com/matthewvenn)
