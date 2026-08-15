class apb_seq_item extends uvm_sequence_item;
    `uvm_object_utils(apb_seq_item)
    
    function new(string name="apb_seq_item");
        super.new(name);
    endfunction
    // ------------------------------------------ //
    // Fields to be set by User for Creating Txns //
    // ------------------------------------------ //

    rand bit [1023:0]    data;
    rand bit [63:0]      addr;
    rand bit             direction; // 1=Write 0=Read
    rand int unsigned    pre_drive_delay_cycles;
    rand int unsigned    post_drive_delay_cycles;
    rand bit             response_required;
    
    // ------------------------------------------ //
    // Fields to be used For Response             //
    // ------------------------------------------ //

    rand apb_rsp_t       apb_resp;

    // ------------------------------------------ //
    // Fields to be used by Monitor               //
    // ------------------------------------------ //

    rand bit protocol_error;

endclass