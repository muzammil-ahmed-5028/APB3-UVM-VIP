class apb_ral_adapter extends uvm_reg_adapter;
    `uvm_object_utils(apb_ral_adapter)

    function new(string name = "apb_ral_adapter");
        super.new(name);

        // The APB driver sends a separate response item.
        provides_responses = 1;

        // This VIP implements APB3 and has no PSTRB.
        supports_byte_enable = 0;
    endfunction

    virtual function uvm_sequence_item reg2bus(
        const ref uvm_reg_bus_op rw
    );
        apb_seq_item txn;

        txn = apb_seq_item::type_id::create("txn");

        txn.addr                      = rw.addr;
        txn.data                      = rw.data;
        txn.direction                 = (rw.kind == UVM_WRITE);
        txn.pre_drive_delay_cycles    = 0;
        txn.post_drive_delay_cycles   = 0;

        // RAL requires the driver's returned status/read data.
        txn.response_required         = 1;

        return txn;
    endfunction

    virtual function void bus2reg(
        uvm_sequence_item bus_item,
        ref uvm_reg_bus_op rw
    );
        apb_seq_item txn;

        if (!$cast(txn, bus_item)) begin
            `uvm_fatal(
                "APB_RAL_CAST",
                "RAL adapter received a non-APB transaction"
            )
        end

        rw.kind = txn.direction ? UVM_WRITE : UVM_READ;
        rw.addr = txn.addr;
        rw.data = txn.data;

        rw.status = (txn.apb_resp == APB_OKAY)
                  ? UVM_IS_OK
                  : UVM_NOT_OK;
    endfunction

endclass