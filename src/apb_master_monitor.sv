class apb_master_monitor #(
    parameter APB_ADDR_WIDTH = 64,
    parameter APB_DATA_WIDTH = 32
) extends apb_base_monitor #(APB_ADDR_WIDTH,APB_DATA_WIDTH);
    `uvm_component_param_utils(apb_master_monitor #(APB_ADDR_WIDTH,APB_DATA_WIDTH))

    uvm_analysis_port #(apb_seq_item) item_observed_port;

    function new(string name="apb_master_monitor",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        
        apb_seq_item item;
        item = apb_seq_item::type_id::create("item");
        
        forever begin
            
            wait (vif.PSEL && vif.PENABLE && vif.PREADY);
            
            item.addr       = vif.PADDR;
            item.apb_resp   = apb_rsp_t'(vif.PSLVERR);
            item.data       = (vif.PWRITE == 1'b1) ? vif.PWDATA : vif.PRDATA;
            item_observed_port.write(item);

        end

    endtask

endclass