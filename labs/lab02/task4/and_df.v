// and_df.v
// 2-input AND gate with continuous assignment delay (dataflow style)

module and_df #(
  parameter DELAY = 3
) (
  input  wire a,
  input  wire b,
  output wire y
);

  assign #(DELAY) y = a & b;

endmodule
