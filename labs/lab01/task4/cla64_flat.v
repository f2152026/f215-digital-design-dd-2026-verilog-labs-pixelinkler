// cla64_flat.v
// A flat, unblocked 64-bit carry-lookahead adder: every carry is computed
// directly (two-level, no rippling), exactly like cla4.v, just scaled to
// 64 bits. Add delays throughout (same convention as cla4.v) so it can be
// fairly compared against rca64.v and cla64_blocked.v.

module cla64_flat(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [63:0] p, g;
  wire [64:1] c;   // c[1]..c[64] are the 64 carries; think of cin as c[0]

  // ---------------------------------------------------------------------
  // Step 1: generate/propagate signals -- WORKED EXAMPLE
  //
  // This part is genuinely uniform across all 64 bits (same operation at
  // every position), so a generate-for loop is the right tool here.
  // `genvar` is a compile-time-only loop variable -- it does not exist as
  // a real signal in the final circuit, it just controls how many times
  // the loop body is elaborated.
  // ---------------------------------------------------------------------
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_pg
      xor #(2) (p[i], a[i], b[i]);
      and #(2) (g[i], a[i], b[i]);
    end
  endgenerate

  // ---------------------------------------------------------------------
  // Step 2: the 64 direct carry equations -- YOUR TASK
  //
  // Unlike P and G, these are NOT uniform: Ck needs k+1 product terms,
  // each one literal longer than the last (see Tutorial 3's derivation).
  // Writing all 64 of these by hand is extremely tedious and error-prone,
  // and a single generate-for loop cannot produce them directly (both the
  // number of terms AND the length of each term change with k).
  //
  // Instead: use an AI coding assistant to generate these 64 `assign`
  // statements.
  //   - Give it your own C1..C4 equations from cla4.v as the exact
  //     pattern to continue.
  //   - Ask it to produce assign statements (with #(2) delays, matching
  //     the rest of this file) for c[1] through c[64] following that
  //     same pattern.
  //
  // YOU are responsible for verifying the result before trusting it --
  // this is not optional:
  //   (1) Confirm the generated c[1]..c[4] exactly match your own cla4.v
  //       equations.
  //   (2) Pick at least one later equation (e.g. c[10] or c[32]), re-derive
  //       it yourself by hand from the recursive definition, and confirm
  //       it matches what was generated.
  // Do not move on to this task's reflection question until you've done
  // both checks.
  //
  // TODO: paste your verified assign statements for c[1] through c[64] here.

  // finding c1 by using extra wire

  wire t1_0;
  and #(2) (t1_0, p0, cin);
  or  #(2) (c1, g0, t1_0);

  // finding c2 by using extra wire

  wire t2_0, t2_1;
  and #(2) (t2_0, p1, g0);
  and #(2) (t2_1, p1, p0, cin);
  or  #(2) (c2, g1, t2_0, t2_1);

  // finding c3 by using extra wire

  wire t3_0, t3_1, t3_2;
  and #(2) (t3_0, p2, g1);
  and #(2) (t3_1, p2, p1, g0);
  and #(2) (t3_2, p2, p1, p0, cin);
  or  #(2) (c3, g2, t3_0, t3_1, t3_2);

  // finding c4 by using extra wire

  wire t4_0, t4_1, t4_2, t4_3;
  and #(2) (t4_0, p3, g2);
  and #(2) (t4_1, p3, p2, g1);
  and #(2) (t4_2, p3, p2, p1, g0);
  and #(2) (t4_3, p3, p2, p1, p0, cin);
  or  #(2) (c4, g3, t4_0, t4_1, t4_2, t4_3);

  // finding c5 by using extra wire

  wire t5_0, t5_1, t5_2, t5_3, t5_4;
  and #(2) (t5_0, p4, g3);
  and #(2) (t5_1, p4, p3, g2);
  and #(2) (t5_2, p4, p3, p2, g1);
  and #(2) (t5_3, p4, p3, p2, p1, g0);
  and #(2) (t5_4, p4, p3, p2, p1, p0, cin);
  or  #(2) (c5, g4, t5_0, t5_1, t5_2, t5_3, t5_4);

  // finding c6 by using extra wire

  wire t6_0, t6_1, t6_2, t6_3, t6_4, t6_5;
  and #(2) (t6_0, p5, g4);
  and #(2) (t6_1, p5, p4, g3);
  and #(2) (t6_2, p5, p4, p3, g2);
  and #(2) (t6_3, p5, p4, p3, p2, g1);
  and #(2) (t6_4, p5, p4, p3, p2, p1, g0);
  and #(2) (t6_5, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c6, g5, t6_0, t6_1, t6_2, t6_3, t6_4, t6_5);

  // finding c7 by using extra wire

  wire t7_0, t7_1, t7_2, t7_3, t7_4, t7_5, t7_6;
  and #(2) (t7_0, p6, g5);
  and #(2) (t7_1, p6, p5, g4);
  and #(2) (t7_2, p6, p5, p4, g3);
  and #(2) (t7_3, p6, p5, p4, p3, g2);
  and #(2) (t7_4, p6, p5, p4, p3, p2, g1);
  and #(2) (t7_5, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t7_6, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c7, g6, t7_0, t7_1, t7_2, t7_3, t7_4, t7_5, t7_6);

  // finding c8 by using extra wire

  wire t8_0, t8_1, t8_2, t8_3, t8_4, t8_5, t8_6, t8_7;
  and #(2) (t8_0, p7, g6);
  and #(2) (t8_1, p7, p6, g5);
  and #(2) (t8_2, p7, p6, p5, g4);
  and #(2) (t8_3, p7, p6, p5, p4, g3);
  and #(2) (t8_4, p7, p6, p5, p4, p3, g2);
  and #(2) (t8_5, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t8_6, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t8_7, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c8, g7, t8_0, t8_1, t8_2, t8_3, t8_4, t8_5, t8_6, t8_7);

  // finding c9 by using extra wire

  wire t9_0, t9_1, t9_2, t9_3, t9_4, t9_5, t9_6, t9_7, t9_8;
  and #(2) (t9_0, p8, g7);
  and #(2) (t9_1, p8, p7, g6);
  and #(2) (t9_2, p8, p7, p6, g5);
  and #(2) (t9_3, p8, p7, p6, p5, g4);
  and #(2) (t9_4, p8, p7, p6, p5, p4, g3);
  and #(2) (t9_5, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t9_6, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t9_7, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t9_8, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c9, g8, t9_0, t9_1, t9_2, t9_3, t9_4, t9_5, t9_6, t9_7, t9_8);

  // finding c10 by using extra wire

  wire t10_0, t10_1, t10_2, t10_3, t10_4, t10_5, t10_6, t10_7, t10_8, t10_9;
  and #(2) (t10_0, p9, g8);
  and #(2) (t10_1, p9, p8, g7);
  and #(2) (t10_2, p9, p8, p7, g6);
  and #(2) (t10_3, p9, p8, p7, p6, g5);
  and #(2) (t10_4, p9, p8, p7, p6, p5, g4);
  and #(2) (t10_5, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t10_6, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t10_7, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t10_8, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t10_9, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c10, g9, t10_0, t10_1, t10_2, t10_3, t10_4, t10_5, t10_6, t10_7, t10_8, t10_9);

  // finding c11 by using extra wire

  wire t11_0, t11_1, t11_2, t11_3, t11_4, t11_5, t11_6, t11_7, t11_8, t11_9, t11_10;
  and #(2) (t11_0, p10, g9);
  and #(2) (t11_1, p10, p9, g8);
  and #(2) (t11_2, p10, p9, p8, g7);
  and #(2) (t11_3, p10, p9, p8, p7, g6);
  and #(2) (t11_4, p10, p9, p8, p7, p6, g5);
  and #(2) (t11_5, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t11_6, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t11_7, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t11_8, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t11_9, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t11_10, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c11, g10, t11_0, t11_1, t11_2, t11_3, t11_4, t11_5, t11_6, t11_7, t11_8, t11_9, t11_10);

  // finding c12 by using extra wire

  wire t12_0, t12_1, t12_2, t12_3, t12_4, t12_5, t12_6, t12_7, t12_8, t12_9, t12_10, t12_11;
  and #(2) (t12_0, p11, g10);
  and #(2) (t12_1, p11, p10, g9);
  and #(2) (t12_2, p11, p10, p9, g8);
  and #(2) (t12_3, p11, p10, p9, p8, g7);
  and #(2) (t12_4, p11, p10, p9, p8, p7, g6);
  and #(2) (t12_5, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t12_6, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t12_7, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t12_8, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t12_9, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t12_10, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t12_11, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c12, g11, t12_0, t12_1, t12_2, t12_3, t12_4, t12_5, t12_6, t12_7, t12_8, t12_9, t12_10, t12_11);

  // finding c13 by using extra wire

  wire t13_0, t13_1, t13_2, t13_3, t13_4, t13_5, t13_6, t13_7, t13_8, t13_9, t13_10, t13_11, t13_12;
  and #(2) (t13_0, p12, g11);
  and #(2) (t13_1, p12, p11, g10);
  and #(2) (t13_2, p12, p11, p10, g9);
  and #(2) (t13_3, p12, p11, p10, p9, g8);
  and #(2) (t13_4, p12, p11, p10, p9, p8, g7);
  and #(2) (t13_5, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t13_6, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t13_7, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t13_8, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t13_9, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t13_10, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t13_11, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t13_12, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c13, g12, t13_0, t13_1, t13_2, t13_3, t13_4, t13_5, t13_6, t13_7, t13_8, t13_9, t13_10, t13_11, t13_12);

  // finding c14 by using extra wire

  wire t14_0, t14_1, t14_2, t14_3, t14_4, t14_5, t14_6, t14_7, t14_8, t14_9, t14_10, t14_11, t14_12, t14_13;
  and #(2) (t14_0, p13, g12);
  and #(2) (t14_1, p13, p12, g11);
  and #(2) (t14_2, p13, p12, p11, g10);
  and #(2) (t14_3, p13, p12, p11, p10, g9);
  and #(2) (t14_4, p13, p12, p11, p10, p9, g8);
  and #(2) (t14_5, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t14_6, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t14_7, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t14_8, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t14_9, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t14_10, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t14_11, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t14_12, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t14_13, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c14, g13, t14_0, t14_1, t14_2, t14_3, t14_4, t14_5, t14_6, t14_7, t14_8, t14_9, t14_10, t14_11, t14_12, t14_13);

  // finding c15 by using extra wire

  wire t15_0, t15_1, t15_2, t15_3, t15_4, t15_5, t15_6, t15_7, t15_8, t15_9, t15_10, t15_11, t15_12, t15_13, t15_14;
  and #(2) (t15_0, p14, g13);
  and #(2) (t15_1, p14, p13, g12);
  and #(2) (t15_2, p14, p13, p12, g11);
  and #(2) (t15_3, p14, p13, p12, p11, g10);
  and #(2) (t15_4, p14, p13, p12, p11, p10, g9);
  and #(2) (t15_5, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t15_6, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t15_7, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t15_8, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t15_9, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t15_10, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t15_11, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t15_12, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t15_13, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t15_14, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c15, g14, t15_0, t15_1, t15_2, t15_3, t15_4, t15_5, t15_6, t15_7, t15_8, t15_9, t15_10, t15_11, t15_12, t15_13, t15_14);

  // finding c16 by using extra wire

  wire t16_0, t16_1, t16_2, t16_3, t16_4, t16_5, t16_6, t16_7, t16_8, t16_9, t16_10, t16_11, t16_12, t16_13, t16_14, t16_15;
  and #(2) (t16_0, p15, g14);
  and #(2) (t16_1, p15, p14, g13);
  and #(2) (t16_2, p15, p14, p13, g12);
  and #(2) (t16_3, p15, p14, p13, p12, g11);
  and #(2) (t16_4, p15, p14, p13, p12, p11, g10);
  and #(2) (t16_5, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t16_6, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t16_7, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t16_8, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t16_9, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t16_10, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t16_11, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t16_12, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t16_13, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t16_14, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t16_15, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c16, g15, t16_0, t16_1, t16_2, t16_3, t16_4, t16_5, t16_6, t16_7, t16_8, t16_9, t16_10, t16_11, t16_12, t16_13, t16_14, t16_15);

  // finding c17 by using extra wire

  wire t17_0, t17_1, t17_2, t17_3, t17_4, t17_5, t17_6, t17_7, t17_8, t17_9, t17_10, t17_11, t17_12, t17_13, t17_14, t17_15, t17_16;
  and #(2) (t17_0, p16, g15);
  and #(2) (t17_1, p16, p15, g14);
  and #(2) (t17_2, p16, p15, p14, g13);
  and #(2) (t17_3, p16, p15, p14, p13, g12);
  and #(2) (t17_4, p16, p15, p14, p13, p12, g11);
  and #(2) (t17_5, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t17_6, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t17_7, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t17_8, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t17_9, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t17_10, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t17_11, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t17_12, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t17_13, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t17_14, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t17_15, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t17_16, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c17, g16, t17_0, t17_1, t17_2, t17_3, t17_4, t17_5, t17_6, t17_7, t17_8, t17_9, t17_10, t17_11, t17_12, t17_13, t17_14, t17_15, t17_16);

  // finding c18 by using extra wire

  wire t18_0, t18_1, t18_2, t18_3, t18_4, t18_5, t18_6, t18_7, t18_8, t18_9, t18_10, t18_11, t18_12, t18_13, t18_14, t18_15, t18_16, t18_17;
  and #(2) (t18_0, p17, g16);
  and #(2) (t18_1, p17, p16, g15);
  and #(2) (t18_2, p17, p16, p15, g14);
  and #(2) (t18_3, p17, p16, p15, p14, g13);
  and #(2) (t18_4, p17, p16, p15, p14, p13, g12);
  and #(2) (t18_5, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t18_6, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t18_7, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t18_8, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t18_9, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t18_10, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t18_11, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t18_12, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t18_13, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t18_14, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t18_15, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t18_16, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t18_17, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c18, g17, t18_0, t18_1, t18_2, t18_3, t18_4, t18_5, t18_6, t18_7, t18_8, t18_9, t18_10, t18_11, t18_12, t18_13, t18_14, t18_15, t18_16, t18_17);

  // finding c19 by using extra wire

  wire t19_0, t19_1, t19_2, t19_3, t19_4, t19_5, t19_6, t19_7, t19_8, t19_9, t19_10, t19_11, t19_12, t19_13, t19_14, t19_15, t19_16, t19_17, t19_18;
  and #(2) (t19_0, p18, g17);
  and #(2) (t19_1, p18, p17, g16);
  and #(2) (t19_2, p18, p17, p16, g15);
  and #(2) (t19_3, p18, p17, p16, p15, g14);
  and #(2) (t19_4, p18, p17, p16, p15, p14, g13);
  and #(2) (t19_5, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t19_6, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t19_7, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t19_8, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t19_9, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t19_10, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t19_11, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t19_12, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t19_13, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t19_14, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t19_15, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t19_16, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t19_17, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t19_18, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c19, g18, t19_0, t19_1, t19_2, t19_3, t19_4, t19_5, t19_6, t19_7, t19_8, t19_9, t19_10, t19_11, t19_12, t19_13, t19_14, t19_15, t19_16, t19_17, t19_18);

  // finding c20 by using extra wire

  wire t20_0, t20_1, t20_2, t20_3, t20_4, t20_5, t20_6, t20_7, t20_8, t20_9, t20_10, t20_11, t20_12, t20_13, t20_14, t20_15, t20_16, t20_17, t20_18, t20_19;
  and #(2) (t20_0, p19, g18);
  and #(2) (t20_1, p19, p18, g17);
  and #(2) (t20_2, p19, p18, p17, g16);
  and #(2) (t20_3, p19, p18, p17, p16, g15);
  and #(2) (t20_4, p19, p18, p17, p16, p15, g14);
  and #(2) (t20_5, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t20_6, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t20_7, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t20_8, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t20_9, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t20_10, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t20_11, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t20_12, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t20_13, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t20_14, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t20_15, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t20_16, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t20_17, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t20_18, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t20_19, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c20, g19, t20_0, t20_1, t20_2, t20_3, t20_4, t20_5, t20_6, t20_7, t20_8, t20_9, t20_10, t20_11, t20_12, t20_13, t20_14, t20_15, t20_16, t20_17, t20_18, t20_19);

  // finding c21 by using extra wire

  wire t21_0, t21_1, t21_2, t21_3, t21_4, t21_5, t21_6, t21_7, t21_8, t21_9, t21_10, t21_11, t21_12, t21_13, t21_14, t21_15, t21_16, t21_17, t21_18, t21_19, t21_20;
  and #(2) (t21_0, p20, g19);
  and #(2) (t21_1, p20, p19, g18);
  and #(2) (t21_2, p20, p19, p18, g17);
  and #(2) (t21_3, p20, p19, p18, p17, g16);
  and #(2) (t21_4, p20, p19, p18, p17, p16, g15);
  and #(2) (t21_5, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t21_6, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t21_7, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t21_8, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t21_9, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t21_10, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t21_11, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t21_12, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t21_13, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t21_14, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t21_15, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t21_16, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t21_17, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t21_18, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t21_19, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t21_20, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c21, g20, t21_0, t21_1, t21_2, t21_3, t21_4, t21_5, t21_6, t21_7, t21_8, t21_9, t21_10, t21_11, t21_12, t21_13, t21_14, t21_15, t21_16, t21_17, t21_18, t21_19, t21_20);

  // finding c22 by using extra wire

  wire t22_0, t22_1, t22_2, t22_3, t22_4, t22_5, t22_6, t22_7, t22_8, t22_9, t22_10, t22_11, t22_12, t22_13, t22_14, t22_15, t22_16, t22_17, t22_18, t22_19, t22_20, t22_21;
  and #(2) (t22_0, p21, g20);
  and #(2) (t22_1, p21, p20, g19);
  and #(2) (t22_2, p21, p20, p19, g18);
  and #(2) (t22_3, p21, p20, p19, p18, g17);
  and #(2) (t22_4, p21, p20, p19, p18, p17, g16);
  and #(2) (t22_5, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t22_6, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t22_7, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t22_8, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t22_9, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t22_10, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t22_11, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t22_12, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t22_13, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t22_14, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t22_15, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t22_16, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t22_17, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t22_18, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t22_19, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t22_20, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t22_21, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c22, g21, t22_0, t22_1, t22_2, t22_3, t22_4, t22_5, t22_6, t22_7, t22_8, t22_9, t22_10, t22_11, t22_12, t22_13, t22_14, t22_15, t22_16, t22_17, t22_18, t22_19, t22_20, t22_21);

  // finding c23 by using extra wire

  wire t23_0, t23_1, t23_2, t23_3, t23_4, t23_5, t23_6, t23_7, t23_8, t23_9, t23_10, t23_11, t23_12, t23_13, t23_14, t23_15, t23_16, t23_17, t23_18, t23_19, t23_20, t23_21, t23_22;
  and #(2) (t23_0, p22, g21);
  and #(2) (t23_1, p22, p21, g20);
  and #(2) (t23_2, p22, p21, p20, g19);
  and #(2) (t23_3, p22, p21, p20, p19, g18);
  and #(2) (t23_4, p22, p21, p20, p19, p18, g17);
  and #(2) (t23_5, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t23_6, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t23_7, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t23_8, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t23_9, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t23_10, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t23_11, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t23_12, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t23_13, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t23_14, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t23_15, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t23_16, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t23_17, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t23_18, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t23_19, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t23_20, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t23_21, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t23_22, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c23, g22, t23_0, t23_1, t23_2, t23_3, t23_4, t23_5, t23_6, t23_7, t23_8, t23_9, t23_10, t23_11, t23_12, t23_13, t23_14, t23_15, t23_16, t23_17, t23_18, t23_19, t23_20, t23_21, t23_22);

  // finding c24 by using extra wire

  wire t24_0, t24_1, t24_2, t24_3, t24_4, t24_5, t24_6, t24_7, t24_8, t24_9, t24_10, t24_11, t24_12, t24_13, t24_14, t24_15, t24_16, t24_17, t24_18, t24_19, t24_20, t24_21, t24_22, t24_23;
  and #(2) (t24_0, p23, g22);
  and #(2) (t24_1, p23, p22, g21);
  and #(2) (t24_2, p23, p22, p21, g20);
  and #(2) (t24_3, p23, p22, p21, p20, g19);
  and #(2) (t24_4, p23, p22, p21, p20, p19, g18);
  and #(2) (t24_5, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t24_6, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t24_7, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t24_8, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t24_9, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t24_10, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t24_11, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t24_12, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t24_13, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t24_14, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t24_15, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t24_16, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t24_17, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t24_18, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t24_19, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t24_20, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t24_21, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t24_22, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t24_23, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c24, g23, t24_0, t24_1, t24_2, t24_3, t24_4, t24_5, t24_6, t24_7, t24_8, t24_9, t24_10, t24_11, t24_12, t24_13, t24_14, t24_15, t24_16, t24_17, t24_18, t24_19, t24_20, t24_21, t24_22, t24_23);

  // finding c25 by using extra wire

  wire t25_0, t25_1, t25_2, t25_3, t25_4, t25_5, t25_6, t25_7, t25_8, t25_9, t25_10, t25_11, t25_12, t25_13, t25_14, t25_15, t25_16, t25_17, t25_18, t25_19, t25_20, t25_21, t25_22, t25_23, t25_24;
  and #(2) (t25_0, p24, g23);
  and #(2) (t25_1, p24, p23, g22);
  and #(2) (t25_2, p24, p23, p22, g21);
  and #(2) (t25_3, p24, p23, p22, p21, g20);
  and #(2) (t25_4, p24, p23, p22, p21, p20, g19);
  and #(2) (t25_5, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t25_6, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t25_7, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t25_8, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t25_9, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t25_10, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t25_11, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t25_12, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t25_13, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t25_14, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t25_15, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t25_16, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t25_17, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t25_18, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t25_19, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t25_20, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t25_21, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t25_22, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t25_23, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t25_24, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c25, g24, t25_0, t25_1, t25_2, t25_3, t25_4, t25_5, t25_6, t25_7, t25_8, t25_9, t25_10, t25_11, t25_12, t25_13, t25_14, t25_15, t25_16, t25_17, t25_18, t25_19, t25_20, t25_21, t25_22, t25_23, t25_24);

  // finding c26 by using extra wire

  wire t26_0, t26_1, t26_2, t26_3, t26_4, t26_5, t26_6, t26_7, t26_8, t26_9, t26_10, t26_11, t26_12, t26_13, t26_14, t26_15, t26_16, t26_17, t26_18, t26_19, t26_20, t26_21, t26_22, t26_23, t26_24, t26_25;
  and #(2) (t26_0, p25, g24);
  and #(2) (t26_1, p25, p24, g23);
  and #(2) (t26_2, p25, p24, p23, g22);
  and #(2) (t26_3, p25, p24, p23, p22, g21);
  and #(2) (t26_4, p25, p24, p23, p22, p21, g20);
  and #(2) (t26_5, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t26_6, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t26_7, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t26_8, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t26_9, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t26_10, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t26_11, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t26_12, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t26_13, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t26_14, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t26_15, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t26_16, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t26_17, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t26_18, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t26_19, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t26_20, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t26_21, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t26_22, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t26_23, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t26_24, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t26_25, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c26, g25, t26_0, t26_1, t26_2, t26_3, t26_4, t26_5, t26_6, t26_7, t26_8, t26_9, t26_10, t26_11, t26_12, t26_13, t26_14, t26_15, t26_16, t26_17, t26_18, t26_19, t26_20, t26_21, t26_22, t26_23, t26_24, t26_25);

  // finding c27 by using extra wire

  wire t27_0, t27_1, t27_2, t27_3, t27_4, t27_5, t27_6, t27_7, t27_8, t27_9, t27_10, t27_11, t27_12, t27_13, t27_14, t27_15, t27_16, t27_17, t27_18, t27_19, t27_20, t27_21, t27_22, t27_23, t27_24, t27_25, t27_26;
  and #(2) (t27_0, p26, g25);
  and #(2) (t27_1, p26, p25, g24);
  and #(2) (t27_2, p26, p25, p24, g23);
  and #(2) (t27_3, p26, p25, p24, p23, g22);
  and #(2) (t27_4, p26, p25, p24, p23, p22, g21);
  and #(2) (t27_5, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t27_6, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t27_7, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t27_8, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t27_9, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t27_10, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t27_11, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t27_12, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t27_13, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t27_14, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t27_15, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t27_16, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t27_17, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t27_18, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t27_19, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t27_20, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t27_21, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t27_22, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t27_23, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t27_24, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t27_25, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t27_26, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c27, g26, t27_0, t27_1, t27_2, t27_3, t27_4, t27_5, t27_6, t27_7, t27_8, t27_9, t27_10, t27_11, t27_12, t27_13, t27_14, t27_15, t27_16, t27_17, t27_18, t27_19, t27_20, t27_21, t27_22, t27_23, t27_24, t27_25, t27_26);

  // finding c28 by using extra wire

  wire t28_0, t28_1, t28_2, t28_3, t28_4, t28_5, t28_6, t28_7, t28_8, t28_9, t28_10, t28_11, t28_12, t28_13, t28_14, t28_15, t28_16, t28_17, t28_18, t28_19, t28_20, t28_21, t28_22, t28_23, t28_24, t28_25, t28_26, t28_27;
  and #(2) (t28_0, p27, g26);
  and #(2) (t28_1, p27, p26, g25);
  and #(2) (t28_2, p27, p26, p25, g24);
  and #(2) (t28_3, p27, p26, p25, p24, g23);
  and #(2) (t28_4, p27, p26, p25, p24, p23, g22);
  and #(2) (t28_5, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t28_6, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t28_7, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t28_8, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t28_9, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t28_10, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t28_11, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t28_12, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t28_13, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t28_14, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t28_15, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t28_16, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t28_17, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t28_18, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t28_19, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t28_20, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t28_21, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t28_22, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t28_23, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t28_24, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t28_25, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t28_26, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t28_27, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c28, g27, t28_0, t28_1, t28_2, t28_3, t28_4, t28_5, t28_6, t28_7, t28_8, t28_9, t28_10, t28_11, t28_12, t28_13, t28_14, t28_15, t28_16, t28_17, t28_18, t28_19, t28_20, t28_21, t28_22, t28_23, t28_24, t28_25, t28_26, t28_27);

  // finding c29 by using extra wire

  wire t29_0, t29_1, t29_2, t29_3, t29_4, t29_5, t29_6, t29_7, t29_8, t29_9, t29_10, t29_11, t29_12, t29_13, t29_14, t29_15, t29_16, t29_17, t29_18, t29_19, t29_20, t29_21, t29_22, t29_23, t29_24, t29_25, t29_26, t29_27, t29_28;
  and #(2) (t29_0, p28, g27);
  and #(2) (t29_1, p28, p27, g26);
  and #(2) (t29_2, p28, p27, p26, g25);
  and #(2) (t29_3, p28, p27, p26, p25, g24);
  and #(2) (t29_4, p28, p27, p26, p25, p24, g23);
  and #(2) (t29_5, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t29_6, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t29_7, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t29_8, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t29_9, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t29_10, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t29_11, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t29_12, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t29_13, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t29_14, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t29_15, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t29_16, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t29_17, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t29_18, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t29_19, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t29_20, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t29_21, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t29_22, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t29_23, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t29_24, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t29_25, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t29_26, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t29_27, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t29_28, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c29, g28, t29_0, t29_1, t29_2, t29_3, t29_4, t29_5, t29_6, t29_7, t29_8, t29_9, t29_10, t29_11, t29_12, t29_13, t29_14, t29_15, t29_16, t29_17, t29_18, t29_19, t29_20, t29_21, t29_22, t29_23, t29_24, t29_25, t29_26, t29_27, t29_28);

  // finding c30 by using extra wire

  wire t30_0, t30_1, t30_2, t30_3, t30_4, t30_5, t30_6, t30_7, t30_8, t30_9, t30_10, t30_11, t30_12, t30_13, t30_14, t30_15, t30_16, t30_17, t30_18, t30_19, t30_20, t30_21, t30_22, t30_23, t30_24, t30_25, t30_26, t30_27, t30_28, t30_29;
  and #(2) (t30_0, p29, g28);
  and #(2) (t30_1, p29, p28, g27);
  and #(2) (t30_2, p29, p28, p27, g26);
  and #(2) (t30_3, p29, p28, p27, p26, g25);
  and #(2) (t30_4, p29, p28, p27, p26, p25, g24);
  and #(2) (t30_5, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t30_6, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t30_7, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t30_8, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t30_9, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t30_10, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t30_11, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t30_12, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t30_13, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t30_14, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t30_15, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t30_16, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t30_17, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t30_18, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t30_19, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t30_20, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t30_21, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t30_22, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t30_23, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t30_24, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t30_25, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t30_26, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t30_27, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t30_28, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t30_29, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c30, g29, t30_0, t30_1, t30_2, t30_3, t30_4, t30_5, t30_6, t30_7, t30_8, t30_9, t30_10, t30_11, t30_12, t30_13, t30_14, t30_15, t30_16, t30_17, t30_18, t30_19, t30_20, t30_21, t30_22, t30_23, t30_24, t30_25, t30_26, t30_27, t30_28, t30_29);

  // finding c31 by using extra wire

  wire t31_0, t31_1, t31_2, t31_3, t31_4, t31_5, t31_6, t31_7, t31_8, t31_9, t31_10, t31_11, t31_12, t31_13, t31_14, t31_15, t31_16, t31_17, t31_18, t31_19, t31_20, t31_21, t31_22, t31_23, t31_24, t31_25, t31_26, t31_27, t31_28, t31_29, t31_30;
  and #(2) (t31_0, p30, g29);
  and #(2) (t31_1, p30, p29, g28);
  and #(2) (t31_2, p30, p29, p28, g27);
  and #(2) (t31_3, p30, p29, p28, p27, g26);
  and #(2) (t31_4, p30, p29, p28, p27, p26, g25);
  and #(2) (t31_5, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t31_6, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t31_7, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t31_8, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t31_9, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t31_10, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t31_11, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t31_12, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t31_13, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t31_14, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t31_15, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t31_16, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t31_17, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t31_18, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t31_19, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t31_20, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t31_21, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t31_22, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t31_23, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t31_24, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t31_25, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t31_26, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t31_27, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t31_28, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t31_29, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t31_30, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c31, g30, t31_0, t31_1, t31_2, t31_3, t31_4, t31_5, t31_6, t31_7, t31_8, t31_9, t31_10, t31_11, t31_12, t31_13, t31_14, t31_15, t31_16, t31_17, t31_18, t31_19, t31_20, t31_21, t31_22, t31_23, t31_24, t31_25, t31_26, t31_27, t31_28, t31_29, t31_30);

  // finding c32 by using extra wire

  wire t32_0, t32_1, t32_2, t32_3, t32_4, t32_5, t32_6, t32_7, t32_8, t32_9, t32_10, t32_11, t32_12, t32_13, t32_14, t32_15, t32_16, t32_17, t32_18, t32_19, t32_20, t32_21, t32_22, t32_23, t32_24, t32_25, t32_26, t32_27, t32_28, t32_29, t32_30, t32_31;
  and #(2) (t32_0, p31, g30);
  and #(2) (t32_1, p31, p30, g29);
  and #(2) (t32_2, p31, p30, p29, g28);
  and #(2) (t32_3, p31, p30, p29, p28, g27);
  and #(2) (t32_4, p31, p30, p29, p28, p27, g26);
  and #(2) (t32_5, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t32_6, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t32_7, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t32_8, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t32_9, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t32_10, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t32_11, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t32_12, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t32_13, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t32_14, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t32_15, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t32_16, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t32_17, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t32_18, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t32_19, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t32_20, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t32_21, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t32_22, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t32_23, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t32_24, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t32_25, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t32_26, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t32_27, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t32_28, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t32_29, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t32_30, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t32_31, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c32, g31, t32_0, t32_1, t32_2, t32_3, t32_4, t32_5, t32_6, t32_7, t32_8, t32_9, t32_10, t32_11, t32_12, t32_13, t32_14, t32_15, t32_16, t32_17, t32_18, t32_19, t32_20, t32_21, t32_22, t32_23, t32_24, t32_25, t32_26, t32_27, t32_28, t32_29, t32_30, t32_31);

  // finding c33 by using extra wire

  wire t33_0, t33_1, t33_2, t33_3, t33_4, t33_5, t33_6, t33_7, t33_8, t33_9, t33_10, t33_11, t33_12, t33_13, t33_14, t33_15, t33_16, t33_17, t33_18, t33_19, t33_20, t33_21, t33_22, t33_23, t33_24, t33_25, t33_26, t33_27, t33_28, t33_29, t33_30, t33_31, t33_32;
  and #(2) (t33_0, p32, g31);
  and #(2) (t33_1, p32, p31, g30);
  and #(2) (t33_2, p32, p31, p30, g29);
  and #(2) (t33_3, p32, p31, p30, p29, g28);
  and #(2) (t33_4, p32, p31, p30, p29, p28, g27);
  and #(2) (t33_5, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t33_6, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t33_7, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t33_8, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t33_9, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t33_10, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t33_11, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t33_12, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t33_13, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t33_14, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t33_15, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t33_16, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t33_17, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t33_18, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t33_19, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t33_20, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t33_21, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t33_22, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t33_23, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t33_24, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t33_25, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t33_26, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t33_27, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t33_28, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t33_29, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t33_30, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t33_31, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t33_32, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c33, g32, t33_0, t33_1, t33_2, t33_3, t33_4, t33_5, t33_6, t33_7, t33_8, t33_9, t33_10, t33_11, t33_12, t33_13, t33_14, t33_15, t33_16, t33_17, t33_18, t33_19, t33_20, t33_21, t33_22, t33_23, t33_24, t33_25, t33_26, t33_27, t33_28, t33_29, t33_30, t33_31, t33_32);

  // finding c34 by using extra wire

  wire t34_0, t34_1, t34_2, t34_3, t34_4, t34_5, t34_6, t34_7, t34_8, t34_9, t34_10, t34_11, t34_12, t34_13, t34_14, t34_15, t34_16, t34_17, t34_18, t34_19, t34_20, t34_21, t34_22, t34_23, t34_24, t34_25, t34_26, t34_27, t34_28, t34_29, t34_30, t34_31, t34_32, t34_33;
  and #(2) (t34_0, p33, g32);
  and #(2) (t34_1, p33, p32, g31);
  and #(2) (t34_2, p33, p32, p31, g30);
  and #(2) (t34_3, p33, p32, p31, p30, g29);
  and #(2) (t34_4, p33, p32, p31, p30, p29, g28);
  and #(2) (t34_5, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t34_6, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t34_7, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t34_8, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t34_9, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t34_10, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t34_11, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t34_12, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t34_13, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t34_14, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t34_15, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t34_16, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t34_17, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t34_18, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t34_19, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t34_20, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t34_21, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t34_22, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t34_23, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t34_24, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t34_25, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t34_26, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t34_27, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t34_28, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t34_29, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t34_30, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t34_31, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t34_32, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t34_33, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c34, g33, t34_0, t34_1, t34_2, t34_3, t34_4, t34_5, t34_6, t34_7, t34_8, t34_9, t34_10, t34_11, t34_12, t34_13, t34_14, t34_15, t34_16, t34_17, t34_18, t34_19, t34_20, t34_21, t34_22, t34_23, t34_24, t34_25, t34_26, t34_27, t34_28, t34_29, t34_30, t34_31, t34_32, t34_33);

  // finding c35 by using extra wire

  wire t35_0, t35_1, t35_2, t35_3, t35_4, t35_5, t35_6, t35_7, t35_8, t35_9, t35_10, t35_11, t35_12, t35_13, t35_14, t35_15, t35_16, t35_17, t35_18, t35_19, t35_20, t35_21, t35_22, t35_23, t35_24, t35_25, t35_26, t35_27, t35_28, t35_29, t35_30, t35_31, t35_32, t35_33, t35_34;
  and #(2) (t35_0, p34, g33);
  and #(2) (t35_1, p34, p33, g32);
  and #(2) (t35_2, p34, p33, p32, g31);
  and #(2) (t35_3, p34, p33, p32, p31, g30);
  and #(2) (t35_4, p34, p33, p32, p31, p30, g29);
  and #(2) (t35_5, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t35_6, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t35_7, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t35_8, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t35_9, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t35_10, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t35_11, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t35_12, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t35_13, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t35_14, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t35_15, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t35_16, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t35_17, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t35_18, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t35_19, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t35_20, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t35_21, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t35_22, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t35_23, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t35_24, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t35_25, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t35_26, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t35_27, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t35_28, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t35_29, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t35_30, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t35_31, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t35_32, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t35_33, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t35_34, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c35, g34, t35_0, t35_1, t35_2, t35_3, t35_4, t35_5, t35_6, t35_7, t35_8, t35_9, t35_10, t35_11, t35_12, t35_13, t35_14, t35_15, t35_16, t35_17, t35_18, t35_19, t35_20, t35_21, t35_22, t35_23, t35_24, t35_25, t35_26, t35_27, t35_28, t35_29, t35_30, t35_31, t35_32, t35_33, t35_34);

  // finding c36 by using extra wire

  wire t36_0, t36_1, t36_2, t36_3, t36_4, t36_5, t36_6, t36_7, t36_8, t36_9, t36_10, t36_11, t36_12, t36_13, t36_14, t36_15, t36_16, t36_17, t36_18, t36_19, t36_20, t36_21, t36_22, t36_23, t36_24, t36_25, t36_26, t36_27, t36_28, t36_29, t36_30, t36_31, t36_32, t36_33, t36_34, t36_35;
  and #(2) (t36_0, p35, g34);
  and #(2) (t36_1, p35, p34, g33);
  and #(2) (t36_2, p35, p34, p33, g32);
  and #(2) (t36_3, p35, p34, p33, p32, g31);
  and #(2) (t36_4, p35, p34, p33, p32, p31, g30);
  and #(2) (t36_5, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t36_6, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t36_7, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t36_8, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t36_9, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t36_10, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t36_11, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t36_12, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t36_13, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t36_14, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t36_15, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t36_16, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t36_17, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t36_18, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t36_19, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t36_20, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t36_21, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t36_22, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t36_23, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t36_24, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t36_25, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t36_26, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t36_27, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t36_28, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t36_29, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t36_30, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t36_31, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t36_32, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t36_33, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t36_34, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t36_35, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c36, g35, t36_0, t36_1, t36_2, t36_3, t36_4, t36_5, t36_6, t36_7, t36_8, t36_9, t36_10, t36_11, t36_12, t36_13, t36_14, t36_15, t36_16, t36_17, t36_18, t36_19, t36_20, t36_21, t36_22, t36_23, t36_24, t36_25, t36_26, t36_27, t36_28, t36_29, t36_30, t36_31, t36_32, t36_33, t36_34, t36_35);

  // finding c37 by using extra wire

  wire t37_0, t37_1, t37_2, t37_3, t37_4, t37_5, t37_6, t37_7, t37_8, t37_9, t37_10, t37_11, t37_12, t37_13, t37_14, t37_15, t37_16, t37_17, t37_18, t37_19, t37_20, t37_21, t37_22, t37_23, t37_24, t37_25, t37_26, t37_27, t37_28, t37_29, t37_30, t37_31, t37_32, t37_33, t37_34, t37_35, t37_36;
  and #(2) (t37_0, p36, g35);
  and #(2) (t37_1, p36, p35, g34);
  and #(2) (t37_2, p36, p35, p34, g33);
  and #(2) (t37_3, p36, p35, p34, p33, g32);
  and #(2) (t37_4, p36, p35, p34, p33, p32, g31);
  and #(2) (t37_5, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t37_6, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t37_7, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t37_8, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t37_9, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t37_10, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t37_11, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t37_12, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t37_13, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t37_14, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t37_15, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t37_16, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t37_17, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t37_18, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t37_19, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t37_20, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t37_21, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t37_22, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t37_23, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t37_24, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t37_25, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t37_26, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t37_27, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t37_28, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t37_29, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t37_30, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t37_31, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t37_32, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t37_33, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t37_34, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t37_35, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t37_36, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c37, g36, t37_0, t37_1, t37_2, t37_3, t37_4, t37_5, t37_6, t37_7, t37_8, t37_9, t37_10, t37_11, t37_12, t37_13, t37_14, t37_15, t37_16, t37_17, t37_18, t37_19, t37_20, t37_21, t37_22, t37_23, t37_24, t37_25, t37_26, t37_27, t37_28, t37_29, t37_30, t37_31, t37_32, t37_33, t37_34, t37_35, t37_36);

  // finding c38 by using extra wire

  wire t38_0, t38_1, t38_2, t38_3, t38_4, t38_5, t38_6, t38_7, t38_8, t38_9, t38_10, t38_11, t38_12, t38_13, t38_14, t38_15, t38_16, t38_17, t38_18, t38_19, t38_20, t38_21, t38_22, t38_23, t38_24, t38_25, t38_26, t38_27, t38_28, t38_29, t38_30, t38_31, t38_32, t38_33, t38_34, t38_35, t38_36, t38_37;
  and #(2) (t38_0, p37, g36);
  and #(2) (t38_1, p37, p36, g35);
  and #(2) (t38_2, p37, p36, p35, g34);
  and #(2) (t38_3, p37, p36, p35, p34, g33);
  and #(2) (t38_4, p37, p36, p35, p34, p33, g32);
  and #(2) (t38_5, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t38_6, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t38_7, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t38_8, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t38_9, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t38_10, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t38_11, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t38_12, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t38_13, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t38_14, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t38_15, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t38_16, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t38_17, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t38_18, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t38_19, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t38_20, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t38_21, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t38_22, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t38_23, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t38_24, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t38_25, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t38_26, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t38_27, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t38_28, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t38_29, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t38_30, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t38_31, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t38_32, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t38_33, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t38_34, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t38_35, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t38_36, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t38_37, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c38, g37, t38_0, t38_1, t38_2, t38_3, t38_4, t38_5, t38_6, t38_7, t38_8, t38_9, t38_10, t38_11, t38_12, t38_13, t38_14, t38_15, t38_16, t38_17, t38_18, t38_19, t38_20, t38_21, t38_22, t38_23, t38_24, t38_25, t38_26, t38_27, t38_28, t38_29, t38_30, t38_31, t38_32, t38_33, t38_34, t38_35, t38_36, t38_37);

  // finding c39 by using extra wire

  wire t39_0, t39_1, t39_2, t39_3, t39_4, t39_5, t39_6, t39_7, t39_8, t39_9, t39_10, t39_11, t39_12, t39_13, t39_14, t39_15, t39_16, t39_17, t39_18, t39_19, t39_20, t39_21, t39_22, t39_23, t39_24, t39_25, t39_26, t39_27, t39_28, t39_29, t39_30, t39_31, t39_32, t39_33, t39_34, t39_35, t39_36, t39_37, t39_38;
  and #(2) (t39_0, p38, g37);
  and #(2) (t39_1, p38, p37, g36);
  and #(2) (t39_2, p38, p37, p36, g35);
  and #(2) (t39_3, p38, p37, p36, p35, g34);
  and #(2) (t39_4, p38, p37, p36, p35, p34, g33);
  and #(2) (t39_5, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t39_6, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t39_7, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t39_8, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t39_9, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t39_10, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t39_11, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t39_12, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t39_13, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t39_14, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t39_15, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t39_16, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t39_17, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t39_18, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t39_19, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t39_20, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t39_21, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t39_22, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t39_23, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t39_24, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t39_25, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t39_26, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t39_27, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t39_28, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t39_29, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t39_30, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t39_31, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t39_32, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t39_33, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t39_34, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t39_35, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t39_36, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t39_37, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t39_38, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c39, g38, t39_0, t39_1, t39_2, t39_3, t39_4, t39_5, t39_6, t39_7, t39_8, t39_9, t39_10, t39_11, t39_12, t39_13, t39_14, t39_15, t39_16, t39_17, t39_18, t39_19, t39_20, t39_21, t39_22, t39_23, t39_24, t39_25, t39_26, t39_27, t39_28, t39_29, t39_30, t39_31, t39_32, t39_33, t39_34, t39_35, t39_36, t39_37, t39_38);

  // finding c40 by using extra wire

  wire t40_0, t40_1, t40_2, t40_3, t40_4, t40_5, t40_6, t40_7, t40_8, t40_9, t40_10, t40_11, t40_12, t40_13, t40_14, t40_15, t40_16, t40_17, t40_18, t40_19, t40_20, t40_21, t40_22, t40_23, t40_24, t40_25, t40_26, t40_27, t40_28, t40_29, t40_30, t40_31, t40_32, t40_33, t40_34, t40_35, t40_36, t40_37, t40_38, t40_39;
  and #(2) (t40_0, p39, g38);
  and #(2) (t40_1, p39, p38, g37);
  and #(2) (t40_2, p39, p38, p37, g36);
  and #(2) (t40_3, p39, p38, p37, p36, g35);
  and #(2) (t40_4, p39, p38, p37, p36, p35, g34);
  and #(2) (t40_5, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t40_6, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t40_7, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t40_8, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t40_9, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t40_10, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t40_11, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t40_12, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t40_13, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t40_14, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t40_15, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t40_16, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t40_17, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t40_18, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t40_19, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t40_20, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t40_21, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t40_22, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t40_23, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t40_24, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t40_25, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t40_26, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t40_27, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t40_28, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t40_29, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t40_30, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t40_31, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t40_32, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t40_33, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t40_34, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t40_35, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t40_36, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t40_37, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t40_38, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t40_39, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c40, g39, t40_0, t40_1, t40_2, t40_3, t40_4, t40_5, t40_6, t40_7, t40_8, t40_9, t40_10, t40_11, t40_12, t40_13, t40_14, t40_15, t40_16, t40_17, t40_18, t40_19, t40_20, t40_21, t40_22, t40_23, t40_24, t40_25, t40_26, t40_27, t40_28, t40_29, t40_30, t40_31, t40_32, t40_33, t40_34, t40_35, t40_36, t40_37, t40_38, t40_39);

  // finding c41 by using extra wire

  wire t41_0, t41_1, t41_2, t41_3, t41_4, t41_5, t41_6, t41_7, t41_8, t41_9, t41_10, t41_11, t41_12, t41_13, t41_14, t41_15, t41_16, t41_17, t41_18, t41_19, t41_20, t41_21, t41_22, t41_23, t41_24, t41_25, t41_26, t41_27, t41_28, t41_29, t41_30, t41_31, t41_32, t41_33, t41_34, t41_35, t41_36, t41_37, t41_38, t41_39, t41_40;
  and #(2) (t41_0, p40, g39);
  and #(2) (t41_1, p40, p39, g38);
  and #(2) (t41_2, p40, p39, p38, g37);
  and #(2) (t41_3, p40, p39, p38, p37, g36);
  and #(2) (t41_4, p40, p39, p38, p37, p36, g35);
  and #(2) (t41_5, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t41_6, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t41_7, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t41_8, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t41_9, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t41_10, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t41_11, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t41_12, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t41_13, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t41_14, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t41_15, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t41_16, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t41_17, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t41_18, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t41_19, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t41_20, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t41_21, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t41_22, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t41_23, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t41_24, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t41_25, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t41_26, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t41_27, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t41_28, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t41_29, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t41_30, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t41_31, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t41_32, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t41_33, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t41_34, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t41_35, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t41_36, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t41_37, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t41_38, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t41_39, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t41_40, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c41, g40, t41_0, t41_1, t41_2, t41_3, t41_4, t41_5, t41_6, t41_7, t41_8, t41_9, t41_10, t41_11, t41_12, t41_13, t41_14, t41_15, t41_16, t41_17, t41_18, t41_19, t41_20, t41_21, t41_22, t41_23, t41_24, t41_25, t41_26, t41_27, t41_28, t41_29, t41_30, t41_31, t41_32, t41_33, t41_34, t41_35, t41_36, t41_37, t41_38, t41_39, t41_40);

  // finding c42 by using extra wire

  wire t42_0, t42_1, t42_2, t42_3, t42_4, t42_5, t42_6, t42_7, t42_8, t42_9, t42_10, t42_11, t42_12, t42_13, t42_14, t42_15, t42_16, t42_17, t42_18, t42_19, t42_20, t42_21, t42_22, t42_23, t42_24, t42_25, t42_26, t42_27, t42_28, t42_29, t42_30, t42_31, t42_32, t42_33, t42_34, t42_35, t42_36, t42_37, t42_38, t42_39, t42_40, t42_41;
  and #(2) (t42_0, p41, g40);
  and #(2) (t42_1, p41, p40, g39);
  and #(2) (t42_2, p41, p40, p39, g38);
  and #(2) (t42_3, p41, p40, p39, p38, g37);
  and #(2) (t42_4, p41, p40, p39, p38, p37, g36);
  and #(2) (t42_5, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t42_6, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t42_7, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t42_8, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t42_9, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t42_10, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t42_11, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t42_12, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t42_13, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t42_14, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t42_15, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t42_16, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t42_17, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t42_18, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t42_19, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t42_20, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t42_21, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t42_22, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t42_23, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t42_24, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t42_25, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t42_26, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t42_27, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t42_28, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t42_29, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t42_30, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t42_31, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t42_32, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t42_33, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t42_34, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t42_35, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t42_36, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t42_37, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t42_38, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t42_39, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t42_40, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t42_41, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c42, g41, t42_0, t42_1, t42_2, t42_3, t42_4, t42_5, t42_6, t42_7, t42_8, t42_9, t42_10, t42_11, t42_12, t42_13, t42_14, t42_15, t42_16, t42_17, t42_18, t42_19, t42_20, t42_21, t42_22, t42_23, t42_24, t42_25, t42_26, t42_27, t42_28, t42_29, t42_30, t42_31, t42_32, t42_33, t42_34, t42_35, t42_36, t42_37, t42_38, t42_39, t42_40, t42_41);

  // finding c43 by using extra wire

  wire t43_0, t43_1, t43_2, t43_3, t43_4, t43_5, t43_6, t43_7, t43_8, t43_9, t43_10, t43_11, t43_12, t43_13, t43_14, t43_15, t43_16, t43_17, t43_18, t43_19, t43_20, t43_21, t43_22, t43_23, t43_24, t43_25, t43_26, t43_27, t43_28, t43_29, t43_30, t43_31, t43_32, t43_33, t43_34, t43_35, t43_36, t43_37, t43_38, t43_39, t43_40, t43_41, t43_42;
  and #(2) (t43_0, p42, g41);
  and #(2) (t43_1, p42, p41, g40);
  and #(2) (t43_2, p42, p41, p40, g39);
  and #(2) (t43_3, p42, p41, p40, p39, g38);
  and #(2) (t43_4, p42, p41, p40, p39, p38, g37);
  and #(2) (t43_5, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t43_6, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t43_7, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t43_8, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t43_9, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t43_10, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t43_11, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t43_12, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t43_13, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t43_14, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t43_15, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t43_16, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t43_17, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t43_18, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t43_19, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t43_20, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t43_21, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t43_22, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t43_23, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t43_24, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t43_25, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t43_26, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t43_27, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t43_28, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t43_29, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t43_30, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t43_31, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t43_32, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t43_33, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t43_34, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t43_35, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t43_36, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t43_37, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t43_38, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t43_39, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t43_40, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t43_41, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t43_42, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c43, g42, t43_0, t43_1, t43_2, t43_3, t43_4, t43_5, t43_6, t43_7, t43_8, t43_9, t43_10, t43_11, t43_12, t43_13, t43_14, t43_15, t43_16, t43_17, t43_18, t43_19, t43_20, t43_21, t43_22, t43_23, t43_24, t43_25, t43_26, t43_27, t43_28, t43_29, t43_30, t43_31, t43_32, t43_33, t43_34, t43_35, t43_36, t43_37, t43_38, t43_39, t43_40, t43_41, t43_42);

  // finding c44 by using extra wire

  wire t44_0, t44_1, t44_2, t44_3, t44_4, t44_5, t44_6, t44_7, t44_8, t44_9, t44_10, t44_11, t44_12, t44_13, t44_14, t44_15, t44_16, t44_17, t44_18, t44_19, t44_20, t44_21, t44_22, t44_23, t44_24, t44_25, t44_26, t44_27, t44_28, t44_29, t44_30, t44_31, t44_32, t44_33, t44_34, t44_35, t44_36, t44_37, t44_38, t44_39, t44_40, t44_41, t44_42, t44_43;
  and #(2) (t44_0, p43, g42);
  and #(2) (t44_1, p43, p42, g41);
  and #(2) (t44_2, p43, p42, p41, g40);
  and #(2) (t44_3, p43, p42, p41, p40, g39);
  and #(2) (t44_4, p43, p42, p41, p40, p39, g38);
  and #(2) (t44_5, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t44_6, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t44_7, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t44_8, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t44_9, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t44_10, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t44_11, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t44_12, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t44_13, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t44_14, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t44_15, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t44_16, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t44_17, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t44_18, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t44_19, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t44_20, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t44_21, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t44_22, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t44_23, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t44_24, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t44_25, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t44_26, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t44_27, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t44_28, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t44_29, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t44_30, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t44_31, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t44_32, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t44_33, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t44_34, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t44_35, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t44_36, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t44_37, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t44_38, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t44_39, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t44_40, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t44_41, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t44_42, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t44_43, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c44, g43, t44_0, t44_1, t44_2, t44_3, t44_4, t44_5, t44_6, t44_7, t44_8, t44_9, t44_10, t44_11, t44_12, t44_13, t44_14, t44_15, t44_16, t44_17, t44_18, t44_19, t44_20, t44_21, t44_22, t44_23, t44_24, t44_25, t44_26, t44_27, t44_28, t44_29, t44_30, t44_31, t44_32, t44_33, t44_34, t44_35, t44_36, t44_37, t44_38, t44_39, t44_40, t44_41, t44_42, t44_43);

  // finding c45 by using extra wire

  wire t45_0, t45_1, t45_2, t45_3, t45_4, t45_5, t45_6, t45_7, t45_8, t45_9, t45_10, t45_11, t45_12, t45_13, t45_14, t45_15, t45_16, t45_17, t45_18, t45_19, t45_20, t45_21, t45_22, t45_23, t45_24, t45_25, t45_26, t45_27, t45_28, t45_29, t45_30, t45_31, t45_32, t45_33, t45_34, t45_35, t45_36, t45_37, t45_38, t45_39, t45_40, t45_41, t45_42, t45_43, t45_44;
  and #(2) (t45_0, p44, g43);
  and #(2) (t45_1, p44, p43, g42);
  and #(2) (t45_2, p44, p43, p42, g41);
  and #(2) (t45_3, p44, p43, p42, p41, g40);
  and #(2) (t45_4, p44, p43, p42, p41, p40, g39);
  and #(2) (t45_5, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t45_6, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t45_7, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t45_8, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t45_9, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t45_10, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t45_11, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t45_12, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t45_13, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t45_14, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t45_15, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t45_16, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t45_17, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t45_18, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t45_19, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t45_20, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t45_21, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t45_22, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t45_23, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t45_24, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t45_25, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t45_26, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t45_27, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t45_28, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t45_29, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t45_30, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t45_31, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t45_32, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t45_33, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t45_34, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t45_35, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t45_36, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t45_37, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t45_38, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t45_39, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t45_40, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t45_41, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t45_42, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t45_43, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t45_44, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c45, g44, t45_0, t45_1, t45_2, t45_3, t45_4, t45_5, t45_6, t45_7, t45_8, t45_9, t45_10, t45_11, t45_12, t45_13, t45_14, t45_15, t45_16, t45_17, t45_18, t45_19, t45_20, t45_21, t45_22, t45_23, t45_24, t45_25, t45_26, t45_27, t45_28, t45_29, t45_30, t45_31, t45_32, t45_33, t45_34, t45_35, t45_36, t45_37, t45_38, t45_39, t45_40, t45_41, t45_42, t45_43, t45_44);

  // finding c46 by using extra wire

  wire t46_0, t46_1, t46_2, t46_3, t46_4, t46_5, t46_6, t46_7, t46_8, t46_9, t46_10, t46_11, t46_12, t46_13, t46_14, t46_15, t46_16, t46_17, t46_18, t46_19, t46_20, t46_21, t46_22, t46_23, t46_24, t46_25, t46_26, t46_27, t46_28, t46_29, t46_30, t46_31, t46_32, t46_33, t46_34, t46_35, t46_36, t46_37, t46_38, t46_39, t46_40, t46_41, t46_42, t46_43, t46_44, t46_45;
  and #(2) (t46_0, p45, g44);
  and #(2) (t46_1, p45, p44, g43);
  and #(2) (t46_2, p45, p44, p43, g42);
  and #(2) (t46_3, p45, p44, p43, p42, g41);
  and #(2) (t46_4, p45, p44, p43, p42, p41, g40);
  and #(2) (t46_5, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t46_6, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t46_7, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t46_8, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t46_9, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t46_10, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t46_11, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t46_12, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t46_13, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t46_14, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t46_15, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t46_16, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t46_17, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t46_18, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t46_19, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t46_20, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t46_21, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t46_22, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t46_23, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t46_24, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t46_25, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t46_26, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t46_27, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t46_28, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t46_29, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t46_30, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t46_31, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t46_32, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t46_33, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t46_34, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t46_35, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t46_36, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t46_37, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t46_38, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t46_39, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t46_40, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t46_41, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t46_42, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t46_43, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t46_44, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t46_45, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c46, g45, t46_0, t46_1, t46_2, t46_3, t46_4, t46_5, t46_6, t46_7, t46_8, t46_9, t46_10, t46_11, t46_12, t46_13, t46_14, t46_15, t46_16, t46_17, t46_18, t46_19, t46_20, t46_21, t46_22, t46_23, t46_24, t46_25, t46_26, t46_27, t46_28, t46_29, t46_30, t46_31, t46_32, t46_33, t46_34, t46_35, t46_36, t46_37, t46_38, t46_39, t46_40, t46_41, t46_42, t46_43, t46_44, t46_45);

  // finding c47 by using extra wire

  wire t47_0, t47_1, t47_2, t47_3, t47_4, t47_5, t47_6, t47_7, t47_8, t47_9, t47_10, t47_11, t47_12, t47_13, t47_14, t47_15, t47_16, t47_17, t47_18, t47_19, t47_20, t47_21, t47_22, t47_23, t47_24, t47_25, t47_26, t47_27, t47_28, t47_29, t47_30, t47_31, t47_32, t47_33, t47_34, t47_35, t47_36, t47_37, t47_38, t47_39, t47_40, t47_41, t47_42, t47_43, t47_44, t47_45, t47_46;
  and #(2) (t47_0, p46, g45);
  and #(2) (t47_1, p46, p45, g44);
  and #(2) (t47_2, p46, p45, p44, g43);
  and #(2) (t47_3, p46, p45, p44, p43, g42);
  and #(2) (t47_4, p46, p45, p44, p43, p42, g41);
  and #(2) (t47_5, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t47_6, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t47_7, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t47_8, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t47_9, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t47_10, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t47_11, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t47_12, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t47_13, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t47_14, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t47_15, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t47_16, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t47_17, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t47_18, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t47_19, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t47_20, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t47_21, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t47_22, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t47_23, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t47_24, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t47_25, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t47_26, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t47_27, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t47_28, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t47_29, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t47_30, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t47_31, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t47_32, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t47_33, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t47_34, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t47_35, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t47_36, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t47_37, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t47_38, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t47_39, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t47_40, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t47_41, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t47_42, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t47_43, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t47_44, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t47_45, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t47_46, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c47, g46, t47_0, t47_1, t47_2, t47_3, t47_4, t47_5, t47_6, t47_7, t47_8, t47_9, t47_10, t47_11, t47_12, t47_13, t47_14, t47_15, t47_16, t47_17, t47_18, t47_19, t47_20, t47_21, t47_22, t47_23, t47_24, t47_25, t47_26, t47_27, t47_28, t47_29, t47_30, t47_31, t47_32, t47_33, t47_34, t47_35, t47_36, t47_37, t47_38, t47_39, t47_40, t47_41, t47_42, t47_43, t47_44, t47_45, t47_46);

  // finding c48 by using extra wire

  wire t48_0, t48_1, t48_2, t48_3, t48_4, t48_5, t48_6, t48_7, t48_8, t48_9, t48_10, t48_11, t48_12, t48_13, t48_14, t48_15, t48_16, t48_17, t48_18, t48_19, t48_20, t48_21, t48_22, t48_23, t48_24, t48_25, t48_26, t48_27, t48_28, t48_29, t48_30, t48_31, t48_32, t48_33, t48_34, t48_35, t48_36, t48_37, t48_38, t48_39, t48_40, t48_41, t48_42, t48_43, t48_44, t48_45, t48_46, t48_47;
  and #(2) (t48_0, p47, g46);
  and #(2) (t48_1, p47, p46, g45);
  and #(2) (t48_2, p47, p46, p45, g44);
  and #(2) (t48_3, p47, p46, p45, p44, g43);
  and #(2) (t48_4, p47, p46, p45, p44, p43, g42);
  and #(2) (t48_5, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t48_6, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t48_7, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t48_8, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t48_9, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t48_10, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t48_11, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t48_12, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t48_13, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t48_14, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t48_15, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t48_16, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t48_17, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t48_18, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t48_19, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t48_20, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t48_21, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t48_22, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t48_23, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t48_24, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t48_25, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t48_26, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t48_27, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t48_28, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t48_29, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t48_30, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t48_31, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t48_32, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t48_33, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t48_34, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t48_35, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t48_36, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t48_37, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t48_38, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t48_39, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t48_40, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t48_41, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t48_42, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t48_43, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t48_44, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t48_45, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t48_46, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t48_47, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c48, g47, t48_0, t48_1, t48_2, t48_3, t48_4, t48_5, t48_6, t48_7, t48_8, t48_9, t48_10, t48_11, t48_12, t48_13, t48_14, t48_15, t48_16, t48_17, t48_18, t48_19, t48_20, t48_21, t48_22, t48_23, t48_24, t48_25, t48_26, t48_27, t48_28, t48_29, t48_30, t48_31, t48_32, t48_33, t48_34, t48_35, t48_36, t48_37, t48_38, t48_39, t48_40, t48_41, t48_42, t48_43, t48_44, t48_45, t48_46, t48_47);

  // finding c49 by using extra wire

  wire t49_0, t49_1, t49_2, t49_3, t49_4, t49_5, t49_6, t49_7, t49_8, t49_9, t49_10, t49_11, t49_12, t49_13, t49_14, t49_15, t49_16, t49_17, t49_18, t49_19, t49_20, t49_21, t49_22, t49_23, t49_24, t49_25, t49_26, t49_27, t49_28, t49_29, t49_30, t49_31, t49_32, t49_33, t49_34, t49_35, t49_36, t49_37, t49_38, t49_39, t49_40, t49_41, t49_42, t49_43, t49_44, t49_45, t49_46, t49_47, t49_48;
  and #(2) (t49_0, p48, g47);
  and #(2) (t49_1, p48, p47, g46);
  and #(2) (t49_2, p48, p47, p46, g45);
  and #(2) (t49_3, p48, p47, p46, p45, g44);
  and #(2) (t49_4, p48, p47, p46, p45, p44, g43);
  and #(2) (t49_5, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t49_6, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t49_7, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t49_8, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t49_9, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t49_10, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t49_11, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t49_12, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t49_13, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t49_14, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t49_15, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t49_16, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t49_17, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t49_18, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t49_19, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t49_20, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t49_21, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t49_22, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t49_23, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t49_24, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t49_25, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t49_26, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t49_27, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t49_28, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t49_29, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t49_30, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t49_31, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t49_32, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t49_33, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t49_34, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t49_35, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t49_36, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t49_37, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t49_38, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t49_39, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t49_40, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t49_41, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t49_42, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t49_43, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t49_44, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t49_45, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t49_46, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t49_47, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t49_48, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c49, g48, t49_0, t49_1, t49_2, t49_3, t49_4, t49_5, t49_6, t49_7, t49_8, t49_9, t49_10, t49_11, t49_12, t49_13, t49_14, t49_15, t49_16, t49_17, t49_18, t49_19, t49_20, t49_21, t49_22, t49_23, t49_24, t49_25, t49_26, t49_27, t49_28, t49_29, t49_30, t49_31, t49_32, t49_33, t49_34, t49_35, t49_36, t49_37, t49_38, t49_39, t49_40, t49_41, t49_42, t49_43, t49_44, t49_45, t49_46, t49_47, t49_48);

  // finding c50 by using extra wire

  wire t50_0, t50_1, t50_2, t50_3, t50_4, t50_5, t50_6, t50_7, t50_8, t50_9, t50_10, t50_11, t50_12, t50_13, t50_14, t50_15, t50_16, t50_17, t50_18, t50_19, t50_20, t50_21, t50_22, t50_23, t50_24, t50_25, t50_26, t50_27, t50_28, t50_29, t50_30, t50_31, t50_32, t50_33, t50_34, t50_35, t50_36, t50_37, t50_38, t50_39, t50_40, t50_41, t50_42, t50_43, t50_44, t50_45, t50_46, t50_47, t50_48, t50_49;
  and #(2) (t50_0, p49, g48);
  and #(2) (t50_1, p49, p48, g47);
  and #(2) (t50_2, p49, p48, p47, g46);
  and #(2) (t50_3, p49, p48, p47, p46, g45);
  and #(2) (t50_4, p49, p48, p47, p46, p45, g44);
  and #(2) (t50_5, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t50_6, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t50_7, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t50_8, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t50_9, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t50_10, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t50_11, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t50_12, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t50_13, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t50_14, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t50_15, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t50_16, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t50_17, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t50_18, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t50_19, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t50_20, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t50_21, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t50_22, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t50_23, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t50_24, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t50_25, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t50_26, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t50_27, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t50_28, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t50_29, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t50_30, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t50_31, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t50_32, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t50_33, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t50_34, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t50_35, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t50_36, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t50_37, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t50_38, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t50_39, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t50_40, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t50_41, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t50_42, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t50_43, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t50_44, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t50_45, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t50_46, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t50_47, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t50_48, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t50_49, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c50, g49, t50_0, t50_1, t50_2, t50_3, t50_4, t50_5, t50_6, t50_7, t50_8, t50_9, t50_10, t50_11, t50_12, t50_13, t50_14, t50_15, t50_16, t50_17, t50_18, t50_19, t50_20, t50_21, t50_22, t50_23, t50_24, t50_25, t50_26, t50_27, t50_28, t50_29, t50_30, t50_31, t50_32, t50_33, t50_34, t50_35, t50_36, t50_37, t50_38, t50_39, t50_40, t50_41, t50_42, t50_43, t50_44, t50_45, t50_46, t50_47, t50_48, t50_49);

  // finding c51 by using extra wire

  wire t51_0, t51_1, t51_2, t51_3, t51_4, t51_5, t51_6, t51_7, t51_8, t51_9, t51_10, t51_11, t51_12, t51_13, t51_14, t51_15, t51_16, t51_17, t51_18, t51_19, t51_20, t51_21, t51_22, t51_23, t51_24, t51_25, t51_26, t51_27, t51_28, t51_29, t51_30, t51_31, t51_32, t51_33, t51_34, t51_35, t51_36, t51_37, t51_38, t51_39, t51_40, t51_41, t51_42, t51_43, t51_44, t51_45, t51_46, t51_47, t51_48, t51_49, t51_50;
  and #(2) (t51_0, p50, g49);
  and #(2) (t51_1, p50, p49, g48);
  and #(2) (t51_2, p50, p49, p48, g47);
  and #(2) (t51_3, p50, p49, p48, p47, g46);
  and #(2) (t51_4, p50, p49, p48, p47, p46, g45);
  and #(2) (t51_5, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t51_6, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t51_7, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t51_8, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t51_9, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t51_10, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t51_11, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t51_12, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t51_13, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t51_14, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t51_15, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t51_16, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t51_17, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t51_18, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t51_19, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t51_20, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t51_21, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t51_22, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t51_23, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t51_24, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t51_25, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t51_26, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t51_27, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t51_28, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t51_29, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t51_30, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t51_31, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t51_32, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t51_33, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t51_34, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t51_35, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t51_36, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t51_37, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t51_38, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t51_39, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t51_40, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t51_41, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t51_42, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t51_43, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t51_44, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t51_45, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t51_46, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t51_47, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t51_48, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t51_49, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t51_50, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c51, g50, t51_0, t51_1, t51_2, t51_3, t51_4, t51_5, t51_6, t51_7, t51_8, t51_9, t51_10, t51_11, t51_12, t51_13, t51_14, t51_15, t51_16, t51_17, t51_18, t51_19, t51_20, t51_21, t51_22, t51_23, t51_24, t51_25, t51_26, t51_27, t51_28, t51_29, t51_30, t51_31, t51_32, t51_33, t51_34, t51_35, t51_36, t51_37, t51_38, t51_39, t51_40, t51_41, t51_42, t51_43, t51_44, t51_45, t51_46, t51_47, t51_48, t51_49, t51_50);

  // finding c52 by using extra wire

  wire t52_0, t52_1, t52_2, t52_3, t52_4, t52_5, t52_6, t52_7, t52_8, t52_9, t52_10, t52_11, t52_12, t52_13, t52_14, t52_15, t52_16, t52_17, t52_18, t52_19, t52_20, t52_21, t52_22, t52_23, t52_24, t52_25, t52_26, t52_27, t52_28, t52_29, t52_30, t52_31, t52_32, t52_33, t52_34, t52_35, t52_36, t52_37, t52_38, t52_39, t52_40, t52_41, t52_42, t52_43, t52_44, t52_45, t52_46, t52_47, t52_48, t52_49, t52_50, t52_51;
  and #(2) (t52_0, p51, g50);
  and #(2) (t52_1, p51, p50, g49);
  and #(2) (t52_2, p51, p50, p49, g48);
  and #(2) (t52_3, p51, p50, p49, p48, g47);
  and #(2) (t52_4, p51, p50, p49, p48, p47, g46);
  and #(2) (t52_5, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t52_6, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t52_7, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t52_8, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t52_9, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t52_10, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t52_11, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t52_12, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t52_13, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t52_14, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t52_15, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t52_16, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t52_17, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t52_18, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t52_19, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t52_20, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t52_21, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t52_22, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t52_23, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t52_24, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t52_25, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t52_26, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t52_27, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t52_28, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t52_29, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t52_30, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t52_31, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t52_32, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t52_33, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t52_34, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t52_35, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t52_36, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t52_37, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t52_38, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t52_39, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t52_40, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t52_41, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t52_42, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t52_43, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t52_44, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t52_45, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t52_46, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t52_47, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t52_48, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t52_49, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t52_50, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t52_51, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c52, g51, t52_0, t52_1, t52_2, t52_3, t52_4, t52_5, t52_6, t52_7, t52_8, t52_9, t52_10, t52_11, t52_12, t52_13, t52_14, t52_15, t52_16, t52_17, t52_18, t52_19, t52_20, t52_21, t52_22, t52_23, t52_24, t52_25, t52_26, t52_27, t52_28, t52_29, t52_30, t52_31, t52_32, t52_33, t52_34, t52_35, t52_36, t52_37, t52_38, t52_39, t52_40, t52_41, t52_42, t52_43, t52_44, t52_45, t52_46, t52_47, t52_48, t52_49, t52_50, t52_51);

  // finding c53 by using extra wire

  wire t53_0, t53_1, t53_2, t53_3, t53_4, t53_5, t53_6, t53_7, t53_8, t53_9, t53_10, t53_11, t53_12, t53_13, t53_14, t53_15, t53_16, t53_17, t53_18, t53_19, t53_20, t53_21, t53_22, t53_23, t53_24, t53_25, t53_26, t53_27, t53_28, t53_29, t53_30, t53_31, t53_32, t53_33, t53_34, t53_35, t53_36, t53_37, t53_38, t53_39, t53_40, t53_41, t53_42, t53_43, t53_44, t53_45, t53_46, t53_47, t53_48, t53_49, t53_50, t53_51, t53_52;
  and #(2) (t53_0, p52, g51);
  and #(2) (t53_1, p52, p51, g50);
  and #(2) (t53_2, p52, p51, p50, g49);
  and #(2) (t53_3, p52, p51, p50, p49, g48);
  and #(2) (t53_4, p52, p51, p50, p49, p48, g47);
  and #(2) (t53_5, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t53_6, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t53_7, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t53_8, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t53_9, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t53_10, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t53_11, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t53_12, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t53_13, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t53_14, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t53_15, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t53_16, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t53_17, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t53_18, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t53_19, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t53_20, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t53_21, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t53_22, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t53_23, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t53_24, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t53_25, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t53_26, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t53_27, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t53_28, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t53_29, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t53_30, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t53_31, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t53_32, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t53_33, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t53_34, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t53_35, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t53_36, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t53_37, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t53_38, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t53_39, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t53_40, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t53_41, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t53_42, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t53_43, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t53_44, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t53_45, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t53_46, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t53_47, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t53_48, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t53_49, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t53_50, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t53_51, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t53_52, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c53, g52, t53_0, t53_1, t53_2, t53_3, t53_4, t53_5, t53_6, t53_7, t53_8, t53_9, t53_10, t53_11, t53_12, t53_13, t53_14, t53_15, t53_16, t53_17, t53_18, t53_19, t53_20, t53_21, t53_22, t53_23, t53_24, t53_25, t53_26, t53_27, t53_28, t53_29, t53_30, t53_31, t53_32, t53_33, t53_34, t53_35, t53_36, t53_37, t53_38, t53_39, t53_40, t53_41, t53_42, t53_43, t53_44, t53_45, t53_46, t53_47, t53_48, t53_49, t53_50, t53_51, t53_52);

  // finding c54 by using extra wire

  wire t54_0, t54_1, t54_2, t54_3, t54_4, t54_5, t54_6, t54_7, t54_8, t54_9, t54_10, t54_11, t54_12, t54_13, t54_14, t54_15, t54_16, t54_17, t54_18, t54_19, t54_20, t54_21, t54_22, t54_23, t54_24, t54_25, t54_26, t54_27, t54_28, t54_29, t54_30, t54_31, t54_32, t54_33, t54_34, t54_35, t54_36, t54_37, t54_38, t54_39, t54_40, t54_41, t54_42, t54_43, t54_44, t54_45, t54_46, t54_47, t54_48, t54_49, t54_50, t54_51, t54_52, t54_53;
  and #(2) (t54_0, p53, g52);
  and #(2) (t54_1, p53, p52, g51);
  and #(2) (t54_2, p53, p52, p51, g50);
  and #(2) (t54_3, p53, p52, p51, p50, g49);
  and #(2) (t54_4, p53, p52, p51, p50, p49, g48);
  and #(2) (t54_5, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t54_6, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t54_7, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t54_8, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t54_9, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t54_10, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t54_11, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t54_12, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t54_13, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t54_14, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t54_15, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t54_16, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t54_17, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t54_18, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t54_19, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t54_20, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t54_21, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t54_22, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t54_23, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t54_24, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t54_25, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t54_26, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t54_27, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t54_28, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t54_29, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t54_30, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t54_31, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t54_32, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t54_33, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t54_34, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t54_35, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t54_36, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t54_37, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t54_38, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t54_39, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t54_40, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t54_41, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t54_42, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t54_43, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t54_44, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t54_45, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t54_46, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t54_47, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t54_48, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t54_49, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t54_50, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t54_51, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t54_52, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t54_53, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c54, g53, t54_0, t54_1, t54_2, t54_3, t54_4, t54_5, t54_6, t54_7, t54_8, t54_9, t54_10, t54_11, t54_12, t54_13, t54_14, t54_15, t54_16, t54_17, t54_18, t54_19, t54_20, t54_21, t54_22, t54_23, t54_24, t54_25, t54_26, t54_27, t54_28, t54_29, t54_30, t54_31, t54_32, t54_33, t54_34, t54_35, t54_36, t54_37, t54_38, t54_39, t54_40, t54_41, t54_42, t54_43, t54_44, t54_45, t54_46, t54_47, t54_48, t54_49, t54_50, t54_51, t54_52, t54_53);

  // finding c55 by using extra wire

  wire t55_0, t55_1, t55_2, t55_3, t55_4, t55_5, t55_6, t55_7, t55_8, t55_9, t55_10, t55_11, t55_12, t55_13, t55_14, t55_15, t55_16, t55_17, t55_18, t55_19, t55_20, t55_21, t55_22, t55_23, t55_24, t55_25, t55_26, t55_27, t55_28, t55_29, t55_30, t55_31, t55_32, t55_33, t55_34, t55_35, t55_36, t55_37, t55_38, t55_39, t55_40, t55_41, t55_42, t55_43, t55_44, t55_45, t55_46, t55_47, t55_48, t55_49, t55_50, t55_51, t55_52, t55_53, t55_54;
  and #(2) (t55_0, p54, g53);
  and #(2) (t55_1, p54, p53, g52);
  and #(2) (t55_2, p54, p53, p52, g51);
  and #(2) (t55_3, p54, p53, p52, p51, g50);
  and #(2) (t55_4, p54, p53, p52, p51, p50, g49);
  and #(2) (t55_5, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t55_6, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t55_7, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t55_8, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t55_9, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t55_10, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t55_11, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t55_12, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t55_13, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t55_14, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t55_15, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t55_16, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t55_17, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t55_18, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t55_19, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t55_20, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t55_21, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t55_22, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t55_23, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t55_24, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t55_25, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t55_26, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t55_27, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t55_28, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t55_29, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t55_30, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t55_31, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t55_32, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t55_33, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t55_34, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t55_35, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t55_36, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t55_37, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t55_38, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t55_39, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t55_40, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t55_41, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t55_42, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t55_43, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t55_44, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t55_45, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t55_46, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t55_47, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t55_48, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t55_49, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t55_50, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t55_51, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t55_52, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t55_53, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t55_54, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c55, g54, t55_0, t55_1, t55_2, t55_3, t55_4, t55_5, t55_6, t55_7, t55_8, t55_9, t55_10, t55_11, t55_12, t55_13, t55_14, t55_15, t55_16, t55_17, t55_18, t55_19, t55_20, t55_21, t55_22, t55_23, t55_24, t55_25, t55_26, t55_27, t55_28, t55_29, t55_30, t55_31, t55_32, t55_33, t55_34, t55_35, t55_36, t55_37, t55_38, t55_39, t55_40, t55_41, t55_42, t55_43, t55_44, t55_45, t55_46, t55_47, t55_48, t55_49, t55_50, t55_51, t55_52, t55_53, t55_54);

  // finding c56 by using extra wire

  wire t56_0, t56_1, t56_2, t56_3, t56_4, t56_5, t56_6, t56_7, t56_8, t56_9, t56_10, t56_11, t56_12, t56_13, t56_14, t56_15, t56_16, t56_17, t56_18, t56_19, t56_20, t56_21, t56_22, t56_23, t56_24, t56_25, t56_26, t56_27, t56_28, t56_29, t56_30, t56_31, t56_32, t56_33, t56_34, t56_35, t56_36, t56_37, t56_38, t56_39, t56_40, t56_41, t56_42, t56_43, t56_44, t56_45, t56_46, t56_47, t56_48, t56_49, t56_50, t56_51, t56_52, t56_53, t56_54, t56_55;
  and #(2) (t56_0, p55, g54);
  and #(2) (t56_1, p55, p54, g53);
  and #(2) (t56_2, p55, p54, p53, g52);
  and #(2) (t56_3, p55, p54, p53, p52, g51);
  and #(2) (t56_4, p55, p54, p53, p52, p51, g50);
  and #(2) (t56_5, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t56_6, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t56_7, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t56_8, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t56_9, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t56_10, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t56_11, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t56_12, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t56_13, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t56_14, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t56_15, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t56_16, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t56_17, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t56_18, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t56_19, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t56_20, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t56_21, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t56_22, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t56_23, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t56_24, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t56_25, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t56_26, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t56_27, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t56_28, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t56_29, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t56_30, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t56_31, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t56_32, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t56_33, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t56_34, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t56_35, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t56_36, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t56_37, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t56_38, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t56_39, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t56_40, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t56_41, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t56_42, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t56_43, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t56_44, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t56_45, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t56_46, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t56_47, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t56_48, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t56_49, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t56_50, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t56_51, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t56_52, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t56_53, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t56_54, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t56_55, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c56, g55, t56_0, t56_1, t56_2, t56_3, t56_4, t56_5, t56_6, t56_7, t56_8, t56_9, t56_10, t56_11, t56_12, t56_13, t56_14, t56_15, t56_16, t56_17, t56_18, t56_19, t56_20, t56_21, t56_22, t56_23, t56_24, t56_25, t56_26, t56_27, t56_28, t56_29, t56_30, t56_31, t56_32, t56_33, t56_34, t56_35, t56_36, t56_37, t56_38, t56_39, t56_40, t56_41, t56_42, t56_43, t56_44, t56_45, t56_46, t56_47, t56_48, t56_49, t56_50, t56_51, t56_52, t56_53, t56_54, t56_55);

  // finding c57 by using extra wire

  wire t57_0, t57_1, t57_2, t57_3, t57_4, t57_5, t57_6, t57_7, t57_8, t57_9, t57_10, t57_11, t57_12, t57_13, t57_14, t57_15, t57_16, t57_17, t57_18, t57_19, t57_20, t57_21, t57_22, t57_23, t57_24, t57_25, t57_26, t57_27, t57_28, t57_29, t57_30, t57_31, t57_32, t57_33, t57_34, t57_35, t57_36, t57_37, t57_38, t57_39, t57_40, t57_41, t57_42, t57_43, t57_44, t57_45, t57_46, t57_47, t57_48, t57_49, t57_50, t57_51, t57_52, t57_53, t57_54, t57_55, t57_56;
  and #(2) (t57_0, p56, g55);
  and #(2) (t57_1, p56, p55, g54);
  and #(2) (t57_2, p56, p55, p54, g53);
  and #(2) (t57_3, p56, p55, p54, p53, g52);
  and #(2) (t57_4, p56, p55, p54, p53, p52, g51);
  and #(2) (t57_5, p56, p55, p54, p53, p52, p51, g50);
  and #(2) (t57_6, p56, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t57_7, p56, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t57_8, p56, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t57_9, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t57_10, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t57_11, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t57_12, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t57_13, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t57_14, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t57_15, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t57_16, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t57_17, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t57_18, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t57_19, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t57_20, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t57_21, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t57_22, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t57_23, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t57_24, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t57_25, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t57_26, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t57_27, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t57_28, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t57_29, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t57_30, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t57_31, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t57_32, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t57_33, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t57_34, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t57_35, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t57_36, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t57_37, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t57_38, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t57_39, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t57_40, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t57_41, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t57_42, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t57_43, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t57_44, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t57_45, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t57_46, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t57_47, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t57_48, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t57_49, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t57_50, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t57_51, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t57_52, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t57_53, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t57_54, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t57_55, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t57_56, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c57, g56, t57_0, t57_1, t57_2, t57_3, t57_4, t57_5, t57_6, t57_7, t57_8, t57_9, t57_10, t57_11, t57_12, t57_13, t57_14, t57_15, t57_16, t57_17, t57_18, t57_19, t57_20, t57_21, t57_22, t57_23, t57_24, t57_25, t57_26, t57_27, t57_28, t57_29, t57_30, t57_31, t57_32, t57_33, t57_34, t57_35, t57_36, t57_37, t57_38, t57_39, t57_40, t57_41, t57_42, t57_43, t57_44, t57_45, t57_46, t57_47, t57_48, t57_49, t57_50, t57_51, t57_52, t57_53, t57_54, t57_55, t57_56);

  // finding c58 by using extra wire

  wire t58_0, t58_1, t58_2, t58_3, t58_4, t58_5, t58_6, t58_7, t58_8, t58_9, t58_10, t58_11, t58_12, t58_13, t58_14, t58_15, t58_16, t58_17, t58_18, t58_19, t58_20, t58_21, t58_22, t58_23, t58_24, t58_25, t58_26, t58_27, t58_28, t58_29, t58_30, t58_31, t58_32, t58_33, t58_34, t58_35, t58_36, t58_37, t58_38, t58_39, t58_40, t58_41, t58_42, t58_43, t58_44, t58_45, t58_46, t58_47, t58_48, t58_49, t58_50, t58_51, t58_52, t58_53, t58_54, t58_55, t58_56, t58_57;
  and #(2) (t58_0, p57, g56);
  and #(2) (t58_1, p57, p56, g55);
  and #(2) (t58_2, p57, p56, p55, g54);
  and #(2) (t58_3, p57, p56, p55, p54, g53);
  and #(2) (t58_4, p57, p56, p55, p54, p53, g52);
  and #(2) (t58_5, p57, p56, p55, p54, p53, p52, g51);
  and #(2) (t58_6, p57, p56, p55, p54, p53, p52, p51, g50);
  and #(2) (t58_7, p57, p56, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t58_8, p57, p56, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t58_9, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t58_10, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t58_11, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t58_12, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t58_13, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t58_14, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t58_15, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t58_16, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t58_17, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t58_18, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t58_19, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t58_20, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t58_21, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t58_22, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t58_23, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t58_24, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t58_25, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t58_26, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t58_27, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t58_28, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t58_29, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t58_30, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t58_31, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t58_32, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t58_33, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t58_34, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t58_35, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t58_36, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t58_37, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t58_38, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t58_39, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t58_40, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t58_41, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t58_42, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t58_43, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t58_44, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t58_45, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t58_46, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t58_47, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t58_48, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t58_49, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t58_50, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t58_51, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t58_52, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t58_53, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t58_54, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t58_55, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t58_56, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t58_57, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c58, g57, t58_0, t58_1, t58_2, t58_3, t58_4, t58_5, t58_6, t58_7, t58_8, t58_9, t58_10, t58_11, t58_12, t58_13, t58_14, t58_15, t58_16, t58_17, t58_18, t58_19, t58_20, t58_21, t58_22, t58_23, t58_24, t58_25, t58_26, t58_27, t58_28, t58_29, t58_30, t58_31, t58_32, t58_33, t58_34, t58_35, t58_36, t58_37, t58_38, t58_39, t58_40, t58_41, t58_42, t58_43, t58_44, t58_45, t58_46, t58_47, t58_48, t58_49, t58_50, t58_51, t58_52, t58_53, t58_54, t58_55, t58_56, t58_57);

  // finding c59 by using extra wire

  wire t59_0, t59_1, t59_2, t59_3, t59_4, t59_5, t59_6, t59_7, t59_8, t59_9, t59_10, t59_11, t59_12, t59_13, t59_14, t59_15, t59_16, t59_17, t59_18, t59_19, t59_20, t59_21, t59_22, t59_23, t59_24, t59_25, t59_26, t59_27, t59_28, t59_29, t59_30, t59_31, t59_32, t59_33, t59_34, t59_35, t59_36, t59_37, t59_38, t59_39, t59_40, t59_41, t59_42, t59_43, t59_44, t59_45, t59_46, t59_47, t59_48, t59_49, t59_50, t59_51, t59_52, t59_53, t59_54, t59_55, t59_56, t59_57, t59_58;
  and #(2) (t59_0, p58, g57);
  and #(2) (t59_1, p58, p57, g56);
  and #(2) (t59_2, p58, p57, p56, g55);
  and #(2) (t59_3, p58, p57, p56, p55, g54);
  and #(2) (t59_4, p58, p57, p56, p55, p54, g53);
  and #(2) (t59_5, p58, p57, p56, p55, p54, p53, g52);
  and #(2) (t59_6, p58, p57, p56, p55, p54, p53, p52, g51);
  and #(2) (t59_7, p58, p57, p56, p55, p54, p53, p52, p51, g50);
  and #(2) (t59_8, p58, p57, p56, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t59_9, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t59_10, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t59_11, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t59_12, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t59_13, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t59_14, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t59_15, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t59_16, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t59_17, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t59_18, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t59_19, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t59_20, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t59_21, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t59_22, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t59_23, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t59_24, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t59_25, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t59_26, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t59_27, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t59_28, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t59_29, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t59_30, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t59_31, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t59_32, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t59_33, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t59_34, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t59_35, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t59_36, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t59_37, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t59_38, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t59_39, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t59_40, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t59_41, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t59_42, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t59_43, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t59_44, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t59_45, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t59_46, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t59_47, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t59_48, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t59_49, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t59_50, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t59_51, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t59_52, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t59_53, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t59_54, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t59_55, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t59_56, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t59_57, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t59_58, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c59, g58, t59_0, t59_1, t59_2, t59_3, t59_4, t59_5, t59_6, t59_7, t59_8, t59_9, t59_10, t59_11, t59_12, t59_13, t59_14, t59_15, t59_16, t59_17, t59_18, t59_19, t59_20, t59_21, t59_22, t59_23, t59_24, t59_25, t59_26, t59_27, t59_28, t59_29, t59_30, t59_31, t59_32, t59_33, t59_34, t59_35, t59_36, t59_37, t59_38, t59_39, t59_40, t59_41, t59_42, t59_43, t59_44, t59_45, t59_46, t59_47, t59_48, t59_49, t59_50, t59_51, t59_52, t59_53, t59_54, t59_55, t59_56, t59_57, t59_58);

  // finding c60 by using extra wire

  wire t60_0, t60_1, t60_2, t60_3, t60_4, t60_5, t60_6, t60_7, t60_8, t60_9, t60_10, t60_11, t60_12, t60_13, t60_14, t60_15, t60_16, t60_17, t60_18, t60_19, t60_20, t60_21, t60_22, t60_23, t60_24, t60_25, t60_26, t60_27, t60_28, t60_29, t60_30, t60_31, t60_32, t60_33, t60_34, t60_35, t60_36, t60_37, t60_38, t60_39, t60_40, t60_41, t60_42, t60_43, t60_44, t60_45, t60_46, t60_47, t60_48, t60_49, t60_50, t60_51, t60_52, t60_53, t60_54, t60_55, t60_56, t60_57, t60_58, t60_59;
  and #(2) (t60_0, p59, g58);
  and #(2) (t60_1, p59, p58, g57);
  and #(2) (t60_2, p59, p58, p57, g56);
  and #(2) (t60_3, p59, p58, p57, p56, g55);
  and #(2) (t60_4, p59, p58, p57, p56, p55, g54);
  and #(2) (t60_5, p59, p58, p57, p56, p55, p54, g53);
  and #(2) (t60_6, p59, p58, p57, p56, p55, p54, p53, g52);
  and #(2) (t60_7, p59, p58, p57, p56, p55, p54, p53, p52, g51);
  and #(2) (t60_8, p59, p58, p57, p56, p55, p54, p53, p52, p51, g50);
  and #(2) (t60_9, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t60_10, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t60_11, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t60_12, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t60_13, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t60_14, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t60_15, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t60_16, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t60_17, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t60_18, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t60_19, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t60_20, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t60_21, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t60_22, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t60_23, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t60_24, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t60_25, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t60_26, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t60_27, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t60_28, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t60_29, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t60_30, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t60_31, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t60_32, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t60_33, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t60_34, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t60_35, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t60_36, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t60_37, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t60_38, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t60_39, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t60_40, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t60_41, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t60_42, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t60_43, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t60_44, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t60_45, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t60_46, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t60_47, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t60_48, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t60_49, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t60_50, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t60_51, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t60_52, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t60_53, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t60_54, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t60_55, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t60_56, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t60_57, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t60_58, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t60_59, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c60, g59, t60_0, t60_1, t60_2, t60_3, t60_4, t60_5, t60_6, t60_7, t60_8, t60_9, t60_10, t60_11, t60_12, t60_13, t60_14, t60_15, t60_16, t60_17, t60_18, t60_19, t60_20, t60_21, t60_22, t60_23, t60_24, t60_25, t60_26, t60_27, t60_28, t60_29, t60_30, t60_31, t60_32, t60_33, t60_34, t60_35, t60_36, t60_37, t60_38, t60_39, t60_40, t60_41, t60_42, t60_43, t60_44, t60_45, t60_46, t60_47, t60_48, t60_49, t60_50, t60_51, t60_52, t60_53, t60_54, t60_55, t60_56, t60_57, t60_58, t60_59);

  // finding c61 by using extra wire

  wire t61_0, t61_1, t61_2, t61_3, t61_4, t61_5, t61_6, t61_7, t61_8, t61_9, t61_10, t61_11, t61_12, t61_13, t61_14, t61_15, t61_16, t61_17, t61_18, t61_19, t61_20, t61_21, t61_22, t61_23, t61_24, t61_25, t61_26, t61_27, t61_28, t61_29, t61_30, t61_31, t61_32, t61_33, t61_34, t61_35, t61_36, t61_37, t61_38, t61_39, t61_40, t61_41, t61_42, t61_43, t61_44, t61_45, t61_46, t61_47, t61_48, t61_49, t61_50, t61_51, t61_52, t61_53, t61_54, t61_55, t61_56, t61_57, t61_58, t61_59, t61_60;
  and #(2) (t61_0, p60, g59);
  and #(2) (t61_1, p60, p59, g58);
  and #(2) (t61_2, p60, p59, p58, g57);
  and #(2) (t61_3, p60, p59, p58, p57, g56);
  and #(2) (t61_4, p60, p59, p58, p57, p56, g55);
  and #(2) (t61_5, p60, p59, p58, p57, p56, p55, g54);
  and #(2) (t61_6, p60, p59, p58, p57, p56, p55, p54, g53);
  and #(2) (t61_7, p60, p59, p58, p57, p56, p55, p54, p53, g52);
  and #(2) (t61_8, p60, p59, p58, p57, p56, p55, p54, p53, p52, g51);
  and #(2) (t61_9, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, g50);
  and #(2) (t61_10, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t61_11, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t61_12, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t61_13, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t61_14, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t61_15, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t61_16, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t61_17, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t61_18, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t61_19, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t61_20, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t61_21, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t61_22, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t61_23, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t61_24, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t61_25, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t61_26, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t61_27, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t61_28, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t61_29, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t61_30, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t61_31, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t61_32, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t61_33, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t61_34, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t61_35, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t61_36, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t61_37, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t61_38, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t61_39, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t61_40, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t61_41, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t61_42, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t61_43, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t61_44, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t61_45, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t61_46, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t61_47, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t61_48, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t61_49, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t61_50, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t61_51, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t61_52, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t61_53, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t61_54, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t61_55, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t61_56, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t61_57, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t61_58, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t61_59, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t61_60, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c61, g60, t61_0, t61_1, t61_2, t61_3, t61_4, t61_5, t61_6, t61_7, t61_8, t61_9, t61_10, t61_11, t61_12, t61_13, t61_14, t61_15, t61_16, t61_17, t61_18, t61_19, t61_20, t61_21, t61_22, t61_23, t61_24, t61_25, t61_26, t61_27, t61_28, t61_29, t61_30, t61_31, t61_32, t61_33, t61_34, t61_35, t61_36, t61_37, t61_38, t61_39, t61_40, t61_41, t61_42, t61_43, t61_44, t61_45, t61_46, t61_47, t61_48, t61_49, t61_50, t61_51, t61_52, t61_53, t61_54, t61_55, t61_56, t61_57, t61_58, t61_59, t61_60);

  // finding c62 by using extra wire

  wire t62_0, t62_1, t62_2, t62_3, t62_4, t62_5, t62_6, t62_7, t62_8, t62_9, t62_10, t62_11, t62_12, t62_13, t62_14, t62_15, t62_16, t62_17, t62_18, t62_19, t62_20, t62_21, t62_22, t62_23, t62_24, t62_25, t62_26, t62_27, t62_28, t62_29, t62_30, t62_31, t62_32, t62_33, t62_34, t62_35, t62_36, t62_37, t62_38, t62_39, t62_40, t62_41, t62_42, t62_43, t62_44, t62_45, t62_46, t62_47, t62_48, t62_49, t62_50, t62_51, t62_52, t62_53, t62_54, t62_55, t62_56, t62_57, t62_58, t62_59, t62_60, t62_61;
  and #(2) (t62_0, p61, g60);
  and #(2) (t62_1, p61, p60, g59);
  and #(2) (t62_2, p61, p60, p59, g58);
  and #(2) (t62_3, p61, p60, p59, p58, g57);
  and #(2) (t62_4, p61, p60, p59, p58, p57, g56);
  and #(2) (t62_5, p61, p60, p59, p58, p57, p56, g55);
  and #(2) (t62_6, p61, p60, p59, p58, p57, p56, p55, g54);
  and #(2) (t62_7, p61, p60, p59, p58, p57, p56, p55, p54, g53);
  and #(2) (t62_8, p61, p60, p59, p58, p57, p56, p55, p54, p53, g52);
  and #(2) (t62_9, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, g51);
  and #(2) (t62_10, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, g50);
  and #(2) (t62_11, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t62_12, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t62_13, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t62_14, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t62_15, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t62_16, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t62_17, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t62_18, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t62_19, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t62_20, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t62_21, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t62_22, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t62_23, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t62_24, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t62_25, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t62_26, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t62_27, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t62_28, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t62_29, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t62_30, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t62_31, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t62_32, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t62_33, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t62_34, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t62_35, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t62_36, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t62_37, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t62_38, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t62_39, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t62_40, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t62_41, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t62_42, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t62_43, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t62_44, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t62_45, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t62_46, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t62_47, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t62_48, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t62_49, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t62_50, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t62_51, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t62_52, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t62_53, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t62_54, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t62_55, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t62_56, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t62_57, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t62_58, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t62_59, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t62_60, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t62_61, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c62, g61, t62_0, t62_1, t62_2, t62_3, t62_4, t62_5, t62_6, t62_7, t62_8, t62_9, t62_10, t62_11, t62_12, t62_13, t62_14, t62_15, t62_16, t62_17, t62_18, t62_19, t62_20, t62_21, t62_22, t62_23, t62_24, t62_25, t62_26, t62_27, t62_28, t62_29, t62_30, t62_31, t62_32, t62_33, t62_34, t62_35, t62_36, t62_37, t62_38, t62_39, t62_40, t62_41, t62_42, t62_43, t62_44, t62_45, t62_46, t62_47, t62_48, t62_49, t62_50, t62_51, t62_52, t62_53, t62_54, t62_55, t62_56, t62_57, t62_58, t62_59, t62_60, t62_61);

  // finding c63 by using extra wire

  wire t63_0, t63_1, t63_2, t63_3, t63_4, t63_5, t63_6, t63_7, t63_8, t63_9, t63_10, t63_11, t63_12, t63_13, t63_14, t63_15, t63_16, t63_17, t63_18, t63_19, t63_20, t63_21, t63_22, t63_23, t63_24, t63_25, t63_26, t63_27, t63_28, t63_29, t63_30, t63_31, t63_32, t63_33, t63_34, t63_35, t63_36, t63_37, t63_38, t63_39, t63_40, t63_41, t63_42, t63_43, t63_44, t63_45, t63_46, t63_47, t63_48, t63_49, t63_50, t63_51, t63_52, t63_53, t63_54, t63_55, t63_56, t63_57, t63_58, t63_59, t63_60, t63_61, t63_62;
  and #(2) (t63_0, p62, g61);
  and #(2) (t63_1, p62, p61, g60);
  and #(2) (t63_2, p62, p61, p60, g59);
  and #(2) (t63_3, p62, p61, p60, p59, g58);
  and #(2) (t63_4, p62, p61, p60, p59, p58, g57);
  and #(2) (t63_5, p62, p61, p60, p59, p58, p57, g56);
  and #(2) (t63_6, p62, p61, p60, p59, p58, p57, p56, g55);
  and #(2) (t63_7, p62, p61, p60, p59, p58, p57, p56, p55, g54);
  and #(2) (t63_8, p62, p61, p60, p59, p58, p57, p56, p55, p54, g53);
  and #(2) (t63_9, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, g52);
  and #(2) (t63_10, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, g51);
  and #(2) (t63_11, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, g50);
  and #(2) (t63_12, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t63_13, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t63_14, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t63_15, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t63_16, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t63_17, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t63_18, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t63_19, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t63_20, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t63_21, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t63_22, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t63_23, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t63_24, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t63_25, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t63_26, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t63_27, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t63_28, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t63_29, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t63_30, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t63_31, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t63_32, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t63_33, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t63_34, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t63_35, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t63_36, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t63_37, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t63_38, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t63_39, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t63_40, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t63_41, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t63_42, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t63_43, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t63_44, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t63_45, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t63_46, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t63_47, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t63_48, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t63_49, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t63_50, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t63_51, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t63_52, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t63_53, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t63_54, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t63_55, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t63_56, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t63_57, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t63_58, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t63_59, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t63_60, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t63_61, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t63_62, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c63, g62, t63_0, t63_1, t63_2, t63_3, t63_4, t63_5, t63_6, t63_7, t63_8, t63_9, t63_10, t63_11, t63_12, t63_13, t63_14, t63_15, t63_16, t63_17, t63_18, t63_19, t63_20, t63_21, t63_22, t63_23, t63_24, t63_25, t63_26, t63_27, t63_28, t63_29, t63_30, t63_31, t63_32, t63_33, t63_34, t63_35, t63_36, t63_37, t63_38, t63_39, t63_40, t63_41, t63_42, t63_43, t63_44, t63_45, t63_46, t63_47, t63_48, t63_49, t63_50, t63_51, t63_52, t63_53, t63_54, t63_55, t63_56, t63_57, t63_58, t63_59, t63_60, t63_61, t63_62);

  // finding c64 by using extra wire

  wire t64_0, t64_1, t64_2, t64_3, t64_4, t64_5, t64_6, t64_7, t64_8, t64_9, t64_10, t64_11, t64_12, t64_13, t64_14, t64_15, t64_16, t64_17, t64_18, t64_19, t64_20, t64_21, t64_22, t64_23, t64_24, t64_25, t64_26, t64_27, t64_28, t64_29, t64_30, t64_31, t64_32, t64_33, t64_34, t64_35, t64_36, t64_37, t64_38, t64_39, t64_40, t64_41, t64_42, t64_43, t64_44, t64_45, t64_46, t64_47, t64_48, t64_49, t64_50, t64_51, t64_52, t64_53, t64_54, t64_55, t64_56, t64_57, t64_58, t64_59, t64_60, t64_61, t64_62, t64_63;
  and #(2) (t64_0, p63, g62);
  and #(2) (t64_1, p63, p62, g61);
  and #(2) (t64_2, p63, p62, p61, g60);
  and #(2) (t64_3, p63, p62, p61, p60, g59);
  and #(2) (t64_4, p63, p62, p61, p60, p59, g58);
  and #(2) (t64_5, p63, p62, p61, p60, p59, p58, g57);
  and #(2) (t64_6, p63, p62, p61, p60, p59, p58, p57, g56);
  and #(2) (t64_7, p63, p62, p61, p60, p59, p58, p57, p56, g55);
  and #(2) (t64_8, p63, p62, p61, p60, p59, p58, p57, p56, p55, g54);
  and #(2) (t64_9, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, g53);
  and #(2) (t64_10, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, g52);
  and #(2) (t64_11, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, g51);
  and #(2) (t64_12, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, g50);
  and #(2) (t64_13, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, g49);
  and #(2) (t64_14, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, g48);
  and #(2) (t64_15, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, g47);
  and #(2) (t64_16, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, g46);
  and #(2) (t64_17, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, g45);
  and #(2) (t64_18, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, g44);
  and #(2) (t64_19, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, g43);
  and #(2) (t64_20, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, g42);
  and #(2) (t64_21, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, g41);
  and #(2) (t64_22, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, g40);
  and #(2) (t64_23, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, g39);
  and #(2) (t64_24, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, g38);
  and #(2) (t64_25, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, g37);
  and #(2) (t64_26, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, g36);
  and #(2) (t64_27, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, g35);
  and #(2) (t64_28, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, g34);
  and #(2) (t64_29, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, g33);
  and #(2) (t64_30, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, g32);
  and #(2) (t64_31, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, g31);
  and #(2) (t64_32, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, g30);
  and #(2) (t64_33, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, g29);
  and #(2) (t64_34, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, g28);
  and #(2) (t64_35, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, g27);
  and #(2) (t64_36, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, g26);
  and #(2) (t64_37, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, g25);
  and #(2) (t64_38, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, g24);
  and #(2) (t64_39, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, g23);
  and #(2) (t64_40, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, g22);
  and #(2) (t64_41, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, g21);
  and #(2) (t64_42, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, g20);
  and #(2) (t64_43, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, g19);
  and #(2) (t64_44, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, g18);
  and #(2) (t64_45, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, g17);
  and #(2) (t64_46, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, g16);
  and #(2) (t64_47, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, g15);
  and #(2) (t64_48, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, g14);
  and #(2) (t64_49, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, g13);
  and #(2) (t64_50, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, g12);
  and #(2) (t64_51, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, g11);
  and #(2) (t64_52, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, g10);
  and #(2) (t64_53, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, g9);
  and #(2) (t64_54, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, g8);
  and #(2) (t64_55, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, g7);
  and #(2) (t64_56, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, g6);
  and #(2) (t64_57, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, g5);
  and #(2) (t64_58, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, g4);
  and #(2) (t64_59, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, g3);
  and #(2) (t64_60, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, g2);
  and #(2) (t64_61, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, g1);
  and #(2) (t64_62, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, g0);
  and #(2) (t64_63, p63, p62, p61, p60, p59, p58, p57, p56, p55, p54, p53, p52, p51, p50, p49, p48, p47, p46, p45, p44, p43, p42, p41, p40, p39, p38, p37, p36, p35, p34, p33, p32, p31, p30, p29, p28, p27, p26, p25, p24, p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13, p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0, cin);
  or  #(2) (c64, g63, t64_0, t64_1, t64_2, t64_3, t64_4, t64_5, t64_6, t64_7, t64_8, t64_9, t64_10, t64_11, t64_12, t64_13, t64_14, t64_15, t64_16, t64_17, t64_18, t64_19, t64_20, t64_21, t64_22, t64_23, t64_24, t64_25, t64_26, t64_27, t64_28, t64_29, t64_30, t64_31, t64_32, t64_33, t64_34, t64_35, t64_36, t64_37, t64_38, t64_39, t64_40, t64_41, t64_42, t64_43, t64_44, t64_45, t64_46, t64_47, t64_48, t64_49, t64_50, t64_51, t64_52, t64_53, t64_54, t64_55, t64_56, t64_57, t64_58, t64_59, t64_60, t64_61, t64_62, t64_63);

  assign cout = c[64];

  // ---------------------------------------------------------------------
  // Step 3: sum bits
  // ---------------------------------------------------------------------
  // TODO: assign #(2) sum = p ^ {c[63:1], cin};


  assign #(2) sum = p ^ {c[63:1], cin};

endmodule
