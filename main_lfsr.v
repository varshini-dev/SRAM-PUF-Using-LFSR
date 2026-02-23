`timescale 1ns / 1ps

module main_lfsr #(parameter WIDTH = 128)(
    input clk,
    input rst,
    input load,
    input [WIDTH-1:0] seed,
    output reg [WIDTH-1:0] lfsr_out
);

    wire feedback;

    assign feedback = lfsr_out[127] ^ 
                      lfsr_out[6]   ^ 
                      lfsr_out[1]   ^ 
                      lfsr_out[0];

    always @(posedge clk) begin
        if (rst)
            lfsr_out <= 128'h1;  // NEVER reset to 0 (LFSR lock state)
        else if (load)
            lfsr_out <= seed;
        else
            lfsr_out <= {lfsr_out[126:0], feedback};
    end

endmodule
