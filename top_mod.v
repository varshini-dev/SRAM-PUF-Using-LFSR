`timescale 1ns / 1ps

module top_mod #(parameter WIDTH = 128)(
    input clk,
    input rst,
    input enable,
    output [WIDTH-1:0] puf_response,
    output [WIDTH-1:0] raw_sram_out
);

    wire [WIDTH-1:0] raw_sram;
    reg load_lfsr;

    sram_puf #(WIDTH) SRAM (
        .clk(clk),
        .enable(enable),
        .sram_out(raw_sram)
    );

    always @(posedge clk) begin
        load_lfsr <= enable;
    end

    // LFSR
    main_lfsr #(WIDTH) LFSR (
        .clk(clk),
        .rst(rst),
        .load(load_lfsr),
        .seed(raw_sram),
        .lfsr_out(puf_response)
    );

    assign raw_sram_out = raw_sram;

endmodule
