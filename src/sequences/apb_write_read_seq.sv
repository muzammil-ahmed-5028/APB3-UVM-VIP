class apb_write_read_sequence extends uvm_sequnce #(apb_seq_item);
    `uvm_object_utils(apb_write_read_sequence)

    function new(string name="apb_write_read_sequence");
        super.new(name);
    endfunction

    task body();
        apb_seq_item w_txn;
        
    endtask
endclass