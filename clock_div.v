module clock_div #(parameter DIV = 24000000) (
  input hwclk, output reg clk_out
);
  reg [$clog2(DIV) - 1:0] counter = 0;
    
  always @ (posedge hwclk) begin
    counter <= counter + 1;
    if (counter >= (DIV - 1))
      counter <= 0;
    clk_out <= (counter < DIV / 2) ? 1'b1 : 1'b0;
  end

endmodule
