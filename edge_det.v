module edge_det (
  input R,
  input C,
  input clk,
  output out,
  output [1:0] debug
);

parameter IDLE          = 2'b00;
parameter WAIT_RELEASE  = 2'b01;
parameter OUTPUT_HIGH_0 = 2'b10;

reg [1:0] state = 0;

reg out;

reg [1:0] next_state;

assign debug = {~R, ~R & C};

always @ (*) begin
  case (state)
    IDLE: begin
      next_state = (~R & ~C) ? WAIT_RELEASE : IDLE;
      out = 0;
    end  
    WAIT_RELEASE: begin
      next_state = (~R & C) ? OUTPUT_HIGH_0 : WAIT_RELEASE;
      out = 0;
    end
    OUTPUT_HIGH_0: begin
      next_state = IDLE;
      out = 1;
    end
    default: begin
      next_state = IDLE;
      out = 0;
    end
  endcase
end

always @ (posedge clk) begin
  state <= next_state;
end

endmodule
