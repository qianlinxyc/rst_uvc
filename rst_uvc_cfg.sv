class rst_uvc_cfg extends uvm_object;
    `uvm_object_utils(rst_uvc_cfg)

    bit                     sync_to_clk;
    bit                     active_low;
    uvm_active_passive_enum is_active = UVM_ACTIVE;
    logic                   init_val = 1'bx; //0: deassert reset
                                             //1: assert reset
                                             //x: initial value is x
                                             //z: initial value is z

    `uvm_object_new

    function void set_sync_to_clk(bit sync_to_clk);
        this.sync_to_clk = sync_to_clk;
    endfunction : set_sync_to_clk

    function void set_active_low(bit active_low);
        this.active_low = active_low;
    endfunction : set_active_low

endclass : rst_uvc_cfg
