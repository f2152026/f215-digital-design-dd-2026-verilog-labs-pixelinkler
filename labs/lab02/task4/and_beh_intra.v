

module and_beh_intra (
  input       a,
  input       b,
  output reg  y // since Y is not continuosly assigned, we use reg 
                // as we want it to hold its value until next cycle.
);

  always @(*) begin
      y = #3 a & b;
  end

endmodule
