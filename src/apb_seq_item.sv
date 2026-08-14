class apb_seq_item extends uvm_sequence_item;
    `uvm_object_utils(apb_seq_item)
    
    // ------------------------------------------ //
    // Fields to be set by User for Creating Txns //
    // ------------------------------------------ //

    bit [1023:0]    data;
    bit [63:0]      addr;
    bit             direction; // 1=Write 0=Read
    int             pre_drive_delay_cycles;
    int             post_drive_delay_cycles;
    bit             response_required;
    
    // ------------------------------------------ //
    // Fields to be used For Response             //
    // ------------------------------------------ //

    apb_rsp_t       apb_resp;

    // ------------------------------------------ //
    // Fields to be used by Monitor               //
    // ------------------------------------------ //

    bit protocol_error;

endclass