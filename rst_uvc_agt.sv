class rst_uvc_agt extends uvm_agent;
    `uvm_component_utils(rst_uvc_agt)

    rst_uvc_cfg        cfg;
    rst_uvc_drv        drv;
    virtual rst_uvc_if vif;

    `uvm_component_new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if((cfg == null) && !uvm_config_db#(rst_uvc_cfg)::get(this, "", "cfg", cfg)) begin
            `uvm_fatal(`gfn, "cfg is neither passed in nor configured.")
        end

        if((vif == null) && !uvm_config_db#(virtual rst_uvc_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(`gfn, "vif is neither passed in nor configured.")
        end

        if(cfg.is_active == UVM_ACTIVE) begin
            drv = rst_uvc_drv::type_id::create("drv, this");
            drv.cfg = cfg;
            drv.vif = vif;
        end
    endfunction : build_phase
endclass : rst_uvc_agt
