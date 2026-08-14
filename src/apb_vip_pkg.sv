interface apb_intf#(
    parameter DATA_WIDTH=32
    parameter ADDRESS_WIDTH=64
);

    logic                       PCLK,
    logic                       PRESETN,
    logic [ADDRESS_WIDTH-1:0]   PADDR,
    logic                       PSEL,
    logic                       PENABLE,
    logic                       PWRITE,
    logic [DATA_WIDTH-1:0]      PWDATA,
    logic [DATA_WIDTH-1:0]      PRDATA,
    logic                       PREADY,
    logic                       PSLVERR

endinterface

package apb_vip_pkg;
    
    typedef enum bit {
        APB_OKAY    = 1'b0,
        APB_SLVERR  = 1'b1
    } apb_rsp_t;

    
endpackage