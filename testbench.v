`timescale 1ns/1ps
module testbench;

    reg clk;
    reg rst;
    reg enable;

    wire [127:0] puf_response;
    wire [127:0] raw_sram_out;

    top_mod DUT (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .puf_response(puf_response),
        .raw_sram_out(raw_sram_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        enable = 0;

        #30;
        rst = 0;

        #20;
        enable = 1;   // generate SRAM

        #10;
        enable = 0;

        #500;

        $finish;
    end

endmodule
