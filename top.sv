//  Module: top
//
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
        .ici(bfm.icache_input),
        .dci(bfm.dcache_input),
        .dco(bfm.dcache_output)
    );
    
    initial begin
        bfm.send_data(32'h100);
        bfm.send_inst(32'h01000000);
        bfm.set_Up();
        bfm.reset_dut();
        bfm.set_Up();

    end
    initial begin 
        
        clk = 0 ;
        repeat (14*2)#10 clk=~clk;
        repeat (14*2)#10 clk=~clk;
        for (integer i =0; i <32;i++) begin
            bfm.load(i,i*i);
            repeat(2*1)#10 clk=~clk;
            //bfm.nop();
            repeat(2*4)#10 clk=~clk;
        end
        repeat(2*400)#10 clk=~clk;

        $stop();
    end

    /*
    initial begin
        clk = 0 ; 
        forever begin 
            #10 clk=~clk;
           // $display(clk);
        end
    end
    
*/
endmodule: top
