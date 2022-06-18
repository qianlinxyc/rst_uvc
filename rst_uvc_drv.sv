class rst_uvc_drv extends uvm_driver;
    `uvm_component_utils(rst_uvc_drv)

    virtual rst_uvc_if vif;
    rst_uvc_cfg        cfg;

    `uvm_component_new

    virtual function void build_phase(uvm_phase phase);
        if((cfg == null) && !uvm_config_db#(rst_uvc_cfg)::get(this, "", "cfg", cfg)) begin
            `uvm_fatal(`gfn, "cfg is neither passed in nor configured.")
        end

        if((vif == null) && !uvm_config_db#(virtual rst_uvc_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(`gfn, "vif is neither passed in nor configured.")
        end
    endfunction : build_phase


    virtual task run_phase(uvm_phase);
        super.run_phase(phase);

        // set initial value for rst pin
        case(cfg.init_val)
            1'bx, 1'bz: vif.rst <= cfg.init_val;
            1'b0, 1'b1: vif.rst <= cfg.active_low ^ cfg.init_val;
            default: `uvm_fatal(`gfn, "You should never see this fatal error")
        endcase
    endtask : run_phase

    virtual task asrt_rst();
        if(cfg.sync_to_clk) @(posedge vif.clk);
        vif.rst <= ~cfg.active_low;
    endtask : asrt_rst

    virtual task deasrt_rst();
        if(cfg.sync_to_clk) @(posedge vif.clk);
        vif.rst <= cfg.active_low;
    endtask : deasrt_rst

endclass : rst_uvc_drv
