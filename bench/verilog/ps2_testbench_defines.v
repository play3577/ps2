//////////////////////////////////////////////////////////////////////
////                                                              ////
////  ps2_testbench_defines.v                                     ////
////                                                              ////
////  This file is part of the "ps2" project                      ////
////  http://www.opencores.org/cores/ps2/                         ////
////                                                              ////
////  Author(s):                                                  ////
////      - mihad@opencores.org                                   ////
////      - Miha Dolenc                                           ////
////                                                              ////
////  All additional information is avaliable in the README.txt   ////
////  file.                                                       ////
////                                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Miha Dolenc, mihad@opencores.org          ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.1.1.1  2002/02/18 16:16:56  mihad
// Initial project import - working
//
//

//===================================================================================
//  User-unchangeable testbench defines (constants)
//===================================================================================

// setup and hold time definitions for WISHBONE - used in BFMs for signal generation
`define Tsetup 2
`define Thold  2

// how many clock cycles should model wait for design's response - integer 32 bit value
`define WAIT_FOR_RESPONSE 6

// maximum number of transactions allowed in single call to block or cab transfer routines
`define MAX_BLK_SIZE  8

// maximum retry terminations allows for WISHBONE master to repeat an access
`define WB_TB_MAX_RTY 1000


// some common types and defines
`define WB_ADDR_WIDTH 32
`define WB_DATA_WIDTH 32
`define WB_SEL_WIDTH `WB_DATA_WIDTH/8
`define WB_TAG_WIDTH 1
`define WB_ADDR_TYPE [(`WB_ADDR_WIDTH - 1):0]
`define WB_DATA_TYPE [(`WB_DATA_WIDTH - 1):0]
`define WB_SEL_TYPE  [(`WB_SEL_WIDTH  - 1):0]
`define WB_TAG_TYPE  [(`WB_TAG_WIDTH  - 1):0]

// definitions file only for testbench usage
// wishbone master behavioral defines
// flags type for wishbone cycle initialization
`define CYC_FLAG_TYPE [0:0]
// cab flag field in cycle initialization data
`define CYC_CAB_FLAG [0]
// read cycle stimulus - consists of:
//    - address field - which address read will be performed from
//    - sel field     - what byte select value should be
//    - tag field     - what tag values should be put on the bus
`define READ_STIM_TYPE [(`WB_ADDR_WIDTH + `WB_SEL_WIDTH + `WB_TAG_WIDTH - 1):0]
`define READ_STIM_LENGTH (`WB_ADDR_WIDTH + `WB_SEL_WIDTH + `WB_TAG_WIDTH)
`define READ_ADDRESS  [(`WB_ADDR_WIDTH - 1):0]
`define READ_SEL      [(`WB_ADDR_WIDTH + `WB_SEL_WIDTH - 1):`WB_ADDR_WIDTH]
`define READ_TAG_STIM [(`WB_ADDR_WIDTH + `WB_SEL_WIDTH + `WB_TAG_WIDTH - 1):(`WB_ADDR_WIDTH + `WB_SEL_WIDTH)]

// read cycle return type consists of:
//    - read data field
//    - tag field received from WISHBONE
//    - wishbone slave response fields - ACK, ERR and RTY
//    - test bench error indicator (when testcase has not used wb master model properly)
//    - how much data was actually transfered
`define READ_RETURN_TYPE [(32 + 4 + `WB_DATA_WIDTH + `WB_TAG_WIDTH - 1):0]
`define READ_DATA        [(32 + `WB_DATA_WIDTH + 4 - 1):32 + 4]
`define READ_TAG_RET     [(32 + 4 + `WB_DATA_WIDTH + `WB_TAG_WIDTH - 1):(`WB_DATA_WIDTH + 32 + 4)]
`define READ_RETURN_LENGTH (32 + 4 + `WB_DATA_WIDTH + `WB_TAG_WIDTH - 1)

// write cycle stimulus type consists of
//    - address field
//    - data field
//    - sel field
//    - tag field
`define WRITE_STIM_TYPE [(`WB_ADDR_WIDTH + `WB_DATA_WIDTH + `WB_SEL_WIDTH + `WB_TAG_WIDTH - 1):0]
`define WRITE_ADDRESS       [(`WB_ADDR_WIDTH - 1):0]
`define WRITE_DATA          [(`WB_ADDR_WIDTH + `WB_DATA_WIDTH - 1):`WB_ADDR_WIDTH]
`define WRITE_SEL           [(`WB_ADDR_WIDTH + `WB_DATA_WIDTH + `WB_SEL_WIDTH - 1):(`WB_ADDR_WIDTH + `WB_DATA_WIDTH)]
`define WRITE_TAG_STIM      [(`WB_ADDR_WIDTH + `WB_DATA_WIDTH + `WB_SEL_WIDTH + `WB_TAG_WIDTH - 1):(`WB_ADDR_WIDTH + `WB_DATA_WIDTH + `WB_SEL_WIDTH)]

// length of WRITE_STIMULUS
`define WRITE_STIM_LENGTH (`WB_ADDR_WIDTH + `WB_DATA_WIDTH + `WB_SEL_WIDTH + `WB_TAG_WIDTH)

// write cycle return type consists of:
//    - test bench error indicator (when testcase has not used wb master model properly)
//    - wishbone slave response fields - ACK, ERR and RTY
//    - tag field received from WISHBONE
//    - how much data was actually transfered
`define WRITE_RETURN_TYPE [(32 + 4 + `WB_TAG_WIDTH - 1):0]
`define WRITE_TAG_RET     [(32 + 4 + `WB_TAG_WIDTH - 1):32 + 4]

// this four fields are common to both read and write routines return values
`define TB_ERROR_BIT [0]
`define CYC_ACK [1]
`define CYC_RTY [2]
`define CYC_ERR [3]
`define CYC_RESPONSE [3:1]
`define CYC_ACTUAL_TRANSFER [35:4]

// block transfer flags
`define WB_TRANSFER_FLAGS [41:0]
// consists of:
// - number of transfer cycles to perform
// - flag that enables retry termination handling - if disabled, block transfer routines will return on any termination other than acknowledge
// - flag indicating CAB transfer is to be performed - ignored by all single transfer routines
// - number of initial wait states to insert
// - number of subsequent wait states to insert
`define WB_TRANSFER_SIZE     [41:10]
`define WB_TRANSFER_AUTO_RTY [8]
`define WB_TRANSFER_CAB      [9]
`define INIT_WAITS           [3:0]
`define SUBSEQ_WAITS         [7:4]

`define WB_FREQ 0.025
