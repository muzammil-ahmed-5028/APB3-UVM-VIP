interface apb_intf#(
    parameter ADDRESS_WIDTH=64,
    parameter DATA_WIDTH=32
);

    logic                       PCLK;
    logic                       PRESETN;
    logic [ADDRESS_WIDTH-1:0]   PADDR;
    logic                       PSEL;
    logic                       PENABLE;
    logic                       PWRITE;
    logic [DATA_WIDTH-1:0]      PWDATA;
    logic [DATA_WIDTH-1:0]      PRDATA;
    logic                       PREADY;
    logic                       PSLVERR;

endinterface

package apb_vip_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    typedef enum bit {
        APB_OKAY    = 1'b0,
        APB_SLVERR  = 1'b1
    } apb_rsp_t;

    `include "apb_seq_item.sv"
    `include "apb_sequencer.sv"
    `include "apb_base_driver.sv"
    `include "apb_master_driver.sv"
    `include "apb_base_monitor.sv"
    `include "apb_master_monitor.sv"
    `include "apb_master_agent.sv"
    `include "apb_write_read_seq.sv"

    
endpackage