

module and_beh_before (
  input       a,
  input       b,
  output reg  y  // since Y is not continuosly assigned, we use reg 
                // as we want it to hold its value until next cycle.
);

  always @(*) begin
     #3 y = a & b;
  end

endmodule
