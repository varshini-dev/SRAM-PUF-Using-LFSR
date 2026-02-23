`timescale 1ns / 1ps

module testbench;
    parameter WIDTH = 128;

    reg clk;
    reg rst;
    reg enable;

    wire [WIDTH-1:0] puf_response;

    // Instantiate DUT
    top_mod #(WIDTH) DUT (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .puf_response(puf_response)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        enable = 0;

        // Hold reset
        #20;
        rst = 0;

        // Trigger SRAM capture
        #10;
        enable = 1;

        #10;
        enable = 0;   // Load only once

        // Let LFSR run for 50 cycles
        #500;

        $display("Final Extracted PUF Response:");
        $display("%b", puf_response);

        $finish;
    end

    // Monitor signal changes
    initial begin
        $monitor("Time=%0t | Response=%h", $time, puf_response);
    end

endmodule
