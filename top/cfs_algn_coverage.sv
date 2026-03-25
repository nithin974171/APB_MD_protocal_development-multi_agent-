///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_coverage.sv
// Author:      nithin D S
// Date:        2026-03-25
// Description: coverage for specific feature coverage (split feature)
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_COVERAGE_SV
	`define CFS_ALGN_COVERAGE_SV

`uvm_analysis_imp_decl(_in_split_info)

class cfs_algn_coverage extends uvm_component implements uvm_ext_reset_handler;
  
  covergroup split_info with function sample(cfs_algn_split_info info);
    option.per_instance = 1;
    
    ctrl_offset : coverpoint info.ctrl_offset {
    	option.comment = "value of ctrl.offset";
      bins value[] = {[0:3]};
    }
    
    ctrl_size : coverpoint info.ctrl_size {
    	option.comment = "value of ctrl.size";
      bins value[] = {[1:4]};
    }
    
    md_offset : coverpoint info.md_offset {
    	option.comment = "value of md offset";
      bins value[] = {[0:3]};
    }
    
    md_size : coverpoint info.md_size {
    	option.comment = "value of md size";
      bins value[] = {[1:4]};
    }
    
    num_byte_needed : coverpoint info.num_byte_needed {
    	option.comment = "value of md offset";
      bins value[] = {[1:3]};
    }
    
    all : cross ctrl_offset, ctrl_size, md_offset, md_size, num_byte_needed {
      ignore_bins ignore_ctrl = (binsof(ctrl_offset) intersect {0} && binsof(ctrl_size) intersect {3}) ||
      							(binsof(ctrl_offset) intersect {1} && binsof(ctrl_size) intersect {2, 3 ,4}) ||
      							(binsof(ctrl_offset) intersect {2} && binsof(ctrl_size) intersect {3 , 4}) ||
      							(binsof(ctrl_offset) intersect {3} && binsof(ctrl_size) intersect {2 , 3 ,4});
      //TODO 	other combination should be ignored from this cross 
    }
  endgroup

  `uvm_component_utils(cfs_algn_coverage)
  
 uvm_analysis_imp_in_split_info#(cfs_algn_split_info,cfs_algn_coverage) port_in_split_info;

   function new(string name = "",uvm_component parent);
    super.new(name,parent);
    port_in_split_info = new("port_in_split_info",this);
     split_info = new();
  endfunction
  
  virtual function void handle_reset(uvm_phase phase);
  	
  endfunction
  
  virtual function void write_in_split_info(cfs_algn_split_info info);
    split_info.sample(info);
  	endfunction
  
  
    virtual function string coverage2string();
        string result = {
          $sformatf("\n      ctrl_offset:          %03.2f%%", split_info.ctrl_offset.get_inst_coverage()),
          $sformatf("\n      ctrl_size:            %03.2f%%", split_info.ctrl_size.get_inst_coverage()),
          $sformatf("\n      md_offset:            %03.2f%%", split_info.md_offset.get_inst_coverage()),
          $sformatf("\n      md_size:              %03.2f%%", split_info.md_size.get_inst_coverage()),
          $sformatf("\n      num_byte_needed:	   %03.2f%%", split_info.num_byte_needed.get_inst_coverage()),
          $sformatf("\n      all:			       %03.2f%%", split_info.all.get_inst_coverage())

        };

        return result;
      endfunction
    
    virtual function void report_phase(uvm_phase phase);
      super.report_phase(phase);
      
      //IMP don't do this in real project
      `uvm_info("COVERAGE",$sformatf("coverage: %0s",coverage2string()),UVM_DEBUG)
    endfunction
endclass
`endif
