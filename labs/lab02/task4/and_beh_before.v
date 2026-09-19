// and_beh_before.v
// 2-input AND gate with delay placed before procedural assignment

module and_beh_before #(
  parameter DELAY = 3
) (
  input  wire a,
  input  wire b,
  output reg  y
);

  always @(*) begin
    #(DELAY) y = a & b;
  end

endmodule