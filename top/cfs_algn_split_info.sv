///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_split_info.sv
// Author:      Nithin D S
// Date:        2026-03-25
// Description: transactions class for the align model for split function usage 
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_SPLIT_INFO_SV
	`define CFS_ALGN_SPLIT_INFO_SV

class cfs_algn_split_info extends uvm_object;
	
  //value of CTRL.OFFSET
  int unsigned ctrl_offset;
  
  //value of CTRL.SIZE
  int unsigned ctrl_size;
  
  //value of the MD transaction offset\
  int unsigned md_offset;
  
  //value of the MD transaction size
  int unsigned md_size;
  
  //number of bytes needed during the split
  int unsigned num_byte_needed;
  
  `uvm_object_utils(cfs_algn_split_info)
  
  function new(string name ="");
    super.new(name);
  endfunction
  
  
endclass
`endif
