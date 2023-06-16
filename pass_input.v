module pass_input #(parameter PC = 121212, WIDTH = 4, SIZE = 6) (
  input rst,
  input clk,
  input [1:0] is_programming,
  output correct,
  output valid,
  output equal,
  output reg [31:0] pass,
  output debug
);

parameter PROGRAM_CODE   = 2'b00;
parameter USER_CODE_VALID  = 2'b01;
parameter USER_CODE_EQUAL = 2'b10;

reg [WIDTH - 1:0] inp_code  [0:SIZE - 1];
reg [WIDTH - 1:0] inp_code2 [0:SIZE - 1];
reg [WIDTH - 1:0] i;

assign correct = (inp_code[0] == PC / 100000 % 10) &&
                 (inp_code[1] == PC / 10000  % 10) &&
                 (inp_code[2] == PC / 1000   % 10) &&
                 (inp_code[3] == PC / 100    % 10) &&
                 (inp_code[4] == PC / 10     % 10) &&
                 (inp_code[5] == PC          % 10);

assign valid = i >= 4 && i <= 6;

wire debug = i[0];

assign equal =  (inp_code[0] == inp_code2[0]) &&
                (inp_code[1] == inp_code2[1]) &&
                (inp_code[2] == inp_code2[2]) &&
                (inp_code[3] == inp_code2[3]) &&
                (inp_code[4] == inp_code2[4]) &&
                (inp_code[5] == inp_code2[5]);  

always @ (posedge clk) begin
  if (rst) begin
    i <= 0;
    inp_code[0]  <= 4'hf;
    inp_code[1]  <= 4'hf;
    inp_code[2]  <= 4'hf;
    inp_code[3]  <= 4'hf;
    inp_code[4]  <= 4'hf;
    inp_code[5]  <= 4'hf;
    inp_code2[0] <= 4'hf;
    inp_code2[1] <= 4'hf;
    inp_code2[2] <= 4'hf;
    inp_code2[3] <= 4'hf;
    inp_code2[4] <= 4'hf;
    inp_code2[5] <= 4'hf;
  end else begin
    case (is_programming)
      PROGRAM_CODE: begin
        if (btns[0]) begin
          inp_code[i] <= 4'd1;
          i <= i + 1;
        end else if (btns[1]) begin
          inp_code[i] <= 4'd2;
          i <= i + 1;
        end else if (btns[2] || btns[3] || btns[4] || btns[5])
          i <= i + 1;
      end
      USER_CODE_VALID: begin
        if (btns[0]) begin
          inp_code[i] <= 4'd1;
          i <= i + 1;
        end else if (btns[1]) begin
          inp_code[i] <= 4'd2;
          i <= i + 1;
        end else if (btns[2]) begin
          inp_code[i] <= 4'd3;
          i <= i + 1;
        end else if (btns[3]) begin
          inp_code[i] <= 4'd4;
          i <= i + 1;
        end else if (btns[4]) begin
          inp_code[i] <= 4'd5;
          i <= i + 1;
        end else if (btns[5]) begin
          inp_code[i] <= 4'd6;
          i <= i + 1;
        end
      end
      USER_CODE_EQUAL: begin
        if (btns[0]) begin
          inp_code2[i] <= 4'd1;
          i <= i + 1;
        end else if (btns[1]) begin
          inp_code2[i] <= 4'd2;
          i <= i + 1;
        end else if (btns[2]) begin
          inp_code2[i] <= 4'd3;
          i <= i + 1;
        end else if (btns[3]) begin
          inp_code2[i] <= 4'd4;
          i <= i + 1;
        end else if (btns[4]) begin
          inp_code2[i] <= 4'd5;
          i <= i + 1;
        end else if (btns[5]) begin
          inp_code2[i] <= 4'd6;
          i <= i + 1;
        end

        if (equal) begin
          pass <= inp_code[0] * 100000 +
                  inp_code[1] * 10000  +
                  inp_code[2] * 1000   +
                  inp_code[3] * 100    + 
                  inp_code[4] * 10     +
                  inp_code[5];
        end
      end
    endcase
  end
end

endmodule
