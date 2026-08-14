class apb_master_driver #(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
) extends apb_base_driver #(APB_ADDR_WIDTH, APB_DATA_WIDTH);
    `uvm_component_param_utils(apb_master_driver #(APB_ADDR_WIDTH, APB_DATA_WIDTH))
    
    function new(string name="apb_master_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        
        // Wait for one cycle before starting transactions
        
        @(posedge vif.PCLK);
            
        forever begin
            seq_item_port.get_next_item(req);
            
            if (req.direction == 1'b1) 
                drive_write(req);
            else
                drive_read(req); 
        end 
    endtask

    virtual task drive_read(apb_seq_item txn);
        
        repeat(txn.pre_drive_delay_cycles) begin
            @(posedge vif.PCLK);
        end

        // ---------------//
        // APB SETUP PHASE//
        // ---------------//
        
        vif.PADDR   <= txn.addr;
        vif.PWRITE  <= 1'b0; // Read
        vif.PSEL    <= 1'b1; // Setup Phase
        vif.PENABLE <= 1'b0; // Enable not asserted in SETUP Phase
        
        // Wait for one cycle
        @(posedge vif.PCLK);

        // ----------------//
        // APB ACCESS PHASE//
        // ----------------//
        
        vif.PENABLE <= 1'b1;
        
        // Wait cycles until PREADY is asserted 
        do begin
            @(posedge vif.PCLK);
        end while (vif.PREADY == 1'b0);

        // set_id_info used to track rsp to correct sequence
        rsp.set_id_info(txn);
        rsp.data        = vif.PRDATA;
        rsp.apb_resp    = apb_rsp_t'(vif.PSLVERR);

        repeat (txn.post_drive_delay_cycles) begin
            @(posedge vif.PCLK);
        end

        if (txn.response_required) 
            seq_item_port.item_done(rsp);
        else
            seq_item_port.item_done();
        
    endtask

    virtual task drive_write(apb_seq_item txn);
        
        repeat(txn.pre_drive_delay_cycles) begin
            @(posedge vif.PCLK);
        end

        // ---------------//
        // APB SETUP PHASE//
        // ---------------//
        
        vif.PADDR   <= txn.addr;
        vif.PWRITE  <= 1'b1; // Write
        vif.PWDATA  <= txn.data;
        vif.PSEL    <= 1'b1; // Setup Phase
        vif.PENABLE <= 1'b0; // Enable not asserted in SETUP Phase
        
        // Wait for one cycle
        @(posedge vif.PCLK);

        // ----------------//
        // APB ACCESS PHASE//
        // ----------------//
        
        vif.PENABLE <= 1'b1;
        
        // Wait cycles until PREADY is asserted 
        do begin
            @(posedge vif.PCLK);
        end while (vif.PREADY == 1'b0);

        // set_id_info used to track rsp to correct sequence
        rsp.set_id_info(txn);
        rsp.apb_resp    = apb_rsp_t'(vif.PSLVERR);

        if (txn.response_required) 
            seq_item_port.item_done(rsp);
        else
            seq_item_port.item_done();
    endtask
endclass