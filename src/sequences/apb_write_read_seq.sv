class apb_write_read_sequence extends uvm_sequence #(apb_seq_item);
    `uvm_object_utils(apb_write_read_sequence)

    function new(string name="apb_write_read_sequence");
        super.new(name);
    endfunction

    task body();
        apb_seq_item w_txn;
        apb_seq_item r_txn;
        w_txn = apb_seq_item::type_id::create("w_txn");
        // Directed Write Sequence
        start_item(w_txn);
        
        w_txn.data = 32'h0000_0011;
        w_txn.addr = 32'h0000_0000;
        w_txn.direction = 1'b1;
        w_txn.pre_drive_delay_cycles = '0;
        w_txn.post_drive_delay_cycles = '0;
        `uvm_info("APB_WRITE_READ_SEQ",$sformatf("APB_SEQ: direction = %0d, Data=%0h,Addr=%0h",
                    w_txn.direction,w_txn.data,w_txn.addr),UVM_LOW)
        
        finish_item(w_txn);

        // Directed Read Sequence
        r_txn = apb_seq_item::type_id::create("r_txn");
        
        start_item(r_txn);
        
        r_txn.addr = 32'h0000_0000;
        r_txn.direction = 1'b0;
        r_txn.pre_drive_delay_cycles = '0;
        r_txn.post_drive_delay_cycles = '0;
        r_txn.response_required = '1;
        `uvm_info("APB_WRITE_READ_SEQ",$sformatf("APB_SEQ: direction = %0d, Data=%0h,Addr=%0h",
                    r_txn.direction,r_txn.data,r_txn.addr),UVM_LOW)
        
        finish_item(r_txn);
        get_response(rsp);

        `uvm_info("APB_WRITE_READ_SEQ",$sformatf("APB_RSP: Data = %0d, Resp = %0d",rsp.data,rsp.apb_resp),UVM_LOW)

    endtask
endclass