// tb.v
// Self-checking testbench for Task 5 -- Capstone ALU (alu)

module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;
  integer    errors;
  integer    total_tests;
  integer    i, j;

  // Instantiate DUT
  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
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
    errors = 0;
    total_tests = 0;

    // Test 1: Fixed operands, toggle op (explicitly checks sensitivity list bug)
    t_a = 4'd7;
    t_b = 4'd3;

    t_op = 1'b0; // Add: 7 + 3 = 10
    #5;
    exp_result = 4'd10;
    total_tests = total_tests + 1;
    if (t_result !== exp_result) begin
      $display("FAIL [Sensitivity Test - ADD]: a=%0d b=%0d op=%b got=%0d exp=%0d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end else begin
      $display("PASS [Sensitivity Test - ADD]: a=%0d b=%0d op=%b result=%0d", t_a, t_b, t_op, t_result);
    end

    t_op = 1'b1; // Sub: 7 - 3 = 4 (same operands, only op changes)
    #5;
    exp_result = 4'd4;
    total_tests = total_tests + 1;
    if (t_result !== exp_result) begin
      $display("FAIL [Sensitivity Test - SUB]: a=%0d b=%0d op=%b got=%0d exp=%0d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end else begin
      $display("PASS [Sensitivity Test - SUB]: a=%0d b=%0d op=%b result=%0d", t_a, t_b, t_op, t_result);
    end

    // Test 2: Comprehensive sweep of all 16x16 operand pairs for both ADD and SUB
    // op = 0 (ADD)
    t_op = 1'b0;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        t_a = i;
        t_b = j;
        exp_result = (i + j) & 4'hF;
        total_tests = total_tests + 1;
        #5;
        if (t_result !== exp_result) begin
          $display("FAIL [ADD]: a=%0d b=%0d got=%0d exp=%0d", t_a, t_b, t_result, exp_result);
          errors = errors + 1;
        end
      end
    end

    // op = 1 (SUB) - thoroughly tests the two's complement chain
    t_op = 1'b1;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        t_a = i;
        t_b = j;
        exp_result = (i - j) & 4'hF;
        total_tests = total_tests + 1;
        #5;
        if (t_result !== exp_result) begin
          $display("FAIL [SUB]: a=%0d b=%0d got=%0d exp=%0d", t_a, t_b, t_result, exp_result);
          errors = errors + 1;
        end
      end
    end

    $display("Summary: %0d passed out of %0d tests (%0d errors)", (total_tests - errors), total_tests, errors);
    $display("Simulation complete: Task 5 finished");
    $finish;
  end

endmodule
