module led_handler (
  input hwclk,
  input [1:0] cmd,
  input [8:0] btns,
  // input locked,
  output led1, led2, led3, led4, led5, led6, led7, led8
);

wire [7:0] leds = {led8, led7, led6, led5, led4, led3, led2, led1};

//assign leds[0] = locked;

reg [26:0] counter = 0; 
reg on_or_off;

wire led_clk;

reg [2:0] state;

clock_div CLKDIV1(hwclk, led_clk);
always @ (posedge hwclk) begin
  case (cmd)
    2'b00: // Off
      leds = 8'b00000001;
    2'b01: // On
      leds = 8'b00000010;
    2'b10: // Off for .5s, on 1s -> repeat 3 times
      leds = {btns[3:0],4'b0100};
    2'b11: // Off for .2s, on for .2s, repeat 5 times
      leds = 8'b00001000;
  endcase
end

endmodule
