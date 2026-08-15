class apb_slave_driver #(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
) extends apb_base_driver #(APB_ADDR_WIDTH, APB_DATA_WIDTH);
    `uvm_component_param_utils(apb_slave_driver #(APB_ADDR_WIDTH, APB_DATA_WIDTH))
    
endclass