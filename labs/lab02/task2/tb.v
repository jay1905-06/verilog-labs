// tb.v
// Testbench for Task 2 -- Parameterized ROM Lookup Table (lut)

module tb;

  // Declare the inputs and outputs
  reg  [2:0] t_sel;
  wire [7:0] t_dout;

  // Instantiate DUT here with parameter override (WIDTH=8, DEPTH=8)
  lut #(
    .WIDTH(8),
    .DEPTH(8)
  ) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer i;
  initial begin
    // Apply input combinations across all addresses 0 to DEPTH-1
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i;
      #5;
    end
    #5;
    $display("Simulation complete: Task 2 finished");
    $finish;
  end

  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout);

endmodule
