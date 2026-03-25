///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_virtual_sequencer.sv
// Author:      Nithin D S
// Date:        2026-03-25
// Description: virtual sequencer defined by p_seqr with created 3 seqr of 2 agent with model
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_VIRTUAL_SEQUENCER_SV
	`define CFS_ALGN_VIRTUAL_SEQUENCER_SV

class cfs_algn_virtual_sequencer extends uvm_sequencer;
	
  //refernce to the APB sequencer
  uvm_sequencer_base apb_sequencer;
  
  //reference to the RX seqr
  cfs_md_sequencer_base_master md_rx_sequencer;
  
  //refernce to the MD TX Seqr
  cfs_md_sequencer_base_slave md_tx_sequencer;
  
  //reference to the model
  cfs_algn_model model;
  
  `uvm_component_utils(cfs_algn_virtual_sequencer)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
endclass

`endif
