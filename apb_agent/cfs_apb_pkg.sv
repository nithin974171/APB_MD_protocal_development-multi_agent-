///////////////////////////////////////////////////////////////////////////////
// File:        cfs_apb_pkg.sv
// Author:      Nithin D S
// Date:        2026-02-25
// Description: APB Agent package.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_APB_PKG_SV
  `define CFS_APB_PKG_SV

  `include "uvm_macros.svh"

  `include "../top/uvm_ext_pkg.sv"

  `include "cfs_apb_if.sv"

  package cfs_apb_pkg;
    import uvm_pkg::*;
    import uvm_ext_pkg::*;

    //Virtual interface type
    typedef virtual cfs_apb_if cfs_apb_vif;

    //APB direction
    typedef enum bit {CFS_APB_READ = 0, CFS_APB_WRITE = 1} cfs_apb_dir;

    //APB address
    typedef bit[`CFS_APB_MAX_ADDR_WIDTH-1:0] cfs_apb_addr;

    //APB data
    typedef bit[`CFS_APB_MAX_DATA_WIDTH-1:0] cfs_apb_data;

    //APB response
  typedef enum bit {CFS_APB_OKAY = 0, CFS_APB_ERR = 1} cfs_apb_response;

`include "cfs_apb_item_base.sv" 
`include "cfs_apb_item_drv.sv"
`include "cfs_apb_item_mon.sv"
`include "cfs_apb_agent_config.sv"
`include "cfs_apb_monitor.sv"
`include "cfs_apb_coverage.sv"  
`include "cfs_apb_driver.sv"
`include "cfs_apb_agent.sv"
`include "cfs_apb_sequence_base.sv"
`include "cfs_apb_sequence_simple.sv"
`include "cfs_apb_reg_adapter.sv"
 
endpackage

`endif
