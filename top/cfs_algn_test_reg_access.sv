///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_test_reg_access.sv
// Author:      Nithin D S 
// Date:        2026-03-24
// Description: Register access test. It targets APB accesses to the registers
//              of the Aligner module.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_TEST_REG_ACCESS_SV
  `define CFS_ALGN_TEST_REG_ACCESS_SV

  class cfs_algn_test_reg_access extends cfs_algn_test_base;
    
    int unsigned num_reg_accesses;
    int unsigned num_unmapped_accesses;

    `uvm_component_utils(cfs_algn_test_reg_access)
    
    function new(string name = "", uvm_component parent);
      super.new(name, parent);
      num_reg_accesses = 100;
      num_unmapped_accesses = 100;
    endfunction
    
    virtual task run_phase(uvm_phase phase);
      uvm_status_e status;
      uvm_reg_data_t data;
      
      phase.raise_objection(this, "TEST_DONE");
      
      #(100ns);
      
//       repeat(2) begin
//         cfs_md_sequence_simple_master seq_simple = cfs_md_sequence_simple_master::type_id::create("seq_simple");
//         seq_simple.set_sequencer(env.md_rx_agent.sequencer);

//         void'(seq_simple.randomize() with {
//           item.data.size() == 3;
//           item.offset      == 0;
//         });

//         seq_simple.start(env.md_rx_agent.sequencer);
//       end
      
//       //Don't do this in a real project
//       void'(env.model.reg_block.STATUS.CNT_DROP.predict(2));
      
//       env.model.reg_block.STATUS.read(status, data);
      
//       //Clear the drop counter
//       env.model.reg_block.CTRL.CLR.set(1);
//       env.model.reg_block.CTRL.update(status);
      
//       env.model.reg_block.STATUS.read(status, data);
      
      fork
        begin
        	cfs_algn_virtual_sequence_reg_access_random seq = cfs_algn_virtual_sequence_reg_access_random::type_id::create("seq");
          
          void'(seq.randomize() with {
          	num_accesses == num_reg_accesses;
          });
          seq.start(env.virtual_sequencer);
        end
        begin
        	cfs_algn_virtual_sequence_reg_access_unmapped seq = cfs_algn_virtual_sequence_reg_access_unmapped::type_id::create("seq");
          
          void'(seq.randomize() with {
          	num_accesses == num_unmapped_accesses;
            
          });
          
          seq.start(env.virtual_sequencer);
        end
      join
      
      #(100ns);
     
      phase.drop_objection(this, "TEST_DONE"); 
    endtask
    
  endclass

`endif
