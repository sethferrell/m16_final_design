module encoder (
  input [8:0] x,
  output [3:0] z
);

always @ (*) begin
  case (x)
    9'b000000001: z = 4'b0001;
    9'b000000010: z = 4'b0010;
    9'b000000100: z = 4'b0011;
    9'b000001000: z = 4'b0100;
    9'b000010000: z = 4'b0101;
    9'b000100000: z = 4'b0110;
    9'b001000000: z = 4'b0111;
    9'b010000000: z = 4'b1000;
    9'b100000000: z = 4'b1001;
    default:      z = 4'b0000;
  endcase
end

endmodule
