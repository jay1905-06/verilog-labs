// tb.v
// Starter testbench template -- completed for Task 1.
//
// Goal: apply all 8 combinations of I0, I1, S (5 time units apart) to DUT
// and observe the output.

module tb;

  // Declare the three DUT inputs as the appropriate variable type.
  // Use exactly these names: t_i0, t_i1, t_s (needed by $monitor below).
  reg   t_i0, t_i1, t_s;
  // Declare the DUT output as the appropriate net type.
  // Use exactly this name: t_y (needed by $monitor below).
  wire  t_y;

  // Instantiate DUT here, connecting t_i0, t_i1, t_s, t_y to its ports
  DUT DUT (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // Apply all 8 combinations of t_i0, t_i1, t_s, 5 time units apart
    t_i0 = 0; t_i1 = 0; t_s = 0;
    #5 t_i0 = 0; t_i1 = 0; t_s = 1;
    #5 t_i0 = 0; t_i1 = 1; t_s = 0;
    #5 t_i0 = 0; t_i1 = 1; t_s = 1;
    #5 t_i0 = 1; t_i1 = 0; t_s = 0;
    #5 t_i0 = 1; t_i1 = 0; t_s = 1;
    #5 t_i0 = 1; t_i1 = 1; t_s = 0;
    #5 t_i0 = 1; t_i1 = 1; t_s = 1;
    #5;
    $display("Simulation complete: Task 1 finished");
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule
