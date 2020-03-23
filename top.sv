//  Module: top
module top ;
    /*  package imports  */
    import iface::*;
    logic clk;
    //logic [31:0] data ; 
    GUVM_interface bfm(clk);
    proc dut(
        .clk(bfm.clk),
        .rst(bfm.rst),
        .pciclk(bfm.pcirst),
        .iui(bfm.integer_unit_input),
        .iuo(bfm.integer_unit_output),
        .ico(bfm.icache_output),
        .dci(bfm.dcache_input),
        .dco(bfm.dcache_output)
    );
  /*  initial begin 
        forever begin
            bfm.send_data(32'hC0000000);
        end

        forever begin
            @(negedge clk)
            $display("iam checking on data:%h",bfm.recive_data());
        end
    end
*/
    initial begin 
        bfm.set_Up();
        bfm.reset_dut();
        bfm.set_Up();
        bfm.send_data(32'h000000012);
        //bfm.send_inst(32'hC0017E81); 
        //bfm.send_inst(32'hC0000000);
        bfm.send_inst(32'hC6002000);
        
        repeat (100)begin
            @(posedge clk)
            //bfm.send_data(32'h000000012);
            //bfm.send_inst(32'hC0017E81);
         //bfm.send_inst(32'hC0000000);//load to register 0 
         $display("is this data ? :%b",bfm.recive_data());
        end
        //$display("now for the load instruction");
        //bfm.send_inst(32'hC0200000);
        bfm.send_inst(32'hC6204002);
        //32'hC6204002
        repeat (100) @(posedge clk) ;
        //repeat (100)begin
       // @(posedge clk)
         
         //$display("is this data ? :%b",bfm.recive_data());
         //bfm.send_data(32'hc);
       // end
        repeat (100) @(posedge clk);
        //$finish();
        $stop();
    end

    
    initial begin
        clk = 0 ; 
        forever begin 
            #10 clk=~clk;
           // $display(clk);
        end
    end

endmodule: top
