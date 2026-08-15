class apb_base_driver #(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
) extends uvm_driver #(apb_seq_item);
    `uvm_component_param_utils(apb_base_driver #(APB_ADDR_WIDTH, APB_DATA_WIDTH))
    
    virtual apb_intf #(APB_DATA_WIDTH,APB_ADDR_WIDTH) vif;

    function new(string name="apb_base_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (vif == null) begin
           `uvm_fatal("NO_APB_VIF","No valid APB VIF passed to driver") 
        end

    endfunction


endclass