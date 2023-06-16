module #(CODE_LEN = 6) moore(
  input reg hwclk;
  input wire [8:0] btns;
);

parameter START = 

reg [3:0] state;
wire [3:0] next_state;

always @ (*) begin
  case (state)
    
  endcase
end

always @ (posedge hwclk) begin
  if (rst)
    state <= START;
  else
    state <= next_state;
end

endmodule;
