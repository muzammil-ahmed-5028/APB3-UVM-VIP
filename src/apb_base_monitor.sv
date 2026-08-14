class apb_base_monitor#(
    parameter APB_ADDR_WIDTH=64,
    parameter APB_DATA_WIDTH=32
) extends uvm_monitor;
    `uvm_component_param_utils(apb_base_monitor #(APB_ADDR_WIDTH,APB_DATA_WIDTH))

    virtual apb_intf #(APB_ADDR_WIDTH,APB_DATA_WIDTH) vif;

    function new(string name="apb_base_monitor",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (vif == null) begin
            `uvm_fatal("NO_APB_MON_VIF","NO VIF passed to the APB Monitor")
        end
        
    endfunction
    
endclass