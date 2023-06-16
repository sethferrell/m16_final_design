module debounce (
  input hwclk, but_in,
  output but_out
);

reg [31:0] debounce_timer = 32'b0;
parameter DEBOUNCE_PERIOD = 32'd120000;
reg debouncing = 1'b0;

always @ (posedge hwclk) begin
  if (~debouncing && ~but_in) begin
    but_out <= 1;
    debouncing <= 1;
  end else if (debouncing && ~but_in) begin
    debounce_timer <= 32'b0;
  end else if (debouncing && debounce_timer < DEBOUNCE_PERIOD) begin
    debounce_timer <= debounce_timer + 1;
  end else if (debouncing) begin
    debounce_timer <= 32'b0;
    debouncing <= 1'b0;
  end else if (but_in)
    but_out <= 0;
end

endmodule
