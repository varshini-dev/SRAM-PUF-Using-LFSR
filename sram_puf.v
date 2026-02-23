`timescale 1ns / 1ps

module sram_puf #(parameter WIDTH = 128)(
    input clk,
    input enable,
    output reg [WIDTH-1:0] sram_out
);

    always @(posedge clk) begin
        if (enable) begin
            sram_out <= {$urandom, $urandom, $urandom, $urandom};
        end
    end

endmodule
