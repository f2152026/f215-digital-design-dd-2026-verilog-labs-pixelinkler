// tb.v
module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;
  reg  [3:0] expected;
  integer    i, j, k, errors;

  alu DUT (.a(t_a), .b(t_b), .op(t_op), .result(t_result));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    #1;   // let the design start up before the first input change

    // op is the innermost loop, so every operand pair is tested with
    // op=0 and then op=1 while a and b stay fixed. Then a and b change.
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 2; k = k + 1) begin
          t_a  = i;
          t_b  = j;
          t_op = k;

          if (k == 0) expected = i + j;
          else        expected = i - j;

          #5;

          if (t_result !== expected) begin
            $display("FAIL: a=%0d b=%0d op=%b  got %0d  expected %0d",
                     t_a, t_b, t_op, t_result, expected);
            errors = errors + 1;
          end
        end
      end
    end

    $display("%0d out of 512 passed", 512 - errors);
    $finish;
  end

endmodule