`default_nettype none

module tt_um_test (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // uo_out: Συνδυασμός διαφορετικών πυλών bit-by-bit
  assign uo_out[0] = ui_in[0] & uio_in[0]; // AND
  assign uo_out[1] = ui_in[1] | uio_in[1]; // OR
  assign uo_out[2] = ui_in[2] ^ uio_in[2]; // XOR
  assign uo_out[3] = ~ui_in[3];             // NOT
  assign uo_out[4] = ~(ui_in[4] & uio_in[4]); // NAND
  assign uo_out[5] = ~(ui_in[5] | uio_in[5]); // NOR
  assign uo_out[6] = ui_in[6] + uio_in[6];   // ADD (LSB του αθροίσματος)
  assign uo_out[7] = &ui_in;                // Reduction AND (1 αν όλα τα ui_in είναι 1)

  // uio_out: Αντιστροφή των εισόδων uio_in
  assign uio_out = ui_in & uio_in;
  
  // uio_oe: Ορίζουμε όλα τα uio ως εξόδους (1) ή εισόδους (0)
  // Ας τα αφήσουμε ως εισόδους για να λειτουργεί το παραπάνω logic
  assign uio_oe  = 8'b00000000;

  // Πρόληψη warnings για αχρησιμοποίητα σήματα
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
