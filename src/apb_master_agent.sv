class apb_master_agent #(
    parameter APB_ADDR_WIDTH = 64,
    parameter APB_DATA_WIDTH = 32
) extends uvm_agent;
    `uvm_component_param_utils(apb_master_agent #(APB_ADDR_WIDTH,APB_DATA_WIDTH))

    virtual apb_intf    #(APB_ADDR_WIDTH,APB_DATA_WIDTH) vif;
    apb_master_driver   #(APB_ADDR_WIDTH,APB_DATA_WIDTH) drv;
    apb_master_monitor  #(APB_ADDR_WIDTH,APB_DATA_WIDTH) mon;
    apb_sequencer                                        seqr;

    function new (string name="apb_master_agent",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);
        
        if (!uvm_config_db #(virtual apb_intf #(APB_ADDR_WIDTH,APB_DATA_WIDTH))::get(
            this,
            "",
            "apb_intf",
            vif)) begin
                `uvm_fatal("NO_APB_MASTER_AGENT_VIF","Unable to recieved Vif in APB Master Agent")
        end

        drv = apb_master_driver #(APB_ADDR_WIDTH,APB_DATA_WIDTH)::type_id::create("Drv",this);
        mon = apb_master_monitor#(APB_ADDR_WIDTH,APB_DATA_WIDTH)::type_id::create("Mon",this);
        
        drv.vif = vif;
        mon.vif = vif;
    
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        drv.seq_item_port.connect(seqr.seq_item_export);
    
    endfunction
    
endclass