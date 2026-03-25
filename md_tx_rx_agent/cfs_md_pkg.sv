///////////////////////////////////////////////////////////////////////////////
// File:        cfs_md_pkg.sv
// Author:      Nithin D S
// Date:        2026-02-22
// Description: MD Agent package.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_MD_PKG_SV
  `define CFS_MD_PKG_SV

  `include "uvm_macros.svh"

  `include "../top/uvm_ext_pkg.sv"

  `include "cfs_md_if.sv"

  package cfs_md_pkg;

    import uvm_pkg::*;
    import uvm_ext_pkg::*;

    //MD response
    typedef enum bit {CFS_MD_OKAY = 0, CFS_MD_ERR = 1} cfs_md_response;
	
	`include "cfs_md_item_base.sv"
	`include "cfs_md_item_drv.sv"
	`include "cfs_md_item_drv_master.sv"
	`include "cfs_md_item_drv_slave.sv"	
  	`include "cfs_md_item_mon.sv" 
   `include "cfs_md_agent_config.sv"
	`include "cfs_md_agent_config_slave.sv"
	`include "cfs_md_agent_config_master.sv"
	`include "cfs_md_coverage.sv"	
   `include "cfs_md_sequencer_base.sv"
	`include "cfs_md_sequencer_base_master.sv"
	`include "cfs_md_sequencer_base_slave.sv"
	`include "cfs_md_sequencer_slave.sv"
	`include "cfs_md_driver.sv"
	`include "cfs_md_driver_master.sv"
	`include "cfs_md_driver_slave.sv"
	`include "cfs_md_agent.sv"
	`include "cfs_md_agent_slave.sv"
	`include "cfs_md_agent_master.sv"
	`include "cfs_md_sequence_base.sv"
	`include "cfs_md_sequence_base_slave.sv"
	`include "cfs_md_sequence_base_master.sv"
	`include "cfs_md_sequence_simple_master.sv"
	`include "cfs_md_sequence_simple_slave.sv"
	`include "cfs_md_sequence_slave_response.sv"
   endpackage

`endif

