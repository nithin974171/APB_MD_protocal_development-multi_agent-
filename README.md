# APB MD Protocol – Aligner Verification (UVM Multi-Agent)

# Overview
This project verifies an Aligner DUT that converts an unaligned data stream (RX) into an aligned data stream (TX) based on programmable configuration registers.

Control is done via APB interface
Data flow uses a custom MD (Memory Data) protocol
Supports alignment based on SIZE and OFFSET

# DUT Functionality (Aligner)
The Aligner performs:

Accepts unaligned input stream (RX)
* Aligns data based on:
CTRL.SIZE
CTRL.OFFSET
Outputs aligned data via TX interface
Uses:
RX FIFO
TX FIFO
Internal Controller

-> As shown in the datasheet (Page 3 block diagram), data flows:
# Interfaces

# 1. APB Interface (Control Path)

Used to configure DUT registers:

Signal	      Description
PSEL	        Select
PENABLE      	Enable
PWRITE    	  Read/Write
PADDR        	Address
PWDATA      	Write Data
PRDATA      	Read Data
PREADY      	Ready
PSLVERR      	Error

# Notes:
Address is word-aligned (paddr[1:0] ignored)
Max wait states ≤ 5

# MD Protocol (Data Path)
RX Interface (Input)
md_rx_valid
md_rx_data
md_rx_offset
md_rx_size
md_rx_ready
md_rx_err

TX Interface (Output)
md_tx_valid
md_tx_data
md_tx_offset
md_tx_size
md_tx_ready
md_tx_err

# Rule
((DATA_WIDTH/8) + offset) % size == 0   → Valid transfer

# Register Map
# Register	      Offset	          Description
  CTRL	          0x0000	          Config (SIZE, OFFSET)
 STATUS	          0x000C	          FIFO levels, drop count
 IRQEN	          0x00F0	          Interrupt enable
 IRQ	            0x00F4	          Interrupt status

# Control Register (Important)
SIZE → alignment size
OFFSET → alignment offset
CLR → clear drop counter

# Illegal combinations → APB error
 Status Register
 CNT_DROP → invalid transfers count
 RX_LVL → RX FIFO level
 TX_LVL → TX FIFO level

 # Functional Behavior
 Data Alignment
The DUT rearranges incoming data based on configuration.
- > Example (from datasheet Page 10):

SIZE = 1 → byte-wise alignment
SIZE = 2 → half-word alignment
SIZE = 4 → word alignment
 -> Flow Control
RX Side
- > If FIFO full → md_rx_ready = 0
Invalid transfer → md_rx_err = 1
- > TX Side
Data sent only when md_tx_ready = 1

# Interrupts
- > Generated for:
RX FIFO empty/full
TX FIFO empty/full
Drop counter max

# Verification Architecture (UVM)

tb_architecture_of_project.png

Components
 -> RX Agent
Drives MD RX transactions
Handles:
Offset
Size
Valid/Ready handshake
 -> TX Agent
Monitors aligned output
Captures:
Data
Offset
Size
  -> APB Agent
Drives register configuration
Reads status/interrupts

# Scoreboard

Expected data → derived from RX stream + config
Actual data → captured from TX monitor
Comparison:
Expected Queue  vs  Actual Queue
-> Validates:
Alignment correctness
Order preservation
Data integrity

# TEST Scenarios
-> Basic
Register Read/Write
Single RX → TX transfer
->  Alignment
SIZE = 1, 2, 4
OFFSET variations
-> Error Cases
Invalid (offset, size)
Register illegal access
-> Stress
Random traffic
Back-to-back transfers
FIFO full/empty
-> Interrupt Testing
RX/TX FIFO conditions
Drop counter max
