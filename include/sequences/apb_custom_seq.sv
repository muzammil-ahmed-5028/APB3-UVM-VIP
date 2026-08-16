class apb_custom_sequence extends uvm_sequence #(apb_seq_item);
    `uvm_object_utils(apb_custom_sequence)
    
    bit [1023:0]    data;
    bit [63:0]      addr;
    bit             direction;
    bit             response_required;

    function new(string name="apb_custom_sequence");
        super.new(name);
    endfunction

    task body();
        apb_seq_item txn;
        txn = apb_seq_item::type_id::create("txn");
        // Directed Write Sequence
        start_item(txn);
        
        txn.data = data;
        txn.addr = addr;
        txn.direction = direction;
        txn.pre_drive_delay_cycles  = '0;
        txn.post_drive_delay_cycles = '0;
        txn.response_required = response_required;
        `uvm_info("APB_CUSTOM_SEQ",$sformatf("APB_SEQ: direction = %0d, Data=%0h,Addr=%0h",
                    txn.direction,txn.data,txn.addr),UVM_LOW)
        
        finish_item(txn);
  
        if (response_required) begin
  
            get_response(rsp);
            `uvm_info("APB_WRITE_READ_SEQ",$sformatf("APB_RSP: Data = %0d, Resp = %0d",rsp.data,rsp.apb_resp),UVM_LOW)
  
        end
        
    endtask
endclass