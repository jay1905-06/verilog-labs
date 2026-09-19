// and_beh_intra.v
// 2-input AND gate with intra-assignment delay

module and_beh_intra #(
  parameter DELAY = 3
) (
  input  wire a,
  input  wire b,
  output reg  y
);

  always @(*) begin
    y = #(DELAY) (a & b);
  end

endmodule
